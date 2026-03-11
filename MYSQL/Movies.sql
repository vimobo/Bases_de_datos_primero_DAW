create database Movies;

use Movies;

create table if not exists Movies (
	Code int primary key,
	Title varchar(24),
    Rating varchar(25));
    
drop table MovieTheatres;    

create table MovieTheaters (
	Code int primary key,
    Name varchar(25),
    Movie varchar(25));
    
    
INSERT INTO Movies(Code,Title,Rating) VALUES(9,'Citizen King','G');
INSERT INTO Movies(Code,Title,Rating) VALUES(1,'Citizen Kane','PG');
INSERT INTO Movies(Code,Title,Rating) VALUES(2,'Singin'' in the Rain','G');
INSERT INTO Movies(Code,Title,Rating) VALUES(3,'The Wizard of Oz','G');
INSERT INTO Movies(Code,Title,Rating) VALUES(4,'The Quiet Man',NULL);
INSERT INTO Movies(Code,Title,Rating) VALUES(5,'North by Northwest',NULL);
INSERT INTO Movies(Code,Title,Rating) VALUES(6,'The Last Tango in Paris','NC-17');
INSERT INTO Movies(Code,Title,Rating) VALUES(7,'Some Like it Hot','PG-13');
INSERT INTO Movies(Code,Title,Rating) VALUES(8,'A Night at the Opera',NULL);
    
INSERT INTO MovieTheaters(Code,Name,Movie) VALUES(1,'Odeon',5);
INSERT INTO MovieTheaters(Code,Name,Movie) VALUES(2,'Imperial',1);
INSERT INTO MovieTheaters(Code,Name,Movie) VALUES(3,'Majestic',NULL);
INSERT INTO MovieTheaters(Code,Name,Movie) VALUES(4,'Royale',6);
INSERT INTO MovieTheaters(Code,Name,Movie) VALUES(5,'Paraiso',3);
INSERT INTO MovieTheaters(Code,Name,Movie) VALUES(6,'Nickelodeon',NULL);

-- 1.Select the title of all movies.

select Title from Movies;


-- 2.Show all the distinct ratings in the database.

select distinct Rating from Movies where Rating is not null;

-- 3.Show all unrated movies.

select * from Movies where Rating is null;

-- 4.Select all movie theaters that are not currently showing a movie.

select t.code, t.Name from MovieTheaters t
-- group by t.code, t.name
where t.movie is null;


-- 5.Select all data from all movie theaters and, additionally, the data from the movie
-- that is being shown in the theater (if one is being shown).

select * from MovieTheaters t
join Movies m on m.code = t.code
group by t.name, t.code;

-- 6.Select all data from all movies and, if that movie is being shown in a theater,
-- show the data from the theater.
select * from Movies m
left join MovieTheaters t on t.movie = m.code 
group by m.code, t.code;

-- 7.Show the titles of movies not currently being shown in any theaters.
select Title, t.Name from Movies m
left join MovieTheaters t on t.movie = m.code 
where t.movie is not null;

-- 8.Add the unrated movie "One, Two, Three".

insert into Movies(Code,Title,Rating) values (10, 'One, Two, Three', null );

-- 9.Set the rating of all unrated movies to "G".

update Movies set Rating = 'G' where Rating is null;

-- 10.Remove movie theaters projecting movies rated "NC-17".
delete from Movies where Rating = 'NC-17';