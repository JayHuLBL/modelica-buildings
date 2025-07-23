<<<<<<<< HEAD:Buildings/ThermalZones/EnergyPlus_9_6_0/Validation/OutputVariable/OneZoneTwoIdenticalOutputVariables.mo
within Buildings.ThermalZones.EnergyPlus_9_6_0.Validation.OutputVariable;
model OneZoneTwoIdenticalOutputVariables
  "Validation model for one zone with two identical output variables"
  extends OneZoneOneOutputVariable;
  Buildings.ThermalZones.EnergyPlus_9_6_0.OutputVariable equEle2(
========
within Buildings.ThermalZones.EnergyPlus_24_2_0.Validation.OutputVariable;
model OneZoneTwoIdenticalOutputVariables
  "Validation model for one zone with two identical output variables"
  extends OneZoneOneOutputVariable;
  Buildings.ThermalZones.EnergyPlus_24_2_0.OutputVariable equEle2(
>>>>>>>> master:Buildings/ThermalZones/EnergyPlus_24_2_0/Validation/OutputVariable/OneZoneTwoIdenticalOutputVariables.mo
    name="Zone Electric Equipment Electricity Rate",
    key="LIVING ZONE",
    y(final unit="W"))
    "Block that reads output from EnergyPlus"
    annotation (Placement(transformation(extent={{60,0},{80,20}})));
  annotation (
    Documentation(
      info="<html>
<p>
Simple test case for one building with one thermal zone and two identical output variables.
This test case validates that the outputs are correct even if requested twice
from the same EnergyPlus variable.
</p>
</html>",
      revisions="<html>
<ul><li>
December 13, 2019, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"),
    __Dymola_Commands(
<<<<<<<< HEAD:Buildings/ThermalZones/EnergyPlus_9_6_0/Validation/OutputVariable/OneZoneTwoIdenticalOutputVariables.mo
      file="modelica://Buildings/Resources/Scripts/Dymola/ThermalZones/EnergyPlus_9_6_0/Validation/OutputVariable/OneZoneTwoIdenticalOutputVariables.mos" "Simulate and plot"),
========
      file="modelica://Buildings/Resources/Scripts/Dymola/ThermalZones/EnergyPlus_24_2_0/Validation/OutputVariable/OneZoneTwoIdenticalOutputVariables.mos" "Simulate and plot"),
>>>>>>>> master:Buildings/ThermalZones/EnergyPlus_24_2_0/Validation/OutputVariable/OneZoneTwoIdenticalOutputVariables.mo
    experiment(
      StopTime=432000,
      Tolerance=1e-06));
end OneZoneTwoIdenticalOutputVariables;
