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
    http:Client lecturerClient = check new ("http://localhost:8080/lecturers");

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
            Lecturer lecturer = {courses: [], officeNumber: "", staffName: "", staffNumber: "", title: ""};
            lecturer.staffNumber = io:readln("Enter Staff Number: ");
            lecturer.officeNumber = io:readln("Enter Office Number: ");
            lecturer.staffName = io:readln("Enter Staff Name: ");
            lecturer.title = io:readln("Enter Title: ");
            string staffNumber = addLecturers();
            
            
        
    check addLecturer(lecturerClient, lecturer);
        }
        "2" => {
            Lecturer lecturer = {courses: [], officeNumber: "", staffName: "", staffNumber: "", title: ""};
            lecturer.staffNumber = io:readln("Enter staffNumber: ");
            lecturer.staffName = io:readln("Enter leturer Name ");
            check update(lecturerClient, lecturer);
        
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

function addLecturers() returns string {
    return "";
}

function update(http:Client lecturerClient, any b) returns error {
    return error("");
}

public function addLecturer(http:Client http, Lecturer lecturer) returns error? {
    if (http is http:Client) {
        string payload = check http->/addLecturer.post(lecturer);
        io:println(payload);
    }
}

public function updateLecturer(http:Client http, string staffNumber, Lecturer lecturer) returns error? {
    if (http is http:Client) {
        string payload = check http->/updateLecturer.put(staffNumber);
        io:println(payload);
    }
}

public function deleteLecturer(http:Client http, string staffNumber) returns error? {
    if (http is http:Client) {
        string payload = check http->/deleteLecturer.delete(staffNumber);
        io:println(payload);
    }
}

public function getAllLecturers(http:Client http) returns error? {
    if (http is http:Client) {
        Lecturer[] lecturers = check http->/getAllLecturers.get();
        foreach var lecturer in lecturers {
            io:println("--------------------------");
            io:println("Staff Number: " , lecturer.staffNumber);
            io:println("Office Number: " , lecturer.officeNumber);
            io:println("Staff Name: " , lecturer.staffName);
            io:println("Title: " , lecturer.title);
            io:println("Courses: " , lecturer.courses);
        }
    }
}

public function getLecturerByStaffNumber(http:Client http, string staffNumber) returns error? {
    if (http is http:Client) {
        Lecturer lecturer = check http->/getLecturerByStaffNumber.get(staffNumber = staffNumber);
        io:println("--------------------------");
        io:println("Staff Number: " , lecturer.staffNumber);
        io:println("Office Number: " , lecturer.officeNumber);
        io:println("Staff Name: " , lecturer.staffName);
        io:println("Title: " , lecturer.title);
        io:println("Courses: " , lecturer.courses);
    }
}

public function getLecturersByCourse(http:Client http, string course) returns error? {
    if (http is http:Client) {
        Lecturer[] lecturers = check http->/getLecturersByCourse.get(course = course);
        foreach var lecturer in lecturers {
            io:println("--------------------------");
            io:println("Staff Number: " , lecturer.staffNumber);
            io:println("Office Number: " , lecturer.officeNumber);
            io:println("Staff Name: " , lecturer.staffName);
            io:println("Title: " , lecturer.title);
            io:println("Courses: " , lecturer.courses);
        }
    }
}

public function getLecturersByOffice(http:Client http, string office) returns error? {
    if (http is http:Client) {
        Lecturer[] lecturers = check http->/getLecturersByOffice.get(office = office);
        foreach var lecturer in lecturers {
            io:println("--------------------------");
            io:println("Staff Number: " , lecturer.staffNumber);
            io:println("Office Number: " , lecturer.officeNumber);
            io:println("Staff Name: " , lecturer.staffName);
            io:println("Title: " , lecturer.title);
            io:println("Courses: " , lecturer.courses);
        }
    }
}







