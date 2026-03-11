create database ejercicio4;
use ejercicio4;

create table empleados (
	DNI varchar(8),
    nombre varchar(120),
    apellidos varchar(100),
    departamento int,
    PRIMARY KEY (DNI));

create table departamento (
	nombre varchar(100),
    presupuesto int,
    codigo int
);


alter table departamento add constraint primary key(codigo);
alter table empleados add constraint foreign key(departamento)
references departamento(codigo);

insert into Departamento values
(14,'Marketing',20000),
(37,'Facturación',2000),
(77,'Ventas',22000),
(55,'RR.HH',60000),
(1,'Informática',70000),
(21,'Mantenimiento',80000),
(31,'Exteriores',90000);

insert into Empleados values
(111, 'Francisco', 'Medina',14),
(112, 'Francisco', 'López',37),
(113, 'Francisco', 'Pérez',77),
(114, 'Cristina', 'Medina',77),
(115, 'Cristina', 'Martín',55),
(116, 'Cristina', 'López',21),
(117, 'Jaime', 'Pérez',21),
(118, 'Marcos', 'García',21);

-- 1 obtener apellidos

select apellidos
from empleados;

-- 2 obtener los apellidos de los empleados sin repeticiones

select distinct apellidos
from empleados;

-- 3 Obtener todos los datos de los empleados que se apellidan López

select * 
from empleados
where apellidos = 'lopez';

-- 4.- Obtener todos los datos de los empleados que se apellidan ‘López’ y los que se apellidan ‘Pérez’.

select *
from empleados
where apellidos in ('lopez','perez');

-- 5.- Obtener todos los datos de los empleados que trabajan para el departamento 14.

select *
from empleados
where departamento = 14;

-- 6.- Obtener todos los datos de los empleados que trabajan para el departamento 37 y para el departamento 77.

select * 
from empleados
where departamento in (37,77);

-- 7.- Obtener todos los datos de los empleados cuyo apellido empiece por ‘P’.

select *
from empleados
where apellidos like 'P%';

-- 8.- Obtener el presupuesto total de todos los departamentos.

select sum(presupuesto)
from departamento;

-- .- Obtener el número de empleados en cada departamentoç

select departamento, count(*)
from empleados
group by departamento;

-- 10.- Obtener un listado completo de empleados, incluyendo por cada empleado los datos delempleado y de su departamento.

select *
from empleados,departamento
where departamento =codigo;

-- 11.- Obtener un listado completo de empleados, incluyendo el nombre y apellidos del
-- empleado junto al nombre y presupuesto de su departamento.

select *
from empleados, departamento
where departamento = codigo;

-- 12.- Obtener los nombres y apellidos de los empleados que trabajen en departamentos cuyo
-- presupuesto sea mayor que 60.000 €

select e.nombre, empleados, d.nombre
from empleados e, departamento d
where departamento = codigo and presupuesto > 60000;

-- 13.- Obtener los datos de los departamentos cuyo presupuesto es superior al presupuesto
 -- medio de todos los departamentos.
 
 select avg(presupuesto)
 from departamento;
 
 select *
 from departamento
 where presupuesto > (select avg(presupuesto)
 from departamento)
 
 -- 14.- Obtener los nombres (únicamente los nombres) de los departamentos que tienen más de
-- dos empleados.

select nombre, departamento
from empleados
where 
 (select count(*) as numeroDeEmpleados
from empleados
where numeroDeEmpleados > 2
group by departamento);


-- 15.- Añadir un nuevo departamento ‘Calidad’ con presupuesto 40.000 euros y código 11.
-- Añadir un empleado vinculado al departamento recién creado: Esther Vázquez, DNI:89267109.

insert into departamento (nombre, presupuesto, codigo)
values('calidad', 40000, 11);

INSERT INTO empleados (DNI, nombre, apellidos, departamento)
VALUES ('89267109', 'Esther', 'Vázquez', 11);


-- 6.- Aplicar un recorte presupuestario del 10% a todos los departamentos

UPDATE departamento
SET presupuesto = presupuesto * 0.9;
describe departamento;


-- 17.- Reasignar a los empleados del departamento de investigación (código 77) al
-- departamento de informática (código 14)

UPDATE empleados
SET departamento = 14
WHERE departamento = 77;

-- 18.- Despedir a todos los empleados que trabajan para el departamento de informática (código
-- 14).

delete empleados
from empleados
where departamento = 14;

-- 19.- Despedir a todos los empleados que trabajen para departamentos cuyo presupuesto sea
-- superior a los 60.000€.
 
select * from departamento;

delete from empleados
where departamento in (select codigo from departamento where presupuesto > 60000);

-- 20. Despedir a tododos

select * from empleados;

delete from empleados;
describe empleados;