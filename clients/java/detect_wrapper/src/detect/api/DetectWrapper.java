package detect.api;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import detect.api.models.ApiError;
import detect.api.models.Image;
import detect.api.util.DOMParser;

public class DetectWrapper {
	
	private static String BASE_URL = "http://localhost:3000";
	private DOMParser dp;
	private String url;
	private ApiError ae = null;
	private Image img = null;
	
	/**
	 * DetectWrapper d = new DetectWrapper("");
       if (d.isSuccessful()) {
         Image img = d.getImage();
         img.getStatus();
       } else {
         ApiError ae = d.getApiError();
         ae.getErrorCode();
       }
	 * @param url
	 * @throws Exception
	 */
	public DetectWrapper(String url) throws Exception {
		this.url = url;
		request();
	}
	
	public DetectWrapper(String url, String base_url) throws Exception {
		this.url = url;
		BASE_URL = base_url;
		request();
	}
	
	public void refresh() throws Exception {
		request();
	}
	
	public boolean isSuccessful() {
		return img != null;
	}
	
	public Image getImage() {
		return img;
	}
	
	public ApiError getApiError() {
		return ae;
	}
	
	private void request() throws Exception {
		this.ae = null;
		this.img = null;
		
		String xml = executeHttpGet("/api/v2/detect/new?url=" + url);			
		this.dp = new DOMParser(xml);
		if (dp.hasNodeNamed("error")) {
			this.ae = dp.getApiError();
		} else {
			this.img = dp.getImage();
		}
	}
	
	private String executeHttpGet(String uri) throws Exception {
	        URL url = new URL(BASE_URL + uri);
	        HttpURLConnection con = (HttpURLConnection) url.openConnection();
	        con.setRequestMethod("GET");	
	      	InputStream is = con.getInputStream();
	        InputStreamReader isr = new InputStreamReader(is);
	        BufferedReader in = new BufferedReader(isr);
	        
	        StringBuffer sb = new StringBuffer("");
	        String line = "";
	        String NL = System.getProperty("line.separator");
	        while ((line = in.readLine()) != null) {
	            sb.append(line + NL);
	        }
	        in.close();
	        return sb.toString();
	}
}
