$(document).ready(function()  {

	$('#editGame').click(function(){
		$('.modal.addGame').modal('show');
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
	var reviewLength = $("#text").val().trim().length;
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

	$("#text").keyup(function(e){
		 var reviewLength = $(this).val().trim().length;	
		
		if(reviewLength == 500){
			e.preventDefault();
		}
		else   if(reviewLength > 500){
			   this.value = this.value.substring(0, this.value.length-1);
			  
		    }
	
	   
	    $("#counter").html(" <strong>"+  reviewLength+"</strong> characters");
	    if(reviewLength < 100 || reviewLength > 500){
	    	document.getElementById("reviewButton").disabled = true;
	    }
	    if(reviewLength >= 100 && reviewLength <= 500){
	    	document.getElementById("reviewButton").disabled = false;
	    }
	    if(reviewLength <= 100 || reviewLength > 500)
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
			
		} else {
			$("#whitespace").html("");
			
		}        
	});
	

	


	$(".textbox").keyup(function(){
		 		var x = document.getElementsByClassName("ui blue labeled submit icon button");
		 		var y= document.getElementsByClassName("textbox");
		 		
		         if ($.trim(y[$('.textbox').index(this)].value) == "") {
		         	x[$('.textbox').index(this)+1].disabled = true;
		 }else{
			 
			 			x[$('.textbox').index(this)+1].disabled = false;
			
		}
	});
	
	$("#gameTitle").keyup(function(){
		var reviewLength = $("#gameDesc").val().trim().length;
		var reviewTitleLength= $("#gameTitle").val().trim().length;
		if(reviewTitleLength>0){
	        if ($.trim($('#gameTitle').val()) == "" && reviewLength <=0 ) {
				document.getElementById("editButton").disabled = true;
				alert("hi");
			}else if(reviewLength <=0 ) {
				document.getElementById("editButton").disabled = true;
			}else{
				document.getElementById("editButton").disabled = false;
			}
		} else {
			document.getElementById("editButton").disabled = true;
		}
	});
	
	$("#gameDesc").keyup(function(){
		Console.log("hi");
		var reviewLength = $("#gameTitle").val().trim().length;
		var reviewDescLength = $("#gameDesc").val().trim().length;
		if(reviewDescLength>0){
	        if ($.trim($('#gameDesc').val()) == "") {
				document.getElementById("editButton").disabled = true;
			}else if (reviewLength <= 0) {
				document.getElementById("editButton").disabled = true;
			}else{
				document.getElementById("editButton").disabled = false;
			}
		} else{
			document.getElementById("editButton").disabled = true;
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
function checkEdit(){
		var checkboxs=document.getElementsByName("newCategory");
		var reviewLength = $("#gameTitle").val().trim().length;
	    var okay=false;
	    if(reviewLength>33){
			alert("Game title should be less than 32 characters");
			return false;
		}else{
			console.log("BOGO");
		}
	    for(var i=0,l=checkboxs.length;i<l;i++)
	    {
	        if(checkboxs[i].checked)
	        {
	            okay=true;
	            break;
	        }
	    }
	    if(!okay){
		    alert("Please check a checkbox");
	    	return false;
	    }
	    var _validFileExtensions = [".jpg", ".jpeg", ".png"];   
		var arrInputs = onForm.getElementsByClassName("superMegaClass");
		for (var i = 0; i < arrInputs.length; i++) {
			var oInput = arrInputs[i];
			if (oInput.type == "file") {
				var sFileName = oInput.value;
				if (sFileName.length > 0) {
					var blnValid = false;
					for (var j = 0; j < _validFileExtensions.length; j++) {
						var sCurExtension = _validFileExtensions[j];
						if (sFileName.substr(
								sFileName.length - sCurExtension.length,
								sCurExtension.length).toLowerCase() == sCurExtension
								.toLowerCase()) {
							blnValid = true;
							break;
						}
					}

					if (!blnValid) {
						alert("Sorry, " + sFileName
								+ " is invalid, allowed extensions are: "
								+ _validFileExtensions.join(", "));
						return false;
					}
				}
			}
		}
	}
function assDate() {
	var date1 = document.getElementById("datePicker").value;
	document.getElementById("releaseDate").value = date1;
	var date2 = document.getElementById("releaseDate").value;
	console.log(date1);
	console.log(date2);
}
function check() {
	var checkboxs = document.getElementsByName("newCategory");
	var reviewLength = $("#gameTitle").val().trim().length;
	var okay = false;
	if(reviewLength>33){
		alert("Game title should be less than 32 characters");
		return false;
	}
	for (var i = 0, l = checkboxs.length; i < l; i++) {
		if (checkboxs[i].checked) {
			okay = true;
			break;
		}
	}
	if (!okay) {
		alert("Please selec a category");
		return false;
	}
}
