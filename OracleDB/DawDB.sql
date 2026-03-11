create table players (
    playerId int primary key,
    firstName varchar2(100),
    lastName varchar2(100));
    
create table stats (
    playerId int,
    year int,
    ab int,
    hits int,
    hr int,
    rbi int,
    team char(3),
    primary key(playerId,year,team),
    foreign key (playerId) references players(playerId));
    

insert into players values (1,'Barry', 'Bonds');
insert into players values (2,'Hank','Aaron');
insert into players values (3,'Babe','Ruth');
insert into players values (4,'Willie','Mays');
insert into players values (5,'Sammy','Sosa');

insert into stats values (1, 2006, 367, 99, 26, 77, 'sfg');
insert into stats values (1, 2007, 340, 94, 28, 66, 'sfg');
insert into stats values (2, 1954, 468, 131, 13, 69, 'mln');
insert into stats values (2, 1955, 602, 189, 27, 106, 'mln');
insert into stats values (2, 1956, 609, 200, 26, 92, 'mln');

commit;

-- 1.- First, let's look at a query that simply lists data from three selected columns in the STATS table

select playerId, year, team from stats;

-- 2.- Lists only those seasons in which the player had more than 50 home runs


select playerId, year
from stats
group by playerId, year
having sum(hr) > 50;

-- 3.- Sort the query number 2 from high to low. To do that, we need to add an ORDER BY clause

select year, hr from stats
where hr < 50
order by hr asc;

-- 4.- The names from the PLAYERS table and the year and HR count from the STATS table for the 50+ HR subset.




-- 5.- Player's career home run total.

select playerId, sum(hr) as HRTotales
from stats
group by playerId;