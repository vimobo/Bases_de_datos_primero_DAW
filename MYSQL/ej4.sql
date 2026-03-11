create database if not exists ej4;

use ej4;

create table if not exists usuarios(
	nombre varchar(30),
    clave varchar(10),
    id int unsigned auto_increment(20),
    primary key(id),
)

insert into usuarios(nombre,clave) 
	values('vicen',20);
insert into usuarios(nombre,clave) values('spao',10);


