// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

contract ProofOfExistence {
    
    // the admin can create record for a student
    // then push the recored into an array
    // generate an Id for that student
    // assign the studentID ID their address
    // assign the students Record to their ID
    // student can call a function from their account to retrive thier id
    // students can give their Id to anyone who can then use it to call a function that will return the record

    struct StudentRec {
        uint ID;
        string fullname;
        uint DOB;
        string gender;
        string state_of_origin;
    }

    uint ID = 1000;

    address admin;

    mapping(address => uint) private studentsToID;
    mapping(uint => StudentRec) internal IDToRecord;
    mapping(uint => StudentRec) public dropouts;

    StudentRec[] studentsRecords;

    constructor(address _admin) {
        admin = _admin;
    }



    modifier onlyAdmin {
        require(msg.sender == admin, "Only admin can call this function!");
        _;
    }

    function addStudent(
        address _address,
        string memory _fullname,
        uint _DOB,
        string memory _gender,
        string memory _state_of_origin
        ) public onlyAdmin returns(bool, uint) {
            
            if(addressExist(_address)) {
                return (false, studentsToID[_address]);
            }

            ID = ID + 1;

            StudentRec memory newStudent = StudentRec(ID, _fullname, _DOB, _gender, _state_of_origin);

            studentsRecords.push(newStudent);

            studentsToID[_address] = ID;

            IDToRecord[ID] = newStudent;

            return(true, ID);

    }

    
    function retriveID() external view returns(bool, uint256) {
        uint id = studentsToID[msg.sender];
        if(id == 0) return (false, 0);
        return (true, id);
    }
    
    // Jumoke: for admin to retrieve student ID by their wallet address
    function adminRecovery(address _address) onlyAdmin external view returns(bool, uint256) {
        uint id = studentsToID[_address];
        if(id == 0) return (false, 0);
        return (true, id);
    }
    // a function to return the recored of a student by their id
    function confirmRecord(uint256 _ID) external view returns(StudentRec memory) {
        return IDToRecord[_ID];
    }
 
    // to confirm whether an address already has a record associated with it
    function addressExist(address _address) internal view returns(bool) {
        return !(studentsToID[_address] == 0);
    }

    function dropOut(uint256 IDTobeDeleted) external onlyAdmin returns(bool) {
        require(IDToRecord[IDTobeDeleted].ID != 0, "Student does not exist");
        dropouts[IDTobeDeleted] = IDToRecord[IDTobeDeleted];
        delete IDToRecord[IDTobeDeleted];

        // first method
        // for(uint i; i < studentsRecords.length; i++) {
        //     if(studentsRecords[i].ID == IDTobeDeleted) {
        //         delete studentsRecords[i];
        //     }
        // }

        // second method
        // uint indexTobeRemoved;
        // for(uint i; i < studentsRecords.length; i++) {
        //     if(studentsRecords[i].ID == IDTobeDeleted) {
        //         indexTobeRemoved = i;
        //         break;
        //     }
        // }

        // for(uint i = indexTobeRemoved; i < studentsRecords.length - 1; i++) {
        //     studentsRecords[i] = studentsRecords[i + 1];
        // }
        // studentsRecords.pop();

        // third method: recormended



        // third method
        uint indexTobeRemoved;
        for(uint i; i < studentsRecords.length; i++) {
            if(studentsRecords[i].ID == IDTobeDeleted) {
                indexTobeRemoved = i;
                break;
            }
        }
        studentsRecords[indexTobeRemoved] = studentsRecords[studentsRecords.length - 1];
        studentsRecords.pop();


        return true;
    }
}