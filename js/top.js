var counter = 1;
var NowImage = 0;

function callback(obj){
	counter+=1;
	if ( !($.isEmptyObject(obj)) ){
		$("#content").append("<h2>"+obj.title+"  "+obj.date+"</h2>"+obj.body);
		$("#next").html('<div id="next"><img src="image/readmore_0.gif" id="top_image"><br></div>');
	}else{
		$("#next").html("");
		//counter=-1;
	}
}



function changeText(){
	$("#next").html('<img src="image/Loading.gif">');
           setTimeout(function() {
				$.getJSON("cgi-bin/test.py?callback=?",{id:counter},function(obj){});
          }, 100);

}

$(document).ready(function(){    
	//トップ画像の切り替え
	$("#top_image").everyTime(RefreshTime ,function () {
		$("#top_image").fadeOut("slow",function(){
				NowImage=(NowImage+1)%(ImageList.length);
				$(this).attr("src",ImageList[NowImage]);
				$(this).fadeIn();
			}
			);
		});

	//ReadMoreに関する設定
	$("#next").mouseup(function(){
		changeText();
	});

	$("#next").mouseout(function(){
		$("#next").html('<div id="next"><img src="image/readmore_0.gif" id="top_image"><br></div>');
  	});
	 
	$("#next").mousedown(function(){
		$("#next").html('<div id="next"><img src="image/readmore_1.gif" id="top_image"><br></div>');
  	});


	//一番最初の記事を読み込むため最初に読んでおく
	//
	changeText();

});

