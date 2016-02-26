var main = function(){
  $("#add-new-gems-btn").click(function(e){
    e.preventDefault();
    $("#ruby-gems-form").toggleClass("hidden");
  });
};

$(document).ready(main);