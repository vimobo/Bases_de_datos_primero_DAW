create database mydb;
USE mydb;
create table mytable
(
id 			int unsigned not null auto_increment,
username	varchar(100) not null,
email 		varchar(100) not null,
primary key	(id)
);

describe mytable;

insert into mytable(username,email) values ('myuser','myuser@haha.com');
insert into mytable(username,email) values ('myuser2','myuser2@haha.com');

DELETE FROM mytable;



select * from mytable;

drop table mytable2;

CREATE TABLE mytable2 (
	id int unsigned AUTO_INCREMENT,
    name CHAR(100),
    PRIMARY KEY(id)
);

describe mytable2;
insert into mytable2(name) values('ANA');

SELECT FROM mytable2;


create TABLE mytable3(
id int unsigned auto_increment,
name varchar(30),
age tinyint,
wight smallint,
salary decimal(5,2),
primary key(id)
);

insert into mytable3(name,age,wight,salary)
	values('pepe',45,78,456.56);
    
insert into mytable3(name,age,wight,salary)
	values('amto',2,78,456.56);
    
insert into mytable3(name,age,wight,salary)
	values('mitu',69,12,47.56);
    describe mytable3;
    
    select * from mytable3;
    update mytable3 set age=1000 where=
    
    