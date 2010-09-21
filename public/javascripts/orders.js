$(document).ready(function() {

   $('a.toggle_status').click(function () {
      var id=this.id.split('_')[1]
      $("#statuses_"+id).toggle();
   });

   $('a.show_payments').click(function () {
      var id=this.id.split('_')[2]
      $("#payments_"+id).toggle();
   });


$(".opener").click(function () {
		$(this).parent().children(".service_info").slideToggle(
			function () {$(this).parent().children(".opener").toggleClass("close")}
		);
		return false;
	});


});

