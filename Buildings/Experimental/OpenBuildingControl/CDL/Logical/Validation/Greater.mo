within Buildings.Experimental.OpenBuildingControl.CDL.Logical.Validation;
model Greater "Validation model for the Greater block"
extends Modelica.Icons.Example;

  Buildings.Experimental.OpenBuildingControl.CDL.Sources.Ramp ramp1(
    duration=1,
    offset=-2,
    height=4)  "Block that generates ramp signal"
    annotation (Placement(transformation(extent={{-26,12},{-6,32}})));
  Buildings.Experimental.OpenBuildingControl.CDL.Sources.Ramp ramp2(
    duration=1,
    offset=-1,
    height=2) "Block that generates ramp signal"
    annotation (Placement(transformation(extent={{-26,-30},{-6,-10}})));

  Buildings.Experimental.OpenBuildingControl.CDL.Logical.Greater greater1
    annotation (Placement(transformation(extent={{26,-8},{46,12}})));

equation
  connect(ramp1.y, greater1.u1)
    annotation (Line(points={{-5,22},{8,22},{8,2},{24,2}}, color={0,0,127}));
  connect(ramp2.y, greater1.u2) annotation (Line(points={{-5,-20},{10,-20},{10,-6},
          {24,-6}}, color={0,0,127}));
  annotation (
  experiment(StopTime=1.0, Tolerance=1e-06),
  __Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Experimental/OpenBuildingControl/CDL/Logical/Validation/Greater.mos"
        "Simulate and plot"),
    Documentation(info="<html>
<p>
Validation test for the block
<a href=\"modelica://Buildings.Experimental.OpenBuildingControl.CDL.Logical.Greater\">
Buildings.Experimental.OpenBuildingControl.CDL.Logical.Greater</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
April 1, 2017, by Jianjun Hu:<br/>
First implementation.
</li>
</ul>

</html>"));
end Greater;