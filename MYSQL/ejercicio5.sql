create database proveedores_piezas;
use proveedores_piezas;

create table proveedor (
pr varchar (2),
nombre varchar (20),
estado int,
ciudad varchar (20),
primary key (pr)
);

insert into proveedor values 
('s1','Salazar',20,'Londres'),
('s2','Jaimes',10,'Paris'),
('s3','Bernal',30,'Paris'),
('s4','Corona',20,'Londres'),
('s5','Aldana',30,'Atenas');


create table piezas (
	pz varchar (2),
	nombre varchar (20),
	color varchar (20),
	peso int,
	ciudad varchar (20),
    primary key(pz)
);

insert into piezas values 
('p1','tuerca','verde',12,'paris'),
('p2','perno','rojo',17,'paris'),
('p3','birlo','azul',17,'paris'),
('p4','birlo','rojo',14,'paris'),
('p5','birlo','azul',12,'paris'),
('p6','engranae','rojo',19,'paris');

drop table suministro;

create table suministro (
codigo int auto_increment,
pr varchar (2),
pz varchar (2),
cantidad int,
primary key (codigo),
foreign key (pr) references proveedor (pr)
on update cascade,
foreign key (pz) references piezas (pz)
on update cascade
);

drop table suministro;

insert into suministro (pr,pz,cantidad) values 
('s1','p1',300),
('s1','p2',200),
('s1','p3',400),
('s1','p4',200),
('s1','p5',300),
('s1','p6',100),
('s2','p1',300),
('s2','p2',400),
('s3','p2',200),
('s4','p2',200),
('s4','p4',300),
('s4','p5',400);

drop table suministro;
-- caso 1.1

delete from proveedor
where pr = 's1';

-- no se puede al tener hijos
-- 1.2

delete from proveedor
where pr = 's5';

-- 1.3

-- caso 2.1

delete from suministro
where pr = 's1';

select * from suministro; 
select * from suministro; 

-- caso 2.2

delete from proveedor
where pr = 's1';

-- caso 4.1

delete from proveedor
where pr = 's5';

select * from proveedor;

update proveedor set pr ='s6' where pr ='s1';

