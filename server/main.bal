import ballerina/http;
import ballerina/io;

// Define a record type for Lecturer
type Lecturer readonly & Record;
type staffNumber string;

type Record record {
    string staffNumber;
    string officeNumber;
    string staffName;
    string title;
    string courses;
};

// Define an in-memory data store for lecturers (replace with a database in production)
table<Lecturer> key(staffNumber) lecturers = table[];

service /lecturers on new http:Listener(8080) {

    resource function get getAllLecturers() returns table<Lecturer> key(staffNumber) {
        return lecturers;
    }

    resource function post addLecturer(Lecturer lecturer) returns string {
        // Parse the JSON request and add the lecturer to the data store
        io:println(lecturer);
        error? err = lecturers.put(lecturer);
        if (err is error) {
            return string `Error, ${err.message()}`;
        }
        return string `${lecturer.staffNumber} saved successfully`;
    }
    
    resource function get getLecturerByStaffNumber(string staffNumber) returns Lecturer? {
        foreach Lecturer lecturer in lecturers {
            if (lecturer.staffNumber === staffNumber) {
                return lecturer;
            }
        }
    }
    
    resource function put updateLecturer( Lecturer lecturer) returns json {
       io:println(lecturer);
        error? err = put(lecturer);
        if (err is error) {
            return string `Error, ${err.message()}`;
        }
        return string `${lecturer.staffNumber} saved successfully`;
    }
    resource function delete deleteLecturerByStaffNumber(string staffNumber) returns json {
        lecturers = <table<Lecturer> key(staffNumber)>lecturers.filter((lecture) => lecture.staffNumber != staffNumber);
        table<Lecturer> Lectuers1 = table [];

        
        if (lecturers.length() === Lectuers1.length()) {
            return staffNumber + " not found.";
        }
        return staffNumber + " successfuly deleted";
        
        // if (Lecturers(staffNumber)) {
        //     Lecturers.remove(staffNumber);
        //     return string `Lecturer with staff number ${staffNumber} deleted successfully`;
        // } else {
        //     return string `Lecturer with staff number ${staffNumber} not found`;
        // }
    }
    
    resource function get getLecturersByCourse/[string course]() returns Lecturer|string {
       foreach Lecturer lecturer in lecturers {
            if (lecturer.courses === course) {
                return lecturer;
            }
        }

        return course + " is invalid";
    }
    
    resource function get getLecturersByOffice/[string office]() returns Lecturer|string {
        
        foreach Lecturer  lecturer in lecturers {
            if (lecturer.officeNumber === office) {
               return lecturer;
            }
        }
        return office + " is invalid";
    }
}

function put(Lecturer r) returns error? {
    return ();
}





