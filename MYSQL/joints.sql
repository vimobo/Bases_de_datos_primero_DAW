create database joinbis;
use joinbis;

create table empleado(
	id int primary key,
    nombre varchar(25),
    direccion varchar(50),
    nombre_dpto varchar(50),
    foreign key (nombre_dpto) references departamento(nombre));
    
create table departamento (
	nombre varchar(50) primary key,
    presupuesto int);
    
    insert into departamento values('marketing',120000),('ventas',5000000),('IT',2000000);
    insert into empleado values(1,'pepe','calle ancha','marketing'),(2,'ana','calle ancha','ventas'),(3,'eva','calle baja',null);
    
    select * from empleado,departamento
    where empleado.nombre_dpto = departamento.nombre;
    
    select * from departamento
    inner join empleado on empleado.nombre = departamento.nombre;
    
    select * from departamento
    left join empleado
    on departamento.nombre =  empleado.nombre;
    
    select * from departamento
    right join empleado
    on departamento.nombre =  empleado.nombre;
    
    select * from empleado e
    left join departamento d
    on d.nombre =  e.nombre;
    
    