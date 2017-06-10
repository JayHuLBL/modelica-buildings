within Buildings.ChillerWSE.BaseClasses;
partial model SignalFilter  "Partial model that implements the filtered opening for valves and dampers"
  extends Buildings.ChillerWSE.BaseClasses.PartialSignalFilter;
protected
  Modelica.Blocks.Interfaces.RealOutput[nFilter] y_actual "Actual valve position"
    annotation (Placement(transformation(extent={{-28,66},{-12,82}})));

  Modelica.Blocks.Continuous.Filter[nFilter] filter(
     each order=2,
     each f_cut=5/(2*Modelica.Constants.pi*riseTimeValve),
     each final init=initValve,
     final y_start=yValve_start,
     each final analogFilter=Modelica.Blocks.Types.AnalogFilter.CriticalDamping,
     each final filterType=Modelica.Blocks.Types.FilterType.LowPass,
     x(each stateSelect=StateSelect.always)) if
        use_inputFilter
    "Second order filter to approximate valve opening time, and to improve numerics"
    annotation (Placement(transformation(extent={{-54,78},{-42,90}})));
  Modelica.Blocks.Interfaces.RealOutput[nFilter] y_filtered if use_inputFilter
    "Filtered valve position in the range 0..1"
    annotation (Placement(transformation(extent={{-28,76},{-12,92}}),
        iconTransformation(extent={{60,50},{80,70}})));

equation
 connect(filter.y,y_filtered)  annotation (Line(
      points={{-41.4,84},{-32,84},{-20,84}},
      color={0,0,127}));
 if use_inputFilter then
   connect(filter.y, y_actual) annotation (Line(points={{-41.4,84},{-32,84},{-32,
            74},{-20,74}},
                         color={0,0,127}));
 end if;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SignalFilter;
