function ajaxDelay(){
	var loading;
    $("#loading").hide();
    //$("#transp").hide();
    console.log("Ajax Calling");
    jQuery.ajaxSetup({
        beforeSend: function() {
			 $("#loading").show();
			 $("#transp").show();
        },
        complete: function(){
             $("#loading").hide();
             $("#transp").hide(); 
		},
        success: function() {
             
        }
    });
}