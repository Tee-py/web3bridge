//SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.5;

contract School {

    struct Instructor {
        string name;
        uint age;
    }

    struct Module {
        string name;
        string description;
    }

    struct Course {
        string name;
        uint fee;
        Instructor[] instructors;
        mapping(uint=> Module) modules;
        uint moduleCount;
    }

    struct CourseWithoutMapping {
        string name;
        uint fee;
        Instructor[] instructors;
        uint moduleCount;
    }

    string schoolName;
    uint private courseCount = 0;
    mapping(uint => Course) private courses;
    address payable private owner;
    

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
        Course storage newCourse = courses[courseCount];
        newCourse.name = _name;
        newCourse.fee = _fee;
        courseCount += 1;
    }

    function addModule(Module memory _module, uint _cid) external isOwner {
        Course storage course = courses[_cid];
        course.modules[course.moduleCount] = _module;
        course.moduleCount += 1;
    }

    function addInstructor(Instructor memory _instructor, uint _index) external isOwner {
        Course storage course = courses[_index];
        course.instructors.push(_instructor);
    }

    function fetchCourses() external view returns(CourseWithoutMapping[] memory){
        CourseWithoutMapping[] memory _courses = new CourseWithoutMapping[](courseCount);
        for (uint i=0; i<courseCount; i++){
            CourseWithoutMapping memory c = CourseWithoutMapping(courses[i].name, courses[i].fee, courses[i].instructors, courses[i].moduleCount);
            _courses[i] = c;
        }
        return _courses;
    }

    function fetchCourse(uint index) external view returns(CourseWithoutMapping memory){
        Course storage course = courses[index];
        CourseWithoutMapping memory returnCourse = CourseWithoutMapping(course.name, course.fee, course.instructors, course.moduleCount);
        return returnCourse;
    }

    function fetchModules(uint _cindex) external view returns(Module[] memory){
        Course storage course = courses[_cindex];
        Module[] memory modules = new Module[](course.moduleCount);
        for (uint i=0; i<course.moduleCount; i++){
            modules[i] = course.modules[i];
        }
        return modules;
    }
}