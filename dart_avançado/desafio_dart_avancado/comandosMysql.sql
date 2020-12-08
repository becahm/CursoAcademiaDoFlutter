create database desafio_dart_avancado;

create table estado (
    id int not null primary key auto_increment,
    nome varchar(200)
);

create table cidade (
    id int not null primary key auto_increment,
    nome varchar(200)
);

create table estado_cidade(
    estado_id int,
    cidade_id int,
    foreign key (estado_id) references estado(id),
    foreign key (cidade_id) references cidade(id)
);

select * from estado;
select * from cidade;
select * from estado_cidade;

select e.nome, c.nome from estado e
inner join estado_cidade ec on ec.estado_id = e.id
inner join cidade c on ec.cidade_id = c.id