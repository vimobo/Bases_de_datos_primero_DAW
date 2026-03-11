create database computer_firm;

use computer_firm;

drop table pc;

create table product (
maker varchar(10),
model varchar(50) primary key,
type varchar(50)
);

create table laptop (
code int primary key,
model varchar(50),
speed smallint,
ram smallint,
hd real,
pice int,
screen tinyint);

create table pc (
code int primary key,
model varchar(50),
speed smallint,
ram smallint,
hd real,
cd varchar(10),
price int);

create table printer (
code int primary key,
model varchar(50),
color char(1),
type varchar(10),
price int);


alter table pc add constraint fk_model_pc 
foreign key (model) references product(model) 
on update cascade
on delete cascade;

alter table laptop add constraint fk_model_laptop
foreign key (model) references product(model)
on update cascade
on delete cascade;

alter table printer add constraint fk_model_printer
foreign key (model) references product(model)
on update cascade
on delete cascade;

insert into printer values
(1,'1276','n','laser',400),
(2,'1433','y','jet',270),
(3,'1434','y','jet',290),
(4,'1401','n','matrix',150),
(5,'1408','n','matrix',270),
(6,'1288','n','laser',400);

insert into product values
('A','1232','PC'),
('A','1233','PC'),
('A','1276','Printer'),
('A','1298','Laptop'),
('A','1401','Printer'),
('A','1408','Printer'),
('A','1752','Laptop'),
('B','1121','PC'),
('B','1750','Laptop'),
('C','1321','Laptop'),
('D','1288','Printer'),
('D','1433','Printer'),
('E','1260','PC'),
('E','1434','Printer'),
('E','2112','PC'),
('E','2113','PC');

insert into pc values
('1','1232',500,64,5.0,'12x',600),
('10','1260',500,32,10.0,'12x',350),
('11','1233',900,128,40.0,'40x',980),
('12','1233',800,128,20.0,'50x',970),
('2','1121',750,128,14.0,'40x',850),
('3','1233',800,64,5.0,'12x',600),
('4','1121',600,128,14.0,'40x',850),
('5','1121',600,128,8.0,'40x',850),
('6','1233',750,128,20.0,'50x',950),
('7','1232',500,32,10.0,'12x',400),
('8','1232',450,64,8.0,'24x',350),
('9','1232',450,32,10.0,'24x',350)
;

insert into laptop values
(1,'1298',350,32,4.0,700,11),
(2,'1321',500,64,8.0,970,12),
(3,'1750',750,128,12.0,1200,14),
(4,'1298',600,64,10.0,1050,15),
(5,'1752',750,128,10.0,1150,14),
(6,'1298',450,64,10.0,950,12)
;


show tables;

select * from laptop 

-- 1
select model, speed, hd from pc where price < 500;


-- 2
select distinct maker from product
inner join printer using(model) ;


-- 3 
select model, ram, screen from laptop where pice > 1000;

-- 4
select model, hd, speed, cd, price from pc where (cd = 12 and price < 600) or (cd = 24 and price < 600);


-- 5
select distinct product.maker, laptop.speed from product 
inner join laptop where hd > 10;

-- 10


-- 11

select avg(pc.speed) from pc
join product 
on pc.model = product.model
where product.maker = 'A';

-- 14

select distinct type, laptop.model, laptop.speed from laptop, product 
where type = 'laptop' and laptop.speed < (select min(speed) from pc);

-- 15


-- 16
select distinct count(model) from product;


select distinct product.maker from product
inner join pc where (select count(distinct model) as cuenta from product);

