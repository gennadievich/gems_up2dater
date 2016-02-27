var main = function(e){
    e.preventDefault();
    $("#ruby-gems-form").toggleClass("hidden");
};

$(document).on('click', '#add-new-gems-btn', main);