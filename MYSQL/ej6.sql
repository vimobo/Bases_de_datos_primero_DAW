create database if not exists mascotas;

use mascotas;

create table if not exists mascota(
	nombre varchar(20),
	especie varchar(40),
	sexo char(1),
	fecha_nacimiento date);

alter table mascota add column id int auto_increment;
alter table mascota add constraint primary key(id);
describe mascota;

alter table mascota add constraint check (sexo in ('f', 'm'));
select * from mascota;
insert into mascota (nombre, especie, sexo, fecha_nacimiento, id) values
('tango','perro','f',curdate(),1),
('flufi','gato','m',curdate(),2);
select * from mascota;

create table if not exists cliente(
	id int unsigned auto_increment,
    nombre VARCHAR(20),
    edad int,
    peso int,
    sexo char(1) check (sexo in ('f','m')),
     primary key(id));
     

insert into cliente (nombre, edad, peso, sexo) values
('pepe',45,80,'m'),
('antonia',89,90,'f'),
('ana',20,20,'f');
describe cliente;
select * from cliente;
     
select nombre,edad
from cliente
where sexo ='f' and edad >40;

select * from cliente;
update cliente
set edad=36
where id=2;

describe cliente;
select * from cliente;