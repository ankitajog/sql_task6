create database std_db;
use std_db;
create table std_tbl(id int primary key, name varchar(20),class varchar(5));
desc std_tbl;
insert into std_tbl values(1,'Alice','fycs'),(2,'Bob','sycs'),(3,'Smith','tycs');
select * from std_tbl;
create table game_tbl(roll_no int  , game varchar(20),foreign key(roll_no) references std_tbl(id)) ;
desc game_tbl;
insert into game_tbl(roll_no,game) values(1,'Cricket'),(1,'KhoKho'),(2,'Cricket'),(3,'khokho');
select * from game_tbl;

select name , (select count(id) from std_tbl) from std_tbl ; -- scalar same table comparision of each row with same table
select name , (select count(roll_no) from game_tbl) from std_tbl ; -- scalar same table comparision of each row with game table

select name,class from std_tbl s1 where id > (select count(id) from std_tbl where id = s1.id) ; -- correlated assums WHERE id > 1 in same table .

select name,class from std_tbl where id in (select roll_no from game_tbl where game='Cricket'); -- prints only col of 1st table based on condition for 2nd table
select class from std_tbl where id =(select game from game_tbl where roll_no = 2) ; -- no output.
select * from std_tbl where exists (select * from game_tbl where game_tbl.roll_no = std_tbl.id) ; -- checks inner query col rollno with id matches or not for each row instance
select * from game_tbl where exists (select * from std_tbl where game_tbl.roll_no = std_tbl.id) ; -- returns gametable
SELECT name FROM std_tbl  WHERE NOT EXISTS (SELECT roll_no FROM game_tbl  WHERE game_tbl.roll_no = std_tbl.id); -- returns true hence no output
