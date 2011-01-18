var api = new DetectClient();

Event.observe(window, 'load', function() {  
  home_url = "http://sphotos.ak.fbcdn.net/photos-ak-snc1/v272/12/29/1352704123/n1352704123_30009292_5638.jpg"
  api.detect(home_url);
});

function clearInput(element) {
  content = element.value;
  if ((content.substring(0,4) != 'http') && (content.substring(0,3) != 'ftp')) {
    element.value = '';
  }
}

