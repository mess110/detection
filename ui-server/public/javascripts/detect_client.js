function Detect() {
  this.detect = function(image_url) {
    var url = "/api/v2/detect/new?url=" + image_url;
    new Ajax.Request(url, {
      method:'get',
      onSuccess: function(transport){
        var response = transport.responseText;
        xp = new XmlParser(response);

        if (xp.isCompleted()) {
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
        } else {
          // image is not completed
        }
      },
      onFailure: function(){
        alert("crap");
      }
    });
  };
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

function Region(tlx, tly, brx, bry) {
  this.top_left_x = tlx;
  this.top_left_y = tly;
  this.bottom_right_x = brx;
  this.bottom_right_y = bry;
}
