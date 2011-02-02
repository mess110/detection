var api = new DetectClient();
var NOT_COMPLETED_TIMEOUT = 3000;

function clearInput(element) {
  content = element.value;
  if ((content.substring(0,4) != 'http') && (content.substring(0,3) != 'ftp')) {
    element.value = '';
  }
}

function DetectClient() {
  this.detect = function(image_url) {
    $("loader").style.visibility = "visible";
    $('urlbox').value = image_url;
    var url = "/api/v2/detect/new?url=" + image_url;
    new Ajax.Request(url, {
      method:'get',
      onSuccess: function(transport){
        var response = transport.responseText;
        result = new DetectResultParser(response);

        if (result.isError()) {
          e = result.getError();
          draw_error(e);
          return;
        }
        if (!result.isCompleted()) {
          draw_not_completed(image_url);
          return;
        }

        draw_image(image_url, result);
        $("loader").style.visibility = "hidden";
      },
      onFailure: function(){
        $("loader").style.visibility = "hidden";
        e = new ApiError("connection_error", "can not connect to runner")
        draw_error(e);
      }
    });
  };

  function draw_error(e) {
    var canvas = $("detection");
    var context = canvas.getContext("2d");
    clearContext(context, canvas.width, canvas.height);
    canvas.height = 50;
    $("shout").innerHTML = e.description;
    $("loader").style.visibility = "hidden";
  }

  function draw_not_completed(image_url) {
    setTimeout('api.detect(\'' + image_url + '\')', NOT_COMPLETED_TIMEOUT);
  }

  function draw_image(image_url, result) {
    var canvas = $("detection");
    var context = canvas.getContext("2d");
    clearContext(context, canvas.width, canvas.height);
    var img = new Image();
    img.src = image_url;
    img.onload = function() {
      canvas.width = img.width;
      canvas.height = img.height;
      context.drawImage(img, 0, 0);
      context.strokeStyle = "#FFA500";
      result.getRegions().each(function(item) {
        x = item.top_left_x;
        y = item.top_left_y;
        width = item.bottom_right_x - x;
        height = item.bottom_right_y - y;
        context.strokeRect(x, y, width, height);
      });
    }
  }
  
  function clearContext(context, width, height) {
    context.fillStyle = "#FFFFFF";
    context.fillRect(0, 0, width, height);
  }
}
