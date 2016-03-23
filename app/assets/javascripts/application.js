// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap-sprockets
//= require jquery_ujs
//= require turbolinks
//= require_tree .

var hideDiv = function(){
    $(this).slideUp(80);
};
$(document).on('click', '.errors', hideDiv);

$(document).on('click', '.notifications', hideDiv);
/*File upload.*/

$(document).on('change', '.btn-file :file', function() {
  var input = $(this),
    numFiles = input.get(0).files ? input.get(0).files.length : 1,
    label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
  input.trigger('fileselect', [numFiles, label]);
});

$(document).ready( function() {
  $('.btn-file :file').on('fileselect', function(event, numFiles, label) {

    var input = $(this).parents('.input-group').find(':text'),
      log = numFiles > 1 ? numFiles + ' files selected' : label;

    if( input.length ) {
      input.val(log);
    } else {
      if( log ) alert(log);
    }

  });
});

$(function() {
  $(document)
    .ajaxStart(function() {
      $('#loading-indicator').show(); // show on any Ajax event.
      $('#mask').show();
    })
    .ajaxStop(function() {
      $('#loading-indicator').hide(); // hide it when it is done.
      $('#mask').hide();
    });
});