$(document).ready(function() {//открывалка сервисов
	$(".opener").click(function () {
		$(this).parent().children(".service_info").slideToggle(
			function () {$(this).parent().children(".opener").toggleClass("close")}
		);
		return false;
	});


	$('.AmodalService').click(function (e) {//открываем окно
	    var id=this.id.split('_')[1];
	    $.get('/order_types/'+id+'/edit', {}, function(data) {

		$("#modalService").html(data).modal(	{
			onOpen: function (dialog) {
			dialog.overlay.fadeIn();
			dialog.container.fadeIn();
			dialog.data.fadeIn();
		}});

        }
        );
		return false;



	});


	$('.AmodalServiceCreate').click(function (e) {//открываем окно
		$("#modalServiceCreate").modal(	{
			onOpen: function (dialog) {
			dialog.overlay.fadeIn();
			var settings = {tl:{radius:5},tr:{radius:5},bl:{radius:5},br:{radius:5},antiAlias:true};
			dialog.container.fadeIn(function(){curvyCorners(settings, "#simplemodal-container");});
			dialog.data.fadeIn();
		}});
		return false;
	});
});

