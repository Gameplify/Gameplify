$(document).ready(function()  {


	    size_li = $("#myList li").size();
	    x=3;
	    $('#myList li:lt('+x+')').show();
	    $('#loadMore').click(function () {
	        x= (x+5 <= size_li) ? x+5 : size_li;
	        $('#myList li:lt('+x+')').show();
	    });
	    


	$("#counter").css("color","red");
    document.getElementById("reviewButton").disabled = true;
    $("#counter").append("<strong> 0 </strong> characters ");
    
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
    });

});




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