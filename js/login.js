
// http://qiita.com/Evolutor_web/items/449065d1bd82c51fef4c
// setCookie(data, period);
// data: hash key = cookie name, hash value = cookie body
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

	$("#login").submit(function(){
		if (!$("#error_message").length) {
			$("article").append('<p id="error_message"></p>');
		}

		if ($("#passwd").val() == "") {
			$("#error_message").html("パスワードを入力してください。");
			return false;
		}

		$.get("../only/auth.pl",  { passwd: $("#passwd").val() }, function(data){
			var res = JSON.parse(data);
			if (res.ok) {
				setCookie({onlyhash:res.hash}, 1);
				location.reload();
			} else {
				$("#error_message").html("パスワードが正しくありません。");
			}
		});

		return false;
	});

});
