<<<<<<<< HEAD:Buildings/ThermalZones/EnergyPlus_9_6_0/Validation/OutputVariable/OneZoneOneOutputVariableSummer.mo
within Buildings.ThermalZones.EnergyPlus_9_6_0.Validation.OutputVariable;
model OneZoneOneOutputVariableSummer
  "Validation model for one zone with one output variable for a summer period"
  extends Buildings.ThermalZones.EnergyPlus_9_6_0.Validation.OutputVariable.OneZoneOneOutputVariable;
========
within Buildings.ThermalZones.EnergyPlus_24_2_0.Validation.OutputVariable;
model OneZoneOneOutputVariableSummer
  "Validation model for one zone with one output variable for a summer period"
  extends Buildings.ThermalZones.EnergyPlus_24_2_0.Validation.OutputVariable.OneZoneOneOutputVariable;
>>>>>>>> master:Buildings/ThermalZones/EnergyPlus_24_2_0/Validation/OutputVariable/OneZoneOneOutputVariableSummer.mo
  annotation (
    Documentation(
      info="<html>
<p>
Test case identical to
<<<<<<<< HEAD:Buildings/ThermalZones/EnergyPlus_9_6_0/Validation/OutputVariable/OneZoneOneOutputVariableSummer.mo
<a href=\"modelica://Buildings.ThermalZones.EnergyPlus_9_6_0.Validation.OutputVariable.OneZoneOneOutputVariable\">
Buildings.ThermalZones.EnergyPlus_9_6_0.Validation.OutputVariable.OneZoneOneOutputVariable</a>
========
<a href=\"modelica://Buildings.ThermalZones.EnergyPlus_24_2_0.Validation.OutputVariable.OneZoneOneOutputVariable\">
Buildings.ThermalZones.EnergyPlus_24_2_0.Validation.OutputVariable.OneZoneOneOutputVariable</a>
>>>>>>>> master:Buildings/ThermalZones/EnergyPlus_24_2_0/Validation/OutputVariable/OneZoneOneOutputVariableSummer.mo
but simulating only a period in summer.
</p>
<p>
This example tests whether the start and end time can be set in Modelica independently
from the EnergyPlus idf file.
</p>
</html>",
      revisions="<html>
<ul><li>
April 2, 2020, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"),
    __Dymola_Commands(
<<<<<<<< HEAD:Buildings/ThermalZones/EnergyPlus_9_6_0/Validation/OutputVariable/OneZoneOneOutputVariableSummer.mo
      file="modelica://Buildings/Resources/Scripts/Dymola/ThermalZones/EnergyPlus_9_6_0/Validation/OutputVariable/OneZoneOneOutputVariableSummer.mos" "Simulate and plot"),
========
      file="modelica://Buildings/Resources/Scripts/Dymola/ThermalZones/EnergyPlus_24_2_0/Validation/OutputVariable/OneZoneOneOutputVariableSummer.mos" "Simulate and plot"),
>>>>>>>> master:Buildings/ThermalZones/EnergyPlus_24_2_0/Validation/OutputVariable/OneZoneOneOutputVariableSummer.mo
    experiment(
      StartTime=18748800,
      StopTime=19353600,
      Tolerance=1e-06));
end OneZoneOneOutputVariableSummer;
