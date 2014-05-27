// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
// Loads all Bootstrap javascripts
//= require bootstrap
//= require bootstrap/scrollspy
//= require bootstrap/modal
//= require bootstrap/dropdown
//= require tinymce
//  require_tree .
function remove_field(object){
	$(object).parent().prev("input[type=hidden]")[0].value = 1;
	$(object).closest(".field").hide();
}
function add_field_time_measure(object, association, content){
	var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g");
	content = content.replace(regexp, new_id);
	var objectAfter = $(object).prev("table").find("tbody > tr.field").last();
	$(content).insertAfter(objectAfter);
}
function add_field_process_record(object, association, content){
	var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g");
	content = content.replace(regexp, new_id);
	var objectAfter = $(object).prev("div.field");
	$(content).insertAfter(objectAfter);
}

