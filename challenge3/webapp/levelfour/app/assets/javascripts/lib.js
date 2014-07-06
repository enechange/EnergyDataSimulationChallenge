$(document).on('ready page:load', function() {
  $('tr[data-href]').addClass('clickable').click(function(e) {
      if(!$(e.target).is('a')) {
        window.location = $(e.target).closest('tr').data('href');
	  }
  });
});
