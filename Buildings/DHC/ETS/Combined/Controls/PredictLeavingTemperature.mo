<<<<<<< HEAD:Buildings/Experimental/DHC/EnergyTransferStations/Combined/Controls/PredictLeavingTemperature.mo
within Buildings.Experimental.DHC.EnergyTransferStations.Combined.Controls;
model PredictLeavingTemperature
  "Block that predicts heat exchanger leaving water temperature"
  extends Modelica.Blocks.Icons.Block;
  parameter Modelica.Units.SI.TemperatureDifference dTApp_nominal
    "Heat exchanger approach" annotation (Dialog(group="Nominal condition"));
  parameter Modelica.Units.SI.MassFlowRate m2_flow_nominal
    "Heat exchanger secondary mass flow rate"
    annotation (Dialog(group="Nominal condition"));
=======
within Buildings.DHC.ETS.Combined.Controls;
model PredictLeavingTemperature
  "Block that predicts heat exchanger leaving water temperature"

  parameter Real dTApp_nominal(
    final quantity="TemperatureDifference",
    final unit="K")
    "Heat exchanger approach"
    annotation (Dialog(group="Nominal condition"));
  parameter Real m2_flow_nominal(
    final quantity="MassFlowRate",
    final unit="kg/s")
    "Heat exchanger secondary mass flow rate"
    annotation (Dialog(group="Nominal condition"));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput m2_flow(
    final unit="kg/s")
    "Heat exchanger secondary mass flow rate"
    annotation (Placement(transformation(extent={{-140,60},{-100,100}}),
        iconTransformation(extent={{-140,30},{-100,70}})));
>>>>>>> master:Buildings/DHC/ETS/Combined/Controls/PredictLeavingTemperature.mo
  Buildings.Controls.OBC.CDL.Interfaces.RealInput T1WatEnt(
    final unit="K",
    displayUnit="degC")
    "Heat exchanger primary water entering temperature"
<<<<<<< HEAD:Buildings/Experimental/DHC/EnergyTransferStations/Combined/Controls/PredictLeavingTemperature.mo
    annotation (Placement(transformation(extent={{-140,-60},{-100,-20}}),
      iconTransformation(extent={{-140,-70},{-100,-30}})));
=======
    annotation (Placement(transformation(extent={{-140,-100},{-100,-60}}),
        iconTransformation(extent={{-140,-70},{-100,-30}})));
>>>>>>> master:Buildings/DHC/ETS/Combined/Controls/PredictLeavingTemperature.mo
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput T2WatLvg(
    final unit="K",
    displayUnit="degC")
    "Heat exchanger secondary water leaving temperature"
<<<<<<< HEAD:Buildings/Experimental/DHC/EnergyTransferStations/Combined/Controls/PredictLeavingTemperature.mo
    annotation (Placement(transformation(extent={{100,-20},{140,20}}),
        iconTransformation(extent={{100,-20},{140,20}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput m2_flow(
    final unit="kg/s")
    "Heat exchanger secondary mass flow rate" annotation (Placement(
        transformation(extent={{-140,20},{-100,60}}), iconTransformation(extent=
           {{-140,30},{-100,70}})));
protected
  Real ratLoa "Part load ratio";
equation
  ratLoa = min(1, abs(m2_flow / m2_flow_nominal));
  T2WatLvg = T1WatEnt + dTApp_nominal * ratLoa;
=======
    annotation (Placement(transformation(extent={{100,-50},{140,-10}}),
        iconTransformation(extent={{100,-20},{140,20}})));

  Buildings.Controls.OBC.CDL.Reals.Divide div1 "Calculate flow ratio"
    annotation (Placement(transformation(extent={{-40,50},{-20,70}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con(
    final k=m2_flow_nominal)
    "Heat exchanger secondary nominal mass flow rate"
    annotation (Placement(transformation(extent={{-80,10},{-60,30}})));
  Buildings.Controls.OBC.CDL.Reals.Min min1 "Output the smaller input"
    annotation (Placement(transformation(extent={{40,50},{60,70}})));
  Buildings.Controls.OBC.CDL.Reals.Abs abs1 "Output the absolute value"
    annotation (Placement(transformation(extent={{0,50},{20,70}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con1(
    final k=1) "One"
    annotation (Placement(transformation(extent={{0,10},{20,30}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con2(
    final k=dTApp_nominal)
    "Heat exchanger approach"
    annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
  Buildings.Controls.OBC.CDL.Reals.Multiply mul "Output product"
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  Buildings.Controls.OBC.CDL.Reals.Add add2
    "Calculate the leaving water temperature"
    annotation (Placement(transformation(extent={{60,-40},{80,-20}})));

equation
  connect(m2_flow, div1.u1) annotation (Line(points={{-120,80},{-80,80},{-80,66},
          {-42,66}}, color={0,0,127}));
  connect(con.y, div1.u2) annotation (Line(points={{-58,20},{-50,20},{-50,54},{-42,
          54}}, color={0,0,127}));
  connect(div1.y, abs1.u)
    annotation (Line(points={{-18,60},{-2,60}}, color={0,0,127}));
  connect(abs1.y, min1.u1) annotation (Line(points={{22,60},{30,60},{30,66},{38,
          66}}, color={0,0,127}));
  connect(con1.y, min1.u2) annotation (Line(points={{22,20},{30,20},{30,54},{38,
          54}}, color={0,0,127}));
  connect(con2.y, mul.u2) annotation (Line(points={{-58,-30},{-40,-30},{-40,-36},
          {-22,-36}}, color={0,0,127}));
  connect(min1.y, mul.u1) annotation (Line(points={{62,60},{70,60},{70,0},{-30,0},
          {-30,-24},{-22,-24}}, color={0,0,127}));
  connect(mul.y, add2.u1) annotation (Line(points={{2,-30},{20,-30},{20,-24},{58,
          -24}}, color={0,0,127}));
  connect(T1WatEnt, add2.u2) annotation (Line(points={{-120,-80},{40,-80},{40,-36},
          {58,-36}}, color={0,0,127}));
  connect(add2.y, T2WatLvg)
    annotation (Line(points={{82,-30},{120,-30}}, color={0,0,127}));
>>>>>>> master:Buildings/DHC/ETS/Combined/Controls/PredictLeavingTemperature.mo
annotation (
  defaultComponentName="calTemLvg",
  Documentation(
    revisions="<html>
<ul>
<li>
<<<<<<< HEAD:Buildings/Experimental/DHC/EnergyTransferStations/Combined/Controls/PredictLeavingTemperature.mo
=======
February 5, 2025, by Jianjun Hu:<br/>
Reimplemented it to comply with CDL specification.
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/4110\">Buildings, issue 4110</a>.
</li>
<li>
>>>>>>> master:Buildings/DHC/ETS/Combined/Controls/PredictLeavingTemperature.mo
July 14, 2021, by Antoine Gautier:<br/>
First implementation.
</li>
</ul>
<<<<<<< HEAD:Buildings/Experimental/DHC/EnergyTransferStations/Combined/Controls/PredictLeavingTemperature.mo
</html>",
      info="<html>
<p>
This block computes the predicted heat exchanger leaving water temperature
as used in
<a href=\"modelica://Buildings.Experimental.DHC.EnergyTransferStations.Combined.Controls.WatersideEconomizer\">
Buildings.Experimental.DHC.EnergyTransferStations.Combined.Controls.WatersideEconomizer</a>.
=======
</html>", info="<html>
<p>
This block computes the predicted heat exchanger leaving water temperature
as used in
<a href=\"modelica://Buildings.DHC.ETS.Combined.Controls.WatersideEconomizer\">
Buildings.DHC.ETS.Combined.Controls.WatersideEconomizer</a>.
>>>>>>> master:Buildings/DHC/ETS/Combined/Controls/PredictLeavingTemperature.mo
</p>
<p>
The predicted heat exchanger approach is computed as
</p>
<p>
<<<<<<< HEAD:Buildings/Experimental/DHC/EnergyTransferStations/Combined/Controls/PredictLeavingTemperature.mo
<i>dTApp = dTApp_nominal * m2_flow / m2_flow_nominal</i>.
</p>
<p>
Which gives the predicted heat exchanger leaving water temperature as
=======
<i>dTApp = dTApp_nominal * m2_flow / m2_flow_nominal</i>,
</p>
<p>
which gives the predicted heat exchanger leaving water temperature as
>>>>>>> master:Buildings/DHC/ETS/Combined/Controls/PredictLeavingTemperature.mo
</p>
<p>
<i>T2WatLvg = T1WatEnt + dTApp</i>.
</p>
<<<<<<< HEAD:Buildings/Experimental/DHC/EnergyTransferStations/Combined/Controls/PredictLeavingTemperature.mo
</html>"));
=======
</html>"),
    Icon(graphics={
        Rectangle(
          extent={{-100,-100},{100,100}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          textColor={0,0,255},
          extent={{-100,100},{102,140}},
          textString="%name")}));
>>>>>>> master:Buildings/DHC/ETS/Combined/Controls/PredictLeavingTemperature.mo
end PredictLeavingTemperature;
