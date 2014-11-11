$(document).ready(function(){
  $("textarea").keyup(function(){
    var charCount = $(this).val().length;
    $(".char-count").html(charCount);
    
    var textColor, buttonDisabled;
    
    if(charCount > 140){
      textColor = "red";
      buttonDisabled = true;
    }else{
      textColor = "black";
      buttonDisabled = false;
    }
    $(".char-count").css("color", textColor);
    $("input[type='submit']").prop("disabled", buttonDisabled);
    console.log("Someone pressed a key!");
    
  });
});
