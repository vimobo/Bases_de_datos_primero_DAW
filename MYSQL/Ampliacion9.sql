create database cientifico;


use cientifico;

update cien
set nombre = "Maria"
where dni = 1;

create table cien (
	dni int,
    nombre varchar (25),
    apellido varchar(25),
    nacimiento date,
primary key (dni));

select * from cien;

create table proyecto (
codigo char,
nombre varchar(25),
horas int,
primary key (codigo));

create table asignado (
	dni int,
    codigo char,
    primary key (dni, codigo),
    foreign key (codigo) references proyecto(codigo),
    foreign key (dni) references cien(dni)
    ON DELETE CASCADE
    ON UPDATE CASCADE 
);


INSERT INTO cien VALUES
(1, 'María', 'Guzmán', '1974-02-12'),
(2, 'María', 'Jiménez', '1954-02-11'),
(3, 'Rafael', 'Girado', '1964-01-22'),
(4, 'Alonso', 'Gómez', '1990-12-12'),
(5, 'Clara', 'Antúnez', '1973-11-12');

INSERT INTO proyecto VALUES
('A', 'Bioquímica', 410),
('B', 'Electrónica', 1200),
('C', 'Geológica', 300),
('D', 'Tectónica', 500),
('E', 'Histograma', 70);

INSERT INTO asignado VALUES
(1, 'A'),
(1, 'B'),
(1, 'C'),
(2, 'A'),
(3, 'A'),
(3, 'B'),
(3, 'C'),
(4, 'A'),
(4, 'B'),
(4, 'C'),
(4, 'E'),
(4, 'D');

-- 1.- Relación completa de los científicos asignados a cada proyecto. Mostrar DNI, Nombre del
-- , Identificador del proyecto y nombre del proyecto.

select  c.dni, c.nombre, a.codigo, p.nombre
 from cien c
 join asignado a
 on c.dni = a.dni
 join proyecto p
 on a.codigo = p.codigo;		

-- 2.- Obtener el número de proyectos al que está asignado cada científico (mostrar el DNI y el nombre)

select count(a.codigo) as nproyectos,
		c.nombre, c.dni, c.apellido
from cien c
join asignado a
on c.dni = a.dni
group by c.dni;

-- 3.- Obtener el número de científicos asignados a cada proyecto (mostrar el identificador del
-- proyecto y el nombre del proyecto).

select p.nombre, p.codigo, count(a.dni) as ncientificos
from proyecto p
join asignado a
on p.codigo = a.codigo
group by a.codigo;

-- 4.- Obtener el número de dedicación de cada científico.

select c.dni, c.nombre, sum(p.horas) as horastotales
from cien c
join asignado a
on a.dni = c.dni
join proyecto p
on p.codigo = a.codigo
group by c.dni;

-- 5.- Obtener el DNI y el nombre de los científicos que se dedican a más de un proyecto y cuya
-- dedicación media a cada proyecto sea superior a las 80 horas.

select c.dni, c.nombre, count(a.codigo) as nproyecto, avg(p.horas) as mediah
from cien c
join asignado a
on a.dni = c.dni
join proyecto p
on p.codigo = a.codigo
group by c.dni
having nproyecto > 1 and
mediah > 80;


-- 6.- Nombre del científico que trabaja en todos los proyectos.

select c.dni, c.nombre
from cien c
join asignado a
on c.dni = a.dni
group by c.dni
having count(distinct a.codigo) = (select count(*) from proyecto);
 

-- 7.- Nombre del científico que no trabaja en ningún proyecto.

select c.nombre, c.dni
from cien c
left join asignado a
on c.dni = a.dni
group by c.nombre, c.dni
having count(distinct a.codigo) = 0;

-- 8 la media de horas de los proyect oexcluyendo el valor maximo y minimo

select avg(horas) as mediah,
 max(horas) as maxhoras,
 min(horas) as minhoras
from proyecto;
WHERE horas <> (SELECT MAX(horas) FROM proyecto)
  AND horas <> (SELECT MIN(horas) FROM proyecto);

-- 9 
select horas, count(*) as moda
from proyecto
group by horas
order by horas limit 1;

-- 10 obtener los cientificos que trabajan en proyectos con mas de 400h

select c.dni, c.nombre
from cien c
join asignado a
on c.dni = a.dni
join proyecto p
on p.codigo = a.codigo
where p.horas > 400
group by c.dni;


-- 11 mostrar los cientificos que solo trabajan en proyectos de mas de 100 horas

select c.dni, c.nombre
from cien c
join asignado a
on c.dni = a.dni
join proyecto p
on p.codigo = a.codigo
group by c.dni
having min(p.horas) > 100;

-- 12 listar los proyecto esnlos que trabaja al menos un cientifico llamado maria

select p.nombre, c.nombre
from cien c
join asignado a
on c.dni = a.dni
join proyecto p
on p.codigo = a.codigo
where c.nombre = 'Maria';


-- 14 mostrar lso cienticios que trabajan en proyectos cuyo nombre mpieza por b

select c.nombre, p.nombre
from cien c
join asignado a
on c.dni = a.dni
join proyecto p
on p.codigo = a.codigo
having p.nombre like 'B%';

-- 15 obtener el proyecto con mayor numero de cientificosa signados

select p.nombre, count(a.codigo)
from proyecto p
join asignado a
on p.codigo = a.codigo
group by p.nombre
limit 1;

-- 16 mostrar los cienticiso que trabajan mas qeu la media

SELECT c.nombre, c.dni, COUNT(a.codigo) AS total_proyectos
FROM cien c
JOIN asignado a
  ON a.dni = c.dni
GROUP BY c.nombre, c.dni
HAVING COUNT(a.codigo) >
       (
         SELECT AVG(proyectos)
         FROM (
               SELECT COUNT(a2.codigo) AS proyectos
               FROM asignado a2
               GROUP BY a2.dni
              ) t
       );

-- mostrar los cientificos sin proyectos

select c.nombre, c.dni, count(a.codigo) as nproeyctos
from cien c
left join asignado a
on a.dni = c.dni
where a.codigo is null
group by c.dni;
having count(a.codigo)  = 0;


-- 16 mostrar los proyectos sin cientificos

select p.codigo, p.nombre, count(a.dni) as fuu from proyecto p
left join asignado a
on a.codigo = p.codigo
group by p.codigo, p.nombre
having count(a.dni) = 1;

-- 18 listar los cientificos que nacieron antes de 1970 que trabajen en proyectos de mas de 1000 horas

select distinct c.dni, c.nombre, c.nacimiento from cien c
join asignado a on a.dni = c.dni
join proyecto p on p.codigo = a.codigo
where c.nacimiento < '1970-01-01' and p.horas > 1000;
group by c.dni;


-- listar los cientificos que trabajan en mas proyectos que la media 

select c.nombre, c.dni, count(a.codigo) as cuenta, avg(a.codigo)
from cien c
join asignado a on c.dni = a.dni
group by c.nombre, c.dni
having count(a.codigo) > (
    SELECT AVG(cuenta)
    FROM (
        SELECT COUNT(codigo) AS cuenta
        FROM asignado
        GROUP BY dni
    ) tabla
);



select c.dni, c.nombre, c.nacimiento, p.horas
from cien c
join asignado a
on a.dni = c.dni
join proyecto p
on p.codigo = a.codigo
where c.nacimiento > '1970/01/01' and p.horas > 100;

-- 19 obtener le proyecto con menos horas que tenga cientificos asignados

select p.nombre, p.horas, count(a.dni) as empleados  from proyecto p
join asignado a 
on a.codigo = p.codigo
group by p.codigo, p.nombre
order by p.horas, empleados asc
limit 1;

select codigo, nombre
from proyecto
where codigo = 'D' or codigo = 'E';

select p.codigo, p.nombre
from proyecto p
join asignado a
on a.codigo = p.codigo
group by p.codigo
having count(a.codigo) < 2;


select c.dni, c.nombre, p.codigo, p.nombre
from cien c
join asignado a on c.dni = a.dni
join proyecto p on p.codigo = a.codigo;

select c.dni, c.nombre , count(a.codigo)
from cien c
join asignado a
on c.dni = a.dni
group by c.dni;

select p.codigo, p.nombre, count(a.dni) as ncien
from proyecto p
join asignado a on a.codigo = p.codigo
group by p.codigo;

select c.dni, c.nombre, sum(p.horas) as horasa
from cien c
join asignado a on a.dni = c.dni
join proyecto p on p.codigo = a.codigo
group by c.dni;

select c.dni, c.nombre
from cien c
join asignado a on a.dni = c.dni
join proyecto p on p.codigo = a.codigo
where p.horas > 80
group by c.dni
having 1 < count(a.codigo);

select c.nombre, c.dni
from cien c
right join asignado a on c.dni = a.dni
where a.dni is null;

-- 16 alteProyectos


select p.nombre, p.codigo, p.horas
from proyecto p
where p.horas > (select  avg(horas) from proyecto)
group by p.nombre, p.codigo;

-- Proyectos cuyo número de científicos sea mayor que el de cualquier otro proyecto.

select p.nombre, p.codigo, count(a.dni) as ncien
from proyecto p
join asignado a on a.codigo = p.codigo
group by p.codigo, p.nombre
having count(a.dni) = (select max(contador) from 
(select count(a.dni) as contador 
from asignado a
group by a.codigo
) tonto);

(select count(a.dni) as contador
from asignado a
group by a.codigo
);