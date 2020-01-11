/*SHOW STUDENTS FROM THE CLASS WITH THE ID 3*/

SELECT student.student_name, student.student_surname
FROM student
WHERE fk_class_id = 3;

/*
should show:
	Micheal Townley
	Trevor Philips
	Franklin Clinton
	*/

#######################################################################

/*SHOW STUDENTS FROM THE CLASS WITH THE NAME "2a"*/

SELECT student.student_name, student.student_surname
FROM student
WHERE fk_class_id = "2a";

/*second option*/

SELECT student.student_name, student.student_surname
FROM student
INNER JOIN class ON student.fk_class_id = class.class_id
WHERE class.className = "2a"

/*
should show:
	Harry Potter
	Ronald Weasley
	Hermione Granger
	*/

#######################################################################

/*SHOW THE CLASSES WHICH THE TEACHER WITH THE ID 4 TEACHES*/

SELECT class.className, teacher.teacher_name, teacher.teacher_surname
FROM teaching
INNER JOIN teacher ON teaching.fk_teacher_id = teacher.teacher_id
INNER JOIN class ON teaching.fk_class_id = class.class_id
WHERE teaching.fk_teacher_id = 4;

/*
should show:
	1a Jake Doe
	3a Jake Doe
	4a Jake Doe
	*/

#######################################################################