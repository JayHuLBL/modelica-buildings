<<<<<<<< HEAD:Buildings/ThermalZones/EnergyPlus_9_6_0/Validation/MultipleBuildings/TwoIdenticalOneZoneBuildings.mo
within Buildings.ThermalZones.EnergyPlus_9_6_0.Validation.MultipleBuildings;
========
within Buildings.ThermalZones.EnergyPlus_24_2_0.Validation.MultipleBuildings;
>>>>>>>> master:Buildings/ThermalZones/EnergyPlus_24_2_0/Validation/MultipleBuildings/TwoIdenticalOneZoneBuildings.mo
model TwoIdenticalOneZoneBuildings
  "Validation model with two identical buildings, each having one thermal zone"
  extends Modelica.Icons.Example;
  constant Integer n=2
    "Number of buildings";
  Zone bui[n]
    "Buildings"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  model Zone
    "Model of a thermal zone"
<<<<<<<< HEAD:Buildings/ThermalZones/EnergyPlus_9_6_0/Validation/MultipleBuildings/TwoIdenticalOneZoneBuildings.mo
    extends Buildings.ThermalZones.EnergyPlus_9_6_0.Examples.SingleFamilyHouse.Unconditioned;
========
    extends Buildings.ThermalZones.EnergyPlus_24_2_0.Examples.SingleFamilyHouse.Unconditioned;
>>>>>>>> master:Buildings/ThermalZones/EnergyPlus_24_2_0/Validation/MultipleBuildings/TwoIdenticalOneZoneBuildings.mo
    extends Modelica.Blocks.Icons.Block;
  end Zone;
  annotation (
    Documentation(
      info="<html>
<p>
Model that validates that multiple buildings can be simulated that use the same EnergyPlus idf file.
The model has two identical buildings, each having one thermal zone.
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
<<<<<<<< HEAD:Buildings/ThermalZones/EnergyPlus_9_6_0/Validation/MultipleBuildings/TwoIdenticalOneZoneBuildings.mo
      file="modelica://Buildings/Resources/Scripts/Dymola/ThermalZones/EnergyPlus_9_6_0/Validation/MultipleBuildings/TwoIdenticalOneZoneBuildings.mos" "Simulate and plot"),
========
      file="modelica://Buildings/Resources/Scripts/Dymola/ThermalZones/EnergyPlus_24_2_0/Validation/MultipleBuildings/TwoIdenticalOneZoneBuildings.mos" "Simulate and plot"),
>>>>>>>> master:Buildings/ThermalZones/EnergyPlus_24_2_0/Validation/MultipleBuildings/TwoIdenticalOneZoneBuildings.mo
    experiment(
      StopTime=172800,
      Tolerance=1e-06));
end TwoIdenticalOneZoneBuildings;
