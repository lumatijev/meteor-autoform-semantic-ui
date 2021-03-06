#
# * Template helpers for "semanticUI" template
# 

# @todo: Template["autoForm_semanticUI"] is undefined – bug?
Template["autoForm"].helpers
  atts: autoFormTplAtts = ->
    context = _.clone(this)
    context.novalidate = "novalidate"  if context.validation isnt "browser" and not context.novalidate
    context.class = "ui form"
    _.omit context, "schema", "collection", "validation", "doc", "resetOnSuccess", "type", "template", "autosave", "meteormethod", "filter", "autoConvert", "removeEmptyStrings", "trimStrings"

Template["quickForm_semanticUI"].helpers
  qfAutoFormContext: ->
    ctx = _.clone(@qfAutoFormContext or {})
    ctx = AutoForm.Utility.addClass(ctx, "ui form")
    return ctx
  submitButtonAtts: bsQuickFormSubmitButtonAtts = ->
    qfAtts = @atts
    atts = {}
    if typeof qfAtts.buttonClasses is "string"
      atts["class"] = qfAtts.buttonClasses
    else
      atts["class"] = "ui submit button"
    return atts

_.each [
  "afInputButton_semanticUI"
  "afInputSubmit_semanticUI"
  "afInputReset_semanticUI"
], (tmplName) ->
  Template[tmplName].helpers atts: addFormControlAtts = ->
    atts = _.clone(@atts)
    
    # Add Semantic UI class
    atts = AutoForm.Utility.addClass(atts, "ui button")
    atts

  return

Template["afRadio_semanticUI"].helpers atts: selectedAttsAdjust = ->
  atts = _.clone(@atts)
  atts.checked = ""  if @selected
  atts

_.each [
  "afCheckboxGroup_semanticUI"
  "afRadioGroup_semanticUI"
], (tmplName) ->
  Template[tmplName].helpers
    atts: selectedAttsAdjust = ->
      atts = _.clone(@atts)
      atts.checked = ""  if @selected
      
      # remove data-schema-key attribute because we put it
      # on the entire group
      delete atts["data-schema-key"]

      atts

    dsk: dsk = ->
      "data-schema-key": @atts["data-schema-key"]

  return

selectHelpers = optionAtts: afSelectOptionAtts = ->
  atts = value: @value
  atts.selected = ""  if @selected
  atts

Template["afSelect_semanticUI"].helpers
  optionAtts: selectHelpers.optionAtts
  atts: ->
    if @atts.class? then @atts.class += " " else @atts.class = ""
    @atts.class += "ui dropdown"
    @atts

Template["afSelectMultiple_semanticUI"].helpers selectHelpers
Template["afBooleanSelect_semanticUI"].helpers selectHelpers

Template["afQuickField"].rendered = ->
  $("select.dropdown").dropdown()
  $(".ui.checkbox").checkbox()

AutoForm.setDefaultTemplate "semanticUI"