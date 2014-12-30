
// http://qiita.com/Evolutor_web/items/449065d1bd82c51fef4c
// period: expire time(hour)
var setCookie = (function(){
	return function(data, period) {
		var cookies = '';
		for (var key in data) {
			cookies += key + '=' + encodeURIComponent(data[key]) + '; ';
		}

		var expire = new Date();
		expire.setTime( expire.getTime() + 1000 * 3600 * period);
		expire.toUTCString();

		cookies += 'expires=' + expire+';';

		document.cookie = cookies;
	};
})();

$(function(){

	$("#login").click(function(){
		$.get("../only/auth.pl",  { passwd: $("#passwd").val() }, function(data){
			setCookie({onlyhash:data}, 1);
		});
	});

});
