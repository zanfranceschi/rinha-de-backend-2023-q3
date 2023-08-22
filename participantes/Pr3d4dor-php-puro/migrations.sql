create table people (
    uuid char(36) not null,
    nickname varchar(32) not null,
    name varchar(100) not null,
    date_of_birth date not null,
    stack varchar(1024) null
);
