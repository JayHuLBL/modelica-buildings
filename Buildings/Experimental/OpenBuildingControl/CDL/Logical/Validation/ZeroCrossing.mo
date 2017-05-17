within Buildings.Experimental.OpenBuildingControl.CDL.Logical.Validation;
model ZeroCrossing "Validation model for the ZeroCrossing block"
extends Modelica.Icons.Example;

  Buildings.Experimental.OpenBuildingControl.CDL.Sources.Ramp ramp1(
    duration=5,
    offset=0,
    height=31.415926) "Block that generates ramp signal"
    annotation (Placement(transformation(extent={{-82,-10},{-62,10}})));
  Buildings.Experimental.OpenBuildingControl.CDL.Continuous.Sin sin1
    "Block that outputs the sine of the input"
    annotation (Placement(transformation(extent={{-38,-10},{-18,10}})));

   Buildings.Experimental.OpenBuildingControl.CDL.Sources.BooleanPulse booPul1(
     width = 0.15,
     period = 5)
     "Block that outputs cyclic on and off"
     annotation (Placement(transformation(extent={{-38,-44},{-18,-24}})));
    Buildings.Experimental.OpenBuildingControl.CDL.Logical.ZeroCrossing zeroCrossing
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));


  Buildings.Experimental.OpenBuildingControl.CDL.Discrete.TriggeredSampler triggeredSampler(
    samplePeriod = 0.2)
    "Output the triggered sampled value of a continuous signal"
    annotation (Placement(transformation(extent={{42,44},{62,64}})));
  Buildings.Experimental.OpenBuildingControl.CDL.Sources.Ramp ramp2(
    duration=5,
    offset=0,
    height=31.415926) "Block that generates ramp signal"
    annotation (Placement(transformation(extent={{0,44},{20,64}})));

equation
  connect(booPul1.y, zeroCrossing.enable) annotation (Line(points={{-17,-34},{
          10,-34},{10,-12}},color={255,0,255}));
  connect(ramp1.y, sin1.u)
    annotation (Line(points={{-61,0},{-50.5,0},{-40,0}},    color={0,0,127}));
  connect(sin1.y, zeroCrossing.u)
    annotation (Line(points={{-17,0},{-2,0}},         color={0,0,127}));
  connect(zeroCrossing.y, triggeredSampler.trigger) annotation (Line(points={{21,0},{
          32,0},{32,42.2},{52,42.2}},  color={255,0,255}));
  connect(ramp2.y, triggeredSampler.u)
    annotation (Line(points={{21,54},{40,54}}, color={0,0,127}));
  annotation (
  experiment(StopTime=5.0, Tolerance=1e-06),
  __Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Experimental/OpenBuildingControl/CDL/Logical/Validation/ZeroCrossing.mos"
        "Simulate and plot"),
    Documentation(info="<html>
<p>
Validation test for the block
<a href=\"modelica://Buildings.Experimental.OpenBuildingControl.CDL.Logical.ZeroCrossing\">
Buildings.Experimental.OpenBuildingControl.CDL.Logical.ZeroCrossing</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
April 2, 2017, by Jianjun Hu:<br/>
First implementation.
</li>
</ul>

</html>"));
end ZeroCrossing;