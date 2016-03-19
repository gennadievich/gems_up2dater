$(document).on('click', '#hide-user-form-button', function(e){
  e.preventDefault();
  $("#show-user-form-button").show();
  $(".notifications").slideUp(80);
  $("#user-form").slideUp(80);
  $("#hide-user-form-button").hide();
});