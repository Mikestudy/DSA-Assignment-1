import ballerina/http;
import ballerina/io;

// Define a record type for Lecturer
type Lecturer readonly & record {
    string staffNumber;
    string officeNumber;
    string staffName;
    string title;
    string[] courses;
};

// Define an in-memory data store for lecturers (replace with a database in production)
table<Lecturer> key(staffNumber) Lecturers = table[];

service /lecturers on new http:Listener(8080) {

    resource function get getAllLecturers() returns table<Lecturer> key(staffNumber) {
        return Lecturers;
    }

    resource function post addLecturer(Lecturer lecturer) returns json {
        // Parse the JSON request and add the lecturer to the data store
        io:println(lecturer);
        error? err = Lecturers.put(lecturer);
        if (err is error) {
            return string `Error, ${err.message()}`;
        }
        return string `${lecturer.staffNumber} saved successfully`;
    }
    
    resource function get getLecturerByStaffNumber(string staffNumber) returns Lecturer? {
        Lecturer? lecturer = Lecturers[staffNumber];
        return lecturer;
    }
    
    resource function put updateLecturer( Lecturer lecturer) returns json {
       io:println(Lecturers);
        error? err = put(lecturer);
        if (err is error) {
            return string `Error, ${err.message()}`;
        }
        return string `${lecturer.staffNumber} saved successfully`;
    }
    resource function delete deleteLecturerByStaffNumber(string staffNumber) returns json {
        Lecturers = <table<Lecturer> key(staffNumber)>Lecturers.filter((lecture) => lecture.staffNumber != staffNumber);
        table<Lecturer> Lectuers1 = table [];

        
        if (Lecturers.length() === Lectuers1.length()) {
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
    
    resource function get getLecturersByCourse/[string course]() returns Lecturer[] {
        foreach Lecturer lectuer in Lecturers {
            if (addlecturer.course === course) {
                return lecturer;
            }
        }

        return course[];
    }
    
    resource function get getLecturersByOffice(string office) returns Lecturer[] {
        Lecturer[] lecturers = [];
        foreach Lecturer  value in Lecturers {
            if (office == value.officeNumber) {
                lecturers.push(value);
            }
        }
        return lecturers;
    }
}

function put(Lecturer r) returns error? {
    return ();
}





