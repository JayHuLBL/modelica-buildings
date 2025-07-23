within Buildings.Controls.OBC.ASHRAE.G36.Types;
type OutdoorAirSection = enumeration(
<<<<<<< HEAD
    DedicatedDampersAirflow   "Separate dedicated OA dampers with AFMS",
    DedicatedDampersPressure   "Separate dedicated OA dampers with differential pressure sensor",
    NoEconomizer   "No economizer",
    SingleDamper   "Single common OA damper with AFMS")
=======
    DedicatedDampersAirflow   "Separate dampers for ventilation and economizer, with airflow measurement station",
    DedicatedDampersPressure   "Separate dampers for ventilation and economizer, with differential pressure sensor",
    SingleDamper   "Single damper for ventilation and economizer, with airflow measurement station")
>>>>>>> master
  "Enumeration to configure the outdoor air section"
annotation (
 Evaluate=true, Documentation(info="<html>
<p>
Enumeration to define how minimum outdoor air and economizer function being
designed in multizone AHU. Possible values are:
</p>
<table border=\"1\" summary=\"Explanation of the enumeration\">
<tr>
<th>Enumeration</th>
<th>Description</th></tr>
<tr><td><code>DedicatedDampersAirflow</code></td>
<td>
<<<<<<< HEAD
Minimum outdoor air and economizer function use separate dampers, with airflow measurement.
</td></tr>
<tr><td><code>DedicatedDampersPressure</code></td>
<td>
Minimum outdoor air and economizer function use separate dampers, with differential pressure measurement.
</td></tr>
<tr><td><code>NoEconomizer</code></td>
<td>
No economizer.
</td></tr>
<tr><td><code>SingleDamper</code></td>
<td>
Minimum outdoor air and economizer function use single common damper.
=======
Separate dampers for ventilation and economizer, with airflow measurement station.
</td></tr>
<tr><td><code>DedicatedDampersPressure</code></td>
<td>
Separate dampers for ventilation and economizer, with differential pressure sensor.
</td></tr>
<tr><td><code>SingleDamper</code></td>
<td>
Single damper for ventilation and economizer, with airflow measurement station.
>>>>>>> master
</td></tr>
</table>
</html>", revisions="<html>
<ul>
<li>
<<<<<<< HEAD
=======
December 15, 2022, by Jianjun Hu:<br/>
Removed the no-economizer option.<br/>
This is for <a href=\"https://github.com/lbl-srg/modelica-buildings/issues/3139\">issue 3139</a>.
</li>
<li>
>>>>>>> master
August 1, 2020, by Jianjun Hu:<br/>
First implementation.
</li>
</ul>
</html>"));
