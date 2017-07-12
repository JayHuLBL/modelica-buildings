within Buildings.Experimental.OpenBuildingControl.ASHRAE.G36.Atomic;
block EconDamperPositionLimitsSingleZone
  "Single zone VAV AHU minimum outdoor air control - damper position limits"

  parameter Real minFanSpe(final min=0, max=1, unit="1") = 0.1 "Minimum supply fan operation speed";
  parameter Real maxFanSpe(final min=0, max=1, unit="1") = 0.9 "Maximum supply fan operation speed";
  parameter Real outDamPhyPosMax(final min=0, max=1, unit="1") = 1
    "Physically fixed maximum position of the outdoor air (OA) damper";
  parameter Real outDamPhyPosMin(final min=0, max=1, unit="1") = 0
    "Physically fixed minimum position of the outdoor air damper";
  parameter Real minVOutMinFansSpePos(
    final min=minVOutMaxFanSpePos, max=desVOutMinFanSpePos, unit="1") = 0.4
    "OA damper position to supply minimum outdoor airflow at minimum fan speed";
  parameter Real minVOutMaxFanSpePos(
    final min=outDamPhyPosMin, max=minVOutMinFansSpePos, unit="1") = 0.3
    "OA damper position to supply minimum outdoor airflow at maximum fan speed";
  parameter Real desVOutMinFanSpePos(
    final min=desVOutMaxFanSpePos, max=outDamPhyPosMax, unit="1") = 0.9
    "OA damper position to supply design outdoor airflow at minimum fan speed";
  parameter Real desVOutMaxFanSpePos(
    final min=minVOutMaxFanSpePos, max=desVOutMinFanSpePos, unit="1") = 0.8
    "OA damper position to supply design outdoor airflow at maximum fan speed";
  parameter Modelica.SIunits.VolumeFlowRate minVOut_flow = 1.0
    "Calculated minimum outdoor airflow rate";
  parameter Modelica.SIunits.VolumeFlowRate desVOut_flow = 2.0
    "Calculated design outdoor airflow rate";

  CDL.Interfaces.RealInput uSupFanSpe(min=minFanSpe, max=maxFanSpe, unit="1") "Supply fan speed"
    annotation (Placement(transformation(extent={{-220,90},{-180,130}}),
      iconTransformation(extent={{-120,28},{-100,48}})));
  CDL.Interfaces.RealInput uVOutMinSet_flow(min=minVOut_flow, max=desVOut_flow) "Minimum outdoor airflow setpoint"
    annotation (Placement(transformation(extent={{-220,180},{-180,220}}),
      iconTransformation(extent={{-120,60},{-100,80}})));
  CDL.Interfaces.IntegerInput uOperationMode "AHU operation mode status signal"
    annotation (Placement(transformation(extent={{-220,-180},{-180,-140}}),
    iconTransformation(extent={{-120,-60},{-100,-40}})));
  CDL.Interfaces.IntegerInput uFreProSta "Freeze protection status signal"
    annotation (Placement(transformation(extent={{-220,-140},{-180,-100}}),
    iconTransformation(extent={{-120,-90},{-100,-70}})));
  CDL.Interfaces.BooleanInput uSupFan "Supply fan status signal"
    annotation (Placement(transformation(extent={{-220,-100},{-180,-60}}),
        iconTransformation(extent={{-120,-30},{-100,-10}})));

  CDL.Interfaces.RealOutput yOutDamPosMin(min=outDamPhyPosMin, max=outDamPhyPosMax, unit="1")
    "Minimum outdoor air damper position limit" annotation (Placement(transformation(extent={{180,70},{200,90}}),
      iconTransformation(extent={{100,30},{120,50}})));
  CDL.Interfaces.RealOutput yOutDamPosMax(min=outDamPhyPosMin, max=outDamPhyPosMax, unit="1")
    "Maximum outdoor air damper position limit" annotation (Placement(transformation(extent={{180,110},{200,130}}),
    iconTransformation(extent={{100,-50},{120,-30}})));

protected
  parameter Types.FreezeProtectionStage allowedFreProSta = Types.FreezeProtectionStage.stage1
    "Freeze protection stage 1";
  parameter Real allowedFreProStaNum = Integer(allowedFreProSta)-1
    "Freeze protection stage control loop upper enable limit (=1)";
  parameter Types.OperationMode occupied = Types.OperationMode.occupied "Operation mode is Occupied";
  parameter Real occupiedNum = Integer(occupied) "Numerical value for Occupied operation mode";

  CDL.Continuous.Constant OperationMode(final k=occupiedNum) "Control loop is enabled in occupied operation mode"
    annotation (Placement(transformation(extent={{-160,-200},{-140,-180}})));

  CDL.Continuous.Constant minFanSpeSig(final k=minFanSpe) "Minimum supply fan speed"
    annotation (Placement(transformation(extent={{-140,50},{-120,70}})));
  CDL.Continuous.Constant outDamPhyPosMinSig(final k=outDamPhyPosMin)
    "Physically fixed minimum position of the outdoor air (OA) damper"
    annotation (Placement(transformation(extent={{80,-20},{100,0}})));
  CDL.Continuous.Constant outDamPhyPosMaxSig(final k=outDamPhyPosMax)
    "Physically fixed maximum position of the outdoor air (OA) damper"
    annotation (Placement(transformation(extent={{80,20},{100,40}})));
  CDL.Continuous.Constant maxFanSpeSig(final k=maxFanSpe) "Maximum supply fan speed"
    annotation (Placement(transformation(extent={{-140,80},{-120,100}})));
  CDL.Continuous.Constant minVOutMinFansSpePosSig(final k=minVOutMinFansSpePos)
    "OA damper position to supply minimum outdoor airflow at minimum fan speed"
    annotation (Placement(transformation(extent={{-140,130},{-120,150}})));
  CDL.Continuous.Constant desVOutMinFanSpePosSig(final k=desVOutMinFanSpePos)
    "OA damper position to supply design outdoor airflow at minimum fan speed"
    annotation (Placement(transformation(extent={{-140,-30},{-120,-10}})));
  CDL.Continuous.Constant minVOutMaxFanSpePosSig(final k=minVOutMaxFanSpePos)
    "OA damper position to supply minimum outdoor airflow at maximum fan speed"
    annotation (Placement(transformation(extent={{-140,160},{-120,180}})));
  CDL.Continuous.Constant desVOutMaxFanSpePosSig(final k=desVOutMaxFanSpePos)
    "OA damper position to supply design outdoor airflow at maximum fan speed"
    annotation (Placement(transformation(extent={{-140,0},{-120,20}})));
  CDL.Continuous.Constant minVOutSig(final k=minVOut_flow) "Minimum outdoor airflow rate"
    annotation (Placement(transformation(extent={{-20,150},{0,170}})));
  CDL.Continuous.Constant desVOutSig(final k=desVOut_flow) "Design outdoor airflow rate"
    annotation (Placement(transformation(extent={{-20,70},{0,90}})));
  CDL.Continuous.Line minVOutCurFanSpePos(limitBelow=true, limitAbove=true)
    "Calculates OA damper position required to supply minimum outdoor airflow at current fan speed"
    annotation (Placement(transformation(extent={{-20,110},{0,130}})));
  CDL.Continuous.Line desVOutCurFanSpePos(limitBelow=true, limitAbove=true)
    "Calculates OA damper position required to supply design outdoor airflow at current fan speed"
    annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  CDL.Continuous.Line minVOutSetCurFanSpePos(limitBelow=true, limitAbove=true)
    "Calculates OA damper position required to supply minimum outdoor airflow setpoint at current fan speed"
    annotation (Placement(transformation(extent={{60,90},{80,110}})));
  CDL.Logical.Switch enaDis
    "Logical switch to enable damper position limit calculation or disable it (set limit to physical minimum)"
    annotation (Placement(transformation(extent={{140,70},{160,90}})));
  CDL.Logical.And3 and1 "Locical and block"
    annotation (Placement(transformation(extent={{-80,-80},{-60,-60}})));
  CDL.Logical.Not not1 "Logical not block"
    annotation (Placement(transformation(extent={{-40,-80},{-20,-60}})));
  CDL.Conversions.IntegerToReal intToRea "Integer to real converter"
    annotation (Placement(transformation(extent={{-160,-130},{-140,-110}})));
  CDL.Conversions.IntegerToReal intToRea1 "Integer to real converter"
    annotation (Placement(transformation(extent={{-160,-170},{-140,-150}})));
  CDL.Logical.LessEqualThreshold equ(final threshold=allowedFreProStaNum)
    "Freeze protection stage above allowedFreProStaNum disables the control"
    annotation (Placement(transformation(extent={{-120,-130},{-100,-110}})));
  CDL.Logical.Equal equ1 "Logical equal block"
    annotation (Placement(transformation(extent={{-120,-170},{-100,-150}})));

equation
  connect(minVOutSig.y, minVOutSetCurFanSpePos.x1)
    annotation (Line(points={{1,160},{50,160},{50,108},{58,108}}, color={0,0,127}));
  connect(desVOutSig.y, minVOutSetCurFanSpePos.x2)
    annotation (Line(points={{1,80},{40,80},{40,96},{58,96}},color={0,0,127}));
  connect(minVOutCurFanSpePos.y, minVOutSetCurFanSpePos.f1)
    annotation (Line(points={{1,120},{1,120},{40,120},{40,104},{58,104}},color={0,0,127}));
  connect(desVOutCurFanSpePos.y, minVOutSetCurFanSpePos.f2)
    annotation (Line(points={{1,30},{50,30},{50,92},{58,92}}, color={0,0,127}));
  connect(enaDis.y, yOutDamPosMin)
    annotation (Line(points={{161,80},{148,80},{190,80}},color={0,0,127}));
  connect(desVOutMinFanSpePosSig.y, desVOutCurFanSpePos.f1)
    annotation (Line(points={{-119,-20},{-60,-20},{-60,34},{-22,34}},color={0,0,127}));
  connect(desVOutMaxFanSpePosSig.y, desVOutCurFanSpePos.f2)
    annotation (Line(points={{-119,10},{-120,10},{-80,10},{-80,22},{-22,22}},color={0,0,127}));
  connect(minVOutMinFansSpePosSig.y, minVOutCurFanSpePos.f1)
    annotation (Line(points={{-119,140},{-119,140},{-80,140},{-80,124},{-22,124}},color={0,0,127}));
  connect(minVOutMaxFanSpePosSig.y, minVOutCurFanSpePos.f2)
    annotation (Line(points={{-119,170},{-60,170},{-60,112},{-22,112}},color={0,0,127}));
  connect(uSupFanSpe, minVOutCurFanSpePos.u)
    annotation (Line(points={{-200,110},{-110,110},{-110,120},{-22,120}},color={0,0,127}));
  connect(outDamPhyPosMaxSig.y, yOutDamPosMax)
    annotation (Line(points={{101,30},{110,30},{110,120},{190,120}}, color={0,0,127}));
  connect(maxFanSpeSig.y, minVOutCurFanSpePos.x2)
    annotation (Line(points={{-119,90},{-66,90},{-66,116},{-22,116}}, color={0,0,127}));
  connect(minFanSpeSig.y, minVOutCurFanSpePos.x1)
    annotation (Line(points={{-119,60},{-70,60},{-70,128},{-22,128}}, color={0,0,127}));
  connect(minFanSpeSig.y, desVOutCurFanSpePos.x1)
    annotation (Line(points={{-119,60},{-70,60},{-70,38},{-22,38}}, color={0,0,127}));
  connect(maxFanSpeSig.y, desVOutCurFanSpePos.x2)
    annotation (Line(points={{-119,90},{-80,90},{-80,26},{-22,26}}, color={0,0,127}));
  connect(uVOutMinSet_flow, minVOutSetCurFanSpePos.u)
    annotation (Line(points={{-200,200},{-90,200},{30,200},{30,100},{58,100}}, color={0,0,127}));
  connect(uSupFanSpe, desVOutCurFanSpePos.u)
    annotation (Line(points={{-200,110},{-110,110},{-110,30},{-22,30}}, color={0,0,127}));
  connect(uSupFan,and1. u1)
    annotation (Line(points={{-200,-80},{-108,-80},{-108,-62},{-82,-62}},  color={255,0,255}));
  connect(and1.y,not1. u)
    annotation (Line(points={{-59,-70},{-42,-70}},color={255,0,255}));
  connect(and1.u2,equ. y)
    annotation (Line(points={{-82,-70},{-90,-70},{-90,-120},{-99,-120}},color={255,0,255}));
  connect(intToRea.u,uFreProSta)
    annotation (Line(points={{-162,-120},{-162,-120},{-200,-120}}, color={255,127,0}));
  connect(intToRea.y,equ. u)
    annotation (Line(points={{-139,-120},{-130,-120},{-122,-120}}, color={0,0,127}));
  connect(uOperationMode,intToRea1. u)
    annotation (Line(points={{-200,-160},{-182,-160},{-162,-160}}, color={255,127,0}));
  connect(and1.u3,equ1. y)
    annotation (Line(points={{-82,-78},{-86,-78},{-86,-160},{-99,-160}},color={255,0,255}));
  connect(intToRea1.y,equ1. u1)
    annotation (Line(points={{-139,-160},{-130.5,-160},{-122,-160}}, color={0,0,127}));
  connect(OperationMode.y,equ1. u2)
    annotation (Line(points={{-139,-190},{-130,-190},{-130,-168},{-122,-168}},color={0,0,127}));
  connect(not1.y, enaDis.u2) annotation (Line(points={{-19,-70},{60,-70},{60,80},{138,80}}, color={255,0,255}));
  connect(outDamPhyPosMinSig.y, enaDis.u1)
    annotation (Line(points={{101,-10},{120,-10},{120,88},{138,88}}, color={0,0,127}));
  connect(minVOutSetCurFanSpePos.y, enaDis.u3)
    annotation (Line(points={{81,100},{100,100},{100,72},{138,72}}, color={0,0,127}));
    annotation (Placement(transformation(extent={{-20,110},{0,130}})),
                Placement(transformation(extent={{-20,20},{0,40}})),
                Placement(transformation(extent={{60,90},{80,110}})),
                Placement(transformation(extent={{-140,130},{-120,150}})),
                Placement(transformation(extent={{-140,-30},{-120,-10}})),
                Placement(transformation(extent={{-140,160},{-120,180}})),
                Placement(transformation(extent={{-140,0},{-120,20}})),
    defaultComponentName = "ecoDamLim",
    Icon(graphics={
        Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,0},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-76,80},{-72,76}},
          lineColor={28,108,200},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-78,-56},{-74,-60}},
          lineColor={28,108,200},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{72,60},{76,56}},
          lineColor={28,108,200},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{72,-74},{76,-78}},
          lineColor={28,108,200},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-74,78},{72,58}},
          color={0,0,127},
          thickness=0.5),
        Line(
          points={{-74,-58},{74,-76}},
          color={0,0,127},
          thickness=0.5),
        Line(
          points={{-2,-66},{-2,70}},
          color={0,0,127},
          thickness=0.5),
        Rectangle(
          extent={{-4,-64},{0,-68}},
          lineColor={0,0,127},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-4,70},{0,66}},
          lineColor={0,0,127},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-124,146},{128,110}},
          lineColor={0,0,127},
          textString="%name"),
        Ellipse(
          extent={{-4,-10},{0,-14}},
          lineColor={28,108,200},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid)}),
    Diagram(coordinateSystem(                           extent={{-180,-220},{180,220}},
        initialScale=0.1), graphics={
        Rectangle(
          extent={{-172,-52},{-6,-212}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
                                   Text(
          extent={{-86,-150},{58,-232}},
          lineColor={0,0,0},
          fontSize=12,
          horizontalAlignment=TextAlignment.Left,
          textString="Enable/disable conditions
for damper position limits
control loop")}),
    Documentation(info="<html>
<p>
This atomic sequence sets the minimum economizer damper position limit. The implementation is according
to ASHRAE Guidline 36 (G36), PART5.P.4.d.
</p>
<p>
The controller is enabled when the zone is in occupied mode. Otherwise, the outdoor air damper position limit is set to
minimum physical or at commissioning fixed limits. The state machine diagram below illustrates this.
<br/>
</p>
<p align=\"center\">
<img alt=\"Image of damper position limits state machine chart\"
src=\"modelica://Buildings/Resources/Images/Experimental/OpenBuildingControl/ASHRAE/G36/Atomic/EconDamperLimitsStateMachineChartSingleZone.png\"/>
</p>
<p>
According to article from G36,
<ul>
<li>
based on current supply fan speed (<code>uSupFanSpe</code>), it calculates outdoor air damper position (<code>minVOutCurFanSpePos</code>),
to ensure minimum outdoor air flow rate (<code>minVOut_flow</code>);
</li>
</ul>
<ul>
<li>
based on current supply fan speed (<code>uSupFanSpe</code>), it calculates outdoor air damper position (<code>desVOutCurFanSpePos</code>),
to ensure design outdoor air flow rate (<code>desVOut_flow</code>);
</li>
</ul>
<ul>
<li>
given the calculated air damper positions (<code>minVOutCurFanSpePos</code>, <code>desVOutCurFanSpePos</code>)
and the outdoor air flow rate limits (<code>minVOut_flow</code>, <code>desVOut_flow</code>),
it caculates the minimum outdoor air damper position (<code>yOutDamPosMin</code>),
to ensure outdoor air flow rate setpoint (<code>uVOutMinSet_flow</code>)
under current supply fan speed (<code>uSupFanSpe</code>).
</li>
</ul>
Both the outdoor air flow rate setpoint (code>uVOutMinSet_flow</code>)
and current supply fan speed (<code>uSupFanSpe</code>) are output from separate sequences.
</p>
<p>
This chart illustrates the OA damper position calculation based on the supply fan speed:
<br>
</br>
</p>
<p align=\"center\">
<img alt=\"Image of damper position limits control chart\"
src=\"modelica://Buildings/Resources/Images/Experimental/OpenBuildingControl/ASHRAE/G36/Atomic/EconDamperLimitsControlChartSingleZone.png\"/>
</p>
<p>
fixme: additional text about the functioning of the sequence
Note that VOut_flow depends on whether the economizer damper is controlled to a
position higher than it's minimum limit. This is defined by the EconEnableDisable
and EconModulate [fixme check seq name] sequences. Fixme feature add: For this reason
we may want to implement something like:
while VOut_flow > VOut_flowSet and outDamPos>outDamPosMin, keep previous outDamPosMin.
fixme: add option for separate minimum outdoor air damper.
</p>
</html>", revisions="<html>
<ul>
<li>
July 06, 2017, by Milica Grahovac:<br/>
Refactored implementation.
</li>
<li>
April 15, 2017, by Jianjun Hu:<br/>
First implementation.
</li>
</ul>
</html>"));
end EconDamperPositionLimitsSingleZone;
