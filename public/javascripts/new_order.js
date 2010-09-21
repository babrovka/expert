$(document).ready(function() {

   $('a#more_files').click(function () {
      size=$("p.upload").size();
      $("p#upload_"+size).after($("p#upload_"+size).clone().attr("id", "upload_"+(size+1)));
      $("p#upload_"+(size+1)+" > input").each(function () {
           if (this.id) this.id = this.id.replace("_"+(size-1)+"_", "_"+size+"_");
           if (this.name) this.name = this.name.replace("["+(size-1)+"]", "["+size+"]");
        });
      $("p#upload_"+(size+1)).html($("p#upload_"+(size+1)).html().replace(""+size+".", ""+(size+1)+"."));
   });

   $('a.new_message').click(function () {
      var id=this.id.split('_')[2];
      $("#new_message_form_"+id).toggle();
      return false;
   });

   $("#order_order_type_id").change(function () {
       var id=$("#order_order_type_id").val();
       $(".order_info").hide();
       $("#order_info_"+id).show();
       if ($("#order_info_"+id).hasClass("type_blocked")) {$("#order_body").hide();} else {$("#order_body").show();}

     });

	$('.AmodalPlatejNew').click(function (e) {// окно заказ
		$("#modalPlatejNew").modal(	{
			onOpen: function (dialog) {
			dialog.overlay.fadeIn();
			var settings = {tl:{radius:5},tr:{radius:5},bl:{radius:5},br:{radius:5},antiAlias:true};
			dialog.container.fadeIn(function(){curvyCorners(settings, "#simplemodal-container");});
			dialog.data.fadeIn();
		}});
		return false;
	});


	$('.AmodalPlatej').click(function (e) {//открываем окно
	    var id=this.id.split('_')[1];
	    $.get('/payments/'+id+'/edit', {}, function(data) {

		$("#modalPlatej").html(data).modal(	{
			onOpen: function (dialog) {
			dialog.overlay.fadeIn();
			var settings = {tl:{radius:5},tr:{radius:5},bl:{radius:5},br:{radius:5},antiAlias:true};
			dialog.container.fadeIn(function(){curvyCorners(settings, "#simplemodal-container");});
			dialog.data.fadeIn();
		}});

        }
        );
		return false;


	});




$(".opener").click(function () {
		$(".plateji_info").slideToggle(
			function () {$(this).parent().children(".r").children("a.opener").toggleClass("close")}

     	);
});

});

