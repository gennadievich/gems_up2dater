$(document).on('click', '#hide-project-form-button', function(e){
  e.preventDefault();
  $("#show-project-form-button").show();
  $(".notifications").slideUp(80);
  $("#project-form").slideUp(80);
  $("#hide-project-form-button").hide();
  $("h3").removeClass("display-none");
});

$(document).on('click', '#show-name-version-form-button', function(e){
  e.preventDefault();
  $('#show-name-version-form-button').hide();
  $('#hide-name-version-form-button').show();
  $('#name-version-form').slideDown(80);
});

$(document).on('click', '#hide-name-version-form-button', function(e){
    e.preventDefault();
    $('#show-name-version-form-button').show();
    $('#hide-name-version-form-button').hide();
    $('#name-version-form').slideUp(80);
});