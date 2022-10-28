within Buildings.Electrical.DC.Sources;
model WindTurbine
  "Wind turbine with power output based on table as a function of wind speed"
  extends Buildings.Electrical.Interfaces.PartialWindTurbine(
    redeclare package PhaseSystem =
        Buildings.Electrical.PhaseSystems.TwoConductor,
    redeclare Buildings.Electrical.DC.Interfaces.Terminal_p terminal);
protected
  Loads.Conductor con(
    mode=Buildings.Electrical.Types.Load.VariableZ_P_input,
    V_nominal=V_nominal)
    "Conductor, used to interface the power with the electrical circuit"
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
equation
  connect(con.terminal, terminal) annotation (Line(
      points={{60,6.66134e-16},{-20,6.66134e-16},{-20,0},{-100,0}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(gain.y, con.Pow) annotation (Line(
      points={{23,30},{94,30},{94,6.66134e-16},{80,6.66134e-16}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={
        Text(
          extent={{-150,70},{-50,20}},
          textColor={0,0,0},
          textString="+"),
        Text(
          extent={{-150,-12},{-50,-62}},
          textColor={0,0,0},
          textString="-")}),
    Documentation(info="<html>
<p>
Model of a wind turbine whose power is computed as a function of wind-speed as defined in a table.
</p>
<p>
Input to the model is the local wind speed.
The model requires the specification of a table that maps wind speed in meters per second to generated
power <i>P<sub>t</sub></i> in Watts.
The model has a parameter called <code>scale</code> with a default value of one
that can be used to scale the power generated by the wind turbine.
The generated DC electrical power is
</p>
<p align=\"center\" style=\"font-style:italic;\">
P = P<sub>t</sub> scale = v i,
</p>
<p>
where <i>v</i> is the voltage and <i>i</i> is the current.
For example, the following specification (with default <code>scale=1</code>) of a wind turbine
</p>
<pre>
  WindTurbine_Table tur(
    table=[3.5, 0;
           5.5,   100;
           12, 900;
           14, 1000;
           25, 1000]) \"Wind turbine\";
</pre>
<p>
yields the performance shown below. In this example, the cut-in wind speed is <i>3.5</i> meters per second,
and the cut-out wind speed is <i>25</i> meters per second,
as entered by the first and last entry of the wind speed column.
Below and above these wind speeds, the generated power is zero.
</p>
<p align=\"center\">
<img alt=\"alt-image\"  src=\"modelica://Buildings/Resources/Images/Electrical/DC/Sources/WindTurbine_Table.png\"/>
</p>
</html>", revisions="<html>
<ul>
<li>
September 24, 2015 by Michael Wetter:<br/>
Removed binding of <code>P_nominal</code> as
this parameter is disabled and assigned a value
in the <code>initial equation</code> section.
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/426\">issue 426</a>.
</li>
<li>
January 10, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end WindTurbine;
