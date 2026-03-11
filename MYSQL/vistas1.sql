create database vistas1;

use vistas1;

drop table if exists inscritos;
drop table if exists socios;
drop table if exists profesores;
drop table if exists cursos;
create table socios(
documento char(8) not null,
nombre varchar(40),
domicilio varchar(30),
primary key (documento)
);
create table profesores(
documento char(8) not null,
nombre varchar(40),
domicilio varchar(30),
primary key (documento)
);
create table cursos(
numero integer auto_increment,
deporte varchar(20),
dia varchar(15),
documentoprofesor char(8),
primary key (numero)
);
create table inscritos(
documentosocio char(8) not null,
numero integer not null,
matricula char(1),
primary key (documentosocio,numero)
);

alter table inscritos add foreign key(documentosocio) references socios(documento);
alter table inscritos add foreign key(numero) references cursos(numero);
alter table cursos add foreign key(documentoprofesor) references profesores(documento);

insert into socios values('30000000','Fabian Fuentes','Caseros 987');
insert into socios values('31111111','Gaston Garcia','Guemes 65');
insert into socios values('32222222','Hector Huerta','Sucre 534');
insert into socios values('33333333','Ines Irala','Bulnes 345');
insert into profesores values('22222222','Ana Acosta','Avellaneda 231');
insert into profesores values('23333333','Carlos Caseres','Colon 245');
insert into profesores values('24444444','Daniel Duarte','Sarmiento 987');
insert into profesores values('25555555','Esteban Lopez','Sucre 1204');
insert into cursos(deporte,dia,documentoprofesor)
values('tenis','lunes','22222222');
insert into cursos(deporte,dia,documentoprofesor)
values('tenis','martes','22222222');
insert into cursos(deporte,dia,documentoprofesor)
values('natacion','miercoles','22222222');
insert into cursos(deporte,dia,documentoprofesor)
values('natacion','jueves','23333333');
insert into cursos(deporte,dia,documentoprofesor)
values('natacion','viernes','23333333');
insert into cursos(deporte,dia,documentoprofesor)
values('futbol','sabado','24444444');
insert into cursos(deporte,dia,documentoprofesor)
values('futbol','lunes','24444444');
insert into cursos(deporte,dia,documentoprofesor)
values('basquet','martes','24444444');
insert into inscritos values('30000000',1,'s');
insert into inscritos values('30000000',3,'n');
insert into inscritos values('30000000',6,null);
insert into inscritos values('31111111',1,'s');
insert into inscritos values('31111111',4,'s');
insert into inscritos values('32222222',8,'s');

-- 3- Eliminar la vista "vista_club" si existe

-- 4- Crear una vista en la que aparezca el nombre y documento del socio,
--    el deporte, el día y el nombre del profesor
--    (no mostrar datos de los socios que no están inscritos en deportes)

-- drop view v_socios_deportes;

create view v_socios_deportes as select s.nombre as n_socio, s.documento, p.nombre as n_profe, c.dia, c.deporte
from inscritos i
join socios s
on i.documentosocio = s.documento
join cursos c
on c.numero = i.numero
join profesores p
on c.documentoprofesor = p.documento
group by s.documento, p.nombre, c.dia, c.deporte;


-- 5- Mostrar la información contenida en la vista

select * from v_socios_deportes;

-- 6- Realizar una consulta a la vista donde se muestre la cantidad de socios
--    inscritos en cada deporte, ordenados por cantidad

select count(documento) as cuneta, deporte
from v_socios_deportes
group by deporte;

select count(documento) as n_inscrito, deporte from v_socios_deportes group by deporte;

select * from v_socios_deportes;

-- 7- Mostrar (consultando la vista) el nombre y documento de los socios
--    que deben matrículas

select distinct n_socio, documento, matricula, deporte
from v_socios_deportes 
join inscritos i on i.documentosocio = documento
where matricula = 'n';

-- 8- Consultar la vista y mostrar los nombres de los profesores
--    y los días en que asisten al club para dictar sus clases

select distinct dia, n_profe, deporte from v_socios_deportes;

-- 9- Mostrar todos los socios que son compañeros en tenis los lunes

select n_socio, deporte, dia from v_socios_deportes where deporte = 'Tenis' and dia = 'Lunes';

-- 10- Crear una nueva vista llamada 'vista_inscritos' que muestre la cantidad
--     de inscritos por curso, incluyendo el nombre del deporte y el día
--     (eliminar la vista previamente si ya existe)

create view v_inscritos as select count(i.documentosocio) as num_socios, c.dia, c.deporte
from socios s
join inscritos i
on s.documento = i.documentosocio
join cursos c
on  c.numero = i.numero
group by c.deporte,c.dia;

-- 11- Consultar la vista 'vista_inscritos'

select * from v_inscritos;

