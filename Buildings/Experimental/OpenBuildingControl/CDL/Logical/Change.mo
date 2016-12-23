within Buildings.Experimental.OpenBuildingControl.CDL.Logical;
block Change
  "Output y is true, if the input u has a rising or falling edge (y = change(u))"

  parameter Boolean pre_u_start=false "Start value of pre(u) at initial time";

  Modelica.Blocks.Interfaces.BooleanInput u "Connector of Boolean input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));

  Modelica.Blocks.Interfaces.BooleanOutput y "Connector of Boolean output signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));

initial equation
  pre(u) = pre_u_start;
equation
  y = change(u);
  annotation (
    defaultComponentName="change1",
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          lineThickness=5.0,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          borderPattern=BorderPattern.Raised),
                              Text(
          extent={{-50,62},{50,-56}},
          lineColor={0,0,0},
          textString="change"),
        Ellipse(
          extent={{71,7},{85,-7}},
          lineColor=DynamicSelect({235,235,235}, if y > 0.5 then {0,255,0}
               else {235,235,235}),
          fillColor=DynamicSelect({235,235,235}, if y > 0.5 then {0,255,0}
               else {235,235,235}),
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<p>
Block that outputs <code>true</code> if the Boolean input has either a rising edge
from <code>false</code> to <code>true</code> or a falling edge from
<code>true</code> to <code>false</code>.
Otherwise the output is <code>false</code>.
</p>
</html>"));
end Change;