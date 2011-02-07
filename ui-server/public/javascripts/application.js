var api = new DetectClient();
var NOT_COMPLETED_TIMEOUT = 3000;

function clearInput(element) {
  content = element.value;
  if ((content.substring(0,4) != 'http') && (content.substring(0,3) != 'ftp')) {
    element.value = '';
  }
}
