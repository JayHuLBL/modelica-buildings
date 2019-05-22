within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Subsequences;
block Configurator "Configures chiller staging"

  parameter Integer nSta = 3
    "Number of stages";

  parameter Integer nChi = 2
    "Number of chillers";

  parameter Real staMat[nSta, nChi] = {{1,0},{0,1},{1,1}}
    "Staging matrix with stages in rows and chillers in columns";

  parameter Integer chiTyp[nChi] = {1,2}
    "Chiller type: 1 - positive displacement, 2 - variable speed centrifugal, 3 - constant speed centrifugal";

  parameter Modelica.SIunits.Power chiNomCap[nChi]
    "Nominal chiller capacities";

  parameter Modelica.SIunits.Power chiMinCap[nChi]
    "Chiller unload capacities";

  final parameter Integer chiTypExp[nSta, nChi] = {chiTyp[i] for i in 1:nChi, j in 1:nSta}
    "Chiller type array expanded to allow for elementwise multiplication with the staging matrix";

  final parameter Integer chiExtMat[nSta, nChi] = {j for i in 1:nChi, j in 1:nSta}
     "Matrix used in extracting chillers at current stage";

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uChiAva[nChi]
    "Chiller availability status"
    annotation (Placement(transformation(extent={{-300,20},{-260,60}}),
        iconTransformation(extent={{-140,40},{-100,80}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yAva[nSta]
    "Stage availability status array" annotation (Placement(transformation(
          extent={{260,10},{280,30}}), iconTransformation(extent={{100,-100},{120,
            -80}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yChi[nChi] "Chillers in the stage" annotation (
      Placement(transformation(extent={{260,-190},{280,-170}}),
        iconTransformation(extent={{100,-100},{120,-80}})));

  Buildings.Controls.OBC.CDL.Interfaces.IntegerOutput yTyp[nSta](final max=nSta)
    "Chiller stage type" annotation (Placement(transformation(extent={{260,-50},
            {280,-30}}), iconTransformation(extent={{100,40},{120,60}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yNomCap[nSta](final unit="W",
      final quantity="Power") "Stage nominal capacities" annotation (Placement(
        transformation(extent={{260,100},{280,120}}), iconTransformation(extent=
           {{100,60},{120,80}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yMinCap[nSta](final unit="W",
      final quantity="Power") "Stage minimal capacities" annotation (Placement(
        transformation(extent={{260,40},{280,60}}), iconTransformation(extent={{
            100,20},{120,40}})));

//protected

  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant chiNomCaps[nChi](
    final k=chiNomCap) "Array of nominal chiller capacities"
    annotation (Placement(transformation(extent={{-200,300},{-180,320}})));

  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant chiMinCaps[nChi](
    final k=chiMinCap) "Array of chiller unload capacities"
    annotation (Placement(transformation(extent={{-200,220},{-180,240}})));

  Buildings.Controls.OBC.CDL.Continuous.MatrixGain staNomCaps(K=staMat)
    annotation (Placement(transformation(extent={{-120,260},{-100,280}})));
  Buildings.Controls.OBC.CDL.Continuous.MatrixGain staMinCaps(K=staMat)
    annotation (Placement(transformation(extent={{-120,180},{-100,200}})));
  Buildings.Controls.OBC.CDL.Continuous.MatrixGain staMinCaps1(K=staMat)
    annotation (Placement(transformation(extent={{-140,90},{-120,110}})));
  Buildings.Controls.OBC.CDL.Continuous.MatrixGain staMinCaps2(K=staMat)
    annotation (Placement(transformation(extent={{-140,30},{-120,50}})));

  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant oneVec[nChi](final k=fill(1, nSta))
    "All chillers available"
    annotation (Placement(transformation(extent={{-200,90},{-180,110}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea[nChi]
    annotation (Placement(transformation(extent={{-200,30},{-180,50}})));
  Buildings.Controls.OBC.CDL.Continuous.Add add2[nSta](k2=fill(-1, nSta))
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  Buildings.Controls.OBC.CDL.Continuous.LessThreshold                           lesThr[nSta](threshold=fill(0.5, nSta))
    "Checks if the number of chillers available in each stage equals the design number of chillers"
    annotation (Placement(transformation(extent={{-40,60},{-20,80}})));

  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant chiStaMat[nSta,nChi](final k=
        staMat) "Staging matrix"
    annotation (Placement(transformation(extent={{-180,-100},{-160,-80}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant staType[nSta,nChi](final k=chiTypExp)
    "Chiller stage type"
    annotation (Placement(transformation(extent={{-180,-40},{-160,-20}})));
  Buildings.Controls.OBC.CDL.Continuous.Product pro[nSta,nChi]
    annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
  Buildings.Controls.OBC.CDL.Conversions.IntegerToReal intToRea[nSta,nChi]
    annotation (Placement(transformation(extent={{-140,-40},{-120,-20}})));
  Buildings.Controls.OBC.CDL.Continuous.MatrixMax matMax(ninr=nSta, ninc=nChi)
    annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
  Buildings.Controls.OBC.CDL.Conversions.RealToInteger reaToInt[nSta]
    annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
  Buildings.Controls.OBC.CDL.Continuous.Sort sort(nin=nSta)
    annotation (Placement(transformation(extent={{80,-130},{100,-110}})));
  Buildings.Controls.OBC.CDL.Conversions.IntegerToReal intToRea1[nSta]
    annotation (Placement(transformation(extent={{40,-130},{60,-110}})));
  Buildings.Controls.OBC.CDL.Conversions.RealToInteger reaToInt1[nSta]
    annotation (Placement(transformation(extent={{120,-130},{140,-110}})));
  Buildings.Controls.OBC.CDL.Integers.Equal                        intEqu[nSta]
    annotation (Placement(transformation(extent={{160,-100},{180,-80}})));
  Buildings.Controls.OBC.CDL.Utilities.Assert assMes(message="Chillers are not staged according to G36 recommendation: stage any positive displacement machines first, stage any variable speed centrifugal next and any constant speed centrifugal last.")
    annotation (Placement(transformation(extent={{240,-100},{260,-80}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput                        uSta(final min=0, final
      max=nSta)       "Chiller stage"
    annotation (Placement(transformation(extent={{-300,-180},{-260,-140}}),
      iconTransformation(extent={{-140,-80},{-100,-40}})));
  Buildings.Controls.OBC.CDL.Routing.IntegerReplicator intRep(nout=nSta)
    annotation (Placement(transformation(extent={{-220,-170},{-200,-150}})));
  Buildings.Controls.OBC.CDL.Routing.IntegerReplicator intRep1[nSta](nout=fill(nChi, nSta))
    annotation (Placement(transformation(extent={{-160,-170},{-140,-150}})));
  CDL.Integers.Sources.Constant                          chiExtMatr[nSta,nChi](final k=chiExtMat)
    "Transposed staging matrix"
    annotation (Placement(transformation(extent={{-160,-220},{-140,-200}})));
  Buildings.Controls.OBC.CDL.Integers.Equal intEqu1[nSta,nChi]
    annotation (Placement(transformation(extent={{-100,-170},{-80,-150}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea1[nSta,nChi]
    annotation (Placement(transformation(extent={{-60,-170},{-40,-150}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant chiStaMat1[nSta,nChi](final k=staMat)
    "Transposed staging matrix"
    annotation (Placement(transformation(extent={{-60,-220},{-40,-200}})));
  Buildings.Controls.OBC.CDL.Continuous.Product                        pro1[nSta,nChi]
    annotation (Placement(transformation(extent={{0,-190},{20,-170}})));
  Buildings.Controls.OBC.CDL.Continuous.MatrixMax                        matMax1(
    rowMin=false,
    ninr=nSta,
    ninc=nChi)
    annotation (Placement(transformation(extent={{60,-190},{80,-170}})));
  Buildings.Controls.OBC.CDL.Continuous.GreaterThreshold chiInSta[nChi](threshold=fill(0.5, nChi))
    "Identifies chillers designated to operate in a given stage (regardless of the availability)"
    annotation (Placement(transformation(extent={{120,-190},{140,-170}})));

  CDL.Logical.MultiAnd mulAnd(nu=nSta)
    annotation (Placement(transformation(extent={{200,-100},{220,-80}})));
equation
  connect(chiNomCaps.y, staNomCaps.u) annotation (Line(points={{-179,310},{-140,
          310},{-140,270},{-122,270}},
                                color={0,0,127}));
  connect(oneVec.y, staMinCaps1.u)
    annotation (Line(points={{-179,100},{-142,100}},
                                                   color={0,0,127}));
  connect(chiMinCaps.y, staMinCaps.u) annotation (Line(points={{-179,230},{-140,
          230},{-140,190},{-122,190}},   color={0,0,127}));
  connect(uChiAva, booToRea.u)
    annotation (Line(points={{-280,40},{-202,40}},
                                                 color={255,0,255}));
  connect(booToRea.y, staMinCaps2.u) annotation (Line(points={{-179,40},{-142,40}},
                                    color={0,0,127}));
  connect(staMinCaps1.y, add2.u1) annotation (Line(points={{-119,100},{-100,100},
          {-100,76},{-82,76}},color={0,0,127}));
  connect(staMinCaps2.y, add2.u2) annotation (Line(points={{-119,40},{-100.5,40},
          {-100.5,64},{-82,64}}, color={0,0,127}));
  connect(add2.y,lesThr. u)
    annotation (Line(points={{-59,70},{-42,70}}, color={0,0,127}));
  connect(lesThr.y, yAva) annotation (Line(points={{-19,70},{60,70},{60,20},{270,
          20}}, color={255,0,255}));
  connect(staType.y,intToRea. u)
    annotation (Line(points={{-159,-30},{-142,-30}}, color={255,127,0}));
  connect(intToRea.y,pro. u1) annotation (Line(points={{-119,-30},{-100,-30},{-100,
          -44},{-82,-44}},    color={0,0,127}));
  connect(chiStaMat.y,pro. u2) annotation (Line(points={{-159,-90},{-100,-90},{-100,
          -56},{-82,-56}},          color={0,0,127}));
  connect(pro.y,matMax. u)
    annotation (Line(points={{-59,-50},{-42,-50}},
                                               color={0,0,127}));
  connect(matMax.y,reaToInt. u)
    annotation (Line(points={{-19,-50},{-2,-50}},
                                               color={0,0,127}));
  connect(reaToInt.y, yTyp) annotation (Line(points={{21,-50},{30,-50},{30,-40},
          {270,-40}}, color={255,127,0}));
  connect(reaToInt.y, intToRea1.u) annotation (Line(points={{21,-50},{30,-50},{30,
          -120},{38,-120}},     color={255,127,0}));
  connect(intToRea1.y, sort.u)
    annotation (Line(points={{61,-120},{78,-120}}, color={0,0,127}));
  connect(sort.y, reaToInt1.u)
    annotation (Line(points={{101,-120},{118,-120}}, color={0,0,127}));
  connect(reaToInt.y,intEqu. u1) annotation (Line(points={{21,-50},{150,-50},{150,
          -90},{158,-90}},       color={255,127,0}));
  connect(reaToInt1.y,intEqu. u2) annotation (Line(points={{141,-120},{150,-120},
          {150,-98},{158,-98}},   color={255,127,0}));
  connect(uSta, intRep.u)
    annotation (Line(points={{-280,-160},{-222,-160}}, color={255,127,0}));
  connect(intRep.y, intRep1.u) annotation (Line(points={{-199,-160},{-178,-160},
          {-178,-160},{-162,-160}}, color={255,127,0}));
  connect(intRep1.y, intEqu1.u1)
    annotation (Line(points={{-139,-160},{-102,-160}}, color={255,127,0}));
  connect(intEqu1.y, booToRea1.u)
    annotation (Line(points={{-79,-160},{-62,-160}}, color={255,0,255}));
  connect(booToRea1.y, pro1.u1) annotation (Line(points={{-39,-160},{-19.5,-160},
          {-19.5,-174},{-2,-174}}, color={0,0,127}));
  connect(chiStaMat1.y, pro1.u2) annotation (Line(points={{-39,-210},{-20.5,-210},
          {-20.5,-186},{-2,-186}}, color={0,0,127}));
  connect(pro1.y, matMax1.u)
    annotation (Line(points={{21,-180},{58,-180}}, color={0,0,127}));
  connect(matMax1.y, chiInSta.u)
    annotation (Line(points={{81,-180},{118,-180}}, color={0,0,127}));
  connect(staNomCaps.y, yNomCap) annotation (Line(points={{-99,270},{220,270},{220,
          110},{270,110}},                     color={0,0,127}));
  connect(staMinCaps.y, yMinCap) annotation (Line(points={{-99,190},{160,190},{160,
          50},{270,50}}, color={0,0,127}));
  connect(chiInSta.y, yChi)
    annotation (Line(points={{141,-180},{270,-180}}, color={255,0,255}));
  connect(mulAnd.y, assMes.u)
    annotation (Line(points={{221.7,-90},{238,-90}}, color={255,0,255}));
  connect(intEqu.y, mulAnd.u) annotation (Line(points={{181,-90},{190,-90},
          {190,-90},{198,-90}},           color={255,0,255}));
  connect(chiExtMatr.y, intEqu1.u2) annotation (Line(points={{-139,-210},{-120,-210},
          {-120,-168},{-102,-168}}, color={255,127,0}));
  annotation (defaultComponentName = "conf",
        Icon(graphics={
        Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
        Text(
          extent={{-120,146},{100,108}},
          lineColor={0,0,255},
          textString="%name")}),
                          Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-260,-340},{260,340}})),
Documentation(info="<html>
<p>
Configures the chiller staging based on the nominal <code>chiNomCap</code> and 
minimal <code>chiMinCap</code> chiller capacities and the chiller staging matrix <code>staMat</code>. 
The rows in <code>staMat</code> correspond to array indices in <code>chiNomCap</code>
and <code>chiMinCap</code>.
</p>
<p>
The outputs of the staging configurator are:
<ul>
<li>

</li>
<li>

</li>


</p>

</p>
</html>",
revisions="<html>
<ul>
<li>
January 13, 2019, by Milica Grahovac:<br/>
First implementation.
</li>
</ul>
</html>"));
end Configurator;