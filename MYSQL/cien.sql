create database trabajadores;

use trabajadores;

create table proyecto (
codigo char primary key,
nombre varchar(25),
horas int);

create table investigador ( 
	dni int,
    nombre varchar(23),
    apellidos varchar(23),
    muerte date,
    primary key (dni)
);

create table asignado (
dni int,
codigo char,
primary key (dni,codigo),

foreign key (codigo) references proyecto(codigo),
foreign key (dni) references investigador(dni));


INSERT INTO investigador VALUES
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



select  p.codigo, p.nombre
from investigador i
join asignado a
on i.dni = a.dni
join proyecto p
on p.codigo = a.codigo
group by p.nombre, p.codigo;

