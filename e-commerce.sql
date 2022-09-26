-- criação do banco de ddos para o cenário de E-commerce

-- drop database ecommerce;
create database ecommerce;
use ecommerce;

-- criar tabela cliente
create table cliente(
		idClient int auto_increment primary key,
		Fname varchar(10),
		Minit char(3),
		Lname varchar(20),
		CPF char(11) not null,
		Address varchar(30),
		constraint unique_cpf_client unique (CPF)
);

-- criar tabela produto

create table product(
		idProduct int auto_increment primary key,
        Pname varchar(10) not null,
        classification_kids bool default false,
        category enum('Eletrônico', 'Vestuário', 'Brinquedos', 'Alimentos', 'Móveis') not null,
        avaliação float default 0,
        size varchar(10)
);


-- criar tabela pedido
create table orders(
		idOrder int auto_increment primary key,
		idOrderClient int,
		orderStatus enum('Cancelado', 'Confirmado', 'Em processamento') default 'Em processamento',
		orderDescription varchar(255),
		sendValue float default 10,
		paymentCash bool default false,
constraint fk_orders_client foreign key (idOrderClient) references cliente(idclient)
		on update cascade
        
);


-- criar tabela estoque
create table productStorage(
		idProdStorage int auto_increment primary key,
		SocialName varchar (255) not null,
		quantity int default 0
);

-- criar tabela fornecedor
create table supplier(
		idSupplier int auto_increment primary key,
		SocialName varchar (255) not null,
		CNPJ char(15) not null,
		contact char(11) not null,
		constraint unique_supplier unique (CNPJ)
);



-- criar tabela vendedor
create table seller (
		idSeller int auto_increment primary key,
        SocialName varchar(255) not null,
        AbstName varchar(255) not null,
        CNPJ char(15),
        CPF char(9),
        location varchar(255),
        contact char (11) not null,
        constraint unique_cnpj_seller unique (CNPJ),
        constraint unique_cpf_seller unique(CPF)
);

create table productSeller(
idPseller int,
idProduct int,
Quantity int default 1,
primary key (idPseller, idProduct),
constraint fk_product_seller foreign key (idPseller) references seller(idSeller),
constraint fk_product_product foreign key (idProduct) references product(idProduct)
);



create table productOrder(
idPOproduct int,
idPOorder int,
poQuantity int default 1,
poStatus enum('Disponível', 'Sem estoque') default 'Disponível',
primary key (idPOProduct, idPOorder),
constraint fk_productorder_seller foreign key (idPOProduct) references product (idProduct),
constraint fk_productorder_product foreign key (idPOorder) references orders(idOrder)
);

create table storeageLocation(
idLproduct int,
idLstorage int,
location varchar(255) not null,
primary key (idLproduct, idLstorage),
constraint fk_storage_location_product foreign key (idLproduct) references product(idProduct),
constraint fk_storage_location_storage foreign key (idLstorage) references productStorage(idProdStorage)
);

create table productSupplier(
idPsSupplier int,
idPsProduct int,
quantity int not null,
primary key (idPsSupplier, idPsProduct),
constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier(idSupplier),
constraint fk_product_supplier_product foreign key (idPsProduct) references product(idProduct)
);


show tables;

show databases;
use information_schema;
show tables;
desc table_constraints;
desc referential_constraints;
select * from referential_constraints where constraint_schema = 'ecommerce';
