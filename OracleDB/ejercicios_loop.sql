SET SERVEROUTPUT ON;
DECLARE
    numero int := &introduce;
BEGIN
    if mod(numero,2) == 0 then
        dbms_output.put_line('||numero|| es primo');
    else
        dbms_output.put_line('||numero|| no es primo');

END;



-- 2

declare 
    i int := 1;
begin
    
    while i < 101 loop
        dbms_output.put_line(i);
        i:=i+1;
    end loop;
end;

-- 3

declare 
    i int := 100;
begin
    
    while i > 0 loop
        dbms_output.put_line(i);
        i:=i-1;
    end loop;
end;

-- 4

declare 
    i int := 1;
begin
    
    while i < 101 loop
        if mod(i,2) = 0 then
            dbms_output.put_line(i);
        end if;
        i:=i+1;
    end loop;
end;

-- 5

declare 
    i int := 1;
begin
    
    while i < 101 loop
        if mod(i,2) = 1 then
            dbms_output.put_line(i);
        end if;
        i:=i+1;
    end loop;
end;

-- 6

declare 
    i int := 1;
    suma int :=0;
begin
    while i < 101 loop
        suma := suma + i;
        i := i+1;
    end loop;
    dbms_output.put_line('suma total: ' ||suma);
end;

-- 7

declare
    i int := 1;
    suma int := 0;
begin
    while i < 101 loop
        if mod(i, 2) = 0 then
            suma := suma + i;   
        end if;
        i := i + 1;
    end loop;
    dbms_output.put_line('suma total: ' ||suma);
end;

-- 8

declare
    i int := 1;
    suma int := 0;
begin
    while i < 101 loop
        if mod(i, 2) = 1 then
            suma := suma + i;   
        end if;
        i := i + 1;
    end loop;
    dbms_output.put_line('suma total: ' ||suma);
end;

-- 9

declare
    i int := 1;
    suma int := 0;
    cuenta int := 0;
begin
    while i < 101 loop
        if mod(i, 2) = 0 then
            suma := suma + i;   
            cuenta := cuenta +1;
        end if;
        i := i + 1;

    end loop;
    dbms_output.put_line('suma total: ' ||suma);
    dbms_output.put_line('cuenta ' || cuenta );
end;

-- 10

-- 11

declare
    x int:= &x;
    y int := &y;
    z int:= 0;
    
begin
    if x > y then
        z := x;
        x := y;
        y := z;
    end if;
    
    while x <= y loop

        dbms_output.put_line(x);
        x := x+1;
    end loop;
end;

-- 12
        
declare
    x int:= &x;
    y int := &y;
    z int:= 0;
begin

    if x > y then
        z := x;
        x := y;
        y := z;
    end if;
    
    while x <= y loop
        if mod(x, 2) = 0 then
            dbms_output.put_line(x);
        end if;
        x := x+1;
    end loop;
end;
      
      
-- 13

declare
    x int:= &x;
    y int := &y;
    z int:= 0;
    suma int:= 0;
begin

    if x > y then
        z := x;
        x := y;
        y := z;
    end if;
    
    while x <= y loop
        if mod(x, 2) = 0 then
            dbms_output.put_line(x);
            suma := x +suma;
        end if;
        x := x+1;
    end loop;
    dbms_output.put_line('suma: ' || suma);

end;
 
