create database dbempleados;

use dbempleados;

create table ficha_empleados (
id int auto_increment primary key,
nombre varchar (25),
salario int (5),
fecha_ingreso date,
edad int,
departamento varchar (25),
activo boolean
);

drop table ficha_empleados;

select * from ficha_empleados;

update ficha_empleados
set activo = false
where nombre = 'luis martinez';


alter table ficha_empleados add column muerte date;

insert into ficha_empleados (nombre,salario,fecha_ingreso,edad,departamento,activo) values 
('juan perez',2500,'2020-01-15',30,'ventas',true),
('maria lopez',3000,'2019-01-15',28,'marketing',true),
('pedro garcia',1500,'2020-01-15',35,'ventas',true),
('ana fernandez',1800,'2020-01-15',40,'soporte',false),
('luis martinez',2200,'2020-01-15',25,'it',true),
('carla gomez',3200,'2020-01-15',32,'marketing',true),
('miguel sanchez',2800,'2017-09-15',45,'ventas',false);

insert into ficha_empleados (nombre,salario,fecha_ingreso,edad,departamento,activo) values 
('juan perez morro',200,'2010-01-15',30,'soporte',1);

select * from ficha_empleados where salario > 1400 and salario < 2100;

select sum(salario) from ficha_empleados as salario_total;

select * from ficha_empleados order by salario asc limit 1;

select nombre, count(*) from ficha_empleados as empleados_activos where activo = true;

select avg(salario) as salario_medio from ficha_empleados;


select departamento, count(*) from ficha_empleados as empleados_departamento group by departamento;

select avg(salario) as promedio_marqueting from ficha_empleados where departamento = 'marketing';

select nombre, salario from ficha_empleados order by salario desc limit 1; 

select nombre , edad from ficha_empleados as mayores where edad > 30;

select avg(edad) as media_edad from ficha_empleados where activo = false;