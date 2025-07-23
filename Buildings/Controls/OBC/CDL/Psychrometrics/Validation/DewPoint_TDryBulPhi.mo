within Buildings.Controls.OBC.CDL.Psychrometrics.Validation;
model DewPoint_TDryBulPhi
  "Model to test the dew point temperature computation"
  Buildings.Controls.OBC.CDL.Psychrometrics.DewPoint_TDryBulPhi dewBulPhi
    "Model for dew point temperature"
    annotation (Placement(transformation(extent={{20,30},{40,50}})));
  Buildings.Controls.OBC.CDL.Psychrometrics.DewPoint_TDryBulPhi dewBulPhi1
    "Model for dew point temperature"
    annotation (Placement(transformation(extent={{20,-50},{40,-30}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Ramp phi(
    duration=1,
    height=1,
    offset=0.001)
    "Relative humidity"
    annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant TDryBul(
    k=273.15+29.4)
    "Dry bulb temperature"
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Ramp TDryBul2(
    duration=1,
    height=35,
    offset=273.15+2.0)
    "Dry bulb temperature"
    annotation (Placement(transformation(extent={{-60,-30},{-40,-10}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant phi2(
    k=0.4)
    "Relative humidity"
<<<<<<< HEAD
    annotation (Placement(transformation(extent={{-94,-60},{-74,-40}})));
  // ============ Below blocks are from Buildings Library ============
  Buildings.Utilities.Psychrometrics.TDewPoi_pW TDewPoi
    "Dew point temperature"
    annotation (Placement(transformation(extent={{18,4},{38,24}})));
  Buildings.Utilities.Psychrometrics.X_pTphi X_pTphi(
    use_p_in=false)
    "Steam mass fraction"
    annotation (Placement(transformation(extent={{-46,4},{-26,24}})));
  Buildings.Utilities.Psychrometrics.pW_X humRat(
    use_p_in=false)
    "Water vapor pressure"
    annotation (Placement(transformation(extent={{-12,4},{8,24}})));
  // ===================================================================
  Buildings.Controls.OBC.CDL.Continuous.Subtract sub
    "Dew point temperature difference"
    annotation (Placement(transformation(extent={{52,40},{72,60}})));
  Buildings.Controls.OBC.CDL.Psychrometrics.DewPoint_TDryBulPhi dewBulPhi1
    "Model for dew point temperature"
    annotation (Placement(transformation(extent={{18,-28},{38,-8}})));
  Buildings.Utilities.Psychrometrics.TDewPoi_pW TDewPoi1
    "Dew point temperature"
    annotation (Placement(transformation(extent={{20,-98},{40,-78}})));
  Buildings.Utilities.Psychrometrics.pW_X humRat1(
    use_p_in=false)
    "Water vapor pressure"
    annotation (Placement(transformation(extent={{-10,-98},{10,-78}})));
  Buildings.Utilities.Psychrometrics.X_pTphi X_pTphi1(
    use_p_in=false)
    "Steam mass fraction"
    annotation (Placement(transformation(extent={{-44,-98},{-24,-78}})));
  Buildings.Controls.OBC.CDL.Continuous.Subtract sub1
    "Dew point temperature difference"
    annotation (Placement(transformation(extent={{52,-60},{72,-40}})));
=======
    annotation (Placement(transformation(extent={{-60,-80},{-40,-60}})));
>>>>>>> master

equation
  connect(TDryBul.y,dewBulPhi.TDryBul)
    annotation (Line(points={{-38,70},{0,70},{0,46},{18,46}}, color={0,0,127}));
  connect(phi.y,dewBulPhi.phi)
<<<<<<< HEAD
    annotation (Line(points={{-72,50},{-62,50},{-62,78},{14,78}},color={0,0,127}));
  connect(TDryBul.y,X_pTphi.T)
    annotation (Line(points={{-72,84},{-68,84},{-68,14},{-48,14}},color={0,0,127}));
  connect(phi.y,X_pTphi.phi)
    annotation (Line(points={{-72,50},{-62,50},{-62,8},{-48,8}},color={0,0,127}));
  connect(TDewPoi.T,sub.u2)
    annotation (Line(points={{39,14},{44,14},{44,44},{50,44}},color={0,0,127}));
  connect(dewBulPhi.TDewPoi,sub.u1)
    annotation (Line(points={{38,84},{42,84},{42,56},{50,56}},color={0,0,127}));
=======
    annotation (Line(points={{-38,20},{0,20},{0,34},{18,34}}, color={0,0,127}));
>>>>>>> master
  connect(TDryBul2.y,dewBulPhi1.TDryBul)
    annotation (Line(points={{-38,-20},{0,-20},{0,-34},{18,-34}}, color={0,0,127}));
  connect(phi2.y,dewBulPhi1.phi)
<<<<<<< HEAD
    annotation (Line(points={{-72,-50},{-62,-50},{-62,-24},{16,-24}},color={0,0,127}));
  connect(phi2.y,X_pTphi1.phi)
    annotation (Line(points={{-72,-50},{-62,-50},{-62,-94},{-46,-94}},color={0,0,127}));
  connect(X_pTphi1.X[1],humRat1.X_w)
    annotation (Line(points={{-23,-88},{-11,-88},{-11,-88}},color={0,0,127}));
  connect(humRat1.p_w,TDewPoi1.p_w)
    annotation (Line(points={{11,-88},{19,-88},{19,-88}},color={0,0,127}));
  connect(dewBulPhi1.TDewPoi,sub1.u1)
    annotation (Line(points={{40,-18},{44,-18},{44,-44},{50,-44}},color={0,0,127}));
  connect(TDewPoi1.T,sub1.u2)
    annotation (Line(points={{41,-88},{46,-88},{46,-56},{50,-56}},color={0,0,127}));
=======
    annotation (Line(points={{-38,-70},{0,-70},{0,-46},{18,-46}}, color={0,0,127}));
>>>>>>> master
  annotation (
    experiment(
      StopTime=1.0,
      Tolerance=1e-06),
    __Dymola_Commands(
      file="modelica://Buildings/Resources/Scripts/Dymola/Controls/OBC/CDL/Psychrometrics/Validation/DewPoint_TDryBulPhi.mos" "Simulate and plot"),
    Documentation(
      info="<html>
<p>
This examples is a unit test for the dew point temperature computation <a href=\"modelica://Buildings.Controls.OBC.CDL.Psychrometrics.DewPoint_TDryBulPhi\">
Buildings.Controls.OBC.CDL.Psychrometrics.DewPoint_TDryBulPhi</a>.
</p>
</html>",
      revisions="<html>
<ul>
<li>
March 17, 2023, by Jianjun Hu:<br/>
Removed instances that use blocks outside of
<a href=\"modelica://Buildings.Controls.OBC.CDL\">Buildings.Controls.OBC.CDL</a> package.<br/>
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/3302\">Buildings, issue 3302</a>
</li>
<li>
September 29, 2020, by Michael Wetter:<br/>
Renamed model and updated for new input of the psychrometric blocks.<br/>
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/2139\">Buildings, issue 2139</a>
</li>
<li>
April 7, 2017 by Jianjun Hu:<br/>
First implementation.
</li>
</ul>
</html>"),
    Icon(
      graphics={
        Ellipse(
          lineColor={75,138,73},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          extent={{-100,-100},{100,100}}),
        Polygon(
          lineColor={0,0,255},
          fillColor={75,138,73},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          points={{-36,60},{64,0},{-36,-60},{-36,60}})}));
end DewPoint_TDryBulPhi;
