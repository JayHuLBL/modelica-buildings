<<<<<<<< HEAD:Buildings/ThermalZones/EnergyPlus_9_6_0/Validation/MultipleBuildings/TwoIdenticalTwoZoneBuildings.mo
within Buildings.ThermalZones.EnergyPlus_9_6_0.Validation.MultipleBuildings;
========
within Buildings.ThermalZones.EnergyPlus_24_2_0.Validation.MultipleBuildings;
>>>>>>>> master:Buildings/ThermalZones/EnergyPlus_24_2_0/Validation/MultipleBuildings/TwoIdenticalTwoZoneBuildings.mo
model TwoIdenticalTwoZoneBuildings
  "Validation model with two identical buildings, each having two thermal zones"
  extends Modelica.Icons.Example;
  constant Integer n=2
    "Number of buildings";
  Zone bui[n]
    "Buildings"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  model Zone
    "Model of a thermal zone"
<<<<<<<< HEAD:Buildings/ThermalZones/EnergyPlus_9_6_0/Validation/MultipleBuildings/TwoIdenticalTwoZoneBuildings.mo
    extends Buildings.ThermalZones.EnergyPlus_9_6_0.Validation.ThermalZone.TwoIdenticalZones;
========
    extends Buildings.ThermalZones.EnergyPlus_24_2_0.Validation.ThermalZone.TwoIdenticalZones;
>>>>>>>> master:Buildings/ThermalZones/EnergyPlus_24_2_0/Validation/MultipleBuildings/TwoIdenticalTwoZoneBuildings.mo
    extends Modelica.Blocks.Icons.Block;
  end Zone;
  annotation (
    Documentation(
      info="<html>
<p>
Model that validates that multiple buildings can be simulated that use the same EnergyPlus idf file.
The model has two identical buildings, each having two thermal zones.
</p>
<p>
This model has been added because a building with multiple thermal zones executes
C code that is not executed if there is only one thermal zone, as is the case in
<<<<<<<< HEAD:Buildings/ThermalZones/EnergyPlus_9_6_0/Validation/MultipleBuildings/TwoIdenticalTwoZoneBuildings.mo
<a href=\"modelica://Buildings.ThermalZones.EnergyPlus_9_6_0.Validation.MultipleBuildings.TwoIdenticalOneZoneBuildings\">
Buildings.ThermalZones.EnergyPlus_9_6_0.Validation.MultipleBuildings.TwoIdenticalOneZoneBuildings</a>.
========
<a href=\"modelica://Buildings.ThermalZones.EnergyPlus_24_2_0.Validation.MultipleBuildings.TwoIdenticalOneZoneBuildings\">
Buildings.ThermalZones.EnergyPlus_24_2_0.Validation.MultipleBuildings.TwoIdenticalOneZoneBuildings</a>.
>>>>>>>> master:Buildings/ThermalZones/EnergyPlus_24_2_0/Validation/MultipleBuildings/TwoIdenticalTwoZoneBuildings.mo
</p>
</html>",
      revisions="<html>
<ul>
<li>
October 1, 2019, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"),
    __Dymola_Commands(
<<<<<<<< HEAD:Buildings/ThermalZones/EnergyPlus_9_6_0/Validation/MultipleBuildings/TwoIdenticalTwoZoneBuildings.mo
      file="modelica://Buildings/Resources/Scripts/Dymola/ThermalZones/EnergyPlus_9_6_0/Validation/MultipleBuildings/TwoIdenticalTwoZoneBuildings.mos" "Simulate and plot"),
========
      file="modelica://Buildings/Resources/Scripts/Dymola/ThermalZones/EnergyPlus_24_2_0/Validation/MultipleBuildings/TwoIdenticalTwoZoneBuildings.mos" "Simulate and plot"),
>>>>>>>> master:Buildings/ThermalZones/EnergyPlus_24_2_0/Validation/MultipleBuildings/TwoIdenticalTwoZoneBuildings.mo
    experiment(
      StopTime=172800,
      Tolerance=1e-06));
end TwoIdenticalTwoZoneBuildings;
