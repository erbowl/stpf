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
//= require jquery.turbolinks
//= require turbolinks
//= require_tree .
//= require ckeditor/init
$(document).on('ready page:load', function(event) {
    // alert("そもそも");
    $('#cheers').on('click', function() {
      // alert("クリックは完治してるか？");
      that=$("input#is_valid").val();
      if (that=="true") {
        // alert("応援していますに変える");
        $("#cheer_text").text("応援しています");
        setTimeout(function(){
       $("input#is_valid").val("false");
        },1000);
      } else {
        // alert("応援するに変える");
        $("#cheer_text").text("応援する");
        setTimeout(function(){
       $("input#is_valid").val("true");
        },1000);
      }
    });

      var setFileInput = $('.form-group'),
      setFileImg = $('.j-img');
      var selfFile = $(this),
      selfInput = $(this).find('input[type=file]'),
      prevElm = $("form").find(setFileImg),
      orgPass = prevElm.attr('src');

      selfInput.change(function(){
          var file = $(this).prop('files')[0],
          fileRdr = new FileReader();

          if (!this.files.length){
              prevElm.attr('src', orgPass);
              return;
          } else {
              if (!file.type.match('image.*')){
                  prevElm.attr('src', orgPass);
                  return;
              } else {
                  fileRdr.onload = function() {
                      prevElm.attr('src', fileRdr.result);
                  }
                  fileRdr.readAsDataURL(file);
              }
          }
  });


});
