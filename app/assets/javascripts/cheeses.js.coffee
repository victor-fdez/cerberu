# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# adding cheeses namespace
window.Cheeses = {}

Cheeses.remove_field = (object) ->
	$(object).parent().prev("input[type=hidden]")[0].value = 1
	$(object).closest(".field").hide()

Cheeses.add_field_time_measure = (object, association, content) ->
	new_id = new Date().getTime()
	regexp = new RegExp("new_#{association}", "g")
	content = content.replace regexp, new_id
	objectAfter = $(object).prev("table").find("tbody > tr.field").last()
	$(content).insertAfter(objectAfter)

Cheeses.add_field_process_record = (object, association, content) ->
	new_id = new Date().getTime()
	regexp = new RegExp("new_#{association}", "g")
	content = content.replace(regexp, new_id)
	objectAfter = $(object).prev()
	if objectAfter.length is 0
		objectAfter = $(object).closest("div.fields")
		objectAfter.prepend(content)
	else
		objectAfter = objectAfter[0]
		$(content).insertAfter(objectAfter)
