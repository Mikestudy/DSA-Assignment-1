import ballerina/io;
import ballerina/http;

type Lecturer record {
    string staffNumber;
    string officeNumber;
    string staffName;
    string title;
    string[] courses;
};

public function main() returns error? {
    http:Client lecturerClient = check new ("http://localhost:9090/lecturers");

    io:println("1. Add a New Lecturer");
    io:println("2. Update Lecturer Information");
    io:println("3. Delete a Lecturer");
    io:println("4. View All Lecturers");
    io:println("5. View Lecturer By Staff Number");
    io:println("6. View Lecturers By Course");
    io:println("7. View Lecturers By Office");

    string option = io:readln("Choose an option: ");

    match option {
        "1" => {
            Lecturer lecturer = {};
            lecturer.staffNumber = io:readln("Enter Staff Number: ");
            lecturer.officeNumber = io:readln("Enter Office Number: ");
            lecturer.staffName = io:readln("Enter Staff Name: ");
            lecturer.title = io:readln("Enter Title: ");

            io:println("Enter Courses (comma-separated): ");
            string coursesInput = io:readln("Enter Courses: ");
            lecturer.courses = ballerina/string:split(coursesInput, ",");
            
            check addLecturer(lecturerClient, lecturer);
        }
        "2" => {
            string staffNumber = io:readln("Enter Staff Number: ");
            Lecturer updatedLecturer = {};
            updatedLecturer.officeNumber = io:readln("Enter Updated Office Number: ");
            updatedLecturer.staffName = io:readln("Enter Updated Staff Name: ");
            updatedLecturer.title = io:readln("Enter Updated Title: ");

            io:println("Enter Updated Courses (comma-separated): ");
            string updatedCoursesInput = io:readln("Enter Updated Courses: ");
            updatedLecturer.courses = ballerina/string:split(updatedCoursesInput, ",");
            
            check updateLecturer(lecturerClient, staffNumber, updatedLecturer);
        }
        "3" => {
            string staffNumber = io:readln("Enter Staff Number to Delete: ");
            check deleteLecturer(lecturerClient, staffNumber);
        }
        "4" => {
            check getAllLecturers(lecturerClient);
        }
        "5" => {
            string staffNumber = io:readln("Enter Staff Number: ");
            check getLecturerByStaffNumber(lecturerClient, staffNumber);
        }
        "6" => {
            string course = io:readln("Enter Course Name: ");
            check getLecturersByCourse(lecturerClient, course);
        }
        "7" => {
            string office = io:readln("Enter Office Number: ");
            check getLecturersByOffice(lecturerClient, office);
        }
        _ => {
            io:println("Invalid Option");
        }
    }
}

function addLecturer(http:Client client, Lecturer lecturer) returns error? {
    if (client is http:Client) {
        string payload = check client->/addLecturer.post(lecturer);
        io:println(payload);
    }
}

function updateLecturer(http:Client client, string staffNumber, Lecturer lecturer) returns error? {
    if (client is http:Client) {
        string payload = check client->/updateLecturer.put(staffNumber, lecturer);
        io:println(payload);
    }
}

function deleteLecturer(http:Client client, string staffNumber) returns error? {
    if (client is http:Client) {
        string payload = check client->/deleteLecturer.delete(staffNumber);
        io:println(payload);
    }
}

function getAllLecturers(http:Client client) returns error? {
    if (client is http:Client) {
        Lecturer[] lecturers = check client->/getAllLecturers.get();
        foreach var lecturer in lecturers {
            io:println("--------------------------");
            io:println("Staff Number: " + lecturer.staffNumber);
            io:println("Office Number: " + lecturer.officeNumber);
            io:println("Staff Name: " + lecturer.staffName);
            io:println("Title: " + lecturer.title);
            io:println("Courses: " + lecturer.courses);
        }
    }
}

function getLecturerByStaffNumber(http:Client client, string staffNumber) returns error? {
    if (client is http:Client) {
        Lecturer lecturer = check client->/getLecturerByStaffNumber.get(staffNumber);
        io:println("--------------------------");
        io:println("Staff Number: " + lecturer.staffNumber);
        io:println("Office Number: " + lecturer.officeNumber);
        io:println("Staff Name: " + lecturer.staffName);
        io:println("Title: " + lecturer.title);
        io:println("Courses: " + lecturer.courses);
    }
}

function getLecturersByCourse(http:Client client, string course) returns error? {
    if (client is http:Client) {
        Lecturer[] lecturers = check client->/getLecturersByCourse.get(course);
        foreach var lecturer in lecturers {
            io:println("--------------------------");
            io:println("Staff Number: " + lecturer.staffNumber);
            io:println("Office Number: " + lecturer.officeNumber);
            io:println("Staff Name: " + lecturer.staffName);
            io:println("Title: " + lecturer.title);
            io:println("Courses: " + lecturer.courses);
        }
    }
}

function getLecturersByOffice(http:Client client, string office) returns error? {
    if (client is http:Client) {
        Lecturer[] lecturers = check client->/getLecturersByOffice.get(office);
        foreach var lecturer in lecturers {
            io:println("--------------------------");
            io:println("Staff Number: " + lecturer.staffNumber);
            io:println("Office Number: " + lecturer.officeNumber);
            io:println("Staff Name: " + lecturer.staffName);
            io:println("Title: " + lecturer.title);
            io:println("Courses: " + lecturer.courses);
        }
    }
}
