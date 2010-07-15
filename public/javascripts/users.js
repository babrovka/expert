$(document).ready(function() {//открывалка пользователей
	$(".opener").click(function () {
		$(this).parent().children(".userinfo").slideToggle(
			function () {$(this).parent().children(".opener").toggleClass("close")}
		);
		return false;
	});

	$('a.change').click(function (e) {
	    var id=this.id.split('_')[1];
	    $.get('/users/'+id+'/edit', {}, function(data) {


		$("#modalChange").html(data).modal(	{
			onOpen: function (dialog) {
			dialog.overlay.fadeIn();
			var settings = {tl:{radius:5},tr:{radius:5},bl:{radius:5},br:{radius:5},antiAlias:true};
			dialog.container.fadeIn(function(){curvyCorners(settings, "#simplemodal-container");});
			dialog.data.fadeIn();
		}});

		});
		return false;
	});

});

