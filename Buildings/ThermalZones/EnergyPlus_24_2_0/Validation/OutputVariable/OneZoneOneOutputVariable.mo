<<<<<<<< HEAD:Buildings/ThermalZones/EnergyPlus_9_6_0/Validation/OutputVariable/OneZoneOneOutputVariable.mo
within Buildings.ThermalZones.EnergyPlus_9_6_0.Validation.OutputVariable;
model OneZoneOneOutputVariable
  "Validation model for one zone with one output variable"
  extends Buildings.ThermalZones.EnergyPlus_9_6_0.Examples.SingleFamilyHouse.Unconditioned;
  Buildings.ThermalZones.EnergyPlus_9_6_0.OutputVariable equEle(
========
within Buildings.ThermalZones.EnergyPlus_24_2_0.Validation.OutputVariable;
model OneZoneOneOutputVariable
  "Validation model for one zone with one output variable"
  extends Buildings.ThermalZones.EnergyPlus_24_2_0.Examples.SingleFamilyHouse.Unconditioned;
  Buildings.ThermalZones.EnergyPlus_24_2_0.OutputVariable equEle(
>>>>>>>> master:Buildings/ThermalZones/EnergyPlus_24_2_0/Validation/OutputVariable/OneZoneOneOutputVariable.mo
    name="Zone Electric Equipment Electricity Rate",
    key="LIVING ZONE",
    y(final unit="W"))
    "Block that reads output from EnergyPlus"
    annotation (Placement(transformation(extent={{60,30},{80,50}})));
  annotation (
    Documentation(
      info="<html>
<p>
Simple test case for one building with one thermal zone and one output variable.
</p>
<p>
The room air temperature is free floating.
</p>
</html>",
      revisions="<html>
<ul><li>
October 7, 2019, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"),
    __Dymola_Commands(
<<<<<<<< HEAD:Buildings/ThermalZones/EnergyPlus_9_6_0/Validation/OutputVariable/OneZoneOneOutputVariable.mo
      file="modelica://Buildings/Resources/Scripts/Dymola/ThermalZones/EnergyPlus_9_6_0/Validation/OutputVariable/OneZoneOneOutputVariable.mos" "Simulate and plot"),
========
      file="modelica://Buildings/Resources/Scripts/Dymola/ThermalZones/EnergyPlus_24_2_0/Validation/OutputVariable/OneZoneOneOutputVariable.mos" "Simulate and plot"),
>>>>>>>> master:Buildings/ThermalZones/EnergyPlus_24_2_0/Validation/OutputVariable/OneZoneOneOutputVariable.mo
    experiment(
      StopTime=432000,
      Tolerance=1e-06));
end OneZoneOneOutputVariable;
