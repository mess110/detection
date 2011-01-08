function clearInput(element) {
  content = element.value;
  if ((content.substring(0,4) != 'http') && (content.substring(0,3) != 'ftp')) {
    element.value = '';
  }
}

function detect() {
  var url = "/api/v2/detect/new?url=" + $("urlbox").value;
  new Ajax.Request(url, {
    method:'get',
    onSuccess: function(transport){
      var response = transport.responseText;
      var canvas = document.getElementById("detection");
      var context = canvas.getContext("2d");
      clearContext(context, canvas.width, canvas.height);
      var img = new Image();
      img.src = $("urlbox").value;
      img.onload = function() {
        canvas.width = img.width;
        canvas.height = img.height;
        context.drawImage(img, 0, 0);
      }
    },
    onFailure: function(){
      alert("crap");
    }
  });
}

function clearContext(context, width, height) {
  context.fillStyle = "#FFFFFF";
  context.fillRect(0, 0, width, height);
}
