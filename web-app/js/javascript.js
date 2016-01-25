$(document).ready(function()  {

	$('#editGame').click(function(){
		$('.modal').modal('show');
	});
	document.getElementById("gameLogo").onchange = function () {
	    var reader = new FileReader();

	    reader.onload = function (e) {
	        // get loaded data and render thumbnail.
	        document.getElementById("image").src = e.target.result;
	    };

	    // read the image file as a data URL.
	    reader.readAsDataURL(this.files[0]);
	};
	
	i=0;
	w=0;
	x=0;
	var Arr= new Array();
	var myArr = new Array();
	size_li=0;
		
	$('.myList').each(function() {
	    var count = $('> li', this).length;
	    myArr.push(count);
	    Arr.push(0);
	    $('.myList li').slice(w, w+3).show();
	    w+= myArr[i]; 
	   	i++;
	});

	  $('.loadMore').click(function () {
	   val=$('.loadMore').index(this);
		   size_li=0;
		    temp=myArr[val];
		    val2=val;
			if(val>1){
				size_li=myArr[val];
			   	while(val>0){
		  	 	val--; 
		  		temp+= myArr[val]; 
			   	size_li+=myArr[val]; 
	 			}
	 			temp+=myArr[0];
		   }else if(val==1){
			   size_li+=myArr[val-1];
				temp+=myArr[val-1];
				
			}
			   
			size_li= size_li+3+Arr[val2];
	       	if ( size_li  < temp) {
	           $('.myList li').slice(size_li, size_li+3).show();
	           Arr[val2]+=3;
	       	}
	       	
	    	if ( size_li +3 >= temp) {
	        $('.loadMore').eq($('.loadMore').index(this)).hide();	
	    	}
	

	    });
   


	$("#counter").css("color","red");
	document.getElementById("reviewButton").disabled = true;
	var reviewLength = $("#text").val().length;
	if(reviewLength < 100){
		document.getElementById("reviewButton").disabled = true;
	}
	if(reviewLength >= 100){
		document.getElementById("reviewButton").disabled = false;
	}
	if(reviewLength <= 100)
	{
	    $("#counter").css("color","red");
	}
	else
	{
	    $("#counter").css("color","black");
	}
	$("#counter").append("<strong>"+reviewLength+"</strong> characters ");

	$("#text").keyup(function(){

	    var reviewLength = $(this).val().length;
	    $("#counter").html(" <strong>"+  reviewLength+"</strong> characters");
	    if(reviewLength < 100){
	    	document.getElementById("reviewButton").disabled = true;
	    }
	    if(reviewLength >= 100){
	    	document.getElementById("reviewButton").disabled = false;
	    }
	    if(reviewLength <= 100)
	    {
	        $("#counter").css("color","red");
	    }
	    else
	    {
	        $("#counter").css("color","black");
	    }
	    $("#whitespace").css("color","red");
            if ($.trim($('#text').val()) == "") {
		$("#whitespace").html(" Please input any alphanumeric character");
			document.getElementById("reviewButton").disabled = true;
		} else {
			$("#whitespace").html("");
		}

	});

 

});



    function focusDiv(){
		document.getElementById('reviewForm').scrollIntoView();
	}

 function showImage(imgName) {
       var curImage = document.getElementById('currentImg');
       var thePath = 'images/';
       var theSource =  imgName;
       curImage.src = theSource;
     }
 function clearComment() {
	 //alert("here");
     $('#texts').val("");
     $('#text').val("");
   }