drop database SocialMedia;
-- create database for social_media
CREATE DATABASE SocialMedia;
USE SocialMedia;
 
-- Table 1
 
-- create Platform table
CREATE TABLE platforms(
    platform_id INT PRIMARY KEY,
    platform_name VARCHAR(100)
);
 
INSERT INTO platforms(platform_id,platform_name) VALUES
(1,'YouTube'),
(2,'Instagram'),
(3,'Facebook'),
(4,'Twitter'),
(5,'LinkedIn');
 
-- Table 2
 
-- create Account table
CREATE TABLE accounts(
    account_id INT PRIMARY KEY,
    account_name VARCHAR(100),
    platform_id INT,
    followers_count INT,
    created_date DATE,
    FOREIGN KEY(platform_id)
    REFERENCES platforms(platform_id)
);
 
 
INSERT INTO accounts(account_id,account_name,platform_id,followers_count,created_date) VALUES
(101,'TechWorld',1,50000,'2024-01-15'),
(102,'FoodLovers',2,25000,'2023-05-20'),
(103,'TravelGuide',3,40000,'2022-08-12'),
(104,'MusicZone',4,35000,'2021-09-25'),
(105,'StudyHub',5,15000,'2024-02-10');
 
-- Table 3
 
-- create Posts table
CREATE TABLE posts(
    post_id INT PRIMARY KEY,
    account_id INT,
    post_content VARCHAR(200),
    likes_count INT,
    post_date DATE,
    FOREIGN KEY(account_id)
    REFERENCES accounts(account_id)
);
 
INSERT INTO posts(post_id,account_id,post_content,likes_count,post_date) VALUES
(1,101,'AI Technology Update',1500,'2025-01-10'),
(2,102,'Best Pizza Recipe',2000,'2025-02-15'),
(3,103,'Travel Tips for Goa',1700,'2025-03-20'),
(4,104,'New Music Release',3000,'2025-04-01'),
(5,105,'SQL Tutorial',2500,'2025-04-12');
 
-- Table 4
 
-- create Comments table
CREATE TABLE comments(
    comment_id INT PRIMARY KEY,
    post_id INT,
    comment_text VARCHAR(200),
    FOREIGN KEY(post_id)
    REFERENCES posts(post_id)
);
 
 
INSERT INTO comments(comment_id,post_id,comment_text)
VALUES
(1,1,'Very informative'),
(2,2,'Nice recipe'),
(3,3,'Helpful travel tips'),
(4,4,'Amazing song'),
(5,5,'Good explanation');
 
-- Table 5
 
-- create Likes table
CREATE TABLE likes(
    like_id INT PRIMARY KEY,
    post_id INT,
    user_name VARCHAR(100),
    FOREIGN KEY(post_id)
    REFERENCES posts(post_id)
);
 
 
INSERT INTO likes(like_id,post_id,user_name) VALUES
(1,1,'Priya'),
(2,2,'Anitha'),
(3,3,'Divya'),
(4,4,'Keerthana'),
(5,5,'Meena');
 
 
 
--  DQL (To view the table)
 
select * from accounts;
select * from likes;
select * from comments;
select * from platforms;
select * from posts;
 
 
-- basic queries
 
-- To view account name and id
  
select account_name,account_id
from accounts;
 
-- Display comment text only
 
SELECT comment_text
FROM comments;
 
-- Display comments for a specific post
 
SELECT *
FROM comments
WHERE post_id = 1;
 
-- Sort comments by comment_id ascending
 
SELECT *
FROM comments
ORDER BY comment_id ASC;
 
-- Sort comments by comment_id descending
 
SELECT *
FROM comments
ORDER BY comment_id DESC;
 
-- Update a comment
 
UPDATE comments
SET comment_text = 'Excellent information'
WHERE comment_id = 1;
 
-- execute query
 
select * from comments;
 
-- Delete a comment
 
DELETE FROM comments
WHERE comment_id = 5;
 
 
-- create aggregate function
  
-- count function (Finding the Total count)
 
select count(*)as total_accounts
from accounts;
 
-- To find average followers_count
 
select avg(followers_count)as average_followers_count
from accounts;
 
-- create max followers_count
 
select max(followers_count)as maximum_followers_count
from accounts;
 
-- create min followers_count
 
select min(followers_count)as minimum_followers_count
from accounts;
 
-- create sum total followers_count
 
select sum(followers_count)as total_followers_count
from accounts;
 
 
-- Group by,having function
   
-- create group by function
 
-- count platform_id total
 
SELECT platform_id,
       COUNT(*) AS total_count
FROM accounts
GROUP BY platform_id;
   
-- group by,having function
 
SELECT followers_count, COUNT(*) AS total_count
FROM accounts
GROUP BY followers_count
HAVING followers_count > 35000;
 
 
-- joins functions
 
-- INNER JOIN (Total account_name,platform_name)
 
SELECT p.platform_name, a.account_name
FROM platforms p
INNER JOIN accounts a
ON p.platform_id = a.platform_id;
 
 -- LEFT JOIN
 
SELECT p.platform_name, a.account_name
FROM platforms p
LEFT JOIN accounts a
ON p.platform_id = a.platform_id;
 
 -- RIGHT JOIN
 
SELECT p.platform_name, a.account_name
FROM platforms p
RIGHT JOIN accounts a
ON p.platform_id = a.platform_id;
 
 -- self join (current tables, a SELF JOIN does not naturally apply because accounts has no column that references another account).
 
-- alter table accounts to mentor ID
 
alter table accounts
add mentor_id int;
 
-- update accounts to mentor
 
update accounts
set mentor_id =101
where account_id in (102,103);
update accounts
set mentor_id=102
where account_id in (104);
 
-- self join 
 
SELECT a1.account_name AS accounts,
       a2.account_name AS mentor
FROM accounts a1
LEFT JOIN accounts a2
ON a1.mentor_id = a2.account_id;
 
 -- CROSS JOIN
 
SELECT p.platform_name,
       a.account_name
FROM platforms p
CROSS JOIN accounts a;
 
 
-- SET OPERATORS
 
-- UNION (HERE NO DUPLICATES RECORDS FOUND)
 
SELECT p.platform_name, a.account_name
FROM platforms p
LEFT JOIN accounts a
ON p.platform_id = a.platform_id
 
UNION
 
SELECT p.platform_name, a.account_name
FROM platforms p
RIGHT JOIN accounts a
ON p.platform_id = a.platform_id;
 
 
-- UNION ALL (HERE DUPLICATES RECORDS FOUND )
 
SELECT p.platform_name, a.account_name
FROM platforms p
LEFT JOIN accounts a
ON p.platform_id = a.platform_id
 
UNION ALL
 
SELECT p.platform_name, a.account_name
FROM platforms p
RIGHT JOIN accounts a
ON p.platform_id = a.platform_id;
 
 
-- INTERSECT
 
SELECT p.platform_name, a.account_name
FROM platforms p
LEFT JOIN accounts a
ON p.platform_id = a.platform_id
 
inner join
 
(SELECT p.platform_name, a.account_name
FROM platforms p
RIGHT JOIN accounts a
ON p.platform_id = a.platform_id)t;
 
 
-- SUBQUERIES
 
-- single row subquery (account_name,followers_count)
 
SELECT account_name, followers_count
FROM accounts
WHERE followers_count >
(
    SELECT AVG(followers_count)
    FROM accounts
);
 
-- multi row subquery
 
SELECT post_content
FROM posts
WHERE account_id IN
(
    SELECT account_id
    FROM accounts
    WHERE followers_count > 30000
);
 
-- Nested subquery
 
select comment_text
from comments
where post_id in
(
select post_id
from posts
where account_id in
(select account_id
from accounts
where platform_id in
(select platform_id
from platforms 
where platform_name='youtube'
)
)
);
 
-- Subquery with exists
 
SELECT account_name
FROM accounts a
WHERE EXISTS
(
    SELECT *
    FROM posts p
    WHERE p.account_id=a.account_id
);
 
 
-- Views
 
-- Create view
 
CREATE VIEW popular_accounts AS
SELECT account_id,
       account_name,
       followers_count
FROM accounts
WHERE followers_count > 30000;
 
-- execute views
 
SELECT * 
FROM popular_accounts;
 
-- Update views
 
CREATE OR REPLACE VIEW popular_accounts AS
SELECT account_name,
       followers_count
FROM accounts
WHERE followers_count > 40000;
 
-- execute views
 
SELECT * 
FROM popular_accounts;
 
-- drop a view
 
DROP VIEW popular_accounts;
 
 
-- INDEX (two or more column to create index)
 
-- create index (allows duplicate values)
 
create index idx_account_name
on accounts(account_name);
 
-- use
 
SELECT * FROM accounts
WHERE account_name='TechWorld';
 
-- SHOW INDEX FROM accounts
 
show index 
from accounts;
 
-- unique index
 
-- Unique index (not allows duplicate values)
 
CREATE UNIQUE INDEX idx_unique_name
ON accounts(account_name);
 
-- Insert values
 
INSERT INTO accounts
(account_id,account_name,platform_id,followers_count,created_date)
VALUES
(106,'MovieHub',1,30000,'2025-06-30');
 
-- Try duplicate account_name for UNIQUE INDEX testing
 
INSERT INTO accounts
(account_id,account_name,platform_id,followers_count,created_date)
VALUES
(107,'MovieHub',2,45000,'2025-07-01');
 
-- drop index
 
drop index idx_account_name
on accounts;
 
-- Stored objects
 
-- Functions
 
DELIMITER $$
 
CREATE FUNCTION get_followers(acc_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
   DECLARE total INT;
 
   SELECT followers_count
   INTO total
   FROM accounts
   WHERE account_id = acc_id;
 
   RETURN total;
END $$
 
DELIMITER ;
 
-- call function
 
select get_followers(101);
 
-- stored procedure
 
DELIMITER $$
create procedure showaccounts()
BEGIN
select * from accounts;
END$$
DELIMITER ;
 
-- EXECUTE
 
CALL ShowAccounts();
 
 
 
-- Triggers
 
-- check audit table
 
-- created table triggers
 
-- Create audit table
 
CREATE table accounts_audit(
    account_id INT,
    action_performed VARCHAR(100)
);
 
-- Insert records into audit table
 
INSERT INTO accounts_audit(account_id, action_performed)
VALUES
(101,'New account inserted'),
(102,'Account updated'),
(103,'Account deleted');
 
DELIMITER $$
 
CREATE TRIGGER trg_after_insert
AFTER INSERT
ON accounts
FOR EACH ROW
BEGIN
    INSERT INTO accounts_audit(account_id, action_performed)
    VALUES(
        NEW.account_id,
        'New account inserted'
    );
END$$
 
DELIMITER ;
 
-- View audit records
 
SELECT *
FROM accounts_audit;
 
 
-- CTE (COMMON TABLE EXPRESSION)
 
WITH high_followers AS
(
    SELECT account_name,
           followers_count
    FROM accounts
    WHERE followers_count > 30000
)


-- Window functions
 
-- Row number
 
select account_name,
followers_count,
row_number() over
(order by followers_count DESC) as row_num
from accounts;
 
-- rank
 
select account_name,
followers_count,
rank() over
(order by followers_count DESC) as rank_num
from accounts;
 
-- Dense rank
 
select account_name,
followers_count,
dense_rank() over
(order by followers_count DESC) as dense_rank_num
from accounts;
 
-- lag
 
SELECT account_name,
       followers_count,
       LAG(followers_count)
       OVER(ORDER BY followers_count) AS previous_followers
FROM accounts;
 
-- lead
 
SELECT account_name,
       followers_count,
       LEAD(followers_count)
       OVER(ORDER BY followers_count) AS next_followers
FROM accounts;
 
-- sum,over
 
SELECT account_name,
       followers_count,
       SUM(followers_count)
       OVER() AS total_followers
FROM accounts;
 
-- avg , over
 
SELECT account_name,
       followers_count,
       AVG(followers_count)
       OVER() AS average_followers
FROM accounts;
 
-- window account name and followers count function
 
SELECT account_name,
       followers_count,
       ROW_NUMBER() OVER(
           ORDER BY followers_count DESC
       ) AS row_num
FROM accounts;
 
-- Truncate 
 
truncate table comments;
 
-- execute query
 
select * from comments;
 
 
-- DCL (data control language)

 CREATE USER 'Process'@'localhost'IDENTIFIED BY 'root';

-- to change password

alter user 'project'@'localhost'
identified by 'Pooja@08';

-- to change user name

update user set user='new_username' where user ='old username';

-- to check user

select user,Host from mysql.user;

-- grants (show grants for currently login host)

show grants;
 
-- show grants
 
SHOW GRANTS FOR 'Process'@'localhost';
 
 GRANT SELECT, INSERT
ON SocialMedia.accounts
TO 'Process'@'localhost';

REVOKE SELECT, INSERT
ON SocialMedia.accounts
FROM 'Process'@'localhost';

 
-- sql function
 
-- upper
 
SELECT UPPER(account_name)
FROM accounts;
 
-- lower
 
SELECT LOWER(account_name)
FROM accounts;
 
-- length
 
SELECT account_name,
       LENGTH(account_name) AS total_characters
FROM accounts;
 
-- round
 
SELECT ROUND(123.4567,2);
 
-- now
 
SELECT NOW();
 
 

--  TCL (TRANSACTION CONTROL LANGUAGE)
 
SET autocommit = 0;
 
-- Start a transaction
 
START TRANSACTION;
 
-- Insert a new account inside the transaction
 
INSERT INTO accounts
(account_id, account_name, platform_id, followers_count, created_date)
VALUES
(108, 'GamerZone', 4, 22000, '2025-07-01');
 
-- Create a savepoint after this insert
 
SAVEPOINT sp_after_gamerzone;
 
-- Update followers_count for an existing account
 
UPDATE accounts
SET followers_count = followers_count + 5000
WHERE account_id = 108;
 
ROLLBACK TO sp_after_gamerzone;
 
SELECT * FROM accounts WHERE account_id = 108;
 
COMMIT;
 
START TRANSACTION;
 
DELETE FROM accounts
WHERE account_id = 108;
 
ROLLBACK;
 
SELECT * FROM accounts WHERE account_id = 108;
 
START TRANSACTION;
 
SELECT * FROM accounts;
 
COMMIT;
 
-- Turn autocommit back on
 
SET autocommit = 1;

