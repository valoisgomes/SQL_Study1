-- criação de banco de dados para e-commerce trabalho DIO --

create database ecommerce;
use ecommerce;

-- criando as tabelas do projeto --

-- tabela cliente --

create table clients(
	idClient int auto_increment  primary key,
    FristName varchar(10),
    Mname varchar(3),
    LastName varchar(10),
    CPF char(11) not null,
    Address varchar(30),
    Brithday date,
    constraint unique_cpf_client unique(CPF)    
);

-- tabela produto -- 

-- size é o que vale a dimenção do produto --
create table product(
	idProduct int auto_increment primary key,
    Pname varchar(20) not null,
    Classification_kids boolean default false,
    category enum('Eletrônico', 'Roupas', 'Alimentos', 'Calçados', 'Brinquedos') not null,
    assessement float default 0,
    size varchar(10)
);

-- tabela pagamentos -- 

create table payments(
	idPayments int auto_increment primary key,
    idpaymentsClient int,
    paymentsType enum('Boleto', 'Pix', 'Débito', 'Crédito'),
    constraint fk_payments_client foreign key (idpaymentsClient) references clients(idClient)
);

-- tabela pedido --

create table orders(
	idOrders int auto_increment primary key,
    idOrdersClient int,
    ordersStatus enum('Cancelado', 'Confirmado', 'Em Processamento') default 'Em Processamento',
    ordersDescription varchar(255),
    shipping float default 10,
    idOrdersPayments int,
    constraint fk_orders_payments foreign key (idOrdersPayments) references payments(idPayments),
    constraint fk_orders_client foreign key (idOrdersClient) references clients(idClient)
);

-- tabela estoque --

create table productStorage(
	idProdStorage int auto_increment primary key,
    storageLocation varchar(255),
    quantity int default 0
);

-- tabela fornecedor --

create table supplier(
	idSupplier int auto_increment primary key,
    SocialName varchar(255) not null, 
    CNPJ char(15) not null,
    contact char(11) not null,
    constraint unique_supplier unique(CNPJ)
);

-- tabela vendedor --

create table saller(
	idSaller int auto_increment primary key,
    SocialName varchar(255) not null,
    abstractName varchar(255),
    CNPJ char(15),
    CPF char(11),
    contact char(11) not null,
    constraint unique_cnpj_saller unique(CNPJ),
    constraint unique_cpf_saller unique(CPF)
);


create table productSaller(
	idPsaller int,
    idProduct int,
    prodQuantity int default 1,
    primary key (idPsaller, idProduct),
    constraint fk_product_saller foreign key (idPsaller) references saller(idSaller),
    constraint fk_product_product foreign key (idProduct) references product(idProduct)
);

create table productOrder(
	idPOproduct int,
    idPOorder int,
    poQuantity int default 1,
    poStatus enum('Disponivel', 'Sem Estoque') default 'Disponivel',
    primary key (idPOproduct, idPOorder),
    constraint fk_product_order_saller foreign key (idPOproduct) references product(idProduct),
    constraint fk_product_order_product foreign key (idPOorder) references orders(idOrders)
);

create table storageLocation(
	idLproduct int,
    idLstorage int,
    location varchar(255) not null,
    primary key (idLproduct, idLstorage),
    constraint fk_storege_location_product foreign key (idLproduct) references product(idProduct),
    constraint fk_storage_location_storage foreign key (idLstorage) references productStorage(idProdStorage)
);

create table productSupplier(
	idPsSupplier int,
    idPsProduct int,
    quantity varchar(255) not null,
    primary key (idPsSupplier, idPsProduct),
    constraint fk_product_supplier_product foreign key (idPsProduct) references product(idProduct),
    constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier(idSupplier)
);
