//SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.5;

contract School {

    struct Instructor {
        string name;
        uint age;
    }

    struct Course {
        string name;
        uint fee;
        address[] students;
        Instructor[] instructors;
    }

    mapping(uint => Course) private courses;
    mapping(address => Course[]) private myCourses;
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

    function addInstructor(string memory _name, uint _age, uint _index) external isOwner {
        Course storage course = courses[_index];
        course.instructors.push(Instructor(_name, _age));
    }

    function enroll(uint _index) external payable isNotOwner{
        Course storage course = courses[_index];
        require(msg.value == course.fee * 1 wei, "Insufficient Amount.");
        course.students.push(msg.sender);
        myCourses[msg.sender].push(course);
    }

    function fetchCourse(uint _index) external view returns(Course memory _course){
        return courses[_index];
    }

    function myCourse() external view returns(Course[] memory _mycourses){
        return myCourses[msg.sender];
    }
}