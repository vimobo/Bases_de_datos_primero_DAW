create table empleado (
    ncodempl number(3),
    nnumdpt number(3),
    nexttef number(3),
    dfecnac date,
    dfecing date,
    nsalempl number(10,2),
    ncomempl number(5,2),
    nhjempl number(2),
    cnomempl varchar2(30),
    primary key(ncodempl),
    foreign key(nnumdpt) references dptos(nnumdpt));
    

create table dptos (
    nnumdpt number(3),
    nnumcen number(2),
    ndirdpt number(3),
    ctipdir number(10,2),
    npredpt number(10,2),
    ndptjef number(3),
    cnomdpt varchar2(30),
    primary key (nnumdpt),
    foreign key(nnumcen) references centros(nnumcen));
    
    
create table centros (
    nnumcen number(2) primary key,
    cnomcen varchar(30),
    cdircen varchar(30));
    
    select * from empleado;