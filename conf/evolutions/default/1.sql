# --- Created by Ebean DDL
# To stop Ebean DDL generation, remove this comment and start using Evolutions

# --- !Ups

create table team (
  id                        bigint not null,
  name                      varchar(255),
  description               varchar(255),
  constraint pk_team primary key (id))
;

create table user (
  id                        bigint not null,
  name                      varchar(255),
  email                     varchar(255),
  constraint pk_user primary key (id))
;


create table team_user (
  team_id                        bigint not null,
  user_id                        bigint not null,
  constraint pk_team_user primary key (team_id, user_id))
;
create sequence team_seq;

create sequence user_seq;




alter table team_user add constraint fk_team_user_team_01 foreign key (team_id) references team (id) on delete restrict on update restrict;

alter table team_user add constraint fk_team_user_user_02 foreign key (user_id) references user (id) on delete restrict on update restrict;

# --- !Downs

SET REFERENTIAL_INTEGRITY FALSE;

drop table if exists team;

drop table if exists team_user;

drop table if exists user;

SET REFERENTIAL_INTEGRITY TRUE;

drop sequence if exists team_seq;

drop sequence if exists user_seq;

