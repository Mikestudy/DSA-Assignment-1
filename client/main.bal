import ballerina/http;
import ballerina/io;
import ballerina/log;

// Define API base URL
string baseUrl = "http://localhost:8080";

// Define HTTP client configuration
http:ClientEndpointConfig clientConfig = {
    baseUrl: baseUrl
};

public function addLecturer(json lecturer) returns json | error {
    // Implement HTTP POST request to add a new lecturer
    http:Request request = new;
    request.setJsonPayload(lecturer);

    var response = check http:post("/lecturers", request, clientConfig);
    if (response is http:Response) {
        if (response.statusCode == 201) {
            return check response.getJsonPayload();
        } else {
            log:printError("Error adding lecturer: " + response.getStringPayload());
            return error("Failed to add lecturer");
        }
    } else {
        log:printError("Error sending HTTP request: " + response.toString());
        return error("Failed to send HTTP request");
    }
}

public function getAllLecturers() returns json | error {
    // Implement HTTP GET request to retrieve all lecturers
    var response = check http:get("/lecturers", clientConfig);
    if (response is http:Response) {
        if (response.statusCode == 200) {
            return check response.getJsonPayload();
        } else {
            log:printError("Error getting lecturers: " + response.getStringPayload());
            return error("Failed to get lecturers");
        }
    } else {
        log:printError("Error sending HTTP request: " + response.toString());
        return error("Failed to send HTTP request");
    }
}

// Implement other client functions for updating, deleting, and querying lecturers
// ...

public function getLecturersByCourse(string courseCode) returns json | error {
    // Implement HTTP GET request to retrieve lecturers for a specific course
    var response = check http:get("/courses/" + courseCode + "/lecturers", clientConfig);
    if (response is http:Response) {
        if (response.statusCode == 200) {
            return check response.getJsonPayload();
        } else {
            log:printError("Error getting lecturers by course: " + response.getStringPayload());
            return error("Failed to get lecturers by course");
        }
    } else {
        log:printError("Error sending HTTP request: " + response.toString());
        return error("Failed to send HTTP request");
    }
}

public function getLecturersByOffice(string officeNumber) returns json | error {
    // Implement HTTP GET request to retrieve lecturers in a specific office
    var response = check http:get("/offices/" + officeNumber + "/lecturers", clientConfig);
    if (response is http:Response) {
        if (response.statusCode == 200) {
            return check response.getJsonPayload();
        } else {
            log:printError("Error getting lecturers by office: " + response.getStringPayload());
            return error("Failed to get lecturers by office");
        }
    } else {
        log:printError("Error sending HTTP request: " + response.toString());
        return error("Failed to send HTTP request");
    }
}
