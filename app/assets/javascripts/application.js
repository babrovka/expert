//= require jquery_ujs
//= require jquery.simplemodal.min
//= require curvycorners.src.js
//= require services
//= require new_order
//= require orders
//= require order
//= require_tree .


$(document).ready(function() {
  $('.AmodalOptions').click(function (e) {//открываем окно настройки
    $("#modalOptions").modal(  {
      onOpen: function (dialog) {
      dialog.overlay.fadeIn();
      dialog.container.fadeIn();
      dialog.data.fadeIn();
    }});
    return false;
  });//конец открываем окно настройки.


  $('.AmodalReg').click(function (e) {// окно рег-ция
    $("#modalReg").modal(  {
      onOpen: function (dialog) {
      dialog.overlay.fadeIn();
      dialog.container.fadeIn();
      dialog.data.fadeIn();
    }});
    return false;
  });

  $('a.AmodalAuth').click(function (e) {// окно логин
    $("#modalAuth").modal(  {
      onOpen: function (dialog) {
      dialog.overlay.fadeIn();
      dialog.container.fadeIn();
      dialog.data.fadeIn();
    }});
    return false;
  });

  $('select#order_order_type_id').change( function(e) {
    $('b.zakaz_price').hide();
    $('b#price_'+$('select#order_order_type_id').val() ).show();
  });

  $('.AmodalZakaz').click(function (e) {
    if ($(this).hasClass('service')) {
       var id=this.id.split('_')[1];
       $('select#order_order_type_id').val(id);
    }

    $('select#order_order_type_id').change();

    $("#modalZakaz").modal({
      onOpen: function (dialog) {
      dialog.overlay.fadeIn();
      dialog.container.fadeIn();
      dialog.data.fadeIn();
    }});
    return false;
  });

  $(".opener").click(function () {
    $(this).parent().children(".service_info").slideToggle(
      function () {$(this).parent().children(".opener").toggleClass("close")}
    );
    return false;
  });
});

