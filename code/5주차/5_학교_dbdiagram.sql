-- dbdiagram.io를 위해 수정하기

TABLE Professor{
	professor_id int [pk]
	professor_name varchar 
	department varchar 
	salary numeric
	salary_level numeric
	hire_date date
}

TABLE Student {
	student_id int [pk]
	student_name varchar
	major varchar
}

TABLE Course {
	course_id int
	section_id int
	professor_id int
	course_name varchar
	indexes {
		(course_id, section_id) [pk]
	}
}

TABLE Enrollment {
	student_id int
	course_id int
	grade varchar
	points numeric -- 99.65
	enrolled_at DATE
	PRIMARY KEY (student_id, course_id)
	FOREIGN KEY (student_id) REFERENCES Student (student_id)
	--FOREIGN KEY (course_id) REFERENCES Course(course_id)
}