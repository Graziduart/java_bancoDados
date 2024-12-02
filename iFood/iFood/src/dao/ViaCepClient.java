package dao;

import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.net.URI;

public class ViaCepClient {

    // Método para buscar o endereço pelo CEP
    public static String buscarEnderecoPorCep(String cep) {
        String url = "https://viacep.com.br/ws/" + cep + "/json/";
        HttpClient client = HttpClient.newHttpClient();
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(url))
                .GET()
                .build();

        try {
            HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());
            if (response.statusCode() == 200) {
                return response.body();
            } else {
                System.err.println("Erro ao consultar o CEP. Status code: " + response.statusCode());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // Método para extrair valores do JSON
    public static String extractValueFromJson(String json, String key) {
        String searchKey = "\"" + key + "\":";
        int startIndex = json.indexOf(searchKey);

        if (startIndex == -1) {
            return "Não encontrado"; // Chave não encontrada
        }

        startIndex += searchKey.length(); // Move o índice para o início do valor

        // Remove espaços extras e detecta o início do valor corretamente
        while (json.charAt(startIndex) == ' ' || json.charAt(startIndex) == '"') {
            startIndex++;
        }

        int endIndex = json.indexOf(",", startIndex);
        if (endIndex == -1) {
            endIndex = json.indexOf("}", startIndex); // Caso seja o último campo
        }

        // Remove possíveis aspas no final
        String value = json.substring(startIndex, endIndex).trim();
        if (value.endsWith("\"")) {
            value = value.substring(0, value.length() - 1);
        }

        return value;
    }
}