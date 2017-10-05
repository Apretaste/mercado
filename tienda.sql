CREATE TABLE _tienda_products(
	code varchar(255) NOT NULL PRIMARY KEY,
	name varchar(255) NOT NULL,
	description varchar (1024),
	category varchar (255),
	price float not null,
	shipping_price float not null,
	credits float not null,
	agency varchar(255) not null,
	owner varchar(255) not null,
	active tinyint(1) not null default 0,
	inserted_date timestamp not null default current_timestamp
);

CREATE TABLE _tienda_orders(
	id int(11) auto_increment primary key,
	product varchar(255) not null,
	email varchar(255) not null,
	ci varchar(11),
	name varchar(100),
	inserted_date timestamp not null default current_timestamp,
	address varchar(255),
	province enum('PINAR_DEL_RIO','LA_HABANA','ARTEMISA','MAYABEQUE','MATANZAS','VILLA_CLARA','CIENFUEGOS','SANCTI_SPIRITUS','CIEGO_DE_AVILA','CAMAGUEY','LAS_TUNAS','HOLGUIN','GRANMA','SANTIAGO_DE_CUBA','GUANTANAMO','ISLA_DE_LA_JUVENTUD'),
	phone varchar(20),
	received tinyint(1) not null default 0 
);