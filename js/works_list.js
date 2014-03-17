$(function(){
	$(".go").css('opacity', 0);
});

$("#works_list .box").hover(function(){
	$(".go",this).stop(true, true).animate({opacity: 1},{duration: "normal", easing: "swing"});
}, function(){
	$(".go",this).stop(true, true).animate({opacity: 0},{duration: "normal", easing: "swing"});
});