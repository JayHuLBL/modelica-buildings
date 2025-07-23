''' Python module that is used for the example
    Buildings.Fluid.Geothermal.Borefields.TOUGHResponse.Examples.Borefields
'''
import os
import shutil
import time
import subprocess
import sys

def doStep(dblInp, state):
    modelicaWorkingPath = os.getcwd()
# Assuming Linux, use:
    py_dir = os.path.join(modelicaWorkingPath, 'Buildings/Resources/Python-Sources')
# To make it explicit and clear:
    if os.name == 'nt':  # Windows
            py_dir = os.path.join(modelicaWorkingPath, 'Buildings\\Resources\\Python-Sources')
            tough_cmd='tough4.exe'
    else:  # Linux/MacOS
            py_dir = os.path.join(modelicaWorkingPath, 'Buildings/Resources/Python-Sources')
            tough_cmd='./tough4'
    tou_model = os.path.join(py_dir, 'toughModel')
    Eindx=[]
    Zmesh=[]
    elemN=[]
    modPar=[]
    os.chdir(tou_model)

    if state == None:
       if sys.platform == 'win32': 
          os.spawnl(os.P_DETACH,tough_cmd,tough_cmd,' -t 4')
       else:
          subprocess.Popen([tough_cmd, '-t', '4'], close_fds=True)
       listFile = os.path.join(tou_model, 'ELEMList.dat') 
       Found=0
       while(Found==0):
           if os.path.exists(listFile):
               Found=1
               break 
#    os.chdir(modelicaWorkingPath)  
        
    getTOUGHParameetrs(Eindx, Zmesh, elemN, tou_model)  
    getModelicaParameters(modPar,tou_model)
    tfElementNum=Eindx[-1]
    mdElementNum=modPar[0]
    # Heat flux from borehole wall to ground: Modelica --> Tough
    Q = dblInp[:mdElementNum]
    # Initial borehole wall temperature at the start of modelica simulation
    T_start = [dblInp[i] for i in range(mdElementNum,mdElementNum*2)]
    # Current outdoor temperature
    T_out = dblInp[-2]
    # Current time when needs to call TOUGH. This is also the end time of TOUGH simulation.
    tim = dblInp[-1]
    endrun=1
    if(tim<0.0):
      endrun=-1
      tim=-tim 
    # Find the depth of each layer
    toughLayers = find_layer_depth(tfElementNum, Zmesh, elemN)  
    add_grid_boundary(toughLayers)
            
    n=tfElementNum-1
    top_z=toughLayers[0]['upperBound']
    bottom_z=toughLayers[n]['lowerBound']

    # Find Modelica layers
    modelicaLayers = modelica_mesh(mdElementNum, top_z, bottom_z)    
    # This is the first call of this python module. There is no state yet.
    if state == None:
        # Initialize the state
        T_tough_start = mesh_to_mesh(toughLayers, modelicaLayers, T_start, 'T_Mo2To')
        state = {'tLast': tim, 'Q': Q, 'T_tough': T_tough_start}
        T_toModelica = T_start
        ToModelica = T_toModelica
        # p_Int = ident_set(modPar[1], mdElementNum)
        # x_Int = ident_set(modPar[2], mdElementNum)
        # T_Int = ident_set(modPar[3]+273.15, mdElementNum)
        # ToModelica = T_toModelica + p_Int + x_Int + T_Int
    else:
        # Use the python object
        tLast = state['tLast']
        # print ('Coupling run from time:', tLast,' to ', tim, 's')
        # Find the TOUGH simulation step size
        dt = tim - tLast
        # JModelica invokes the model twice during an event, in which case
        # dt is zero, or close to zero.
        # We don't evaluate the equations as this can cause chattering and in some
        # cases JModelica does not converge during the event iteration.
        # This guard is fine because the component is sampled at discrete time steps.
        if dt > 1e-6:
            # T_toTough = mesh_to_mesh(toughLayer, modelicaLayers, state['T'], 'Mo2To')
            Q_toTough = mesh_to_mesh(toughLayers, modelicaLayers, state['Q'], 'Q_Mo2To')      
            os.chdir(tou_model)
            if os.path.exists('From_TOUGH'):
               os.remove('From_TOUGH') 
                   
            write_toTOUGH(Q_toTough, tim*endrun, 'To_TOUGH')
            notFound=1
            while(notFound==1):
               if os.path.exists('From_TOUGH'):
                  notFound=0                  
            sucessful=0
            while (sucessful<10):            
                try:            
                   data = read_fromTOUGH('From_TOUGH',tfElementNum)
                   T_tough = data['T_Bor']
                   if(len(T_tough)<tfElementNum):
                      sucessful=sucessful+1
                   else:
                      sucessful=sucessful+20 
                except:
                    sucessful=sucessful+1 
                                 
            T_tough = data['T_Bor']          
            if (T_tough[0]>-500.0):
            # Output to Modelica simulation
#                 print(T_tough)
                 T_toModelica = mesh_to_mesh(toughLayers, modelicaLayers, T_tough, 'To2Mo')              
            else:
                 T_toModelica =T_tough
            # Outputs to Modelica
#            ToModelica = T_toModelica + data['p_Int'] + data['x_Int'] + data['T_Int']
            ToModelica = T_toModelica
            # p_Int = ident_set(modPar[1], mdElementNum)
            # x_Int = ident_set(modPar[2], mdElementNum)
            # T_Int = ident_set(modPar[3]+273.15, mdElementNum)
            # ToModelica = T_toModelica + p_Int + x_Int + T_Int
            # Update state
            state = {'tLast': tim, 'Q': Q, 'T_tough': T_tough}

            # Change back to original working directory
    os.chdir(modelicaWorkingPath)
    return [ToModelica, state]

''' Create set of size num with identical value
'''
def ident_set(value, num):
    results = []
    for i in range(0, num):
        results.append(value)
    return results

''' Find Tough mesh layer depth
'''
def find_layer_depth(tfEleN, Zmesh, elemN):
    layers = list()
    dz = []
    z = []
    z.append(Zmesh[0])
    dz.append(Zmesh[0]-Zmesh[1])   # estimated length of the top well element
    layers.append(
        {'layer': elemN[0],
         'z': z[0],
         'dz': abs(dz[0])
        }
    )      
    for i in range(1,tfEleN):
        if i <tfEleN:
            z.append(Zmesh[i])
            thickness = 2*((z[i-1] - dz[i-1]/2) - z[i])
            dz.append(thickness)
            layers.append(
                {'layer': elemN[i],
                 'z': z[i],
                 'dz': abs(thickness)
                } 
            )                 
    return layers
        
''' Find Modelica mesh size
''' 
def modelica_mesh(mdElementNum, top_z, bottom_z):
    modelicaMeshSize = []
    count=0
    top_z=abs(top_z)
    bottom_z=abs(bottom_z)
    dz=(bottom_z-top_z)/mdElementNum
    bottom_z=bottom_z+dz    
    for i in range(0,mdElementNum+1):
        count+=1
        z=dz*i+top_z
        modelicaMeshSize.append(z)
    return modelicaMeshSize
    

''' Add upper and lower grid boundary
'''
def add_grid_boundary(layers):
    upperBound = layers[0]['z']+layers[0]['dz']/2
    lowerBound =upperBound-layers[0]['dz']
    layers[0]['upperBound'] = upperBound
    layers[0]['lowerBound'] = lowerBound
    for i in range(1,len(layers)):
        upperBound = lowerBound
        lowerBound = upperBound - layers[i]['dz']
        layers[i]['upperBound'] = upperBound
        layers[i]['lowerBound'] = lowerBound

''' From Modelica mesh to Tough mesh, distribute the values from Modelica elements to Tough elements
'''
def mesh_to_mesh(layers, modelicaLayers, variables, flag):
    values = []
    if (flag == 'T_Mo2To' or flag == 'Q_Mo2To'):
        for i in range(len(layers)):
            ub = abs(layers[i]['upperBound'])
            lb = abs(layers[i]['lowerBound'])
            dz = layers[i]['dz']
            scenario = 0
            for j in range(1, len(modelicaLayers)):
                cuMe = modelicaLayers[j]
                preMe = modelicaLayers[j-1]
                if ((ub >= preMe and ub < cuMe) and (lb > preMe and lb <= cuMe)):
                    scenario = 1
                    break
                elif (ub < cuMe and lb > cuMe and lb < modelicaLayers[-1]):
                    scenario = 2
                    break
                elif (ub < modelicaLayers[-1] and lb > modelicaLayers[-1]):
                    scenario = 3
                    break
                else:
                    continue                    
            if (scenario == 1):
                if (flag == 'Q_Mo2To'):
                    values.append(variables[j-1] * dz / (cuMe - preMe))
                else:
                    values.append(variables[j-1])
            elif (scenario == 3):
                if (flag == 'Q_Mo2To'):
                    values.append(variables[j-1] * (modelicaLayers[-1]-ub) / (cuMe - preMe))
                else:
                    values.append(variables[j-1])
            else:
                if (flag == 'Q_Mo2To'):
                    values.append(((cuMe - ub)*variables[j-1] + (lb-cuMe)*variables[j])/(cuMe - preMe))
                else:
                    values.append(((cuMe - ub)*variables[j-1] + (lb-cuMe)*variables[j])/(lb - ub))
    else: 
        # (flag == 'To2Mo')
        for i in range(0, len(modelicaLayers)-1):
            cuMe = modelicaLayers[i]
            nexMe = modelicaLayers[i+1]
            accVar = 0
            for j in range(len(layers)):
                ub = abs(layers[j]['upperBound'])
                lb = abs(layers[j]['lowerBound'])
                # dz = layers[j]['dz']
                if ((ub >= cuMe and ub < nexMe) and (lb > cuMe and lb <= nexMe)):
                    ele = layers[j]['dz']
                elif ((ub >= cuMe and ub <nexMe) and (lb > cuMe and lb > nexMe)):
                    ele = nexMe - ub
                elif ((ub < cuMe and ub <= nexMe) and (lb > cuMe and lb <= nexMe)):
                    ele = lb - cuMe
                else:
                    continue   
                accVar = accVar + ele * variables[j]
            values.append(accVar / (nexMe - cuMe))
    return values      

def getTOUGHParameetrs(Eindx, Zmesh, elemN, tf): 
    listFile = os.path.join(tf, 'ELEMList.dat') 
    fin = open(listFile,"r")
    count = 0
    for line in fin:
        count += 1
        if count == 1:
            data=line.split()
            couplingN=int(data[0]) 
        else:
            data=line.split(",") 
            indx=int(data[0])
            z=float(data[2])
            el=data[1].strip()
            Eindx.append(indx)
            Zmesh.append(z)
            elemN.append(el)
    fin.close()
    Eindx.append(couplingN)

def getModelicaParameters(modPar, tf):
    parFile = os.path.join(tf, 'mINFILE')  
    fin = open(parFile,"r") 
    line=fin.readline()
    data=line.split()     
    modPar.append(int(data[0]))
    line=fin.readline()
    data=line.split()
    for i in range(0,3):        
        modPar.append(float(data[i]))        
    fin.close()        


def write_toTOUGH(Q, tim, fileName):
        fout = open(fileName, 'w')
        for i in range(0, len(Q)):
            fout.write("%20.10f\n" % Q[i])
        fout.write("%20.10f\n" % tim)  
        fout.close()  

''' Extract the borehole temperature, and p, x and temperatures of interested points from TOUGH simulation results
'''
def read_fromTOUGH(outFile,tfElementNum):
    T_Bor = []
    T_Int = []
    p_Int = []
    x_Int = []
    fin = open(outFile)
    count = 0
    for line in fin:
        count += 1
        if count <= tfElementNum:
            temp = line.split() 
            T_Bor.append(float(temp[0].replace('D', 'E').strip())+273.15)
 #           p_Int.append(float(temp[2].replace('D', 'E').strip()))
 #           x_Int.append(float(temp[3].replace('D', 'E').strip()))
 #           T_Int.append(float(temp[0].replace('D', 'E').strip())+273.15)            
    data = {
        'T_Bor': T_Bor,
#        'p_Int': p_Int,
#        'x_Int': x_Int,
#        'T_Int': T_Int
    }
    return data


# #assign initial heat flux
# dbls=[]
# dbls.append(-41.231)
# dbls.append(-79.884)
# dbls.append(-104.62)
# dbls.append(-125.748)
# for i in range(0,2):
# 	dbls.append(-45.738)		
# dbls.append(-46.47)
# dbls.append(-126.873)
# dbls.append(-184.395)
# dbls.append(-105.003)
# #assign initial temperature
# for i in range(0,10):
#     dbls.append(10+0.09*i)
# outdoorT=15.0
# dbls.append(outdoorT)
# mtime=0.0
# dbls.append(mtime)    
# state={}
# state=None
# dbl,st=doStep(dbls, state) 
# for i in range(0,3):
#     dbls[-1]= 10000.0+2000.0*i
#     for j in range(0,10):
#         dbls[j]=dbls[j]*1.2         # simulate increasing on flux by 20% 
#     state=st     
#     dbl,st=doStep(dbls, state)
# #    print(dbls)
#     if(dbl[0]<-500.0):
#        break
# if(dbl[0]>-500.0):
#    state=st 
#    dbls[-1]=-dbls[-1]-1000
#    dbl,st=doStep(dbls, state)


















