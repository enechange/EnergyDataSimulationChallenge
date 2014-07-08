$(document).on('ready page:load', function() {
	MathJax.Hub.Typeset();

	$('tr[data-href]').addClass('clickable').click(function(e) {
		if(!$(e.target).is('a')) {
			window.location = $(e.target).closest('tr').data('href');
		}
	});

	$('button.btn-delete').on('click', function(e) {
		bootbox.confirm("Are you sure to delete?", function(result) {
			if(result) {
				window.location = $(e.target).data('href');
			}
		});
	});
});
