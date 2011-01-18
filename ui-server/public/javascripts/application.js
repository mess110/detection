var text = "http://sphotos.ak.fbcdn.net/photos-ak-snc1/v272/12/29/1352704123/n1352704123_30009292_5638.jpg"
var api = new Detect();

Event.observe(window, 'load', function() {  
  api.detect(text);
});

function clearInput(element) {
  content = element.value;
  if ((content.substring(0,4) != 'http') && (content.substring(0,3) != 'ftp')) {
    element.value = '';
  }
}

function clearContext(context, width, height) {
  context.fillStyle = "#FFFFFF";
  context.fillRect(0, 0, width, height);
}

