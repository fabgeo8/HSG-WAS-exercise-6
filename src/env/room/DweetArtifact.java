package room;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URI;
import java.net.URLEncoder;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;

import cartago.Artifact;
import cartago.OPERATION;

/**
 * A CArtAgO artifact that provides an operation for sending messages to agents 
 * with KQML performatives using the dweet.io API
 */
public class DweetArtifact extends Artifact {
    private final String DWEET_URI = "https://dweet.io/dweet/for/hsg-was-fabio";

    void init() {

    }

    @OPERATION
    void publish(String message) {
        try {
            String urlEncoded = DWEET_URI + "?message=" + URLEncoder.encode(message, StandardCharsets.UTF_8.toString());
        
            System.out.println(urlEncoded);

            HttpClient client = HttpClient.newHttpClient();
            HttpRequest request = HttpRequest.newBuilder(URI.create(DWEET_URI))
                    .GET()
                    .header("Content-Type", "application/json")
                    .build();
            try {
                HttpResponse<Void> response = client.send(request, HttpResponse.BodyHandlers.discarding());

                if(response.statusCode() != 200) {
                    System.out.println(response.statusCode());
                    System.out.println("Something went wrong");
                }
            } catch (IOException | InterruptedException e) {
                throw new RuntimeException(e);
            }
        } catch (UnsupportedEncodingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
}
