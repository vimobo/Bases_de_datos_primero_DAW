Create database Facultad;

use Facultad;

create table facultad (
	codigo int primary key,
    nombre varchar(100));

create table investigadores (
	dni varchar(9) primary key,
    nomApels varchar(255),
    facultad int,
    foreign key (facultad) references facultad(codigo)
    on update cascade
    on delete cascade);
    
create table equipos (
	numSerie char(4) primary key,
    nombre varchar(100),
    facultad int,
    foreign key (facultad) references facultad(codigo)
    on update cascade
    on delete cascade);
    
    
create table reserva (
	dni varchar(9),
    numSerie char(4),
    comienzo date,
    fin date,
    primary key(dni,numSerie),
    foreign key (dni) references investigadores(dni)
    on update cascade
    on delete cascade,
    foreign key (numSerie) references equipos(numSerie)
    on update cascade
    on delete cascade);


update facultad set nombre = 'cardiologia' where codigo = 1;


insert into facultad (codigo,nombre) values 
	(1,'ciencias'),
    (2,'politicas'),
    (3,'derecho'),
    (4,'empresariales'),
    (5,'psicologia');
    
INSERT INTO investigadores (dni, nomApels, facultad) VALUES
('656567678', 'Joaquín Martínez', 5),
('646567678', 'Joaquín Revelles', 1),
('656567778', 'Pedro Martínez', 2),
('656567671', 'Marina Martínez', 3),
('6567678',   'Luisa Jiménez', 4);

INSERT INTO equipos (numSerie, nombre, facultad) VALUES
('IBM1', 'Mainframe', 1),
('IBM2', 'Mainframe', 2),
('IBM3', 'Mainframe', 3),
('IBM4', 'Mainframe', 4),
('IBM5', 'Mainframe', 5),
('EPS1', 'Proyector', 1),
('EPS2', 'Proyector', 2),
('EPS3', 'Proyector', 3),
('EPS4', 'Proyector', 4),
('EPS5', 'Proyector', 5);

INSERT INTO reserva (dni, numSerie, comienzo, fin) VALUES
('656567678', 'IBM5',     '2013-02-10', '2013-03-10'),
('656567778', 'EPS2',   '2012-12-12', '2013-03-13'),
('656567778', 'IBM2',     '2012-12-12', '2013-03-13'),
('656567671',  'IBM5',     '2013-01-10', '2013-02-09'),
('6567678',   'IBM4',     '2012-09-15', '2013-08-31');

-- 1.- Obtener el DNI y el nombre de aquellos investigadores que han realizado más de una reserva.
select i.dni, i.nomApels from investigadores i
join reserva r on i.dni = r.dni
group by i.dni, nomApels
having count(r.dni) > 1;
-- 2.- Obtener un listado completo de reservas incluyendo los siguientes datos:
-- - DNI y nombre del investigador, junto con el nombre de la facultad.
-- - Número de serie y nombre del equipo reservado, junto con el nombre de la facultad a la que pertenece.
-- - Fecha de comienzo y fin de la reserva.

drop view v_completa;

select * from v_completa;
create view v_completa as select i.dni, i.nomApels ,f1.nombre as nom, e.numserie, e.nombre,  r.comienzo, r.fin, f2.nombre as nom2
from investigadores i
join reserva r on i.dni = r.dni
join facultad f1 on f1.codigo = i.facultad
join equipos e on e.numSerie = r.numSerie
join facultad f2 on f2.codigo = e.facultad;
-- 3.- Obtener el DNI y el nombre de los investigadores que han reservado equipos que no son de su facultad.

select nomApels from investigadores i
join facultad f on f.codigo = i.facultad
join reserva r on r.dni = i.dni
join equipos e on e.numSerie = r.numserie
where e.facultad != i.facultad;

-- 4.- Obtener los nombres de las facultades en las que ningún investigador ha realizado una reserva.

select nomApels, count(r.dni) from investigadores i
left join facultad f on f.codigo = i.facultad
left join reserva r on r.dni = i.dni
group by i.dni;
having count(r.dni) = 0;



-- 5.- Obtener los nombres de las facultades con investigadores “ociosos”.

select f.nombre from investigadores i
left join facultad f on f.codigo = i.facultad
left join reserva r on r.dni = i.dni
group by i.dni
having i.dni in 
(select i1.dni from investigadores i1
left join reserva r1 on r1.dni = i1.dni
where r1.numSerie is null);


-- 6.- Obtener el número de serie y nombre de los equipos que nunca han sido reservados.

select e.nombre, e.numSerie from equipos e
left join reserva r on r.numSerie = e.numSerie
where r.dni is null;

-- 7.- Obtener el DNI y nombre de los investigadores que han realizado al menos una reserva.

select i.dni, nomApels, count(i.dni) from investigadores i
join reserva r on r.dni = i.dni
group by i.dni
having count(numSerie) >= 1;
-- 8.- Obtener el DNI y nombre de los investigadores que NO han realizado ninguna reserva.

select i1.dni, numSerie from investigadores i1
left join reserva r1 on r1.dni = i1.dni
where r1.numSerie is null;

-- 9.- Obtener el nombre y número de serie de los equipos que han sido reservados más de una vez.

select nombre, count(r.dni) from equipos e
join reserva r on e.numSerie = r.numSerie
group by e.numSerie 
having count(r.dni) > 1;

-- 10.- Obtener el nombre de la facultad y el número total de reservas realizadas por sus investigadores.

-- 11.- Obtener el nombre de la facultad y el número total de reservas de equipos que pertenecen a dicha facultad.

-- 12.- Obtener el DNI y nombre de los investigadores que han reservado TODOS los equipos de su facultad.

-- 13.- Obtener el nombre de las facultades que tienen al menos un equipo que nunca ha sido reservado.

-- 14.- Obtener el número de serie y nombre del equipo más reservado.

-- 15.- Obtener el DNI y nombre del investigador que más reservas ha realizado 

select i.nomApels, i.dni from investigadores i
join reserva r on r.dni = i.dni
group by i.dni
order by count(r.numSerie) desc limit 1;

-- 16.- Obtener el número total de reservas realizadas en cada año.

select year(comienzo) as año, count(*) as total_reservas
from reserva
group by year(comienzo);

-- 17.- Obtener el nombre de las facultades cuyos investigadores solo han reservado equipos de su propia facultad.
select f.nombre from facultad f
join investigadores i on i.facultad = f.codigo
join reserva r on r.dni = i.dni
join equipos e on e.numSerie = r.numSerie
where ;

select f.nombre from investigadores i 
join reserva r on r.dni = i.dni
join equipos e on e.numSerie = r.numSerie
join facultad f on f.codigo = i.facultad
where i.facultad = e.facultad
group by i.dni
having count(r.dni) = 1;
-- 18.- Obtener el nombre de los equipos que han sido reservados por investigadores de distintas facultades.

-- 19.- Obtener el DNI y nombre de los investigadores que han realizado reservas en fechas solapadas.

-- 20.- Obtener las facultades que tienen investigadores pero no tienen equipos.
