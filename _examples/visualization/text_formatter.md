---
layout: example
title: Visualization / Text formatter
categories: examples visualization
permalink: /visualization-text-formatter/
tclSource: /visualization/text_formatter.tcl
---

Script demonstrates usage of `AIS_TextLabel` and `Font_TextFormatter` properties.

**Graphic3d_HorizontalTextAlignment** (`Prs3d_TextAspect::SetHorizontalJustification()`)
<div class="btn-group" data-toggle="buttons" style="margin-left: 35px">
  <label class="btn btn-primary active">
    <input name="-halign" value="LEFT" onchange="occUpdateText(this);" type="radio" checked> Left
  </label>
  <label class="btn btn-primary">
    <input name="-halign" value="CENTER" onchange="occUpdateText(this);" type="radio"> Center
  </label>
  <label class="btn btn-primary">
    <input name="-halign" value="RIGHT" onchange="occUpdateText(this);" type="radio"> Right
  </label>
</div>
<br />

**Graphic3d_VerticalTextAlignment** (`Prs3d_TextAspect::SetVerticalJustification()`)
<div class="btn-group" data-toggle="buttons" style="margin-left: 35px">
  <label class="btn btn-primary">
    <input name="-valign" value="TOP" onchange="occUpdateText(this);" type="radio"> Top
  </label>
  <label class="btn btn-primary">
    <input name="-valign" value="TOPFIRSTLINE" onchange="occUpdateText(this);" type="radio"> Top first line
  </label>
  <label class="btn btn-primary">
    <input name="-valign" value="CENTER" onchange="occUpdateText(this);" type="radio"> Center
  </label>
  <label class="btn btn-primary active">
    <input name="-valign" value="BOTTOM" onchange="occUpdateText(this);" type="radio" checked> Bottom
  </label>
</div>
<br />

**Aspect_TypeOfDisplayText** (`Graphic3d_Aspects::SetTextStyle()`)
<div class="btn-group" data-toggle="buttons" style="margin-left: 35px">
  <label class="btn btn-primary active">
    <input name="-dispType" value="NORMAL" onchange="occUpdateText(this);" type="radio" checked> Normal
  </label>
  <label class="btn btn-primary">
    <input name="-dispType" value="SHADOW" onchange="occUpdateText(this);" type="radio"> Shadow
  </label>
  <label class="btn btn-primary">
    <input name="-dispType" value="DECAL" onchange="occUpdateText(this);" type="radio"> Decal
  </label>
  <label class="btn btn-primary">
    <input name="-dispType" value="SUBTITLE" onchange="occUpdateText(this);" type="radio"> Subtitle
  </label>
</div>
<br />

**Font_FontAspect** (`Graphic3d_Aspects::SetTextFontAspect()`)
<div class="btn-group" data-toggle="buttons" style="margin-left: 35px">
  <label class="btn btn-primary active">
    <input name="-aspect" value="REGULAR" onchange="occUpdateText(this);" type="radio" checked> Regular
  </label>
  <label class="btn btn-primary">
    <input name="-aspect" value="ITALIC" onchange="occUpdateText(this);" type="radio"> Italic
  </label>
</div>
<br />

**Font height** (`Prs3d_TextAspect::SetHeight()`)
<div style="margin-left: 35px">
  <label>
  <input name="-height" value="30" oninput="occUpdateText(this);" type="range" min="10" max="40" class="slider" style="width: 200px">
  </label>
</div>

**Rotation angle** (`Graphic3d_Aspects::SetTextAngle()`)
<div style="margin-left: 35px">
  <label>
  <input name="-angle" value="0" oninput="occUpdateText(this);" type="range" min="0" max="90" class="slider" style="width: 200px">
  </label>
</div>

**Font name** (`Graphic3d_Aspects::SetTextFont()`)<br />
Specifies font family name registered within `Font_FontMgr` global object.
The Font Manager fills in the list with fonts available in the system.
Developers may also register additional fonts distributed within application itself.

**Main color** (`Graphic3d_Aspects::SetColor()`)<br />

**Secondary color** (`Graphic3d_Aspects::SetColorSubTitle()`)<br />
The color of shadow, contour or background rectangle depending on the type of display text.

**Wrapping width** (`Font_TextFormatter::SetWrapping()`)<br />
The width to wrap the text (continue long text on the next line(s)).
<div style="margin-left: 35px">
  <label>
  <input name="-wrapping" value="0" oninput="occUpdateText(this);" type="range" min="0" max="100" class="slider" style="width: 200px">
  </label>
</div>

`AIS_TextLabel` is an interactive object for creating a text label as a separate object.
Custom AIS objects may use `Graphic3d_Text` directly to put text labels within more complex presentations.

Text position could be defined either as an anchor point in 3D
(text will be always orientated towards the viewer as in case of `Graphic3d_TMF_ZoomRotatePers`),
or within specified plane (text will be rotated in 3D space).
When plane is provided `AIS_TextLabel::SetOrientation3D()`,
one may also ask to automatically flip text orientation `AIS_TextLabel::SetFlipping()` to keep it readable.

`AIS_TextLabel`/`Graphic3d_Text` perform text rendering using cached textured fonts.
This is quite efficient approach for rendering non-zoomable text labels,
but consider also `StdPrs_BRepTextBuilder`/`StdPrs_BRepFont` tools,
when you need to put text alongside the geometry or to perform modeling operations with them.

`AIS_TextLabel` mostly wraps properties of text presentation, which otherwise are stored within:
- `Graphic3d_Aspects` - low-level aspects for rendering text via textured fonts;
- `Prs3d_TextAspect` - aspects for constructing text presentations;
- `Font_TextFormatter` - tool for formatting the text using specified font;
- `Font_FTFont`/`StdPrs_BRepFont` - explicitly loaded font.

<script>
function drawUpdateText(theName, theValue) {
  DRAWEXE.terminalPasteScript (
    "set tparams(" + theName + ") " + theValue + "\n"
  + "vdrawtext t \"$ttext\" -pos {*}$tpos {*}[array get tparams]\n"
  );
}
function occUpdateText(theInput) {
  if (theInput.type === "radio") {
    if (theInput.checked) {
      drawUpdateText(theInput.name, theInput.value);
    }
  } else if (theInput.type === "range") {
    drawUpdateText(theInput.name, theInput.value);
  }
}
</script>
