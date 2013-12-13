$ ->
  $("select[data-option-dependent=true]").each (i) ->
    observer_dom_id = $(this).attr("id")
    observed_dom_id = $(this).data("option-observed")
    url_mask = $(this).data("option-url")
    key_method = $(this).data("option-key-method")
    value_method = $(this).data("option-value-method")
    prompt = if $(this).has("option[value=]").size() then $(this).find("option[value=]") else $("<option value=\"\">").text("Select a value")
    regexp = /:[0-9a-zA-Z_]+:/g
    observer = $("select#" + observer_dom_id)
    observed = $("#" + observed_dom_id)

    observer.attr "disabled", true  if not observer.val() and observed.size() > 1

    observed.on "change", ->
      observer.empty().append prompt

      if observed.val()
        url = url_mask.replace(regexp, observed.val())

        $.getJSON url, (data) ->
          $.each data, (i, object) ->
            observer.append $("<option>").attr("value", object[key_method]).text(object[value_method])
            observer.attr "disabled", false





