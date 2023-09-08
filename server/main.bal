import ballerina/http;
import ballerina/io;

// Define a record type for Lecturer
record Lecturer {
    string staffNumber;
    string officeNumber;
    string staffName;
    string title;
    string[] courses;
}

// Define an in-memory data store for lecturers (replace with a database in production)
var lecturers = [Lecturer{"001", "A101", "John Doe", "Professor", ["CS101", "CS202"]}];

service /lecturers on new http:Listener(8080) {

    resource function get getAllLecturers() returns json {
        // Return the list of all lecturers as JSON
        return lecturers;
    }

    resource function post addLecturer(json lecturerJson) returns json {
        // Parse the JSON request and add the lecturer to the data store
        Lecturer newLecturer = lecturerJson;
        lecturers.push(newLecturer);
        // Return the newly added lecturer as JSON
        return newLecturer;
    }
} 
