create table person(
   id    varchar(36)  primary key unique,
   nick  varchar(32)  not null,
   name  varchar(100) not null,
   searchable  longtext not null,
   birth date         not null,
   stack json
);
