// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(document).ready(function() {
  $(document).bind('domchange', function() {
    $("select, input:checkbox, input:radio, input:file").each(function() {
      if( !$(this).data('uniformed') ) {
        $(this).uniform();
        $(this).data('uniformed', true)
      }
    })
  });
  
  $(document).trigger('domchange');
})

function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".fields").hide();
  
  $(document).trigger('domchange');
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).parent().before(content.replace(regexp, new_id));
  
  $(document).trigger('domchange');
}