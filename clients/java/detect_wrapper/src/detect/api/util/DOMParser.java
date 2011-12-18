package detect.api.util;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.ArrayList;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import detect.api.models.ApiError;
import detect.api.models.Image;
import detect.api.models.Region;

public class DOMParser {

	private Document doc;

	public DOMParser(String xml) throws Exception {
		this.doc = getNormalizedDocument(xml);
	}

	public boolean hasNodeNamed(String name) {
		boolean result = false;
		try {
			result = doc.getElementsByTagName(name).getLength() != 0;
		} catch (Exception e) {
			System.out.println("Could not parse xml!");
			//e.printStackTrace();
		}
		return result;
	}

	public ApiError getApiError() {
		ApiError ae = new ApiError();
    	String[] tagList = {"code", "description"};
    	ArrayList<String> error = getValues("error", tagList);
    	ae.setErrorCode(error.get(0));
    	ae.setErrorDescription(error.get(1));
    	return ae;
	}

	public Image getImage() {
		Image img = new Image();
    	String[] tagList = {"id", "status", "url"};
    	ArrayList<String> values = getValues("image", tagList);
    	img.setId(Integer.parseInt(values.get(0)));
    	img.setStatus(values.get(1));
    	img.setUrl(values.get(2));

    	NodeList nList = doc.getElementsByTagName("regions");
		for (int temp = 0; temp < nList.getLength(); temp++) {
	    	Node nNode = nList.item(temp);
	    	if (nNode.getNodeType() == Node.ELEMENT_NODE) {
	    		Element eElement = (Element) nNode;
	    		NodeList nlList= eElement.getElementsByTagName("region");

	    		for (int i = 0; i < nlList.getLength(); i++) {
	    			Node oneRegion = nlList.item(i);
    	    		NamedNodeMap attr = oneRegion.getAttributes();
    	    		img.addRegion(parseRegion(attr));
	    		}
	       }
	    }
    	return img;
	}

	private Region parseRegion(NamedNodeMap attr) {
		int tlx = Integer.valueOf(attr.getNamedItem("top_left_x").getNodeValue());
		int tly = Integer.valueOf(attr.getNamedItem("top_left_y").getNodeValue());
		int brx = Integer.valueOf(attr.getNamedItem("bottom_right_x").getNodeValue());
		int bry = Integer.valueOf(attr.getNamedItem("bottom_right_y").getNodeValue());

		Region r = new Region();
		r.setTlx(tlx);
		r.setTly(tly);
		r.setBrx(brx);
		r.setBry(bry);

		return r;
	}

    private ArrayList<String> getValues(String nodeListName, String[] tagList){
    	ArrayList<String> result = new ArrayList<String>();
    	NodeList nList = doc.getElementsByTagName(nodeListName);

	    for (int temp = 0; temp < nList.getLength(); temp++) {
	    	Node nNode = nList.item(temp);
	    	if (nNode.getNodeType() == Node.ELEMENT_NODE) {
	    	   Element eElement = (Element) nNode;
	    	   for (String tag : tagList) {
	    		   result.add(getTagValue(tag, eElement));
	    	   }
	       }
	    }
	    return result;
	}

    private Document getNormalizedDocument(String xml) throws Exception {
    	DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
	    DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
	    InputStream is = new ByteArrayInputStream(xml.getBytes("UTF-8"));
	    Document doc = dBuilder.parse(is);
	    doc.getDocumentElement().normalize();
	    return doc;
    }

	private String getTagValue(String sTag, Element eElement){
		NodeList nlList= eElement.getElementsByTagName(sTag).item(0).getChildNodes();
		Node nValue = (Node) nlList.item(0);
		// sucks that I have to do this..
		try {
			return nValue.getNodeValue();
		} catch (NullPointerException e) {
			return "";
		}
	}
}
