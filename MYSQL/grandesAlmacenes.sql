create database GrandesAlmacenes;

use GrandesAlmacenes;

create table Cajeros (
	codigo int primary key,
    nomApels varchar(225));
    
create table Productos (
	codigo int primary key,
    nombre varchar(100),
    precio int);

create table MaquinasRegistradoras (
	codigo int primary key,
    piso int);

create table Venta (
	cajero int,
    maquina int,
	producto int,
    primary key(cajero, maquina, producto ),
    foreign key(cajero) references Cajeros(codigo) 
		ON UPDATE CASCADE
		ON DELETE CASCADE,
        foreign key(maquina) references MaquinasRegistradoras(codigo)
		ON UPDATE CASCADE
        ON DELETE CASCADE,
	foreign key(producto) references Productos(codigo)
		ON UPDATE CASCADE
        ON DELETE CASCADE);

insert into Cajeros values
(4382, 'Juan'),
(8493, 'Nestor'),
(3963, 'Francisco'),
(3414, 'Angel'),
(6298, 'Manuel'),
(5243, 'José');

insert into Productos values
(3741, 'PS4', 400),
(7629, 'xBox One', 450),
(3925, 'Nintendo DS', 180),
(4602, 'PSVita', 220),
(6420, 'Wii-U', 300);


insert into MaquinasRegistradoras values
(2951, 1),
(4325, 1),
(6382, 2),
(4629, 3),
(2843, 4);

INSERT INTO Venta (cajero, maquina, producto) VALUES
(3963, 4629, 6420),
(3414, 2843, 3741),
(4382, 2951, 3925),
(6298, 4325, 4602),
(5243, 2843, 7629),
(3963, 2843, 3741),
(4382, 6382, 7629);


select p.nombre,p.codigo  from Venta v
join Productos p on v.producto = p.codigo;

-- 1. Obtener el número de ventas de cada producto, ordenado de más a menos ventas.

select p.nombre, p.codigo, count(v.producto) as cuenta 
from Productos p
join Venta v on v.producto = p.codigo
group by p.nombre, p.codigo
order by cuenta asc;

-- 2. Obtener un informe completo de ventas, indicando el nombre del cajero que realizó la venta,
-- nombre y precios de los productos vendidos, y piso en el que se encuentra la máquina
-- registradora donde se realizó la venta.

select * from Venta v 
join Productos p on p.codigo = v.producto
join MaquinasRegistradoras mr on mr.codigo = v.maquina
join Cajeros c on c.codigo = v.cajero; 

-- 3. Obtener las ventas realizadas en cada piso.

select mr.piso, count(v.cajero) as cuenta from MaquinasRegistradoras mr
join Venta v on v.maquina = mr.codigo
group by mr.piso;

-- 4. Obtener el código y nombre de cada empleado, junto con el importe total de sus ventas.

select nomApels, sum(p.precio) from Cajeros c
join Venta v on c.codigo = v.cajero
join Productos p on p.codigo = v.producto
group by nomApels;

-- 5. Obtener el código y nombre de aquellos cajeros que hayan realizado ventas en pisos cuyas
-- ventas totales sean inferiores a los 500€


select nomApels, c.codigo from Cajeros c
join Venta v on v.cajero = c.codigo
join MaquinasRegistradoras mr on mr.codigo = v.maquina
where mr.piso in 
	(select piso from Productos p1
	join Venta v1 on p1.codigo = v1.producto
	join MaquinasRegistradoras mr1 on mr1.codigo = v1.maquina
	group by mr1.piso
	having sum(p1.precio) < 500);
    
Promedio de Ventas: Obtener el precio medio de los productos vendidos por cada cajero (mostrar nombre del cajero y la media).

    Maquinaria sin uso: Listar el código y el piso de las máquinas registradoras que no han realizado ninguna venta hasta el momento.
;
select c.nomApels from Cajeros c
left join Venta v on v.cajero = c.codigo
where v.producto is null;

    Grandes Compras: Mostrar los nombres de los cajeros que han vendido productos cuyo precio sea superior a 350€.
    ;
select nomApels, precio from Cajeros c
join Venta v on v.cajero = c.codigo
join Productos p on p.codigo = v.producto
group by nomApels, precio
having sum(precio) > 350;


    Ranking de Pisos: Obtener el número total de productos vendidos en cada piso, pero solo para aquellos pisos que hayan vendido más de 2 productos.

Bloque 2: Cruce de Datos (JOINs)

    Catálogo por Piso: Mostrar el nombre de los productos que se han vendido en el Piso 1, sin repetir nombres.

    Productividad de Cajeros: Obtener el nombre de los cajeros y el número de máquinas distintas que cada uno ha utilizado.
;
select distinct nomApels, mr.codigo from MaquinasRegistradoras mr
join Venta v on v.maquina = mr.codigo
join Cajeros c on c.codigo = v.cajero
group by nomApels, mr.codigo
order by nomApels asc;

    Informe de Ingresos: Mostrar el nombre del producto, su precio y el piso donde se vendió, ordenado por precio de mayor a menor.

Bloque 3: Subconsultas y Desafíos Lógicos

 --    Cajeros Estrella: Obtener los nombres de los cajeros que han realizado ventas por un valor total superior a la media de ventas de todos los cajeros.
 ;
 select nomApels from Cajeros;
;
select nomApels, sum(precio) as suma From Cajeros c
join Venta v on v.cajero = c.codigo
join Productos p on p.codigo = v.producto
group by c.codigo
having suma > (select avg(precio) from Productos);

select avg(precio) from Productos;

  --  El Producto más Vendido: Mostrar el nombre y el precio del producto (o productos) que más veces ha aparecido en la tabla Venta.

    Zonas de baja facturación: Listar el código y el nombre de los productos que se han vendido en máquinas registradoras situadas en pisos donde el total facturado sea el mínimo de todos los pisos.
    ;
    select p.codigo, p.nombre from Productos p
    join Venta v on p.codigo = v.producto
    join MaquinasRegistradoras mr on mr.codigo = v.maquina
    where piso in (select piso as suma from Productos p1
		join Venta v1 on v1.producto = mr1.codigo
		join MaquinasRegistradoras mr1 on mr1.codigo = v1.maquina
        group by mr1.piso
        order by sum(precio) asc
        limit 1);