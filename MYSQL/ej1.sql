create database if not exists ej1;
use ej1;

drop table if exists agenda;

create table agenda(
id int unsigned auto_increment,
nombre varchar(20),
domicilio varchar(30),
ytelefono varchar(11),
primary key (id)
);

select * from agenda;
show tables;
describe agenda;

