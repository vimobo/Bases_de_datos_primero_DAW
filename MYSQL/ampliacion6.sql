create database proveedores_piezas;

use proveedores_piezas;

create table pieza (
codigo int primary key auto_increment,
nombre varchar(20));

create table sumin (
codigo int,
id varchar(3),
precio int,
primary key (codigo, id),
foreign key (codigo) references pieza(codigo),
foreign key key (id) references provee(id));


create table provee (
id varchar(3) primary key,
nombre varchar(20));

INSERT INTO pieza (codigo, nombre) VALUES
(1, 'clavo'),
(2, 'tuerca'),
(3, 'arandela'),
(4, 'grifo'),
(5, 'tornillo'),
(6, 'martillo'),
(7, 'destornillador'),
(8, 'llave'),
(9, 'serrucho');

INSERT INTO provee (id, nombre) VALUES
('RBT', 'Susan Calvin Corp'),
('GHJ', 'Wellington'),
('HAL', 'Perry'),
('JUL', 'Hopper');

INSERT INTO sumin (codigo, id, precio) VALUES
(1, 'RBT', 10),
(1, 'GHJ', 7),
(2, 'GHJ', 7),
(3, 'RBT', 5),
(3, 'GHJ', 7),
(4, 'GHJ', 27),
(5, 'HAL', 7),
(1, 'JUL', 7),
(8, 'JUL', 17),
(9, 'JUL', 7),
(7, 'GHJ', 7),
(7, 'HAL', 15),
(8, 'HAL', 7),
(9, 'GHJ', 66);


-- 
-- 1.- Obtener los nombres de todas las piezas

select distinct nombre
from pieza;
-- 2.- Obtener los datos de todos los proveedores.

select * from provee;

-- 3.- Obtener el precio medio al que se nos suministra las piezas.

select avg(precio) as av
from sumin;

-- 4.- Obtener los nombres de los proveedores que suministran la pieza 1.

select distinct pr.nombre from provee pr 
join sumin s
on s.id = pr.id
where s.codigo = 1;

-- 5.- Obtener los nombres de las piezas suministradas por el proveedor cuyo código es HAL.

select pi.nombre from pieza pi
join sumin s
on s.codigo = pi.codigo 
where s.id = 'HAL';

-- 6.- Obtener los nombres de los proveedores que suministran las piezas más caras, indicando el
-- nombre de la pieza y el precio al que la suministran.

select distinct pi.nombre,  p.nombre , s.precio from sumin s 
join provee p
on s.id = p.id
join  pieza pi
on s.codigo = pi.codigo
where s.precio = (select max(precio)
	from sumin);

-- 7.- Aumentar los precios en una unidad.

UPDATE sumin
SET precio = precio + 1;

-- 8.- Hacer constar en la BD que la empresa “Susan Calvin” (RBT) ya no va a suministrar másclavos.
-- 
delete from sumin
where codigo = 1 and id = 'RBT';


-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 