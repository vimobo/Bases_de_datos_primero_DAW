create database empleados_departamentos;

use empleados_departamentos;

create table empleados (
dni varchar(8) primary key,
nombre varchar(100),
apellidos varchar(255),
departamento int
);

create table departamentos (
codigo int primary key auto_increment,
nombre varchar(100),
presupuesto int);

alter table empleados add constraint fk_empleados_departamentos
foreign key (departamento) references departamentos(codigo);

alter table empleados drop foreign key fk_empleados_departamentos;



INSERT INTO departamentos (codigo, nombre, presupuesto) VALUES
(14, 'Marketing', 20000),
(37, 'Facturación', 2000),
(77, 'Ventas', 22000),
(55, 'RR.HH', 60000),
(1, 'Informática', 70000),
(21, 'Mantenimiento', 80000),
(31, 'Exteriores', 90000);


INSERT INTO empleados (dni, nombre, apellidos, departamento) VALUES
('11111111', 'Francisco', 'Medina', 14),
('22222222', 'Francisco', 'López', 37),
('33333333', 'Francisco', 'Pérez', 77),
('44444444', 'Cristina', 'Medina', 77),
('55555555', 'Cristina', 'Martín', 55),
('66666666', 'Cristina', 'López', 21),
('77777777', 'Jaime', 'Pérez', 21),
('88888888', 'Marcos', 'García', 21);


-- 1.- Obtener los apellidos de los empleados.

select apellidos from empleados;

-- 2.- Obtener los apellidos de los empleados sin repeticiones.

select distinct apellidos from empleados;


-- 3.- Obtener todos los datos de los empleados que se apellidan López.’

select * from empleados where apellidos = 'lopez';

-- 4.- Obtener todos los datos de los empleados que se apellidan ‘López’ y los que se apellidan ‘Pérez’.

select * from empleados where apellidos = 'lopez' or apellidos = 'perez';

-- 5.- Obtener todos los datos de los empleados que trabajan para el departamento 14.

select * from empleados where departamento = 14;

-- 6.- Obtener todos los datos de los empleados que trabajan para el departamento 37 y para eldepartamento 77.

select * from empleados where departamento = 37 or departamento = 77;


-- 7.- Obtener todos los datos de los empleados cuyo apellido empiece por ‘P’.

select nombre from empleados where nombre like 'F%';

-- 8.- Obtener el presupuesto total de todos los departamentos.

select nombre, sum(presupuesto) as presupuesto_total from departamentos group by nombre;

-- 9.- Obtener el número de empleados en cada departamento.

select d.nombre, count(e.dni) as empleados_en_departamento 
from empleados e 
join departamentos d on e.departamento = d.codigo
group by d.nombre;

-- 10.- Obtener un listado completo de empleados, incluyendo por cada empleado los datos del empleado y de su departamento.

select *
from empleados e
join departamentos d
on d.codigo = e.departamento;

-- 11.- Obtener un listado completo de empleados, incluyendo el nombre y apellidos del empleado junto al nombre y presupuesto de su departamento.

select 
	e.nombre,
	e.apellidos,
    d.nombre,
    sum(presupuesto) as presupuesto_departamento
from empleados e
join departamentos d
on d.codigo = e.departamento
group by e.dni;

-- 12.- Obtener los nombres y apellidos de los empleados que trabajen en departamentos cuyo presupuesto sea mayor que 60.000 €

select 
	e.nombre,
	e.apellidos,
    d.nombre,
    d.presupuesto
    from empleados e
join departamentos d
on d.codigo = e.departamento
where d.presupuesto > 60000;

-- 13.- Obtener los datos de los departamentos cuyo presupuesto es superior al presupuesto medio de todos los departamentos.

select *
from departamentos
where presupuesto > 60000
group by codigo;


select *
from departamentos
where presupuesto > (select avg(presupuesto) from departamentos);

-- 14.- Obtener los nombres (únicamente los nombres) de los departamentos que tienen más de dos empleados.

select d.nombre,
from departamentos d
join empleados e
on d.codigo = e.departamento
group by d.nombre
having 2 > count(e.departamento);

-- 15.- Obtener el nombre y presupuesto de todos los departamentos ordenados por presupuesto de mayor a menor.

select nombre, presupuesto
from departamentos
order by presupuesto asc;

-- 16.- Obtener el nombre y apellidos de los empleados que trabajen en el departamento de Mantenimiento.

select e.nombre, e.apellidos
from empleados e
join departamentos d
on d.codigo = e.departamento
where d.nombre = 'Mantenimiento';

-- 17.- Obtener cuántos empleados hay en cada departamento (mostrar nombre del departamento y número de empleados).

select 
	d.nombre,
    count(e.departamento) as n_empl
from departamentos d
join empleados e
on d.codigo = e.departamento
group by d.nombre;

-- 18.- Obtener los departamentos que no tienen ningún empleado.

select d.nombre
from departamentos d
left join empleados e
on d.codigo = e.departamento
where e.dni is null;

-- 19.- Obtener el nombre y apellidos de los empleados cuyo apellido sea 'Pérez'.

select nombre, apellidos 
from empleados
where apellidos = 'Pérez';

-- 20.- Obtener el presupuesto medio de todos los departamentos.

select avg(presupuesto) as promedio from departamentos;

-- 21.- Obtener el nombre del departamento con el presupuesto más alto.

select nombre , presupuesto
from departamentos
order by presupuesto desc
limit 1;

-- 22.- Obtener el nombre y apellidos de los empleados junto con el presupuesto de su departamento.

select e.nombre, e.apellidos, d.presupuesto
from empleados e
join departamentos d
on d.codigo = e.departamento;

-- 23.- Obtener los departamentos cuyo presupuesto sea inferior a 50.000 € y cuántos empleados tienen.

select d.nombre, count(e.dni) as n_empleados 
from departamentos d 
left join empleados e 
on d.codigo = e.departamento 
where d.presupuesto < 50000
group by d.nombre ;

-- 24.- Obtener el nombre de los departamentos que tienen exactamente un empleado.

	select d.nombre,
    count(e.dni) as aa
    from departamentos d
    join empleados e
    on d.codigo = e.departamento
    group by d.nombre
    having 1 = count(e.dni) ;
    

-- 25.- Obtener el nombre y apellidos de los empleados que trabajan en departamentos cuyo nombre empieza por 'M'.

select e.nombre, e.apellidos, d.nombre from empleados e join departamentos d on e.departamento = d.codigo where d.nombre like 'M%'; 



