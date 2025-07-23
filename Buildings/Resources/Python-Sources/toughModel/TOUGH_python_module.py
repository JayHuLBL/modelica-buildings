# my_python_module.py
import numpy as np
import time  # Import the time module
from multiprocessing import shared_memory

def tough_data_port(int_array, double_array):
    result_array = np.zeros(int_array[5], dtype='float64')
    shape_double = (int_array[3],)  # Shape of the large double array    
    shape_int = (int_array[2],)  # Shape of the large integer array   
    if(int_array[1]==1):   
       result_array, local_int_array = TOUGH_read(shape_double, shape_int)           
    if(int_array[1]>1):
       TOUGH_write(double_array, int_array)      
       result_array, local_int_array = TOUGH_read2(shape_double, shape_int,int_array, double_array)
    return result_array

def TOUGH_read(shape_double, shape_int):
    # Define the shared memory names (same as used in Program 1)
    shm_name_double = 'shm_double'
    shm_name_int = 'shm_int'
    shm_name_flag = 'shm_flag'

    # Attach to existing shared memory blocks for input arrays
    shm_double = shared_memory.SharedMemory(name=shm_name_double)
    shm_int = shared_memory.SharedMemory(name=shm_name_int)
    # Attach to the shared memory block for the flag
    shm_flag = shared_memory.SharedMemory(name=shm_name_flag)
    # Create NumPy arrays backed by shared memory
    shared_double_array = np.ndarray(shape_double, dtype=np.float64, buffer=shm_double.buf)
    shared_int_array = np.ndarray(shape_int, dtype=np.int32, buffer=shm_int.buf)
    shared_flag = np.ndarray((1,), dtype=np.uint8, buffer=shm_flag.buf) 
    # Wait until the flag indicates that data is ready
    while shared_flag[0] != 1:
        time.sleep(0.1)  # Sleep for a short while before checking again
    # Copy the data from shared memory to local variables
    local_double_array = np.copy(shared_double_array)
    local_int_array = np.copy(shared_int_array)
    # Clean up shared memory (but do not unlink, as it will still be used)
    shm_double.close()
    shm_int.close()
    shm_flag.close()
    
    return local_double_array, local_int_array

def TOUGH_read2(shape_double, shape_int, int_array, double_array):
    shm_name_double2 = 'shm_double2'
    shm_name_int2 = 'shm_int2'
    shm_name_flag2 = 'shm_flag2'
    try:
        # Create shared memory block for arrays        
        shm_double2 = shared_memory.SharedMemory(name=shm_name_double2, create=True, size=double_array.nbytes)
        shm_int2 = shared_memory.SharedMemory(name=shm_name_int2, create=True, size=int_array.nbytes)
        shm_flag2 = shared_memory.SharedMemory(name=shm_name_flag2, create=True, size=1)
        shared_double_array2 = np.ndarray(shape_double, dtype=double_array.dtype, buffer=shm_double2.buf)
        shared_int_array2 = np.ndarray(shape_int, dtype=int_array.dtype, buffer=shm_int2.buf)
        shared_flag2 = np.ndarray((1,), dtype=np.uint8, buffer=shm_flag2.buf)

        # Copy data into shared memory
        shared_double_array2[:] = double_array[:]
        shared_int_array2[:] = int_array[:]
        shared_flag2[0] = 0  

        # Wait until the flag indicates that data is ready
        timeout = time.time() + 10  # 10-second timeout
        while shared_flag2[0] != 1:
            if time.time() > timeout:
                return None  # Timeout reached, return or handle as needed
            time.sleep(0.1)
        
        local_double_array = np.copy(shared_double_array2)
        local_int_array = np.copy(shared_int_array2)

        shm_double2.close()
        shm_int2.close()
        shm_flag2.close()

        # Unlink the memory to free resources only if you are done with it
        shm_double2.unlink()
        shm_int2.unlink()
        shm_flag2.unlink()

        return local_double_array, local_int_array

    except Exception as e:
        return None


def TOUGH_write(result_double_array, result_int_array):
    shm_name_result_double = 'shm_result_double'
    shm_name_result_int = 'shm_result_int'
    shm_name_flag = 'shm_flag'

    try:
        # Attach to existing shared memory blocks for result arrays  
        shm_result_double = shared_memory.SharedMemory(name=shm_name_result_double)
        shm_result_int = shared_memory.SharedMemory(name=shm_name_result_int)

        # Attach to the shared memory block for the flag
        shm_flag = shared_memory.SharedMemory(name=shm_name_flag)

        # Create NumPy arrays backed by shared memory
        shared_result_double_array = np.ndarray(result_double_array.shape, dtype=np.float64, buffer=shm_result_double.buf)
        shared_result_int_array = np.ndarray(result_int_array.shape, dtype=np.int32, buffer=shm_result_int.buf)
        shared_flag = np.ndarray((1,), dtype=np.uint8, buffer=shm_flag.buf)

        # Write the results back to the shared memory
        shared_result_double_array[:] = result_double_array[:]
        shared_result_int_array[:] = result_int_array[:]

        # Set the flag to indicate processing is complete
        shared_flag[0] = 2

        # Clean up shared memory
        shm_result_double.close()
        shm_result_int.close()
        shm_flag.close()

    except Exception as e:
        return None

    return




