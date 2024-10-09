CREATE TABLE `assignment` (
    `assignment_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `course_id` VARCHAR(255) NOT NULL,
    `title` VARCHAR(255) NOT NULL,
    `description` TEXT NOT NULL,
    `due_date` DATETIME NOT NULL,
    `max_points` BIGINT NOT NULL
);

CREATE TABLE `student` (
    `student_id` BIGINT UNSIGNED NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `email` VARCHAR(255) NOT NULL,
    `password` VARCHAR(255) NOT NULL,
    PRIMARY KEY(`student_id`)
);

ALTER TABLE
    `student` ADD UNIQUE `student_email_unique`(`email`);

CREATE TABLE `course` (
    `course_id` VARCHAR(255) NOT NULL,
    `title` VARCHAR(255) NOT NULL,
    `description` TEXT NOT NULL,
    PRIMARY KEY(`course_id`)
);

CREATE TABLE `teacher` (
    `teacher_id` BIGINT UNSIGNED NOT NULL,
    `department_id` BIGINT UNSIGNED NOT NULL, -- Changed to UNSIGNED
    `name` VARCHAR(255) NOT NULL,
    `email` VARCHAR(255) NOT NULL,
    `password` VARCHAR(255) NOT NULL,
    PRIMARY KEY(`teacher_id`)
);

ALTER TABLE
    `teacher` ADD UNIQUE `teacher_email_unique`(`email`);

CREATE TABLE `department` (
    `department_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL
);

CREATE TABLE `teacher_assignment` (
    `teacher_id` BIGINT UNSIGNED NOT NULL,
    `course_id` VARCHAR(255) NOT NULL,
    PRIMARY KEY(`teacher_id`, `course_id`)
);

CREATE TABLE `submission` (
    `submission_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `assignment_id` BIGINT UNSIGNED NOT NULL, -- Changed to UNSIGNED
    `student_id` BIGINT UNSIGNED NOT NULL,
    `content` TEXT NOT NULL,
    `submitted_at` DATETIME NOT NULL,
    `score` BIGINT NOT NULL
);

CREATE TABLE `student_enroll` (
    `student_id` BIGINT UNSIGNED NOT NULL,
    `course_id` VARCHAR(255) NOT NULL,
    PRIMARY KEY(`student_id`, `course_id`)
);

CREATE TABLE `announcement` (
    `announcement_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `course_id` VARCHAR(255) NOT NULL,
    `content` TEXT NOT NULL,
    `posted_at` DATETIME NOT NULL
);

-- Adding Foreign Key Constraints
ALTER TABLE
    `teacher_assignment` ADD CONSTRAINT `teacher_assignment_teacher_id_foreign` FOREIGN KEY(`teacher_id`) REFERENCES `teacher`(`teacher_id`);

ALTER TABLE
    `teacher` ADD CONSTRAINT `teacher_department_id_foreign` FOREIGN KEY(`department_id`) REFERENCES `department`(`department_id`);

ALTER TABLE
    `student_enroll` ADD CONSTRAINT `student_enroll_student_id_foreign` FOREIGN KEY(`student_id`) REFERENCES `student`(`student_id`);

ALTER TABLE
    `assignment` ADD CONSTRAINT `assignment_course_id_foreign` FOREIGN KEY(`course_id`) REFERENCES `course`(`course_id`);

ALTER TABLE
    `announcement` ADD CONSTRAINT `announcement_course_id_foreign` FOREIGN KEY(`course_id`) REFERENCES `course`(`course_id`);

ALTER TABLE
    `submission` ADD CONSTRAINT `submission_assignment_id_foreign` FOREIGN KEY(`assignment_id`) REFERENCES `assignment`(`assignment_id`);

ALTER TABLE
    `submission` ADD CONSTRAINT `submission_student_id_foreign` FOREIGN KEY(`student_id`) REFERENCES `student`(`student_id`);
