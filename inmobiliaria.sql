create database inmobiliaria; 
use inmobiliaria;


-- ZONA
CREATE TABLE zona (
    id_zona INT NOT NULL AUTO_INCREMENT,
    nombre_zona VARCHAR(50) NOT NULL,
    id_ciudad INT NOT NULL, -- Agrega la columna id_ciudad
    PRIMARY KEY (id_zona),
    CONSTRAINT fk_id_ciudad FOREIGN KEY (id_ciudad) REFERENCES ciudad(id_ciudad) -- Ajusta la referencia a la columna correcta de la tabla "ciudad"
);

-- CIUDAD 
create table ciudad(
id_ciudad int not null auto_increment,
nombre_ciudad varchar(50) not null,
primary key(id_ciudad)
);


-- OFICINA
create table oficina(
id_oficina int not null auto_increment,
hay_llave boolean not null,
primary key(id_oficina),
id_zona int not null,
constraint id_zona foreign key (id_zona) references zona(id_zona)
);


-- TIPO INMUEBLE
create table tipo_inmueble(
id_tipo_inmueble int not null auto_increment,
diafono boolean not null,
acondicionado boolean not null,
puertas_entrada int not null,
puerta_blindada boolean not null,
gas_ciudad  boolean not null,
urbanizacion varchar(100) not null,
tamaño_parcela varchar(1000) not null,
primary key(id_tipo_inmueble)
);


-- ESTANCIA
create table estancia(
id_estancia int not null auto_increment,
nombre_estancia varchar(100) not null,  -- CAMBIAR "NOMBRE" A "NOMBRE_ESTANCIA" EN MODELO ENTIDAD RELACION
cantidad int not null,
id_tipo_inmueble int not null,
primary key (id_estancia),
constraint fk_id_tipo_inmueble foreign key (id_tipo_inmueble) references tipo_inmueble(id_tipo_inmueble)
);


-- INMUEBLE
create table inmueble(
id_inmueble int not null auto_increment,
referencia varchar(50) not null,
precio float not null, -- cambiar a float
superficie float not null,
direccion varchar(100),
id_oficina int not null,
id_tipo_inmueble int not null,
primary key(id_inmueble, id_oficina, id_tipo_inmueble),
constraint fk_inmuble_oficina foreign key (id_oficina) references oficina(id_oficina),
constraint fk_tipo_inmueble foreign key (id_tipo_inmueble) references tipo_inmueble(id_tipo_inmueble)
);


-- PROPIETARIO
create table propietario(
id_propietario int not null auto_increment,  
nombre_propietario varchar(50) not null,     -- CAMBIAR "NOMBRE" A "NOMBRE_PROPIETARIO" EN MODELO ENTIDAD RELACION
telefono int not null,
primary key(id_propietario)
);


-- TRANSACCION
create table transaccion(
id_transaccion int not null auto_increment,
tipo_transaccion varchar(100),
id_inmueble int not null,
id_propietario int not null,
primary key(id_transaccion),
constraint fk_id_inmueble foreign key (id_inmueble) references inmueble(id_inmueble),
constraint fk_propietario foreign key (id_propietario) references propietario(id_propietario)
);


-- CLIENTE
create table cliente(
id_cliente int not null auto_increment,
nombre_cliente varchar(50) not null,
telefono int not null,
primary key (id_cliente)
);

ALTER TABLE cliente
CHANGE COLUMN telefono telefono int not null;

-- VISITA
create table visita(
id_visita int not null auto_increment,
fecha date not null,
hora time not null,
comentario varchar(200) not null,
id_inmueble int not null,
id_cliente int not null,
primary key (id_visita),
constraint fk_idinmueble foreign key (id_inmueble) references inmueble(id_inmueble), -- Para no dupplicar el nombre de la llave foranea se puso "fk_idinmueble"
constraint fk_id_cliente foreign key (id_cliente) references cliente(id_cliente)
);

select * from USER;
USE inmobiliaria;
select current_user();
create user 'administrador'@'%' identified by 'admin';
GRANT ALL PRIVILEGES ON * . * TO 'administrador'@'%';
flush privileges;

create user 'agente_inmobiliario'@'%' identified by 'agente';
grant insert, select on inmobiliaria .tipo_inmueble to 'agente_inmobiliario';
grant insert, select on inmobiliaria .inmueble to 'agente_inmobiliario';
grant insert, select on inmobiliaria .estancia to 'agente_inmobiliario';
grant insert, select on inmobiliaria .propietario to 'agente_inmobiliario';
grant insert, select on inmobiliaria .ciudad to 'agente_inmobiliario';
grant insert, select on inmobiliaria .zona to 'agente_inmobiliario';
flush privileges;

create user 'gerente'@'%' identified by 'gerent';
grant insert, update, delete on * . * to 'gerente';
flush privileges;

create user 'backup'@'%' identified by 'back';
GRANT SELECT, SHOW VIEW, LOCK TABLES, RELOAD, FILE ON *.* TO 'backup'@'%';
flush privileges;

create user 'restore'@'%' identified by 'res';
GRANT SELECT, INSERT, DELETE, CREATE, DROP, FILE ON *.* TO 'restore'@'%';
flush privileges;