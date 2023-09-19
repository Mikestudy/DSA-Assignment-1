import ballerina/http;
import ballerina/io;
import ballerina/log;

// Define a record type for Lecturer
type Lecturer record {
    string staffNumber;
    string officeNumber;
    string staffName;
    string title;
    string[] courses;
}

// Define an in-memory store for lecturers
map<string, Lecturer> lecturersStore;

// Function to handle JSON serialization
function toJson(json j) returns Lecturer? {
    Lecturer lecturer = <Lecturer>j;
    if (lecturer is Lecturer) {
        return lecturer;
    }
    return ();
}

// Function to handle JSON deserialization
function fromJson(Lecturer lecturer) returns json {
    return lecturer;
}

// Add a new lecturer
@http:ResourceConfig {
    methods: ["POST"],
    path: "/lecturers"
}
resource function addLecturer(http:Request req, http:Response res) {
    json requestBody = check req.getJsonPayload();
    Lecturer? lecturer = toJson(requestBody);

    if (lecturer is Lecturer) {
        lecturersStore[lecturer.staffNumber] = lecturer;
        res.setStatusCode(201);
        res.setHeader("Content-Type", "application/json");
        res.setPayload(fromJson(lecturer));
    } else {
        res.setStatusCode(400);
        res.setHeader("Content-Type", "application/json");
        res.setPayload({"error": "Invalid lecturer data"});
    }
}

// Retrieve a list of all lecturers
@http:ResourceConfig {
    methods: ["GET"],
    path: "/lecturers"
}
resource function getAllLecturers(http:Request req, http:Response res) {
    json[] lecturerArray = [];
    foreach key, value in lecturersStore {
        lecturerArray.push(fromJson(value));
    }
    res.setHeader("Content-Type", "application/json");
    res.setPayload(lecturerArray);
}

// Implement other resource functions for updating, deleting, and querying lecturers
// ...

// Retrieve all the lecturers that teach a certain course
@http:ResourceConfig {
    methods: ["GET"],
    path: "/courses/{courseCode}/lecturers"
}
resource function getLecturersByCourse(http:Request req, http:Response res, string courseCode) {
    json[] matchingLecturers = [];
    foreach key, lecturer in lecturersStore {
        if (courseCode in lecturer.courses) {
            matchingLecturers.push(fromJson(lecturer));
        }
    }
    res.setHeader("Content-Type", "application/json");
    res.setPayload(matchingLecturers);
}

// Retrieve all the lecturers that sit in the same office
@http:ResourceConfig {
    methods: ["GET"],
    path: "/offices/{officeNumber}/lecturers"
}
resource function getLecturersByOffice(http:Request req, http:Response res, string officeNumber) {
    json[] matchingLecturers = [];
    foreach key, lecturer in lecturersStore {
        if (officeNumber == lecturer.officeNumber) {
            matchingLecturers.push(fromJson(lecturer));
        }
    }
    res.setHeader("Content-Type", "application/json");
    res.setPayload(matchingLecturers);
}

function main() {
    http:Listener listener = new(8080);
    listener.start();
    log:print("Server started on port 8080");
    listener.stop();
}
