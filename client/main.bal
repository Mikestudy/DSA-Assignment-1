import ballerina/io;
import ballerina/http;
import ballerina/io;

public function main() {
    // Define the API base URL here
    string baseUrl = "http://localhost:8080"; // Replace with your API URL

    // Make a GET request to retrieve a list of all lecturers here 
    http:Client lecturerClient = new(baseUrl + "/lecturers");
    var getResponse = lecturerClient->get("/");

    match getResponse {
        http:Response response => {
            if (response.statusCode == 200) {
                // Successful response, parse the JSON and process the data here
                var json = check response.getJsonPayload();
                io:println(json.toString());
            } else {
                // Handle other response codes here
                io:println("Error: " + response.statusCode.toString());
            }
        }
        http:ConnectionError connectionError => {
            // Handle connection errors here
            io:println("Connection error: " + connectionError.message);
        }
    }
}
