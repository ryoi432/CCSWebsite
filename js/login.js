$(function(){

	$("#login").click(function(){
		$.get("../only/auth.pl",  { passwd: $("#passwd").val() }, 
			function(data){
				alert("Data Loaded: " + data);
			}
		);
	});

});
