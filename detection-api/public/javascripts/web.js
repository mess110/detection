/*
  The reason why this one uses XML is because firefox and IE didn't like json
  Although the first method worked dunnno why this is buggy, but I know I had
  to make it work. And now it does.
*/
function reqTest() {
  $("notice").innerHTML = "loading";
  scanEffect();
  var auth = encodeToken($("key").value, $("secret").value);
  var url = "/detect/new/?url=" + $("urlbox").value;
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
        var cat = new Image();
        cat.src = $("urlbox").value;
        cat.onload = function() {
          offsetX = (600 - cat.width) / 2;
          offsetY = (400 - cat.height) / 2;
          context.drawImage(cat, offsetX, offsetY);
          context.strokeStyle = "#FFA500";
          parser.getFaces().each(function(item) {
            x = offsetX + item.tlx;
            y = offsetY + item.tly;
            width = offsetX + item.brx - x;
            height = offsetY + item.bry - y;
            context.strokeRect(x, y, width, height);
          });
        }
        $("notice").innerHTML = "done";
        scanEffect2();
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
  if (($("pass").value == "") || ($("repass").value == "")) {
    $("notice").innerHTML = "Password can not be null!";
    return;
  }

  if ($("pass").value != $("repass").value) {
    $("notice").innerHTML = "Passwords do not match!";
    return;
  }

  var uri = '/authenticate/?email=' + $('email').value + '&pass=' + $('pass').value;
  new Ajax.Request(uri,
  {
    requestHeaders: {Accept: 'application/json'},
    method:'get',
    onSuccess: function(transport){
      var response = transport.responseText;
      var jsonResponse = response.evalJSON();
      if (jsonResponse.description == undefined)
      {
        $("notice").innerHTML = "If you want, you can test the API by clicking TEST and using your API Key and Secret! (not user and pass)";
        $("key").value = jsonResponse.api_key.key;
        $("secret").value = jsonResponse.api_key.secret;

        authEffect();
      } else {
        $("notice").innerHTML = jsonResponse.description;
      }
    },
    onFailure: function(){
      $("notice").innerHTML = response;
    }
  });
}
