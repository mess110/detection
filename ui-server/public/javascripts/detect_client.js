var NOT_COMPLETED_TIMEOUT = 3000;

function DetectClient() {
  this.detect = function(image_url) {
    $("loader").style.visibility = "visible";
    var url = "/api/v2/detect/new?url=" + image_url;
    new Ajax.Request(url, {
      method:'get',
      onSuccess: function(transport){
        var response = transport.responseText;
        xp = new XmlParser(response);

        if (xp.isError()) {
          e = xp.getError();
          draw_error(e);
          return;
        }
        if (!xp.isCompleted()) {
          draw_not_completed(image_url);
          return;
        }

        draw_image(image_url, xp);
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
    $("shout").innerHTML = e.code;
    $("loader").style.visibility = "hidden";
  }

  function draw_not_completed(image_url) {
    setTimeout('api.detect(\'' + image_url + '\')', NOT_COMPLETED_TIMEOUT);
  }

  function draw_image(image_url, xp) {
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
      xp.getRegions().each(function(item) {
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

function XmlParser(req) {
  this.req = req;
  
  this.getRegions = function() {
    var result = new Array();
    var myregions = xmlDoc.getElementsByTagName("region");
    for ( i = 0; i < myregions.length; i = i + 1)
    {
      region = myregions[i];
      tlx = parseFloat(region.getAttribute("top_left_x"));
      tly = parseFloat(region.getAttribute("top_left_y"));
      brx = parseFloat(region.getAttribute("bottom_right_x"));
      bry = parseFloat(region.getAttribute("bottom_right_y"));
      result[i] = new Region(tlx, tly, brx, bry);
    }
    return result;
  };

  this.isCompleted = function() {
    status = xmlDoc.getElementsByTagName("status")[0].childNodes[0].nodeValue;
    return status == "completed";
  };
  
  this.getError = function() {
    code = xmlDoc.getElementsByTagName("code")[0].childNodes[0].nodeValue;
    description = xmlDoc.getElementsByTagName("description")[0].childNodes[0].nodeValue;
    return new ApiError(code, description);
  }
  
  this.isError = function() {
    return xmlDoc.getElementsByTagName("error")[0] != null;
  };

  if (window.DOMParser)
  {
    parser=new DOMParser();
    xmlDoc=parser.parseFromString(req,"text/xml");
    //xmlhttp=new XMLHttpRequest();
  }
  else // Internet Explorer
  {
    xmlDoc=new ActiveXObject("Microsoft.XMLDOM");
    xmlDoc.async="false";
    xmlDoc.loadXML(req);
    //xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  }
}

function ApiError(code, description) {
  this.code = code;
  this.description = description;
}

function Region(tlx, tly, brx, bry) {
  this.top_left_x = tlx;
  this.top_left_y = tly;
  this.bottom_right_x = brx;
  this.bottom_right_y = bry;
}
