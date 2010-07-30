function reqTest() {
  $("notice").innerHTML = "loading";
  scanEffect();
  var auth = encodeToken($("key").value, $("secret").value);
  var url = "/detect/new/?url=" + $("urlbox").value;
  new Ajax.Request(url, {
    requestHeaders: {
      Accept: 'application/json',
      Authorization: auth
    },
    method:'get',
    onSuccess: function(transport){
      var response = transport.responseText;
      //alert(response);
      var jsonResponse = response.evalJSON();
      if (jsonResponse.description == undefined) {
        var canvas = document.getElementById("workingOn");
        var context = canvas.getContext("2d");
        if (context) {
          context.fillStyle = "#f4f5f5";
          context.fillRect(0,0,600,400);
          var cat = new Image();
          cat.src = $("urlbox").value;
          cat.onload = function() {
            offsetX = (600 - cat.width) / 2;
            offsetY = (400 - cat.height) / 2;
            context.drawImage(cat, offsetX, offsetY);
            context.strokeStyle = "#FFA500";
            jsonResponse.faces.each(function(item) {
              x = offsetX + item.top_left_x;
              y = offsetY + item.top_left_y;
              width = offsetX + item.bottom_right_x - x;
              height = offsetY + item.bottom_right_y - y;
              context.strokeRect(x, y, width, height);
            });
          }
          $("notice").innerHTML = "done";
          scanEffect2();
        };
      } else {
          alert("i am here");
        $("notice").innerHTML = jsonResponse.description;
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
        $("notice").innerHTML = "If you want, you can test the API by clicking TEST";
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
