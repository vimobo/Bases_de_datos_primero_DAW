create database empleados;

use empleados;
create table empleado(
id int unsigned auto_increment primary key,
nombre varchar(20),
salario float,
fecha date,
edad int,
departamento varchar(20),
activo boolean);

select * from empleado;
INSERT INTO empleado (nombre, salario, fecha, edad, departamento, activo) VALUES
('Elena Ríos', 75000.00, '2021-06-15', 35, 'Marketing', TRUE),
('Ricardo Mora', 52000.50, '2023-01-20', 28, 'Ventas', TRUE),
('Laura Solís', 90000.00, '2019-11-01', 42, 'IT', TRUE),
('Pedro Ruiz', 45000.00, '2024-03-10', 22, 'Administración', FALSE),
('Sofía Luna', 68500.25, '2022-09-25', 31, 'Recursos Humanos', TRUE),
('Javier Cruz', 110000.00, '2018-04-05', 48, 'IT', TRUE),
('Andrea Paz', 58000.00, '2023-07-12', 26, 'Ventas', TRUE),
('Manuel Gil', 82000.00, '2020-02-29', 39, 'Marketing', TRUE),
('Diana Vega', 40000.75, '2024-05-01', 21, 'Administración', FALSE),
('Carlos Rey', 150000.00, '2015-08-18', 55, 'Dirección', TRUE);

select nombre
from empleado;

select nombre
from empleado
where nombre = 'Diana Vega';

select nombre, salario, fecha, edad
from empleado
where nombre = 'Diana Vega' or 'Carlos Rey';

select * from empleado
where departamento in ('IT', 'Ventas');



select * from empleado
where nombre like 'P%';

select departamento, sum(salario) as presupuestoPorDepartamentos
from empleado
group by departamento;


select departamento, count(*) as numeroDeEmpleados
from empleado
group by departamento;

select nombre, departamento, salario
from empleado;

select nombre, salario
from empleado
where salario > 70000;

select *
from empleado
where salario > (select avg(salario)
from departamento);
group by departamento;











select nombre,salario
from empleado
where salario = (select max(salario) from empleado);

select nombre, edad
from empleado
where edad >= 30 and edad <= 43;

select nombre, edad
from empleados
where edad between 30 and 43;

select nombre, edad
from empleado
where edad = (select max(edad) from empleados);

select * from empleado;


select nombre, edad, salario
from empleado
where edad = (select min(edad) from empleado)
order by salario desc
limit 1;