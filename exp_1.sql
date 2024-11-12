-- Create User
CREATE USER 
	'USER1'
IDENTIFIED BY
	'USER1'
;

-- Grant Authority
GRANT
	ALL PRIVILEGES
ON
	*.*
TO
	'USER1'@'%'
;

-- Drop Database
DROP DATABASE `company`;

-- Conditional Removing Database
DROP DATABASE IF EXISTS `company`;

-- Use Database
USE `company`;


-- Create Table
CREATE TABLE `article`(
	`id` int,
	`created_at` datetime,
	`title` varchar(100),
	`contents` text
);

-- Describe Table
DESC `article`;


-- Insert row
INSERT INTO 
	`article`
SET
	title = "Hello1",
	contents = "Hello1"
;


INSERT INTO article
	( title, contents )
VALUES
	( "Hello2", "Hello!")
;


-- Read Row
SELECT 
	*
FROM
	article
;

SELECT
	`id` as "번호",
	`title` as "제목",
	`contents` as "내용"
FROM
	article as A
;
	
-- Update Row
UPDATE
	article
SET
	creatd_at = NOW()
;

UPDATE 
	article
SET
	id = 1
WHERE 
	title = "Hello1"
;

UPDATE 
	article
SET
	id = 2
WHERE 
	title = "Hello2"
;

-- Remove Row
DELETE FROM article; -- danger

DELETE FROM 
	article
WHERE
	id = 4
;

-- Alter Table
ALTER TABLE `article` MODIFY id int NOT NULL; -- append NOT NULL

ALTER TABLE `article` ADD PRIMARY KEY(id); -- append primary key

ALTER TABLE `article` MODFIY COLUMN id NOT NULL AUTO_INCREMENT; -- auto_increment

