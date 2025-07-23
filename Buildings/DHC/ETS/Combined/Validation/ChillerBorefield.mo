<<<<<<< HEAD:Buildings/Experimental/DHC/EnergyTransferStations/Combined/Validation/ChillerBorefield.mo
within Buildings.Experimental.DHC.EnergyTransferStations.Combined.Validation;
=======
within Buildings.DHC.ETS.Combined.Validation;
>>>>>>> master:Buildings/DHC/ETS/Combined/Validation/ChillerBorefield.mo
model ChillerBorefield
  "Validation of the ETS model with heat recovery chiller and borefield"
  extends ChillerOnly(
    ets(
      have_borFie=true,
      datBorFie=datBorFie));
  parameter Integer nBorHol=64
    "Number of boreholes (must be a square number)";
  parameter Modelica.Units.SI.Distance dxy=6
    "Distance in x-axis (and y-axis) between borehole axes";
  final parameter Modelica.Units.SI.Distance cooBor[nBorHol,2]=
<<<<<<< HEAD:Buildings/Experimental/DHC/EnergyTransferStations/Combined/Validation/ChillerBorefield.mo
      Buildings.Experimental.DHC.EnergyTransferStations.BaseClasses.computeCoordinates(nBorHol, dxy)
=======
      Buildings.DHC.ETS.BaseClasses.computeCoordinates(nBorHol, dxy)
>>>>>>> master:Buildings/DHC/ETS/Combined/Validation/ChillerBorefield.mo
    "Coordinates of boreholes";
  parameter Fluid.Geothermal.Borefields.Data.Borefield.Example datBorFie(
    conDat=Fluid.Geothermal.Borefields.Data.Configuration.Example(
      dp_nominal=0,
      cooBor=cooBor))
    "Borefield design data"
    annotation (Placement(transformation(extent={{60,180},{80,200}})));
  annotation (
    __Dymola_Commands(
<<<<<<< HEAD:Buildings/Experimental/DHC/EnergyTransferStations/Combined/Validation/ChillerBorefield.mo
      file="modelica://Buildings/Resources/Scripts/Dymola/Experimental/DHC/EnergyTransferStations/Combined/Validation/ChillerBorefield.mos" "Simulate and plot"),
=======
      file="modelica://Buildings/Resources/Scripts/Dymola/DHC/ETS/Combined/Validation/ChillerBorefield.mos" "Simulate and plot"),
>>>>>>> master:Buildings/DHC/ETS/Combined/Validation/ChillerBorefield.mo
    experiment(
      StopTime=360000,
      Tolerance=1e-06),
    Documentation(
      revisions="<html>
<ul>
<li>
July 31, 2020, by Antoine Gautier:<br/>
First implementation.
</li>
</ul>
</html>",
      info="<html>
<p>
This model validates
<<<<<<< HEAD:Buildings/Experimental/DHC/EnergyTransferStations/Combined/Validation/ChillerBorefield.mo
<a href=\"modelica://Buildings.Experimental.DHC.EnergyTransferStations.Combined.ChillerBorefield\">
Buildings.Experimental.DHC.EnergyTransferStations.Combined.ChillerBorefield</a>
in a system configuration including a geothermal borefield.
See
<a href=\"modelica://Buildings.Experimental.DHC.EnergyTransferStations.Combined.Validation.ChillerOnly\">
Buildings.Experimental.DHC.EnergyTransferStations.Combined.Validation.ChillerOnly</a>
=======
<a href=\"modelica://Buildings.DHC.ETS.Combined.ChillerBorefield\">
Buildings.DHC.ETS.Combined.ChillerBorefield</a>
in a system configuration including a geothermal borefield.
See
<a href=\"modelica://Buildings.DHC.ETS.Combined.Validation.ChillerOnly\">
Buildings.DHC.ETS.Combined.Validation.ChillerOnly</a>
>>>>>>> master:Buildings/DHC/ETS/Combined/Validation/ChillerBorefield.mo
for the description of the main modeling assumptions.
</p>
</html>"));
end ChillerBorefield;
