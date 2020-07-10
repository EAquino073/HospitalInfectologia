create database DBHospitalInfectologia2018073;
use DBHospitalInfectologia2018073;
-- drop database DBHospitalInfectologia2018073;

create table Medicos( 
	codigoMedico int auto_increment not null,
    licenciaMedica int not null,
    nombres varchar(100) not null,
    apellidos varchar(100) not null,
    horaEntrada datetime not null,
    horaSalida datetime not null,
    turnoMaximo int not null default 0,
    sexo varchar(20) not null,
    primary key pk_codigoMedico (codigoMedico)
);

create table Especialidades(
	codigoEspecialidad int auto_increment not null,
    nombreEspecialidad varchar(45) not null,
    primary key pk_codigoEspecialidad (codigoEspecialidad)
);

create table Horarios( 
	codigoHorario int auto_increment not null,
    horarioInicio datetime not null,
    horarioSalida datetime not null,
    lunes tinyint,
    martes tinyint,
    miercoles tinyint,
    jueves tinyint,
    viernes tinyint,
    primary key pk_codigoHorario (codigoHorario)
);

create table Areas(
	codigoArea int auto_increment not null,
    nombreArea varchar(45) not null,
    primary key pk_codigoArea (codigoArea)
);

create table MedicoEspecialidad(
	codigoMedicoEspecialidad int auto_increment not null,
    codigoMedico int not null,
    codigoEspecialidad int not null,
    codigoHorario int not null,
    primary key pk_codigoMedicoEspecialidad (codigoMedicoEspecialidad),
    foreign key (codigoMedico) references Medicos(codigoMedico),
    foreign key (codigoEspecialidad) references Especialidades(codigoEspecialidad),
    foreign key (codigoHorario) references Horarios(codigoHorario)
);

create table Cargos(
	codigoCargo int auto_increment not null,
    nombreCargo varchar(45) not null,
    primary key pk_codigoCargo (codigoCargo)
);

create table ResponsableTurno(
	codigoResponsableTurno int auto_increment not null,
    nombreResponsable varchar(75) not null,
    apellidoResponsable varchar(45) not null,
    telefonoPersonal varchar(10) not null,
    codigoArea int not null,
    codigoCargo int not null,
    primary key pk_codigoResponsableTurno (codigoResponsableTurno),
    foreign key (codigoArea) references Areas(codigoArea),
    foreign key (codigoCargo) references cargos(codigoCargo)
);

create table Pacientes(
	codigoPaciente int auto_increment not null,
    DPI varchar(20) not null,
    apellidos varchar(100) not null,
    nombres varchar(100) not null,
    fechaNacimiento date not null,
    edad int,
    direccion varchar(150) not null,
    ocupacion varchar(50) not null,
    sexo varchar(15),
    primary key pk_codigoPaciente (codigoPaciente)
);

create table Turno(
	codigoTurno int auto_increment not null,
    fechaTurno date not null,
    fechaCita date not null,
    valorCita decimal(10,2) not null,
    codigoMedicoEspecialidad int not null,
    codigoTurnoResponsable int not null,
	codigoPaciente int not null,
    primary key pk_codigoTurno (codigoTurno),
    foreign key (codigoMedicoEspecialidad) references MedicoEspecialidad(codigoMedicoEspecialidad),
    foreign key (codigoTurnoResponsable) references ResponsableTurno(codigoResponsableTurno),
    foreign key (codigoPaciente) references Pacientes(codigoPaciente)
);

create table ContactoUrgencia(
	codigoContactoUrgencia int auto_increment not null,
    nombres varchar(100) not null,
    apellido varchar(100) not null,
    numeroContacto int not null,
    codigoPaciente int not null,
    primary key pk_codigoContactoUrgencia (codigoContactoUrgencia),
    foreign key (codigoPaciente) references Pacientes(codigoPaciente)
);

create table TelefonosMedicos(
	codigoTelefonoMedico int auto_increment not null,
    telefonoPersonal varchar(15) not null,
    telefonoTrabajo varchar(15) not null,
    codigoMedico int not null,
    primary key pk_codigoTelefonoMedico (codigoTelefonoMedico),
    foreign key (codigoMedico) references Medicos(codigoMedico)
);

-- ---------------------------------------------------------MEDICOS-------------------------------------------------------------
DELIMITER $$
create procedure sp_addMedicos (in licenciaMedica int, in nombres varchar(100), in apellidos varchar(100), in horaEntrada datetime, in horaSalida datetime, in sexo varchar(20))
begin
	insert into Medicos(licenciaMedica ,nombres,apellidos,horaEntrada,horaSalida,sexo)
    values (licenciaMedica,nombres,apellidos,horaEntrada,horaSalida,sexo);
end $$

call sp_addMedicos (11925,"edwin gustavo","aquino matute","2019-05-15 09:00","2019-05-15 16:00","hombre");
call sp_addMedicos (27894,"jason ottoniel","Gatica flores","2019-05-15 09:00","2019-05-15 16:00","hombre");

DELIMITER $$
create procedure sp_Buscar_Medicos (p_codigoMedico int)
begin
	select codigoMedico,licenciaMedica,nombres,apellidos,horaEntrada,horaSalida,turnoMaximo,sexo from Medicos
    where codigoMedico = p_codigoMedico;
end $$

call sp_Buscar_Medicos (1);

DELIMITER $$   
 create  procedure sp_ModificarMedicos(p_codigoMedico int,p_licenciaMedica int,p_nombres varchar(100),p_apellidos varchar(100),p_horaEntrada datetime, p_horaSalida datetime, p_sexo varchar(100))
 
 begin
	update Medicos
    set licenciaMedica = p_licenciaMedica, nombres = p_nombres, apellidos = p_apellidos, horaEntrada = p_horaEntrada, horaSalida = p_horaSalida, sexo = p_sexo
    where codigoMedico = p_codigoMedico;
		
 end $$
 
call sp_ModificarMedicos(1,11458,"Paco Daniel","Lopez Cabrera","2018-05-15 12:02","2018-05-15 19:06",1,"hombre");

DELIMITER $$   
 create  procedure sp_EliminarMedicos(p_codigoMedico int)
 
 begin
	
	delete from Medicos where codigoMedico = p_codigoMedico;
	
 end $$
call sp_EliminarMedicos(2);

DELIMITER $$    
create  procedure sp_ListarMedicos()   
Begin
	
    select codigoMedico,licenciaMedica,nombres,apellidos,horaEntrada,horaSalida,turnoMaximo,sexo 
    from Medicos;
    
end $$

call sp_ListarMedicos();

-- --------------------------------------------------------ESPECIALIDADES----------------------------------------------------
DELIMITER $$
create procedure sp_AgregarEspecialidades (p_nombreEspecialidad varchar(45))
begin
	insert into Especialidades (nombreEspecialidad)
    values (p_nombreEspecialidad);
end $$
DELIMITER ;

DELIMITER $$
create procedure sp_EliminarEspecialidades (p_codigoEspecialidad int)
begin
	delete from Especialidades 
    where codigoEspecialidad = p_codigoEspecialidad;
end $$
DELIMITER ;

DELIMITER $$
create procedure sp_ModificarEspecialidades (p_codigoEspecialidad int, nombreEspecialidad varchar(45))
begin
	update Especialidades
    set nombreEspecialidad = p_nombreEspecialidad
    where codigoEspecialidad = p_codigoEspecialidad;
end $$
DELIMITER ;

DELIMITER $$    
create  procedure sp_ListarEspecialidades()   
Begin
	
    select codigoEspecialidad, nombreEspecialidad
    from Especialidades;
    
end $$
DELIMITER ;

DELIMITER $$
create procedure sp_Buscar_Especialidades (p_codigoEspecialidad int)
begin
	select codigoEspecialidad, nombreEspecialidad from Especialidades
    where codigoEspecialidad = p_codigoEspecialidad;
end $$
DELIMITER ;

-- ----------------------------------------------HORARIOS----------------------------------------------
DELIMITER $$
	create procedure sp_AgregarHorarios(p_horarioInicio datetime, p_horarioSalida datetime, p_lunes tinyint, p_martes tinyint, p_miercoles tinyint, p_jueves tinyint, p_viernes tinyint)
BEGIN
	insert into Horarios(horarioInicio, horarioSalida, lunes, martes, miercoles, jueves, viernes)
		values (p_horarioInicio, p_horarioSalida, p_lunes, p_martes, p_miercoles, p_jueves, p_viernes);
END $$
DELIMITER ;

DELIMITER $$
	create procedure sp_ModficarHorarios(p_codigoHorario int, p_horarioInicio datetime, p_horarioSalida datetime, p_lunes tinyint,p_martes tinyint, p_miercoles tinyint, p_jueves tinyint, p_viernes tinyint)
BEGIN
	update Horarios
		set horarioInicio = p_horarioInicio, horarioSalida = p_horarioSalida, lunes = p_lunes,martes = p_martes, miercoles = p_miercoles,jueves = p_jueves, viernes = p_viernes
		where codigoHorario = p_codigoHorario;
END $$
DELIMITER ;

DELIMITER $$
create procedure sp_BucarHorarios(p_codigoHorario int)
BEGIN 
	Select  * from Horarios
		where codigoHorario = p_codigoHorario;
END $$	
DELIMITER ;

DELIMITER $$
create procedure sp_ListarHorarios()
BEGIN
	select * from Horarios;
END $$
DELIMITER ;

-- ---------------------------------------------------AREAS----------------------------------------------------------
DELIMITER $$
create procedure sp_AgregarAreas(p_nombreArea varchar(50))
BEGIN
	insert into Areas(nombreArea)
		values(p_nombreArea);
END $$
DELIMITER ;

DELIMITER $$
	create procedure sp_ModificarAreas(p_codigoArea int, p_nombreArea varchar(50))
BEGIN
	update Areas
		set nombreArea = p_nombreArea
		where codigoArea = p_codigoArea;
END $$
DELIMITER ;

DELIMITER $$
	create procedure sp_EliminarAreas(p_codigoArea int)
BEGIN
	delete from Areas where codigoArea = p_codigoArea;
END $$
DELIMITER ;

DELIMITER $$
	create procedure sp_BuscarAreas(p_codigoArea int)
BEGIN
	select * from Areas  
    where codigoArea = p_codigoArea;
END $$
DELIMITER ;

DELIMITER $$
	create procedure sp_ListarAreas()
BEGIN
	select * from Areas;
END $$
DELIMITER ;
-- ---------------------------------------------MEDICOESPECIALIDAD---------------------------------------------------
DELIMITER $$
	create procedure sp_AgreagarMedicoEspecialida(p_codigoMedico int, p_codigoEspecialidad int,  p_codigoHorario int, p_Especialidad_codigoEspecialidad int, p_Horarios_codigoHorario int, p_Medicos_codigoMedico int)
BEGIN
	insert into Medico_Especialidad(codigoMedico, codigoEspecialidad, codigoHorario, Especialidad_codigoEspecialidad, Horarios_codigoHorario, Medicos_codigoMedico)
		values (p_codigoMedico, p_codigoEspecialidad, p_codigoHorario, p_Especialidad_codigoEspecialidad, p_Horarios_codigoHorario, p_Medicos_codigoMedico);
END $$
DELIMITER ;

DELIMITER $$
	create procedure sp_ModificarrMedicoEspecialida(p_codigoMedicoEspecialidad int, p_codigoMedico int, p_codigoEspecialidad int,  p_codigoHorario int, p_Especialidad_codigoEspecialidad int, p_Horarios_codigoHorario int, p_Medicos_codigoMedico int)
BEGIN
	update Medico_Especialidad
		set codigoMedico = p_codigoMedico, codigoEspecialidad = p_codigoEspecialidad, codigoHorario = p_codigoHorario, Especialidad_codigoEspecialidad = p_Especialidad_codigoEspecialidad,Horarios_codigoHorario = p_Horarios_codigoHorario, Medicos_codigoMedico = p_Medicos_codigoMedico
	    where codigoMedicoEspecialidad = p_codigoMedicoEspecialidad;
END $$
DELIMITER ;

DELIMITER $$
create procedure sp_EliminarMedicoEspecialidad(p_codigoMedicoEspecialidad int)
BEGIN
	delete from Medico_Especialidad
	where codigoMedicoEspecialidad = p_codigoMedicoEspecialidad;
END $$
DELIMITER ;

DELIMITER $$
create procedure sp_ListarMedicoEspecialidad()
BEGIN
	select * from Medico_Especialidad;
END $$
DELIMITER ;

DELIMITER $$
create procedure sp_BuscarMedicoEspecialidad(p_codigoMedicoEspecialidad int)
BEGIN
	select * from Medico_Especialidad
	where codigoMedicoEspecialidad = p_codigoMedicoEspecialidad;
END $$
DELIMITER ;
-- --------------------------------------------CARGOS----------------------------------------------------------------
DELIMITER $$
create procedure sp_AgregarCargos(p_nombreCargo varchar (50))
BEGIN
	insert into Cargos(nombreCargo)
		values (p_nombreCargo);
END $$
DELIMITER ;

DELIMITER $$
	create procedure sp_ModificarCargos(p_codigoCargo int, p_nombreCargo varchar (50))
BEGIN 
	update Cargos
		set nombreCargo = p_nombreCargo
		where codigoCargo = p_codigoCargo;
END $$
DELIMITER ;

DELIMITER $$
	create procedure sp_EliminarCargos(p_codigoCargo int)
BEGIN
	delete from Cargos
		where codigoCargo = p_codigoCargo;
END $$
DELIMITER ;

DELIMITER $$
create procedure sp_ListarCargos()
BEGIN
	select * from Cargos;
END $$
DELIMITER ;

DELIMITER $$
create procedure sp_BuscarCargos(p_codigoCargo int)
BEGIN
	select * from Cargos
		where codigoCargo = p_codigoCargo;
END $$
DELIMITER ;
-- ------------------------------------------RESPONSABLETURNO--------------------------------------------------------
DELIMITER $$
create procedure sp_AgregarResponsableTurno(p_nombreResponsable varchar(50), p_apellidoResponsable varchar(50), p_telefonResponsable varchar (10), p_codigoArea int, p_codigoCargo int, p_Areas_codigoArea int, p_Cargos_codigoCargo int)
BEGIN
	insert into ResponsabelTurno(nombreResponsable, apellidoResponsable, telefonResponsable, codigoArea, codigoCargo, Areas_codigoArea, Cargos_codigoCargo)
		values (p_nombreResponsable, p_apellidoResponsable, p_telefonResponsable, p_codigoArea, p_codigoCargo, p_Areas_codigoArea, p_Cargos_codigoCargo);
END $$
DELIMITER ;

DELIMITER $$
create procedure sp_ModificarResponsableTurno(p_codigoResponsableTurno int, p_nombreResponsable varchar(50), p_apellidoResponsable varchar(50), p_telefonResponsable varchar (10), p_codigoArea int, p_codigoCargo int, p_Areas_codigoArea int, p_Cargos_codigoCargo int)
BEGIN
	update ResponsabelTurno
		set nombreResponsable = p_nombreResponsable, llidoResponsable = p_apellidoResponsable, efonResponsable = p_telefonResponsable, codigoArea = p_codigoArea,
        codigoCargo = p_codigoCargo, Areas_codigoArea = p_Areas_codigoArea,Cargos_codigoCargo = p_Cargos_codigoCargo
		where codigoResponsableTurno = p_codigoResponsableTurno;
END $$
DELIMITER ;

DELIMITER $$
create procedure sp_EliminarResponsableTurno(p_codigoResponsableTurno int)
BEGIN
	delete from ResponsabelTurno
		where codigoResponsableTurno = p_codigoResponsableTurno;
END $$
DELIMITER ;

DELIMITER $$
create procedure sp_ListarResponsableTurno()
BEGIN
	select * from ResponsabelTurno;
END $$
DELIMITER ;

DELIMITER $$
create procedure sp_BuscarResponsableTurno(p_codigoResponsableTurno int)
BEGIN
	select * from ResponsabelTurno
		where codigoResponsableTurno = p_codigoResponsableTurno;
END $$
DELIMITER ;

-- -------------------------------------------PACIENTES-------------------------------------------------------------
DELIMITER $$
	create procedure sp_AgregarPacientes(p_DPI varchar(20), p_nombres varchar (50), p_apellidos varchar (50), p_fechaNacimiento date, p_edad int, p_direccion varchar(150),  p_ocupacion varchar(50), p_sexo varchar(15))
BEGIN
	insert into Pacientes(DPI, nombres, apellidos, fechaNacimiento, edad, direccion, ocupacion, sexo)
		values (p_DPI, p_nombre, p_apellido, p_fechaNacimiento, p_edad, p_direccion, p_ocupacion, p_sexo);
END $$
DELIMITER ;

DELIMITER $$
	create procedure sp_ModificarPacientes(p_codigoPaciente int, p_DPI varchar(20), p_nombres varchar (100), p_apellidos varchar (100), p_fechaNacimiento date, p_edad int,p_direccion varchar(150),  p_ocupacion varchar(50), p_sexo varchar(15))
BEGIN
	update Pacientes
		set DPI = p_DPI,nombres = p_nombres,apellidos = p_apellidos, direccion = p_direccion, ocupacion = p_ocupacion, sexo = p_sexo
		where codigoPaciente = p_codigoPaciente;
END $$
DELIMITER ;

DELIMITER $$
create procedure sp_EliminarPacientes(p_codigoPaciente int)
BEGIN 
	delete from Pacientes 
		where codigoPaciente = p_codigoPaciente;
END $$
DELIMITER ;

DELIMITER $$
create procedure sp_BucarPacientes(p_codigoPaciente int)
BEGIN 
	Select  * from Pacientes
		where codigoPaciente = p_codigoPaciente;																			
END $$	
DELIMITER ;

DELIMITER $$
create procedure sp_ListarPacientes()
BEGIN
	select * from Pacientes;
END $$
DELIMITER ;
-- --------------------------------------------TURNO-----------------------------------------------------------------
DELIMITER $$
create procedure sp_AgregarTurno(p_fechaTurno date, p_fecharCita date, p_valorCita decimal(10,2), p_codigoMedicoEspecialidad int, p_codResponsableTurno int,p_codigoPaciente int, p_ResponsabelTurno_codResponsableTurno int, p_Pacientes_codigoPaciente int, p_MedicoEspecialidad_codMedicoEspe int)
BEGIN
	insert into Turno(fechaTurno, fecharCita, valorCita, codigoMedicoEspecialidad, codResponsableTurno, codigoPaciente, ResponsabelTurno_codResponsableTurno, Pacientes_codigoPaciente, MedicoEspecialidad_codMedicoEspe)
		values(p_fechaTurno, p_fecharCita, p_valorCita, p_codigoMedicoEspecialidad, p_codResponsableTurno, p_codigoPaciente, p_ResponsabelTurno_codResponsableTurno, p_Pacientes_codigoPaciente, p_MedicoEspecialidad_codMedicoEspe);
END $$
DELIMITER ;

DELIMITER $$
	create procedure sp_ModificarTurno(p_codigoTurno int, p_fechaTurno date, p_fecharCita date, p_valorCita decimal(10,2), p_codigoMedicoEspecialidad int, p_codResponsableTurno int, p_codigoPaciente int, p_ResponsabelTurno_codResponsableTurno int, p_Pacientes_codigoPaciente int, p_MedicoEspecialidad_codMedicoEspe int)
BEGIN
	update Turno
		set fechaTurno = p_fechaTurno,fecharCita = p_fecharCita,valorCita = p_valorCita,codigoMedicoEspecialidad = p_codigoMedicoEspecialidad,
        codResponsableTurno = p_codResponsableTurno,codigoPaciente = p_codigoPaciente,ResponsabelTurno_codResponsableTurno = p_ResponsabelTurno_codResponsableTurno,Pacientes_codigoPaciente = p_Pacientes_codigoPaciente, MedicoEspecialidad_codMedicoEspe = p_MedicoEspecialidad_codMedicoEspe
		where codigoTurno = p_codigoTurno;
END $$
DELIMITER ;

DELIMITER $$
create procedure sp_EliminarTurno(p_codigoTurno int)
BEGIN
	delete from Turno
		where codigoTurno = p_codigoTurno;
END $$
DELIMITER ;

DELIMITER $$
	create procedure sp_ListarTurno()
BEGIN
	select * from Turno;
END $$
DELIMITER ;

DELIMITER $$
create procedure sp_BuscarTurno(p_codigoTurno int)
BEGIN
	select * from Turno
		where codigoTurno = p_codigoTurno;
END $$
DELIMITER ;
-- ---------------------------------------------CONTACTOURGENCIA-----------------------------------------------------
DELIMITER $$
create procedure sp_AgregarContactoUrgencia(p_nombre varchar (50),  p_apellido varchar (50), p_numeroContacto varchar(10), p_codigoPaciente int, p_Paciente_codigoPaciente int)
BEGIN
	insert into ContactoUrgencia(nombre, apellido, numContacto, codigoPaciente, Paciente_codigoPaciente)
		values(p_nombre, p_apellido, p_numeroContacto, p_codigoPaciente, p_Paciente_codigoPaciente);
END $$
DELIMITER ;

DELIMITER $$
create procedure sp_ModificarContactoUrgencia(p_codigoContactoUrgencia int, p_nombre varchar (50),  p_apellido varchar (50), p_numContacto varchar(10), p_codigoPaciente int, p_Paciente_codigoPaciente int)
BEGIN
	update ContactoUrgencia
		set nombre = p_nombreUr, apellido = p_apellidoUr, numeroContacto = p_numContacto,codigoPaciente = p_codigoPaciente,Paciente_codigoPaciente = p_Paciente_codigoPaciente
		where codigoContactoUrgencia = p_codigoContactoUrgencia;	
END $$
DELIMITER ;

DELIMITER $$
	create procedure sp_EliminarContactoUrgencia(p_codigoContactoUrgencia int)
BEGIN
	delete from ContactoUrgencia
		where codigoContactoUrgencia = p_codigoContactoUrgencia;
END $$
DELIMITER ;

DELIMITER $$
create procedure sp_BuscarContactoUrgengian(p_codigoContactoUrgencia int)
BEGIN
	select * from ContactoUrgencia
		where codigoContactoUrgencia = p_codigoContactoUrgencia;
END $$
DELIMITER ;

DELIMITER $$
	create procedure sp_ListarContactoUrgencian()
BEGIN
	select * from ContactoUrgencia;
END $$
DELIMITER ;
-- ----------------------------------------------TELEFONOSMEDICOS----------------------------------------------------
DELIMITER $$
	create procedure sp_AgregarTelefonoMedicos(p_telefonoPersonal varchar(15), p_telefonoTrabajo varchar(15), p_codigoMedico int, p_Medico_codigoMedico int )
BEGIN
	insert into TelefonosMedicos(telefonoPersonal, telefonoTrabajo, codigoMedico, Medico_codigoMedico)
		values(p_telefonoPersonal, p_telefonoTrabajo, p_codigoMedico, p_Medico_codigoMedico);
END $$
DELIMITER ;

DELIMITER $$
	create procedure sp_ModificarTelefonoMedicos(p_codigoTelefonoMedico int, p_telefonoPersonal varchar(15), p_telefonoTrabajo varchar(15), p_codigoMedico int, p_Medico_codigoMedico int )
BEGIN 
	update TelefonosMedicos
		set telefonoPersonal = p_telefonoPersonal, telefonoTrabajo = p_telefonoPersonal, codigoMedico = p_codigoMedico, Medico_codigoMedico = p_Medico_codigoMedico
		where codigoTelefonoMedico = p_codigoTelefonoMedico;
END $$
DELIMITER ;

DELIMITER $$
create procedure sp_EliminarTelefonoMedicos(codigoTelefonoMedico int)
BEGIN
	delete from TelefonosMedicos
		where codigoTelefonoMedico = p_codigoTelefonoMedico;
END $$
DELIMITER ;

DELIMITER $$
create procedure sp_BuscarTelefonosMedicos(p_p_codigoTelefonoMedico int)
BEGIN 
	select * from TelefonosMedicos
		where p_codigoTelefonoMedico = p_p_codigoTelefonoMedico;
END $$
DELIMITER ;

DELIMITER $$
create procedure sp_ListarTelefonosMedicos()
BEGIN
	select * from TelefonosMedicos;
END $$
DELIMITER ;