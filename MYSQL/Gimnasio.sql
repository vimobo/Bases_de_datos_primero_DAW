Create database Gimnasio;

use Gimnasio;

create table Monitor (
	dni int primary key,
    nombre varchar(25),
    telefono int(9),
    titulacion varchar(25)
);

create table Socio (
	dni int primary key,
	nombre varchar(24),
    direccion varchar(25),
    telefono int);
    
    create table Aparatos (
		codigo int primary key,
        descripcion varchar(25),
		estado varchar(25));
        
	create table Salas (
		numero int primary key,
        superficie int,
        ubicacion varchar(25),
        tipo varchar(25));
        
	create table Se_Imparten (
		numero int,
        codigo int,
        primary key(numero, codigo));
        
	create table Tienen (	
		numero int,
        codigo int,
        primary key(numero, codigo));
        
	create table Clases (
		codigo int primary key,
        descripcion varchar(25),
        dia_Hora time);
        
	create table Son_Impartidas (
		codigo int,
        dni int,
        primary key(codigo, dni));
        
	create table Asisten (
		dni int,
        codigo int,
        primary key(dni, codigo));
        
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

select nombre, telefono from Socio where direccion = 'Trinidad';

-- 2. Nombre y teléfono del socio que vive en Cava.

select nombre, telefono from Socio where direccion = 'Cava';


-- 3. Nombre y dirección de los socios que asisten a aeróbic.

select nombre, direccion, descripcion from Socio s
join Asisten a on s.dni = a.dni 
join Clases c on a.codigo = c.codigo
where descripcion = 'Aerobic';

-- 4. Nombre y dirección de los socios que asisten a sep


-- 5. Nombre de los socios que asisten a las clases de Ana Gil.

select s.nombre, direccion, m.nombre from Socio s
join Asisten a on s.dni = a.dni 
join Son_Impartidas si on si.codigo = a.codigo
join Monitor m on m.dni = si.dni
where m.nombre = 'Ana Gil';

-- 6. Nombre de los monitores que tiene titulación de la INEF.

create view v_mon as select * from Monitor;

select * from v_mon;

-- 7. Descripción de los aparatos nuevos.
-- 8. Nombre y dirección de los socios que asisten a clase antes de las 16:00 horas.

select nombre, direccion, dia_hora from Socio s
join Asisten a on a.dni = s.dni
join Clases c on c.codigo = a.codigo
where dia_hora < '16:00:00';

-- 9. Número y tipo de las salas que tienen más de 12 metros cuadrados.



10. Nombre de los alumnos de Pepe.
11. Nombre de los socios que asisten a clase en la primera planta. ;
-- 12. Aparatos que están situados en la 1º planta.

select descripcion from Aparatos a
join Tienen t on t.codigo = a.codigo
join Salas s on s.numero = t.numero
where ubicacion = 'Planta 1';


-- 13. Todas las clases y todos los alumnos que asisten a esas clases.

select descripcion, s.nombre from Clases c
join Asisten a on a.codigo = c.codigo
join Socio s on s.dni = a.dni
group by descripcion, s.nombre
order by descripcion;

-- 14. Monitores y las clases que dan y a qué hora la dan.

select tipo as media from Salas
where superficie > (select avg(superficie) from Salas)
group by numero;


-- 15. Clases que se dan en salas de más de 22 metros cuadrados

select descripcion, s.numero from Clases c
join Se_Imparten si on si.codigo = c.codigo
join Salas s on s.numero = si.numero
where superficie > 22;
-- 21 Nombre de socios y la descripción de las clases a las que asisten en la 'Planta 1'.

alter table Se_Imparten add constraint foreign key (numero) references Salas(numero);

-- 22 Clases que tienen más de 2 socios inscritos.

select distinct descripcion, count(s.dni) as n_socios from Clases c
join Asisten a on a.codigo = c.codigo
join Socio s on s.dni = a.dni
group by c.codigo;
having  n_socios > 2;
