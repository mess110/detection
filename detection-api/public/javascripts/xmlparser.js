//data structure for JS face.
function Face(tlx, tly, brx, bry) {
  this.tlx = tlx;
  this.tly = tly;
  this.brx = brx;
  this.bry = bry;
}

//the face xml parser. returns face array :)
function FaceXMLParser(req){
  this.req=req

  this.getQueryId = function() {
    return xmlDoc.getElementsByTagName("query-id")[0].childNodes[0].nodeValue;
  };

  this.getTimestamp = function() {
    return xmlDoc.getElementsByTagName("time")[0].childNodes[0].nodeValue;
  };

  this.isError = function() {
    return (xmlDoc.getElementsByTagName("description")[0] != undefined)
  }

  this.getErrorDescription = function() {
    return xmlDoc.getElementsByTagName("description")[0].childNodes[0].nodeValue;
  }

  this.getFaces = function() {
    var result = new Array();
    var myfaces = xmlDoc.getElementsByTagName("face");
    for ( i = 0; i < myfaces.length; i = i + 1)
    {
      face = myfaces[i];
      tlx = parseFloat(face.getElementsByTagName("top-left-x")[0].childNodes[0].nodeValue);
      tly = parseFloat(face.getElementsByTagName("top-left-y")[0].childNodes[0].nodeValue);
      brx = parseFloat(face.getElementsByTagName("bottom-right-x")[0].childNodes[0].nodeValue);
      bry = parseFloat(face.getElementsByTagName("bottom-right-y")[0].childNodes[0].nodeValue);
      result[i] = new Face(tlx, tly, brx, bry);
    }
    return result;
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

  //xmlhttp.open("GET",req,false);
  //xmlhttp.send();
  //xmlDoc=xmlhttp.responseXML;
}

