<<<<<<< HEAD:Buildings/Experimental/DHC/EnergyTransferStations/Combined/Validation/ChillerOnly.mo
within Buildings.Experimental.DHC.EnergyTransferStations.Combined.Validation;
model ChillerOnly
  "Validation of the ETS model with heat recovery chiller"
  extends Buildings.Experimental.DHC.EnergyTransferStations.Combined.Validation.BaseClasses.PartialChillerBorefield;
=======
within Buildings.DHC.ETS.Combined.Validation;
model ChillerOnly
  "Validation of the ETS model with heat recovery chiller"
  extends Buildings.DHC.ETS.Combined.Validation.BaseClasses.PartialChillerBorefield;
>>>>>>> master:Buildings/DHC/ETS/Combined/Validation/ChillerOnly.mo
  Modelica.Blocks.Sources.CombiTimeTable TDisWatSup(
    tableName="tab1",
    table=[
      0,11;
      49,11;
      50,20;
      100,20],
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    timeScale=3600,
    offset={273.15},
    columns={2},
    smoothness=Modelica.Blocks.Types.Smoothness.MonotoneContinuousDerivative1)
    "District water supply temperature"
    annotation (Placement(transformation(extent={{-330,-150},{-310,-130}})));
equation
  connect(loa.y[2],heaLoaNor.u)
    annotation (Line(points={{-309,160},{-300,160},{-300,60},{-252,60}},color={0,0,127}));
  connect(loa.y[1],loaCooNor.u)
    annotation (Line(points={{-309,160},{280,160},{280,60},{272,60}},color={0,0,127}));
  annotation (
    __Dymola_Commands(
<<<<<<< HEAD:Buildings/Experimental/DHC/EnergyTransferStations/Combined/Validation/ChillerOnly.mo
      file="modelica://Buildings/Resources/Scripts/Dymola/Experimental/DHC/EnergyTransferStations/Combined/Validation/ChillerOnly.mos" "Simulate and plot"),
=======
      file="modelica://Buildings/Resources/Scripts/Dymola/DHC/ETS/Combined/Validation/ChillerOnly.mos" "Simulate and plot"),
>>>>>>> master:Buildings/DHC/ETS/Combined/Validation/ChillerOnly.mo
    experiment(
      StopTime=360000,
      Tolerance=1e-06),
    Documentation(
      revisions="<html>
<ul>
<li>
November 22, 2024, by Michael Wetter:<br/>
Removed duplicate connection.
</li>
<li>
July 31, 2020, by Antoine Gautier:<br/>
First implementation.
</li>
</ul>
</html>",
      info="<html>
<p>
This model validates
<<<<<<< HEAD:Buildings/Experimental/DHC/EnergyTransferStations/Combined/Validation/ChillerOnly.mo
<a href=\"modelica://Buildings.Experimental.DHC.EnergyTransferStations.Combined.ChillerBorefield\">
Buildings.Experimental.DHC.EnergyTransferStations.Combined.ChillerBorefield</a>
=======
<a href=\"modelica://Buildings.DHC.ETS.Combined.ChillerBorefield\">
Buildings.DHC.ETS.Combined.ChillerBorefield</a>
>>>>>>> master:Buildings/DHC/ETS/Combined/Validation/ChillerOnly.mo
in a system configuration with no geothermal borefield.
</p>
<ul>
<li>
A fictitious load profile is used, consisting in the succession of five load
patterns.
</li>
<li>
Each load pattern is simulated with two values of the district water supply
temperature, corresponding to typical extreme values over a whole year
 of operation.
</li>
<li>
The other modeling assumptions are described in
<<<<<<< HEAD:Buildings/Experimental/DHC/EnergyTransferStations/Combined/Validation/ChillerOnly.mo
<a href=\"modelica://Buildings.Experimental.DHC.EnergyTransferStations.Combined.Validation.BaseClasses.PartialChillerBorefield\">
Buildings.Experimental.DHC.EnergyTransferStations.Combined.Validation.BaseClasses.PartialChillerBorefield</a>.
=======
<a href=\"modelica://Buildings.DHC.ETS.Combined.Validation.BaseClasses.PartialChillerBorefield\">
Buildings.DHC.ETS.Combined.Validation.BaseClasses.PartialChillerBorefield</a>.
>>>>>>> master:Buildings/DHC/ETS/Combined/Validation/ChillerOnly.mo
</li>
</ul>
</html>"));
end ChillerOnly;
