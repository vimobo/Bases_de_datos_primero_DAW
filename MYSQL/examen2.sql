Create database examen2;


use examen2;

CREATE TABLE EMPLEADO (
    EMP_ID   VARCHAR(2) PRIMARY KEY,
    DNI      INT UNIQUE NOT NULL,
    NOMBRE   VARCHAR(20),
    NUMHIJOS INT,
    CIUDAD   VARCHAR(30)
);
INSERT INTO EMPLEADO VALUES
('E1', 801, 'Uno',    1, 'Albacete'),
('E2', 802, 'Dos',    2, 'Cuenca'),
('E3', 803, 'Tres',   3, 'Albacete'),
('E4', 804, 'Cuatro', 4, 'Lisboa');

CREATE TABLE DEPARTAMENTO (
    DPTO_ID    VARCHAR(2) PRIMARY KEY,
    NOMBRE     VARCHAR(30),
    ASIGNACION DECIMAL(10,2)
);
INSERT INTO DEPARTAMENTO VALUES
('D1', 'Marketing',          115000),
('D2', 'Facturación',         75000),
('D3', 'Ventas',              65000),
('D4', 'Recursos Humanos',    60000);

CREATE TABLE PERTENECE (
    EMP_ID  VARCHAR(2),
    DPTO_ID VARCHAR(2),
    PRIMARY KEY (EMP_ID, DPTO_ID),
    FOREIGN KEY (EMP_ID) REFERENCES EMPLEADO(EMP_ID),
    FOREIGN KEY (DPTO_ID) REFERENCES DEPARTAMENTO(DPTO_ID)
);

INSERT INTO PERTENECE VALUES
('E1', 'D1'),
('E2', 'D1'),
('E3', 'D3'),
('E4', 'D2');

CREATE TABLE ARTICULOS (
    ART_ID VARCHAR(2) PRIMARY KEY,
    NOMBRE VARCHAR(30),
    COLOR  VARCHAR(20),
    CTD    INT,
    IVA    INT
);
INSERT INTO ARTICULOS VALUES
('A1', 'Impresoras', 'Verde',     150, 12),
('A2', 'Tinta',      'Azul',      380,  6),
('A3', 'Papel',      'Azul',      600,  6),
('A4', 'Bolígrafos', 'Blanco',   1000, 12),
('A5', 'Lápiz',      'Negro',     500, 12),
('A6', 'Proyector',  'Negro',     550, 12),
('A7', 'Portátil',   'Amarillo',  350,  6),
('A8', 'Pantalla',   'Rojo',      375, 12);

CREATE TABLE DPTO_ART (
    DPTO_ID VARCHAR(2),
    ART_ID  VARCHAR(2),
    PRIMARY KEY (DPTO_ID, ART_ID),
    FOREIGN KEY (DPTO_ID) REFERENCES DEPARTAMENTO(DPTO_ID),
    FOREIGN KEY (ART_ID)  REFERENCES ARTICULOS(ART_ID)
);

INSERT INTO DPTO_ART VALUES
('D1', 'A1'),
('D1', 'A2'),
('D2', 'A2'),
('D3', 'A2'),
('D3', 'A3'),
('D3', 'A4'),
('D3', 'A1'),
('D2', 'A3'),
('D1', 'A5'),
('D1', 'A6'),
('D2', 'A7'),
('D3', 'A7');

-- 1 -Obtener el nombre y ciudad de los empleados con más de 2 hijos.

select nombre, numhijos, ciudad from EMPLEADO having NUMHIJOS = 2;

-- 2. Nombre y ciudad de los empleados de Marketing.

select e.nombre, e.ciudad, d.nombre from EMPLEADO e
join PERTENECE p on e.emp_id = p.emp_id
join DEPARTAMENTO d on p.DPTO_ID = d.DPTO_ID
WHERE d.nombre = 'Marketing';

-- 3. Nombre de los artículos que tienen un IVA de un 12 %.

select nombre, iva from ARTICULOS a where IVA = 12;

-- 4. El número de departamentos que usan impresoras

select count(a.nombre)
from ARTICULOS a 
join DPTO_ART u on u.ART_ID = a.ART_ID
join DEPARTAMENTO d on d.DPTO_ID = u.DPTO_ID
WHERE a.nombre = 'Impresoras';

-- 5. Nombre del departamento que tiene la menor asignación.


select count(a.ART_ID) as veces, d.nombre
from ARTICULOS a 
join DPTO_ART u on u.ART_ID = a.ART_ID
join DEPARTAMENTO d on d.DPTO_ID = u.DPTO_ID
group by d.nombre
order by veces asc
limit 1
;

-- 6. El nombre de los artículos cuyo CTD es mayor que la media de los CTD.

select nombre, CTD from ARTICULOS a
where CTD > (select avg(ctd) from ARTICULOS);

-- 7. Nombre departamentos y el número de piezas que usan.

select count(a.nombre) recuento_items, d.nombre
from ARTICULOS a 
right join DPTO_ART u on u.ART_ID = a.ART_ID
right join DEPARTAMENTO d on d.DPTO_ID = u.DPTO_ID
group by d.nombre;


8. SELECT d.nombre AS departamento, COUNT(p.emp) AS
total_empleados FROM departamento d LEFT JOIN pertenece p ON
d.dpto = p.dpto GROUP BY d.dpto, d.nombre;
9. SELECT ciudad, COUNT(*) AS total_empleados FROM empleado
GROUP BY ciudad HAVING COUNT(*) > 1;
10. SELECT d.nombre,a.nombre FROM departamento d JOIN usa u ON
d.dpto=u.dpto RIGHT JOIN articulo a ON a.art = u.art WHERE d.dpto IS
NULL