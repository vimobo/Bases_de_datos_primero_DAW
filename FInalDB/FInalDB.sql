create database Plataformas;

use Plataformas;

create table if not exists usuarios (
	id_usuario int primary key,
    nombre varchar(30),
    telefono int,
    email varchar(50),
    direccion varchar(50),
    cuenta_bancaria int,
    activo boolean);
    
create table if not exists notificaciones (
	id_notificacion int primary key,
    id_usuario int,
   	tipo varchar(25),
	fecha date,
    foreign key (id_usuario) references usuarios (id_usuario)
    on delete cascade on update cascade
    );
    
create table if not exists persona (
	id_usuario int primary key,
	dni varchar(9),
	foreign key (id_usuario) references usuarios (id_usuario)
	);
    
create table if not exists empresa (
	id_usuario int primary key,
	cif varchar(9),
	foreign key (id_usuario) references usuarios (id_usuario)
	on delete cascade on update cascade
	);
    
create table if not exists pagos (
	id_pago int primary key,
    id_usuario int,
    estado varchar(30),
    comprobante varchar(30),
    tipo varchar(30),
    importe double,
    fecha date,
	foreign key (id_usuario) references usuarios (id_usuario)
	on delete cascade on update cascade
	);
    
    

create table if not exists plataformas (
	id_plataforma int primary key,
    modelo varchar(30),
    marca varchar(30),
    tipo varchar(30),
    peso double,
    altura double,
    estado varchar(30),
    precio int,
    stock int,
    stock_total int
	);

    
create table if not exists proveedor (
	id_proveedor int primary key,
    tipo varchar(30),
    nombre varchar(30),
    email varchar(50),
    telefono int
    );
    
create table if not exists proviene (
	id_plataforma int,
    id_proveedor int,
    primary key(id_plataforma, id_proveedor), 
    foreign key (id_plataforma) references plataformas(id_plataforma)
    on update cascade on delete cascade,
    foreign key (id_proveedor) references proveedor(id_proveedor)
    on update cascade on delete cascade
    );
    
create table if not exists reparaciones (
	id_reparacion int primary key,
    id_plataforma int,
    coste double,
    estado varchar(30),
    fecha_inicio date,
    fecha_fin date,
    foreign key (id_plataforma) references plataformas(id_plataforma)
    on delete cascade on update cascade);
    
    
create table if not exists pagos (
	id_pago int primary key,
    id_usuario int,
    tipo varchar(30),
    importe double,
    fecha date,
    estado varchar(30),
    comprobante varchar(50),
    foreign key(id_usuario) references usuarios(id_usuario));

    
create table if not exists conceptos (
	id_concepto int primary key,
	id_pago int,
    id_plataforma int,
    precio double,
    foreign key(id_pago) references pagos(id_pago)
    on delete cascade on update cascade,
    foreign key(id_plataforma) references plataformas(id_plataforma)
    on delete cascade on update cascade
	);


create table if not exists compras (
	id_concepto int primary key,
    seguro varchar(30),
    financiacion double,
    comprobante varchar(50),
    foreign key(id_concepto) references conceptos(id_concepto)
    on delete cascade on update cascade);
    
create table if not exists alquileres (
	id_concepto int primary key,
    transporte varchar(30),
    prerrogado varchar(30),
    financiacion double,
    comprobante varchar(50),
    fecha_reserva date,
    fecha_inicio date,
    fecha_fin date,
    estado_fin varchar(30),
    dias_alquiler int,
    dias_extras int,
    foreign key(id_concepto) references conceptos(id_concepto)
    on delete cascade on update cascade);
    
drop table empresa;
show tables;