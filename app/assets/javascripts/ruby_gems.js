$(document).on('click', '#hide-name-version-form-button', function(e){
  e.preventDefault();
  $("#show-name-version-form-button").show();
  $(".notifications").slideUp(80);
  $("#name-version-form").slideUp(80);
  $("#gem-form").slideUp(80);
  $("#hide-name-version-form-button").hide();
});

$(function() {
  $(document)
    .ajaxStart(function() {
      $('#loading-indicator').show(); // show on any Ajax event.
    })
    .ajaxStop(function() {
      $('#loading-indicator').hide(); // hide it when it is done.
    });
});