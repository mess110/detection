var text = "http://sphotos.ak.fbcdn.net/photos-ak-snc1/v272/12/29/1352704123/n1352704123_30009292_5638.jpg"

Event.observe(window, 'load', function() {  
  detect(text);
});

function clearInput(element) {
  content = element.value;
  if ((content.substring(0,4) != 'http') && (content.substring(0,3) != 'ftp')) {
    element.value = '';
  }
}

function detect(image_url) {
  var url = "/api/v2/detect/new?url=" + image_url;
  new Ajax.Request(url, {
    method:'get',
    onSuccess: function(transport){
      var response = transport.responseText;
      alert(response);
      var canvas = $("detection");
      var context = canvas.getContext("2d");
      clearContext(context, canvas.width, canvas.height);
      var img = new Image();
      img.src = image_url;
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
