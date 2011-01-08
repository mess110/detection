// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function clearInput(element) {
  content = element.value;
  if ((content.substring(0,4) != 'http') && (content.substring(0,3) != 'ftp')) {
    element.value = '';
  }
}
