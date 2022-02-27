//SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.5;

contract School {

    struct Instructor {
        string name;
        uint age;
    }

    struct Module {
        string name;
    }

    struct Course {
        string name;
        uint fee;
        Instructor[] instructors;
        mapping(uint=> Module) modules;
        uint lastModule;
    }

    struct CourseOutput {
        string name;
        uint fee;
        Instructor[] instructors;
        uint lastModule;
    }

    mapping(uint => Course) private courses;
    address payable private owner;
    string schoolName;
    uint private currentIndex = 0;

    constructor(string memory _name) {
        schoolName = _name;
        owner = payable(msg.sender);
    }

    modifier isOwner() {
        require(msg.sender == owner, "Caller is not Owner");
        _;
    }

    modifier isNotOwner() {
        require(msg.sender != owner, "Owner Not Allowed To Call this Method.");
        _;
    }

    function createCourse(string memory _name, uint _fee) external isOwner {
        Course storage newCourse = courses[currentIndex];
        newCourse.name = _name;
        newCourse.fee = _fee;
        currentIndex += 1;
    }

    function addModule(string memory _name, uint _cid) external isOwner {
        Course storage course = courses[_cid];
        course.modules[course.lastModule] = Module(_name);
        course.lastModule += 1;
        currentIndex += 1;
    }

    function addInstructor(string memory _name, uint _age, uint _index) external isOwner {
        Course storage course = courses[_index];
        course.instructors.push(Instructor(_name, _age));
    }

    function fetchCourses() external view returns(CourseOutput[] memory){
        CourseOutput[] memory _courses = new CourseOutput[](currentIndex+1);
        for (uint i=0; i<currentIndex+1; i++){
            CourseOutput memory c = CourseOutput(courses[i].name, courses[i].fee, courses[i].instructors, courses[i].lastModule);
            _courses[i] = c;
        }
        return _courses;
    }

    function fetchCourse(uint index) external view returns(CourseOutput memory){
        Course storage course = courses[index];
        CourseOutput memory returnCourse = CourseOutput(course.name, course.fee, course.instructors, course.lastModule);
        return returnCourse;
    }

    function fetchModules(uint _cindex) external view returns(Module[] memory){
        Course storage course = courses[_cindex];
        Module[] memory modules = new Module[](course.lastModule+1);
        for (uint i=0; i<course.lastModule+1; i++){
            modules[i] = course.modules[i];
        }
        return modules;
    }
}