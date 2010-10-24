/*
  The reason why this one uses XML is because firefox and IE didn't like json
  Although the first method worked dunnno why this is buggy, but I know I had
  to make it work. And now it does.
*/
function reqTest() {
  $("notice").innerHTML = "<img src='/images/loader.gif' />";
  var auth = encodeToken($("key").value, $("secret").value);
  var url = "/api/v1/detect/new/?url=" + $("urlbox").value;
  new Ajax.Request(url, {
    requestHeaders: {
      Accept: 'application/xml',
      Authorization: auth
    },
    method:'get',
    onSuccess: function(transport){
      var response = transport.responseText;
      var parser = new FaceXMLParser(response);
      if (parser.isError() == false) {
        var canvas = document.getElementById("workingOn");
        var context = canvas.getContext("2d");
        context.fillStyle = "#FFFFFF";
        context.fillRect(0,0,600,400);
        var cat = new Image();
        cat.src = $("urlbox").value;
        cat.onload = function() {
          canvas.width = cat.width;
          canvas.height = cat.height;
          context.drawImage(cat, 0, 0);
          context.strokeStyle = "#FFA500";
          parser.getFaces().each(function(item) {
            x = item.tlx;
            y = item.tly;
            width = item.brx - x;
            height = item.bry - y;
            context.strokeRect(x, y, width, height);
          });
        }
        $("notice").innerHTML = "done";
      } else {
        $("notice").innerHTML = parser.getErrorDescription();
      }
    },
    onFailure: function(){
      $("notice").innerHTML = resonse;
    }
  });
}

function auth() {
  if ($('pass').value == $('repass').value) {
    document.forms[0].submit();
  } else {
    $('notice').innerHTML = 'Passwords do not match';
  }
}

function clearInput(element) {
  content = element.value;
  if ((content.substring(0,4) != 'http') && (content.substring(0,3) != 'ftp')) {
    element.value = '';
  }
}
