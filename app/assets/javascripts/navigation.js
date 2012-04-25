// Custom JS for Navigation and transitions
$(document).ready(function() {
	
	$('#main_navigation .page_link').click(function(){
		var target = $(this).attr('href');
		$('.page').hide().removeClass('current');
		$(target).addClass('current').show();
		
		$('#main_navigation .page_link').parent().removeClass('active');
		$(this).parent().addClass('active');
	});

});