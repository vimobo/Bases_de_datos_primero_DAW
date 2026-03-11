create database pets;

create table pet(
nombre varchar(20),
propietario varchar(20),
especie varchar(20),
sexo char(1),
nacimiento date,
fallecimiento date);

select * from pet;
insert into pet (nombre,propietario,especie,sexo,nacimiento,fallecimiento) values
('flufy','arnaldo','gato','f','1990-02-04','2000-10-10'),
('mau','juan','gato','m','1998-03-17',null),
('buffy','arnaldo','gato','f','1999-05-13',null),
('fanfan','benito','perro','m','2000-08-27',null),
('kaiser','diana','perro','m','1998-08-31','2000-07-29'),
('chispa','omar','ave','f','1998-09-11',null),
('wicho','tomas','ave',null,'2000-02-09',null),
('skim','benito','serpiente','m','2001-04-29',null);

select * from pet;
update pet set nacimiento = '1999-02-04' where nombre='flufy';

select * from pet;
update pet set especie = 'perro' where nombre='buffy';

select nombre from pet
order by nombre desc;

select nombre,propietario from pet
where sexo='f' and especie='perro';

select nombre, nacimiento, especie from pet
where especie =('gato' or especie='perro') and sexo = 'f';

select nombre, nacimiento from pet
order by nacimiento desc;

select nombre, nacimiento from pet
where nacimiento > 

select nombre from pet
where nombre like '%b';

use pets;

select count(*) as mascotasvivas
from pet
where fallecimiento is null;

select propietario, count(*) from pet
group by propietario;

select especie, count(*) as numeroporespecie
from pet
group by especie;

select especie,count(*) as cantidadporgenero
from pet
group by sexo;
 
 select especie,sexo, count(*) as sexoespecie
 from pet
 group by especie,sexo;
 