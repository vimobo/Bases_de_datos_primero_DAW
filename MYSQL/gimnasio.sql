create database gimnasio;



use gimnasio;

create table Monitor (
dni int primary key,
nombre varchar(25),
telefono int(9),
titulacion varchar(10));


create table Socio (
dni int primary key,
nombre varchar(25),
direccion varchar(25),
telefono int);

create table Aparatos (
codigo int auto_increment primary key,
descripcion varchar(25),
estado varchar(15));

create table Salas (
numero int auto_increment primary key,
superficie int,
ubicacion varchar (10),
tipo varchar(15)
);

create table Se_Imparten (
numero int,
codigo int,
primary key(numero,codigo));

create table Son_Impartidas (
codigo int,
dni int,
primary key (dni, codigo));

create table Tienen (
numero int,
codigo int,
primary key (numero,codigo));

create table Clases (
codigo int primary key,
descripcion varchar(15),
dia_hora time);

create table Asisten (dni int, codigo int, primary key(dni,codigo));


insert into Monitor values(11,'Jose García','953333333','INEF');
insert into Monitor values(22,'Ana Gil','963333334','INEF');
insert into Monitor values(33,'Ana Martín','953333335','F.P.');
insert into Monitor values(44,'Pepe Pérez','953333336','INEF');



insert into Socio values(1,'Manolo Arcos','Libertad','95311111');
insert into Socio values(2,'Jose Rodríguez','Trinidad','95322222');
insert into Socio values(3,'Patricia Jiménez','Ancha','95322222');
insert into Socio values(4,'Soledad Martínez','Rastro','95322222');
insert into Socio values(5,'Inmaculada Pérez','Cava','95322222');
insert into Socio values(6,'Nicolás Ortega','Nueva','95322222');
insert into Socio values(7,'Federico Noriega','Trinidad','95322222');
insert into Socio values(8,'Rodríguez','Cava','95322222');

select * from Socio;

insert into Aparatos values(1,'Banco','Bueno');
insert into Aparatos values(2,'Pesa','Malo');
insert into Aparatos values(3,'Colchón','Nuevo');
insert into Aparatos values(4,'Barra','Bueno');
insert into Aparatos values(5,'Banco','Nuevo');
insert into Aparatos values(6,'Pesa','Nuevo');


insert into Salas values(1,10,'Planta 1','Cardio');
insert into Salas values(2,20,'Planta 1','Aerobic');
insert into Salas values(3,25,'Planta 1','Aerobic');
insert into Salas values(4,10,'Planta 2','Sauna');
insert into Salas values(5,10,'Planta 2','Masaje');
insert into Salas values(6,15,'Planta 2','Cardio');


insert into Clases values(1,'Aerobic','9:00:00');
insert into Clases values(2,'Aerobic','10:00:00');
insert into Clases values(5,'Aerobic','14:00:00');
insert into Clases values(3,'Step','20:00:00');
insert into Clases values(4,'Spining','21:00:00');


insert into Tienen values(4,4);
insert into Tienen values(5,5);
insert into Tienen values(2,1);
insert into Tienen values(3,2);
insert into Tienen values(3,3);
insert into Tienen values(6,6);


insert into Se_Imparten values(2,1);
insert into Se_Imparten values(2,2);
insert into Se_Imparten values(3,3);
insert into Se_Imparten values(3,4);
insert into Se_Imparten values(3,5);


insert into Son_Impartidas values(1,11);
insert into Son_Impartidas values(2,22);
insert into Son_Impartidas values(3,33);
insert into Son_Impartidas values(4,22);
insert into Son_Impartidas values(5,33);


insert into Asisten values(1,1);
insert into Asisten values(1,5);
insert into Asisten values(2,2);
insert into Asisten values(3,4);
insert into Asisten values(3,5);
insert into Asisten values(4,3);
insert into Asisten values(5,3);
insert into Asisten values(6,3);
insert into Asisten values(7,1);
insert into Asisten values(7,5);
insert into Asisten values(7,2);
insert into Asisten values(8,4);
insert into Asisten values(8,5);


-- 1. Nombre y teléfono de los socios del gimnasio que viven en Trinidad.

select nombre, telefono, direccion
from Socio
where direccion = 'Trinidad';

-- 2. Nombre y teléfono del socio que vive en Cava.

select nombre, telefono, direccion
from Socio
where direccion = 'Cava';

-- 3. Nombre y dirección de los socios que asisten a aeróbic.

select distinct s.nombre, s.direccion, c.descripcion
from Socio s
join Asisten a
on a.dni = s.dni
join Clases c
on a.codigo = c.codigo
where c.descripcion = 'aerobic';
;

-- 4. Nombre y dirección de los socios que asisten a sep

select distinct s.nombre, s.direccion, c.descripcion
from Socio s
join Asisten a
on a.dni = s.dni
join Clases c
on a.codigo = c.codigo
where c.descripcion = 'step';
;

-- 5. Nombre de los socios que asisten a las clases de Ana Gil.

select s.nombre, m.nombre
from Monitor m
join Son_Impartidas si
on si.dni = m.dni
join Asisten a
on a.Codigo = si.codigo
join Socio s on s.dni = a.dni
where m.nombre = 'Ana Gil';


-- 6. Nombre de los monitores que tiene titulación de la INEF.

select nombre, titulacion from Monitor where titulacion = 'INEF';

-- 7. Descripción de los aparatos nuevos.

select descripcion from Aparatos where estado = 'nuevo';

-- 8. Nombre y dirección de los socios que asisten a clase antes de las 16:00 horas.

select s.direccion, s.nombre, c.dia_hora
from Socio s
join Asisten a
on s.dni = a.dni
join Clases c
on c.codigo = a.codigo
where dia_hora < '16:00:00';

-- 9. Número y tipo de las salas que tienen más de 12 metros cuadrados.

select superficie, tipo from Salas
having superficie > 12;

-- 10. Nombre de los alumnos de Pepe.

select distinct s.nombre, s.direccion, m.nombre
from Socio s
join Asisten a on s.dni = a.dni
join Son_Impartidas si on si.codigo = a.codigo 
join Monitor m on m.dni = si.dni
where m.nombre = 'Pepe Pérez';

-- 11. Nombre de los socios que asisten a clase en la primera planta.

select distinct s.nombre, s.direccion, sa.ubicacion
from Socio s
join Asisten a on s.dni = a.dni
join Se_Imparten si on a.codigo = si.codigo
join Salas sa on sa.numero = si.numero
where sa.ubicacion = 'Planta 1';

-- 12. Aparatos que j situados en la 1º planta.

select a.descripcion, s.ubicacion
from Aparatos a
join Tienen t on a.codigo = t.codigo
join Salas s on t.numero = s.numero
where s.ubicacion = 'Planta 1';

-- 13. Todas las clases y todos los alumnos que asisten a esas clases.

select  c.descripcion, s.nombre, c.dia_hora
from Clases c
join Asisten a on a.codigo = c.codigo
join Socio s on a.dni = a.dni
group by c.descripcion, s.nombre, c.dia_hora
order by c.descripcion asc;

-- 14. Monitores y las clases que dan y a qué hora la dan.

select m.nombre, c.descripcion, dia_hora
from Monitor m 
join Son_Impartidas si on m.dni = si.dni
join Clases c on c.codigo = si.codigo
group by m.nombre, c.descripcion, dia_hora;

-- 15. Clases que se dan en salas de más de 22 metros cuadrados.

select c.descripcion, s.superficie
from Salas s
join Se_Imparten si
on s.numero = si.numero
join Clases c
on c.codigo = si.codigo
having s.superficie > 21;

18 Calcular la superficie total del gimnasio agrupada por el tipo de sala.
19 Monitores que no tienen clases asignadas actualmente.

;
select m.nombre, count(si.codigo) as nclases
from Monitor m
left join Son_Impartidas si
on m.dni = si.dni
group by m.nombre
having nclases = 0;


-- 20 Mostrar salas cuya superficie es mayor a la media de todas las salas.

select numero, superficie
from Salas
where superficie > (select avg(superficie) from Salas);

-- 21 Nombre de socios y la descripción de las clases a las que asisten en la 'Planta 1'.
-- 22 Clases que tienen más de 2 socios inscritos.

select descripcion, count(a.dni) as cuenta
from Clases c
join Asisten a
on c.codigo = a.codigo
group by descripcion
having cuenta > 2;
            

-- 23 Listar aparatos cuyo estado es 'Malo' junto con el número de sala donde se encuentran.

select descripcion, estado, t.numero
from Aparatos a
join Tienen t
on a.codigo = t.codigo
where estado = 'malo';

-- obtener superficie de las salas de cardio

select tipo, sum(superficie) 
from Salas s
where tipo = 'cardio';