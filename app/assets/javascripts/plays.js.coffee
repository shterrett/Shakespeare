# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#

get_data = (key, order) -> 
  play_id = $("#play_id").text()
  url = "/plays/" + play_id + "/roles"
  query = 
    key: key
    by: order
  options =
    data: query,
    success: (data, status, jqXHR) ->
      populate_table(data)
  $.ajax(url, options)

populate_table = (data) ->
  $.each(data, (index, character) ->
    row_name = "#character-" + index
    $(row_name + " .character-name").text(character.name)
    $(row_name + " .character-line-count").text(character.line_count)
    $(row_name + " .character-scene-percent").text(character.percent_scenes)
    $(row_name + " .character-scene-count").text(character.scene_count)
    $(row_name + " .character-longest-speech").html("<p>" + character.max_speech_text.replace(/\n/g, "</p><p>") + "</p>")
  )

$(document).ready ->
  get_data("line_count", "desc")
  $(".sortable").click( ->
    order = "desc"
    if $(this).hasClass("active")
      this_order = $(this).data("order")
      order = if this_order == "desc" then "asc" else "desc"
      $(this).data("order", order)
    else
      $(".sortable").removeClass("active")
      $(".sortable").data("order", "")
      $(this).addClass("active")
      $(this).data("order", order)
    get_data($(this).data("key"), $(this).data("order"))
  )
