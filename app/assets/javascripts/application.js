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

// var image = document.getElementById('crop');
// var cropper = new Cropper(image, {
//   aspectRatio: 1 / 1,
//   crop: function(e) {
//     console.log(e.detail.x);
//     console.log(e.detail.y);
//     console.log(e.detail.width);
//     console.log(e.detail.height);
//     console.log(e.detail.rotate);
//     console.log(e.detail.scaleX);
//     console.log(e.detail.scaleY);
//   }
// });


// プラマイで開閉するやつ
$(document).ready(function(){
  $('#navi > .open').next().show();
  $('#navi > .open').click(function(){
    // 引数には開閉する速度を指定します
    $(this).next().slideToggle('slow');
    $(this).children('i').toggleClass('fa-plus-circle');
    $(this).children('i').toggleClass('fa-minus-circle');
  });

  $('#navi > .closed').next().hide();
  $('#navi > .closed').click(function(){
    // 引数には開閉する速度を指定します
    $(this).next().slideToggle('slow');
    $(this).children('i').toggleClass('fa-minus-circle');
    $(this).children('i').toggleClass('fa-plus-circle');
  });

});

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


$("#result").click(function(){
  $('#form').click();
};



      setFileImg = $('.j-img');
      prevElm = $("form").find(setFileImg),
      orgPass = prevElm.attr('src');
      $("#form").change(function(){
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
