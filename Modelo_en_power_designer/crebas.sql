/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     04/07/2013 10:08:40 a.m.                     */
/*==============================================================*/


drop table if exists CLIENTE;

drop table if exists CLIENTE_JURIDICO;

drop table if exists CLIENTE_NATURAL;

drop table if exists COMPROBANTE_DE_PAGO;

drop table if exists COMPROBANTE_DE_PAGO_SERVICIO;

drop table if exists DESCUENTO;

drop table if exists ESTADO_DE_HABITACION;

drop table if exists ESTADO_DE_RESERVA;

drop table if exists HABITACION;

drop table if exists HOTEL;

drop table if exists RESERVA;

drop table if exists RESERVA_HABITACION;

drop table if exists SERVICIO;

drop table if exists TIPO_DE_HABITACION;

drop table if exists USUARIO;

/*==============================================================*/
/* Table: CLIENTE                                               */
/*==============================================================*/
create table CLIENTE
(
   IDCLIENTE            int not null,
   DOCUMENTO            text,
   TELEFONO             text,
   FAX                  text,
   EMAIL                text,
   primary key (IDCLIENTE)
);

/*==============================================================*/
/* Table: CLIENTE_JURIDICO                                      */
/*==============================================================*/
create table CLIENTE_JURIDICO
(
   IDCLIENTE            int not null,
   DOCUMENTO            text,
   TELEFONO             text,
   FAX                  text,
   EMAIL                text,
   NOMBRE               text,
   APELLIDO             text,
   primary key (IDCLIENTE)
);

/*==============================================================*/
/* Table: CLIENTE_NATURAL                                       */
/*==============================================================*/
create table CLIENTE_NATURAL
(
   IDCLIENTE            int not null,
   DOCUMENTO            text,
   TELEFONO             text,
   FAX                  text,
   EMAIL                text,
   RAZONSOCIAL          text,
   primary key (IDCLIENTE)
);

/*==============================================================*/
/* Table: COMPROBANTE_DE_PAGO                                   */
/*==============================================================*/
create table COMPROBANTE_DE_PAGO
(
   IDCOMPROBANTEPAGO    int not null,
   IDDESCUENTO          int,
   IDRESERVA            int not null,
   NUMEROCOMPROBANTE    int,
   TIPOCOMPROBANTE      text,
   SUBTOTAL             decimal,
   IGV                  decimal,
   TOTAL                decimal,
   primary key (IDCOMPROBANTEPAGO)
);

/*==============================================================*/
/* Table: COMPROBANTE_DE_PAGO_SERVICIO                          */
/*==============================================================*/
create table COMPROBANTE_DE_PAGO_SERVICIO
(
   IDCOMPROBANTEPAGO    int not null,
   IDSERVICIO           int not null,
   primary key (IDCOMPROBANTEPAGO, IDSERVICIO)
);

/*==============================================================*/
/* Table: DESCUENTO                                             */
/*==============================================================*/
create table DESCUENTO
(
   IDDESCUENTO          int not null,
   DESCRIPCION          text,
   PORCENTAJE           decimal,
   primary key (IDDESCUENTO)
);

/*==============================================================*/
/* Table: ESTADO_DE_HABITACION                                  */
/*==============================================================*/
create table ESTADO_DE_HABITACION
(
   IDESTADOHABITACION   int not null,
   ESTADO               text,
   primary key (IDESTADOHABITACION)
);

/*==============================================================*/
/* Table: ESTADO_DE_RESERVA                                     */
/*==============================================================*/
create table ESTADO_DE_RESERVA
(
   IDESTADO             int not null,
   ESTADO               text,
   primary key (IDESTADO)
);

/*==============================================================*/
/* Table: HABITACION                                            */
/*==============================================================*/
create table HABITACION
(
   IDHABITACION         int not null,
   IDESTADOHABITACION   int not null,
   IDHOTEL              int not null,
   IDTIPOHABITACION     int not null,
   NUMERO               int,
   DESCRIPCION          text,
   primary key (IDHABITACION)
);

/*==============================================================*/
/* Table: HOTEL                                                 */
/*==============================================================*/
create table HOTEL
(
   IDHOTEL              int not null,
   DESCRIPCION          text,
   DIRECCION            text,
   primary key (IDHOTEL)
);

/*==============================================================*/
/* Table: RESERVA                                               */
/*==============================================================*/
create table RESERVA
(
   IDRESERVA            int not null,
   IDCLIENTE            int not null,
   IDESTADO             int not null,
   FECHALLEGADA         date,
   FECHASALIDA          date,
   primary key (IDRESERVA)
);

/*==============================================================*/
/* Table: RESERVA_HABITACION                                    */
/*==============================================================*/
create table RESERVA_HABITACION
(
   IDRESERVA            int not null,
   IDHABITACION         int not null,
   primary key (IDRESERVA, IDHABITACION)
);

/*==============================================================*/
/* Table: SERVICIO                                              */
/*==============================================================*/
create table SERVICIO
(
   IDSERVICIO           int not null,
   DESCRIPCION          text,
   PRECIO               decimal,
   primary key (IDSERVICIO)
);

/*==============================================================*/
/* Table: TIPO_DE_HABITACION                                    */
/*==============================================================*/
create table TIPO_DE_HABITACION
(
   IDTIPOHABITACION     int not null,
   PRECIO               decimal,
   DESCRIPCION          text,
   primary key (IDTIPOHABITACION)
);

/*==============================================================*/
/* Table: USUARIO                                               */
/*==============================================================*/
create table USUARIO
(
   NOMBRE               text,
   CONTRASENA           text,
   PERMISOS             text,
   IDUSUARIO            int not null,
   primary key (IDUSUARIO)
);

alter table CLIENTE_JURIDICO add constraint FK_INHERITANCE_2 foreign key (IDCLIENTE)
      references CLIENTE (IDCLIENTE) on delete restrict on update restrict;

alter table CLIENTE_NATURAL add constraint FK_INHERITANCE_1 foreign key (IDCLIENTE)
      references CLIENTE (IDCLIENTE) on delete restrict on update restrict;

alter table COMPROBANTE_DE_PAGO add constraint FK_RELATIONSHIP_10 foreign key (IDDESCUENTO)
      references DESCUENTO (IDDESCUENTO) on delete restrict on update restrict;

alter table COMPROBANTE_DE_PAGO add constraint FK_RELATIONSHIP_5 foreign key (IDRESERVA)
      references RESERVA (IDRESERVA) on delete restrict on update restrict;

alter table COMPROBANTE_DE_PAGO_SERVICIO add constraint FK_RELATIONSHIP_8 foreign key (IDCOMPROBANTEPAGO)
      references COMPROBANTE_DE_PAGO (IDCOMPROBANTEPAGO) on delete restrict on update restrict;

alter table COMPROBANTE_DE_PAGO_SERVICIO add constraint FK_RELATIONSHIP_9 foreign key (IDSERVICIO)
      references SERVICIO (IDSERVICIO) on delete restrict on update restrict;

alter table HABITACION add constraint FK_RELATIONSHIP_1 foreign key (IDESTADOHABITACION)
      references ESTADO_DE_HABITACION (IDESTADOHABITACION) on delete restrict on update restrict;

alter table HABITACION add constraint FK_RELATIONSHIP_2 foreign key (IDTIPOHABITACION)
      references TIPO_DE_HABITACION (IDTIPOHABITACION) on delete restrict on update restrict;

alter table HABITACION add constraint FK_RELATIONSHIP_3 foreign key (IDHOTEL)
      references HOTEL (IDHOTEL) on delete restrict on update restrict;

alter table RESERVA add constraint FK_RELATIONSHIP_4 foreign key (IDESTADO)
      references ESTADO_DE_RESERVA (IDESTADO) on delete restrict on update restrict;

alter table RESERVA add constraint FK_RELATIONSHIP_7 foreign key (IDCLIENTE)
      references CLIENTE (IDCLIENTE) on delete restrict on update restrict;

alter table RESERVA_HABITACION add constraint FK_RELATIONSHIP_11 foreign key (IDRESERVA)
      references RESERVA (IDRESERVA) on delete restrict on update restrict;

alter table RESERVA_HABITACION add constraint FK_RELATIONSHIP_12 foreign key (IDHABITACION)
      references HABITACION (IDHABITACION) on delete restrict on update restrict;

