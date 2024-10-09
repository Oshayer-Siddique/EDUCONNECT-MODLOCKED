-- Drop existing tables if they exist
DROP TABLE IF EXISTS `submission`;
DROP TABLE IF EXISTS `announcement`;
DROP TABLE IF EXISTS `student_enroll`;
DROP TABLE IF EXISTS `teacher_assignment`;
DROP TABLE IF EXISTS `department_admin`;
DROP TABLE IF EXISTS `admin`;
DROP TABLE IF EXISTS `teacher`;
DROP TABLE IF EXISTS `assignment`;
DROP TABLE IF EXISTS `course`;
DROP TABLE IF EXISTS `student`;

DROP TABLE IF EXISTS `department`;

-- Create department table
CREATE TABLE `department` (
    `department_id` BIGINT UNSIGNED NOT NULL PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL
);

-- Create student table
CREATE TABLE `student` (
    `student_id` BIGINT UNSIGNED NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `email` VARCHAR(255) NOT NULL,
    `password` VARCHAR(255) NOT NULL,
    PRIMARY KEY(`student_id`)
);
ALTER TABLE `student` ADD UNIQUE `student_email_unique`(`email`);

-- Create admin table
CREATE TABLE `admin` (
    `admin_id` BIGINT NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `email` VARCHAR(255) NOT NULL,
    `password` VARCHAR(255) NOT NULL,
    PRIMARY KEY(`admin_id`)
);
ALTER TABLE `admin` ADD UNIQUE `admin_email_unique`(`email`);

-- Create course table
CREATE TABLE `course` (
    `course_id` VARCHAR(255) NOT NULL,
    `department_id` BIGINT UNSIGNED NOT NULL,
    `title` VARCHAR(255) NOT NULL,
    `description` TEXT NOT NULL,
    PRIMARY KEY(`course_id`),
    FOREIGN KEY(`department_id`) REFERENCES `department`(`department_id`)
);

-- Create teacher table
CREATE TABLE `teacher` (
    `teacher_id` BIGINT UNSIGNED NOT NULL,
    `department_id` BIGINT UNSIGNED NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `email` VARCHAR(255) NOT NULL,
    `password` VARCHAR(255) NOT NULL,
    PRIMARY KEY(`teacher_id`)
);
ALTER TABLE `teacher` ADD UNIQUE `teacher_email_unique`(`email`);
ALTER TABLE `teacher` ADD CONSTRAINT `teacher_department_id_foreign` FOREIGN KEY(`department_id`) REFERENCES `department`(`department_id`);

-- Create teacher_assignment table
CREATE TABLE `teacher_assignment` (
    `teacher_id` BIGINT UNSIGNED NOT NULL,
    `course_id` VARCHAR(255) NOT NULL,
    PRIMARY KEY(`teacher_id`, `course_id`),
    FOREIGN KEY(`teacher_id`) REFERENCES `teacher`(`teacher_id`)
);

-- Create department_admin table
CREATE TABLE `department_admin` (
    `department_admin_id` BIGINT NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `email` VARCHAR(255) NOT NULL,
    `password` VARCHAR(255) NOT NULL,
    `department_id` BIGINT UNSIGNED NOT NULL,
    PRIMARY KEY(`department_admin_id`),
    FOREIGN KEY(`department_id`) REFERENCES `department`(`department_id`)
);
ALTER TABLE `department_admin` ADD UNIQUE `department_admin_email_unique`(`email`);

-- Create assignment table
CREATE TABLE `assignment` (
    `assignment_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `course_id` VARCHAR(255) NOT NULL,
    `title` VARCHAR(255) NOT NULL,
    `description` TEXT NOT NULL,
    `due_date` DATETIME NOT NULL,
    `max_points` BIGINT NOT NULL,
    FOREIGN KEY(`course_id`) REFERENCES `course`(`course_id`)
);

-- Create submission table
CREATE TABLE `submission` (
    `submission_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `assignment_id` BIGINT UNSIGNED NOT NULL,
    `student_id` BIGINT UNSIGNED NOT NULL,
    `content` TEXT NOT NULL,
    `submitted_at` DATETIME NOT NULL,
    `score` BIGINT NOT NULL,
    FOREIGN KEY(`assignment_id`) REFERENCES `assignment`(`assignment_id`),
    FOREIGN KEY(`student_id`) REFERENCES `student`(`student_id`)
);

-- Create student_enroll table
CREATE TABLE `student_enroll` (
    `student_id` BIGINT UNSIGNED NOT NULL,
    `course_id` VARCHAR(255) NOT NULL,
    PRIMARY KEY(`student_id`, `course_id`),
    FOREIGN KEY(`student_id`) REFERENCES `student`(`student_id`),
    FOREIGN KEY(`course_id`) REFERENCES `course`(`course_id`)
);

-- Create announcement table
CREATE TABLE `announcement` (
    `announcement_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `course_id` VARCHAR(255) NOT NULL,
    `content` TEXT NOT NULL,
    `posted_at` DATETIME NOT NULL,
    FOREIGN KEY(`course_id`) REFERENCES `course`(`course_id`)
);
