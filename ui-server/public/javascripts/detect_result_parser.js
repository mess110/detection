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

function DetectResultParser(req) {
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
  }
  else // Internet Explorer
  {
    xmlDoc=new ActiveXObject("Microsoft.XMLDOM");
    xmlDoc.async="false";
    xmlDoc.loadXML(req);
  }
}
