$(document).on('click', '#hide-project-form-button', function(e){
  e.preventDefault();
  $("#show-project-form-button").show();
  $(".notifications").slideUp(80);
  $("#project-form").slideUp(80);
  $("#hide-project-form-button").hide();
  $("h3").removeClass("display-none");
});