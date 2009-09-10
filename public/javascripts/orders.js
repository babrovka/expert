$(document).ready(function() {

   $('a.toggle_status').click(function () { 
      var id=this.id.split('_')[1]
      $("#statuses_"+id).toggle();
   });

   $('a.show_payments').click(function () { 
      var id=this.id.split('_')[2]
      $("#payments_"+id).toggle();
   });


});

