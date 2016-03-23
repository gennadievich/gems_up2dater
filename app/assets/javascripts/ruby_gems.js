$(document).on('click', '#hide-name-version-form-button', function(e){
  e.preventDefault();
  $("#show-name-version-form-button").show();
  $(".notifications").slideUp(80);
  $("#name-version-form").slideUp(80);
  $("#gem-form").slideUp(80);
  $("#hide-name-version-form-button").hide();
});
