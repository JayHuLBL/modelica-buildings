<<<<<<<< HEAD:Buildings/ThermalZones/EnergyPlus_9_6_0/Validation/OutputVariable/OneEnvironmentOutputVariable.mo
within Buildings.ThermalZones.EnergyPlus_9_6_0.Validation.OutputVariable;
========
within Buildings.ThermalZones.EnergyPlus_24_2_0.Validation.OutputVariable;
>>>>>>>> master:Buildings/ThermalZones/EnergyPlus_24_2_0/Validation/OutputVariable/OneEnvironmentOutputVariable.mo
model OneEnvironmentOutputVariable
  "Validation model that has only one output variable from the environment conditions reported to Modelica"
  extends Modelica.Icons.Example;
  inner Building building(
<<<<<<<< HEAD:Buildings/ThermalZones/EnergyPlus_9_6_0/Validation/OutputVariable/OneEnvironmentOutputVariable.mo
    idfName=Modelica.Utilities.Files.loadResource("modelica://Buildings/Resources/Data/ThermalZones/EnergyPlus_9_6_0/Examples/SingleFamilyHouse_TwoSpeed_ZoneAirBalance/SingleFamilyHouse_TwoSpeed_ZoneAirBalance.idf"),
========
    idfName=Modelica.Utilities.Files.loadResource("modelica://Buildings/Resources/Data/ThermalZones/EnergyPlus_24_2_0/Examples/SingleFamilyHouse_TwoSpeed_ZoneAirBalance/SingleFamilyHouse_TwoSpeed_ZoneAirBalance.idf"),
>>>>>>>> master:Buildings/ThermalZones/EnergyPlus_24_2_0/Validation/OutputVariable/OneEnvironmentOutputVariable.mo
    epwName=Modelica.Utilities.Files.loadResource("modelica://Buildings/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.epw"),
    weaName=Modelica.Utilities.Files.loadResource("modelica://Buildings/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos"),
    computeWetBulbTemperature=false)
    "Building model"
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));

<<<<<<<< HEAD:Buildings/ThermalZones/EnergyPlus_9_6_0/Validation/OutputVariable/OneEnvironmentOutputVariable.mo
  Buildings.ThermalZones.EnergyPlus_9_6_0.OutputVariable TEnePlu(
========
  Buildings.ThermalZones.EnergyPlus_24_2_0.OutputVariable TEnePlu(
>>>>>>>> master:Buildings/ThermalZones/EnergyPlus_24_2_0/Validation/OutputVariable/OneEnvironmentOutputVariable.mo
    name="Site Outdoor Air Drybulb Temperature",
    key="Environment",
    y(final unit="K", displayUnit="degC"))
    "Block that reads an EnergyPlus output variable"
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    __Dymola_Commands(
<<<<<<<< HEAD:Buildings/ThermalZones/EnergyPlus_9_6_0/Validation/OutputVariable/OneEnvironmentOutputVariable.mo
      file="modelica://Buildings/Resources/Scripts/Dymola/ThermalZones/EnergyPlus_9_6_0/Validation/OutputVariable/OneEnvironmentOutputVariable.mos" "Simulate and plot"),
========
      file="modelica://Buildings/Resources/Scripts/Dymola/ThermalZones/EnergyPlus_24_2_0/Validation/OutputVariable/OneEnvironmentOutputVariable.mos" "Simulate and plot"),
>>>>>>>> master:Buildings/ThermalZones/EnergyPlus_24_2_0/Validation/OutputVariable/OneEnvironmentOutputVariable.mo
    experiment(
      StartTime=864000,
      StopTime=950400,
      Tolerance=1e-06),
    Documentation(info="<html>
<p>
Simple test case for one building in which only an EnergyPlus output variable is read.
</p>
<p>
In this model, the site drybulb temperature is obtained from EnergyPlus.
Note that this variable could be read directly from the Modelica weather data bus,
which can be accessed from
<<<<<<<< HEAD:Buildings/ThermalZones/EnergyPlus_9_6_0/Validation/OutputVariable/OneEnvironmentOutputVariable.mo
<a href=\"Buildings.ThermalZones.EnergyPlus_9_6_0.Building\">
Buildings.ThermalZones.EnergyPlus_9_6_0.Building</a>.
========
<a href=\"modelica://Buildings.ThermalZones.EnergyPlus_24_2_0.Building\">
Buildings.ThermalZones.EnergyPlus_24_2_0.Building</a>.
>>>>>>>> master:Buildings/ThermalZones/EnergyPlus_24_2_0/Validation/OutputVariable/OneEnvironmentOutputVariable.mo
</p>
</html>", revisions="<html>
<ul>
<li>
May 28, 2021, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end OneEnvironmentOutputVariable;
