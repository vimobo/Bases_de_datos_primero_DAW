create database piezas;

use piezas;

create table proveedor (
pr varchar(2) primary key,
nombre varchar (25),
estado int,
ciudad varchar (25));

create table pieza (
pz varchar(2) primary key,
nombre varchar(25),
color varchar(25),
peso int,
ciudad varchar(25));

create table suministro (
pr varchar (2),
pz varchar(2),
cantidad int,
primary key (pr,pz),
foreign key (pz)
references pieza(pz),
foreign key (pr) references proveedor(pr));

INSERT INTO proveedor (pr, nombre, estado, ciudad) VALUES
('S1', 'Salazar', 20, 'Londres'),
('S2', 'Jaime', 10, 'Paris'),
('S3', 'Bernal', 30, 'Paris'),
('S4', 'Corona', 20, 'Londres'),
('S5', 'Aldana', 30, 'Atenas');

INSERT INTO pieza (pz, nombre, color, peso, ciudad) VALUES
('P1', 'tuerca', 'verde', 12, 'Paris'),
('P2', 'perno', 'rojo', 17, 'Londres'),
('P3', 'birlo', 'azul', 17, 'Roma'),
('P4', 'birlo', 'rojo', 14, 'Londres'),
('P5', 'birlo', 'azul', 12, 'Paris'),
('P6', 'engrane', 'rojo', 19, 'Paris');


INSERT INTO suministro (pr, pz, cantidad) VALUES
('S1', 'P1', 300),
('S1', 'P3', 400),
('S1', 'P4', 200),
('S1', 'P5', 100),
('S2', 'P1', 300),
('S2', 'P2', 400),
('S3', 'P2', 200),
('S4', 'P2', 200),
('S4', 'P4', 300),
('S4', 'P5', 400);

select nombre, color, peso from pieza
where color =  'verde' or color = 'rojo';

select nombre, estado, ciudad from proveedor
where ciudad like 'L%';

select pr.nombre, pr.estado, p.nombre, p.color
from suministro s
join pieza p
on p.pz = s.pz
join proveedor pr 
on pr.pr = s.pr;

select p.nombre, p.peso
from pieza p 
where peso > (select avg(peso) from pieza);

select pr.nombre
from proveedor pr
left join suministro s
on s.pr = pr.pr
where s.pr is null;

select pr.nombre, pr.ciudad, count(s.pz)
from suministro s
join proveedor pr
on pr.pr = s.pr
group by pr.pr, pr.nombre
having count(s.pz) > 2;

select pz, count(pr)
from suministro
group by pz
having count(pr) > 1;

-
-- 11. Listar los proveedores que están en París

select nombre, ciudad from proveedor
where ciudad = 'Paris';

-- 12. Mostrar las piezas de color rojo

select * from pieza
where color = 'Rojo';

-- 13. Mostrar los suministros realizados por el proveedor S1

select pz, cantidad
from suministro
where pr = 'S1';

-- 14. Mostrar el nombre del proveedor y la cantidad que suministra (JOIN simple)

select s.pz, s.cantidad, pr.nombre
from suministro s 
join proveedor pr 
on pr.pr = s.pr;

-- 15. Mostrar el nombre del proveedor, el nombre de la pieza y la cantidad suministrada

select s.pz, s.cantidad, pr.nombre, p.nombre, p.color
from suministro s 
join proveedor pr 
on pr.pr = s.pr
join pieza p
on p.pz = s.pz;

-- 16. Mostrar los proveedores que suministran piezas fabricadas en la misma ciudad que ellos

select pr.nombre, pr.estado, p.nombre, p.color
from suministro s
join pieza p
on p.pz = s.pz
join proveedor pr 
on pr.pr = s.pr
where pr.ciudad = p.ciudad;

-- 17. Mostrar el total de piezas suministradas por cada proveedor
-- 18. Mostrar los proveedores que suministran más de una pieza diferente

select pr, count(distinct pz) as cuenta from suministro s
group by pr
having count(distinct pz) > 1;

-- 19. Mostrar los proveedores que suministran más de 300 unidades en total
select pr.nombre from suministro s
join proveedor pr
on pr.pr = s.pr
where  (select sum(cantidad) from suministro  group by pr)> 300);

-- 20. Mostrar la cantidad promedio suministrada por pieza
