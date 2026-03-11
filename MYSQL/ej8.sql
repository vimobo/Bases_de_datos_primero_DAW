create database cientifico_db;

use cientifico_db;

create table cientifico (
dni varchar(9) primary key,
nombre varchar (25),
apellido varchar (25),
fecha_nacimiento date
);

drop table asignado;

create table asignado (
dni varchar(9),
codigo int,
primary key (dni,codigo)
);

create table proyecto (
codigo int primary key,
nombre varchar (25) ,
horas int);

alter table asignado add constraint fk_dni_asignado foreign key (dni) references cientifico(dni);
alter table asignado add constraint fk_codigo_asignado foreign key (codigo) references proyecto(codigo);

INSERT INTO cientifico (dni, nombre, apellido, fecha_nacimiento) VALUES
('1', 'María', 'Guzmán', '1974-02-12'),
('2', 'María', 'Jiménez', '1954-02-11'),
('3', 'Rafael', 'Girado', '1964-01-22'),
('4', 'Alonso', 'Gómez', '1990-12-12'),
('5', 'Clara', 'Antúnez', '1973-11-12');

INSERT INTO proyecto (codigo, nombre, horas) VALUES
(1, 'Bioquímica', 410),
(2, 'Electrónica', 1200),
(3, 'Geológica', 300),
(4, 'Tectónica', 500),
(5, 'Histograma', 70);

INSERT INTO asignado (dni, codigo) VALUES
('1', 1),
('1', 2),
('1', 3),

('2', 1),

('3', 1),
('3', 2),
('3', 3),

('4', 1),
('4', 2),
('4', 3),
('4', 5),
('4', 4);

-- 1
select 
c.dni,
c.nombre as nombre_cientifico,
p.codigo as id_proyecto,
p.nombre as nombre_proyecto
from  asignado a 
join cientifico c on a.dni = c.dni
join proyecto p on a.codigo = p.codigo
order by p.codigo, c.dni;


select * from cientifico join group by ;

-- 2 
select codigo, count(*) as proyecto_empleado from asignado group by codigo;

-- 3
-- 3.- Obtener el número de científicos asignados a cada proyecto (mostrar el identificador del
-- proyecto y el nombre del proyecto

