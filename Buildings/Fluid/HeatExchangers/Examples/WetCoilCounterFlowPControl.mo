within Buildings.Fluid.HeatExchangers.Examples;
model WetCoilCounterFlowPControl
  "Model that demonstrates use of a heat exchanger with condensation and with feedback control"
  extends Modelica.Icons.Example;
<<<<<<< HEAD
  package Medium1 = Buildings.Media.Water;
  package Medium2 = Buildings.Media.Air;
  parameter Modelica.Units.SI.Temperature T_a1_nominal=5 + 273.15;
  parameter Modelica.Units.SI.Temperature T_b1_nominal=10 + 273.15;
  parameter Modelica.Units.SI.Temperature T_a2_nominal=30 + 273.15;
  parameter Modelica.Units.SI.Temperature T_b2_nominal=15 + 273.15;
  parameter Modelica.Units.SI.MassFlowRate m1_flow_nominal=0.1
    "Nominal mass flow rate medium 1";
  parameter Modelica.Units.SI.MassFlowRate m2_flow_nominal=m1_flow_nominal*4200
      /1000*(T_a1_nominal - T_b1_nominal)/(T_b2_nominal - T_a2_nominal)
    "Nominal mass flow rate medium 2";
  Buildings.Fluid.Sources.Boundary_pT sin_2(
    redeclare package Medium = Medium2,
    nPorts=1,
    use_p_in=false,
    p(displayUnit="Pa") = 101325,
    T=303.15) annotation (Placement(transformation(extent={{-80,10},{-60,30}})));
  Buildings.Fluid.Sources.Boundary_pT sou_2(
    redeclare package Medium = Medium2,
    nPorts=1,
    T=T_a2_nominal,
    X={0.02,1 - 0.02},
    use_T_in=true,
    use_X_in=true,
    p(displayUnit="Pa") = 101325 + 300) annotation (Placement(transformation(
          extent={{140,10},{120,30}})));
  Buildings.Fluid.Sources.Boundary_pT sin_1(
    redeclare package Medium = Medium1,
    nPorts=1,
    use_p_in=false,
    p=300000,
    T=293.15) annotation (Placement(transformation(extent={{140,50},{120,70}})));
  Buildings.Fluid.Sources.Boundary_pT sou_1(
    redeclare package Medium = Medium1,
    nPorts=1,
    use_T_in=true,
    p=300000 + 12000)
                   annotation (Placement(transformation(extent={{-40,50},{-20,
            70}})));
  Buildings.Fluid.FixedResistances.PressureDrop res_2(
    from_dp=true,
    redeclare package Medium = Medium2,
    dp_nominal=100,
    m_flow_nominal=m2_flow_nominal)
    annotation (Placement(transformation(extent={{-20,10},{-40,30}})));
  Buildings.Fluid.FixedResistances.PressureDrop res_1(
    from_dp=true,
    redeclare package Medium = Medium1,
    dp_nominal=3000,
    m_flow_nominal=m1_flow_nominal)
    annotation (Placement(transformation(extent={{90,50},{110,70}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort temSen(redeclare package Medium =
               Medium2, m_flow_nominal=m2_flow_nominal)
    annotation (Placement(transformation(extent={{20,10},{0,30}})));
  Buildings.Fluid.Actuators.Valves.TwoWayEqualPercentage val(
    redeclare package Medium = Medium1,
    m_flow_nominal=m1_flow_nominal,
    dpValve_nominal=6000) "Valve model"           annotation (Placement(
        transformation(extent={{30,50},{50,70}})));
  Modelica.Blocks.Sources.TimeTable TSet(table=[0,288.15; 600,288.15; 600,
        298.15; 1200,298.15; 1800,283.15; 2400,283.15; 2400,288.15])
    "Setpoint temperature" annotation (Placement(transformation(extent={{-40,90},
            {-20,110}})));
  Buildings.Fluid.HeatExchangers.WetCoilCounterFlow hex(
    redeclare package Medium1 = Medium1,
    redeclare package Medium2 = Medium2,
    m1_flow_nominal=m1_flow_nominal,
    m2_flow_nominal=m2_flow_nominal,
    dp2_nominal(displayUnit="Pa") = 200,
    allowFlowReversal1=true,
    allowFlowReversal2=true,
    dp1_nominal(displayUnit="Pa") = 3000,
    UA_nominal=2*m1_flow_nominal*4200*(T_a1_nominal - T_b1_nominal)/
      Buildings.Fluid.HeatExchangers.BaseClasses.lmtd(
        T_a1_nominal,
        T_b1_nominal,
        T_a2_nominal,
        T_b2_nominal),
    show_T=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
                             annotation (Placement(transformation(extent={{60,
            16},{80,36}})));
  Modelica.Blocks.Sources.Constant const(k=0.8)
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
  Buildings.Utilities.Psychrometrics.X_pTphi x_pTphi(use_p_in=false)
    annotation (Placement(transformation(extent={{150,-42},{170,-22}})));
  Modelica.Blocks.Sources.Constant const1(k=T_a2_nominal)
    annotation (Placement(transformation(extent={{100,-38},{120,-18}})));
=======
  extends Buildings.Fluid.HeatExchangers.Examples.BaseClasses.PartialWetCoilCounterFlow;

>>>>>>> master
  Buildings.Controls.Continuous.LimPID con(
    Td=1,
    reverseActing=false,
    yMin=0,
    k=0.1,
    Ti=60) "Controller"
    annotation (Placement(transformation(extent={{0,90},{20,110}})));
equation
  connect(con.u_m, temSen.T)
    annotation (Line(points={{10,88},{10,31}}, color={0,0,127}));
  connect(TSet.y, con.u_s)
    annotation (Line(points={{-59,100},{-2,100}}, color={0,0,127}));
  connect(con.y, val.y)
    annotation (Line(points={{21,100},{40,100},{40,72}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{200,200}})),
experiment(Tolerance=1e-6, StopTime=3600),
__Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Fluid/HeatExchangers/Examples/WetCoilCounterFlowPControl.mos"
        "Simulate and plot"),
Documentation(info="<html>
<p>
This model demonstrates the use of
<a href=\"modelica://Buildings.Fluid.HeatExchangers.WetCoilCounterFlow\">
Buildings.Fluid.HeatExchangers.WetCoilCounterFlow</a>.
The valve on the water-side is regulated to track a setpoint temperature
for the air outlet.
</p>
</html>",
revisions="<html>
<ul>
<li>
December 14, 2023 by Jianjun Hu:<br/>
Reduced the nominal airflow rate and the water temperature.
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/3607\">#3607</a>.
</li>
<li>
December 22, 2014 by Michael Wetter:<br/>
Removed <code>Modelica.Fluid.System</code>
to address issue
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/311\">#311</a>.
</li>
<li>
March 1, 2013, by Michael Wetter:<br/>
Added nominal pressure drop for valve as
this parameter no longer has a default value.
</li>
<li>
May 27, 2010, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end WetCoilCounterFlowPControl;
