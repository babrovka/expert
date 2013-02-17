$(document).ready(function() {
  
  $('#order_payment_link').bind('click', function(){
    $('#order_payment_block').modal({
      minHeight: 300,
      onOpen: function (dialog) {
        dialog.overlay.fadeIn();
        dialog.container.fadeIn();
        dialog.data.fadeIn();
      }
    });
  });

});