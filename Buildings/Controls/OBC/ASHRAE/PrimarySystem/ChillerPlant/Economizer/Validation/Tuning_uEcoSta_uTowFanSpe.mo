within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Economizer.Validation;
model Tuning_uEcoSta_uTowFanSpe
  "Validate water side economizer tuning parameter sequence"

  CDL.Logical.Sources.Pulse ecoSta(width=0.5, period=2*20*60)
    "Water side economizer enable/disable status"
    annotation (Placement(transformation(extent={{-120,100},{-100,120}})));
  Tuning wseTun
    "Tests tuning parameter increase due to a dip in tower fan speed"
                annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
  CDL.Continuous.Sources.Sine sin(
    amplitude=0.2,
    offset=1.1,
    freqHz=1/(30*60),
    phase=3.1415926535898)
    annotation (Placement(transformation(extent={{-120,18},{-100,38}})));
  CDL.Continuous.Min min
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  CDL.Continuous.Sources.Constant maxTowFanSig(k=1)
    "Cooling tower fan full load signal"
    annotation (Placement(transformation(extent={{-120,58},{-100,78}})));
  CDL.Logical.Sources.Pulse ecoSta1(width=0.5, period=2*40*60)
    "Water side economizer enable/disable status"
    annotation (Placement(transformation(extent={{20,100},{40,120}})));
  Tuning wseTun1
    "Tests tuning parameter constant inspite of a dip in tower fan speed due to the prolonged WSE on status"
                annotation (Placement(transformation(extent={{100,60},{120,80}})));
  CDL.Continuous.Sources.Sine sin1(
    amplitude=0.2,
    offset=1.1,
    freqHz=1/(30*60),
    phase=3.1415926535898)
    annotation (Placement(transformation(extent={{20,18},{40,38}})));
  CDL.Continuous.Min min1
    annotation (Placement(transformation(extent={{60,40},{80,60}})));
  CDL.Continuous.Sources.Constant maxTowFanSig1(k=1)
    "Cooling tower fan full load signal"
    annotation (Placement(transformation(extent={{20,58},{40,78}})));
  CDL.Logical.Sources.Pulse ecoSta2(width=0.5, period=2*65*60)
    "Water side economizer enable/disable status"
    annotation (Placement(transformation(extent={{-120,-40},{-100,-20}})));
  Tuning wseTun2
    "Tests tuning parameter decrease due to WSE being on for a long time before disable"
                annotation (Placement(transformation(extent={{-40,-80},{-20,-60}})));
  CDL.Continuous.Sources.Constant constTowFanSig(k=1)
    "Cooling tower fan full load signal"
    annotation (Placement(transformation(extent={{-120,-100},{-100,-80}})));
equation

  connect(maxTowFanSig.y, min.u1) annotation (Line(points={{-99,68},{-90,68},{-90,
          56},{-82,56}},       color={0,0,127}));
  connect(sin.y, min.u2) annotation (Line(points={{-99,28},{-92,28},{-92,44},{-82,
          44}},       color={0,0,127}));
  connect(min.y, wseTun.uTowFanSpe) annotation (Line(points={{-59,50},{-50,50},{
          -50,65},{-42,65}},
                           color={0,0,127}));
  connect(ecoSta.y, wseTun.uEcoSta) annotation (Line(points={{-99,110},{-70,110},
          {-70,75},{-42,75}},
                            color={255,0,255}));
  connect(maxTowFanSig1.y, min1.u1) annotation (Line(points={{41,68},{50,68},{50,
          56},{58,56}}, color={0,0,127}));
  connect(sin1.y, min1.u2) annotation (Line(points={{41,28},{48,28},{48,44},{58,
          44}}, color={0,0,127}));
  connect(min1.y, wseTun1.uTowFanSpe) annotation (Line(points={{81,50},{90,50},{
          90,65},{98,65}}, color={0,0,127}));
  connect(ecoSta1.y, wseTun1.uEcoSta) annotation (Line(points={{41,110},{70,110},
          {70,75},{98,75}}, color={255,0,255}));
  connect(ecoSta2.y, wseTun2.uEcoSta) annotation (Line(points={{-99,-30},{-70,-30},
          {-70,-65},{-42,-65}}, color={255,0,255}));
  connect(constTowFanSig.y, wseTun2.uTowFanSpe) annotation (Line(points={{-99,-90},
          {-72,-90},{-72,-75},{-42,-75}}, color={0,0,127}));
annotation (
 experiment(StopTime=4200.0, Tolerance=1e-06),
  __Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Controls/OBC/ASHRAE/PrimarySystem/ChillerPlant/Economizer/Validation/Tuning_uEcoSta_uTowFanSpe.mos"
    "Simulate and plot"),
  Documentation(info="<html>
<p>
This example validates
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Economizer.Tuning\">
Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Economizer.Tuning</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
October 15, 2018, by Milica Grahovac:<br/>
First implementation.
</li>
</ul>
</html>"),
Icon(graphics={
        Ellipse(lineColor = {75,138,73},
                fillColor={255,255,255},
                fillPattern = FillPattern.Solid,
                extent = {{-100,-100},{100,100}}),
        Polygon(lineColor = {0,0,255},
                fillColor = {75,138,73},
                pattern = LinePattern.None,
                fillPattern = FillPattern.Solid,
                points = {{-36,60},{64,0},{-36,-60},{-36,60}})}),Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-140,-120},{140,140}})));
end Tuning_uEcoSta_uTowFanSpe;