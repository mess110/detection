package detect;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;

/**
 *
 * @author Cristian Mircea Messel
 */
public class Detection {

    private static String base_url = "http://detection.myvhost.de/";

    public static String auth(String email, String pass) throws MalformedURLException, IOException {
        String result = "";

        URL url = new URL(base_url + "auth/?email=" + email + "&pass=" + pass);
        URLConnection con = url.openConnection();

        BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
        String inputLine;

        while ((inputLine = in.readLine()) != null) {
            result += inputLine + "\n";
        }

        result = result.substring(0, result.length() - 1);
        in.close();

        return result;
    }

    public static String detect(String image_url, String key, String secret) throws MalformedURLException, IOException {
        String result = "";
        URL url = new URL(base_url + "detect/new?url=" + image_url);
        URLConnection con = url.openConnection();

        String userPassword = key + ":" + secret;

        //sun implementation
        //String encoding = new sun.misc.BASE64Encoder().encode(userPassword.getBytes());

        //wikihow implementation
        String encoding = new Base64().encode(userPassword);
        con.setRequestProperty("Authorization", "Basic " + encoding);

        BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
        String inputLine;

        while ((inputLine = in.readLine()) != null) {
            result += inputLine + "\n";
        }

        result = result.substring(0, result.length() - 1);
        in.close();

        return result;
    }
}
