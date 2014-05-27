-- phpMyAdmin SQL Dump
-- version 2.10.3
-- http://www.phpmyadmin.net
-- 
-- Servidor: localhost
-- Tiempo de generación: 07-12-2013 a las 22:30:20
-- Versión del servidor: 5.0.51
-- Versión de PHP: 5.2.6

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

-- 
-- Base de datos: `inmovitek`
-- 

-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `ct_cliente`
-- 

CREATE TABLE `ct_cliente` (
  `id_cliente` int(10) unsigned NOT NULL auto_increment,
  `id_usuario` int(10) unsigned NOT NULL,
  `nombre` varchar(250) collate latin1_spanish_ci NOT NULL,
  `correo` varchar(45) collate latin1_spanish_ci default NULL,
  `telefono` varchar(80) collate latin1_spanish_ci default NULL,
  `horario_llamada` varchar(140) collate latin1_spanish_ci default NULL,
  `anotaciones` longtext collate latin1_spanish_ci,
  `fecha_alta` date NOT NULL,
  PRIMARY KEY  (`id_cliente`),
  KEY `FK_CLIENTE_INMOBILIARIA` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci AUTO_INCREMENT=1 ;

-- 
-- Volcar la base de datos para la tabla `ct_cliente`
-- 


-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `ct_direccion_inmueble`
-- 

CREATE TABLE `ct_direccion_inmueble` (
  `id_inmueble` int(10) unsigned NOT NULL,
  `id_estado` int(10) unsigned NOT NULL,
  `calle_no` varchar(200) collate latin1_spanish_ci NOT NULL,
  `colonia` varchar(100) collate latin1_spanish_ci NOT NULL,
  `municipio` varchar(100) collate latin1_spanish_ci NOT NULL,
  `cp` int(6) NOT NULL,
  `latitud` double NOT NULL,
  `longitud` double NOT NULL,
  `domicilio_completo` varchar(250) collate latin1_spanish_ci default NULL,
  PRIMARY KEY  (`id_inmueble`),
  KEY `FK_DIRECCION_INMUEBLE` (`id_inmueble`),
  KEY `FK_DIRECCION_ESTADO` (`id_estado`),
  KEY `INDEX_LATITUD` (`latitud`),
  KEY `INDEX_LONGITUD` (`longitud`),
  KEY `INDEX_CP` (`cp`),
  KEY `INDEX_MUNICIPIO` (`municipio`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- 
-- Volcar la base de datos para la tabla `ct_direccion_inmueble`
-- 

INSERT INTO `ct_direccion_inmueble` VALUES (1, 9, 'Herreros 392', 'Veinte de Noviembre, AmpliaciÃ³n', 'Venustiano Carranza', 15420, 19.4393406651059, -99.1130976035523, NULL);

-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `ct_estado`
-- 

CREATE TABLE `ct_estado` (
  `id_estado` int(10) unsigned NOT NULL,
  `nombre` varchar(100) collate latin1_spanish_ci NOT NULL,
  PRIMARY KEY  (`id_estado`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- 
-- Volcar la base de datos para la tabla `ct_estado`
-- 

INSERT INTO `ct_estado` VALUES (1, ' Aguascalientes');
INSERT INTO `ct_estado` VALUES (2, ' Baja California');
INSERT INTO `ct_estado` VALUES (3, ' Baja California Sur');
INSERT INTO `ct_estado` VALUES (4, ' Campeche');
INSERT INTO `ct_estado` VALUES (5, ' Coahuila de Zaragoza');
INSERT INTO `ct_estado` VALUES (6, ' Colima');
INSERT INTO `ct_estado` VALUES (7, ' Chiapas');
INSERT INTO `ct_estado` VALUES (8, ' Chihuahua');
INSERT INTO `ct_estado` VALUES (9, ' Distrito Federal');
INSERT INTO `ct_estado` VALUES (10, ' Durango');
INSERT INTO `ct_estado` VALUES (11, ' Guanajuato');
INSERT INTO `ct_estado` VALUES (12, ' Guerrero');
INSERT INTO `ct_estado` VALUES (13, ' Hidalgo');
INSERT INTO `ct_estado` VALUES (14, ' Jalisco');
INSERT INTO `ct_estado` VALUES (15, ' Estado de M&eacute;xico');
INSERT INTO `ct_estado` VALUES (16, ' Michoac&aacute;n de Ocampo');
INSERT INTO `ct_estado` VALUES (17, ' Morelos');
INSERT INTO `ct_estado` VALUES (18, ' Nayarit');
INSERT INTO `ct_estado` VALUES (19, ' Nuevo Le&oacute;n');
INSERT INTO `ct_estado` VALUES (20, ' Oaxaca');
INSERT INTO `ct_estado` VALUES (21, ' Puebla');
INSERT INTO `ct_estado` VALUES (22, ' Quer&eacute;taro');
INSERT INTO `ct_estado` VALUES (23, ' Quintana Roo');
INSERT INTO `ct_estado` VALUES (24, ' San Luis Potos&iacute;');
INSERT INTO `ct_estado` VALUES (25, ' Sinaloa');
INSERT INTO `ct_estado` VALUES (26, ' Sonora');
INSERT INTO `ct_estado` VALUES (27, ' Tabasco');
INSERT INTO `ct_estado` VALUES (28, ' Tamaulipas');
INSERT INTO `ct_estado` VALUES (29, ' Tlaxcala');
INSERT INTO `ct_estado` VALUES (30, ' Veracruz de Ignacio de la Llave');
INSERT INTO `ct_estado` VALUES (31, ' Yucat&aacute;n');
INSERT INTO `ct_estado` VALUES (32, ' Zacatecas');

-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `ct_foto_inmueble`
-- 

CREATE TABLE `ct_foto_inmueble` (
  `id_foto` int(10) unsigned NOT NULL auto_increment,
  `id_inmueble` int(10) unsigned NOT NULL,
  `url_imagen` varchar(250) collate latin1_spanish_ci NOT NULL,
  PRIMARY KEY  (`id_foto`),
  KEY `FK_FOTO_INMUEBLE` (`id_inmueble`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci AUTO_INCREMENT=1 ;

-- 
-- Volcar la base de datos para la tabla `ct_foto_inmueble`
-- 


-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `ct_info_inmueble`
-- 

CREATE TABLE `ct_info_inmueble` (
  `id_info_extra` int(10) unsigned NOT NULL auto_increment,
  `id_inmueble` int(10) unsigned NOT NULL,
  `nombre_campo` varchar(100) collate latin1_spanish_ci NOT NULL,
  `valor` varchar(200) collate latin1_spanish_ci NOT NULL,
  PRIMARY KEY  (`id_info_extra`),
  KEY `fk_info_inmueble_idx` (`id_inmueble`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci AUTO_INCREMENT=1 ;

-- 
-- Volcar la base de datos para la tabla `ct_info_inmueble`
-- 


-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `ct_inmobiliaria`
-- 

CREATE TABLE `ct_inmobiliaria` (
  `id_inmobiliaria` int(10) unsigned NOT NULL auto_increment,
  `identificador` varchar(50) collate latin1_spanish_ci default NULL,
  `nombre` varchar(100) collate latin1_spanish_ci NOT NULL,
  `licencia` varchar(30) collate latin1_spanish_ci NOT NULL,
  `directorio_archivos` varchar(250) collate latin1_spanish_ci default NULL,
  `url_logo` varchar(250) collate latin1_spanish_ci default NULL,
  `inmobiliaria_activa` tinyint(1) NOT NULL,
  PRIMARY KEY  (`id_inmobiliaria`),
  UNIQUE KEY `INDEX_IDENTIFICADOR` (`identificador`),
  KEY `FK_INMOBILIARIA_LICENCIA` (`licencia`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci AUTO_INCREMENT=2 ;

-- 
-- Volcar la base de datos para la tabla `ct_inmobiliaria`
-- 

INSERT INTO `ct_inmobiliaria` VALUES (1, NULL, 'ENGINETEC de MÃ©xico', 'YM5FH-9H9HN-17U68-XX8F8-QT0PM', 'global\\inmobiliaria\\1', NULL, 1);

-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `ct_inmueble`
-- 

CREATE TABLE `ct_inmueble` (
  `id_inmueble` int(10) unsigned NOT NULL auto_increment,
  `fecha_registro` date NOT NULL,
  `id_tipo_inmueble` int(10) unsigned NOT NULL,
  `metros_cuadrados` float NOT NULL,
  `num_recamaras` int(11) NOT NULL,
  `num_sanitarios` int(11) NOT NULL,
  `alberca` tinyint(1) NOT NULL,
  `cochera` tinyint(1) NOT NULL,
  `num_autos_cochera` int(11) default NULL,
  `num_plantas` int(11) NOT NULL,
  `precio` bigint(20) NOT NULL,
  `detalles` longtext collate latin1_spanish_ci,
  `venta_renta` tinyint(1) NOT NULL COMMENT 'Inmueble en venta = 1\nInmueble en renta = 2',
  `id_usuario` int(10) unsigned NOT NULL,
  `vendida_rentada` tinyint(1) NOT NULL COMMENT 'Vendida = 1\nRentada = 1',
  `id_propietario` int(10) unsigned default NULL,
  `activo` tinyint(1) NOT NULL,
  PRIMARY KEY  (`id_inmueble`),
  KEY `FK_INMUEBLE_TIPO` (`id_tipo_inmueble`),
  KEY `FK_INMUEBLE_INMOBILIARIA` (`id_usuario`),
  KEY `FK_INMUEBLE_PROPIETARIO` (`id_propietario`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci AUTO_INCREMENT=2 ;

-- 
-- Volcar la base de datos para la tabla `ct_inmueble`
-- 

INSERT INTO `ct_inmueble` VALUES (1, '2013-10-06', 1, 97, 5, 2, 0, 0, 0, 3, 1325000, 'El inmueble se encuentra en una zona bastante comunicada. Cuenta con todos los servicios bÃ¡sicos. Cercas hay escuelas de todos los niveles.', 1, 1, 0, NULL, 1);

-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `ct_inmueble_promocionado`
-- 

CREATE TABLE `ct_inmueble_promocionado` (
  `id_inmueble` int(10) unsigned NOT NULL,
  `rank` float NOT NULL default '0',
  `no_clicks` int(11) NOT NULL,
  `promocion_inicia` date NOT NULL,
  `promocion_termina` date NOT NULL,
  PRIMARY KEY  (`id_inmueble`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- 
-- Volcar la base de datos para la tabla `ct_inmueble_promocionado`
-- 


-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `ct_licencia`
-- 

CREATE TABLE `ct_licencia` (
  `licencia` varchar(30) collate latin1_spanish_ci NOT NULL,
  `activacion` tinyint(1) NOT NULL,
  `numero_usuarios` int(11) NOT NULL,
  `usuarios_activos` int(11) NOT NULL,
  `fecha_activacion` date NOT NULL,
  `fecha_termino` date NOT NULL,
  PRIMARY KEY  (`licencia`),
  KEY `INDEX_TERMINO` (`fecha_termino`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- 
-- Volcar la base de datos para la tabla `ct_licencia`
-- 

INSERT INTO `ct_licencia` VALUES ('YM5FH-9H9HN-17U68-XX8F8-QT0PM', 1, 10, 2, '2013-10-06', '2014-10-06');

-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `ct_limite_usuario`
-- 

CREATE TABLE `ct_limite_usuario` (
  `id_usuario` int(10) unsigned NOT NULL,
  `limite_inmuebles` int(11) NOT NULL default '0',
  `caducidad_cuenta` date NOT NULL,
  PRIMARY KEY  (`id_usuario`),
  KEY `FK_LIMITE_USUARIO` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- 
-- Volcar la base de datos para la tabla `ct_limite_usuario`
-- 

INSERT INTO `ct_limite_usuario` VALUES (1, 0, '2014-10-06');

-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `ct_perfil_cliente`
-- 

CREATE TABLE `ct_perfil_cliente` (
  `id_cliente` int(10) unsigned NOT NULL,
  `id_estado_busca_inmueble` int(10) unsigned NOT NULL,
  `id_tipo_inmueble` int(10) unsigned NOT NULL,
  `no_habitaciones_min` int(11) NOT NULL,
  `no_habitaciones_max` int(11) NOT NULL,
  `alberca` tinyint(1) NOT NULL,
  `no_sanitarios_min` int(11) NOT NULL,
  `no_sanitarios_max` int(11) NOT NULL,
  `cochera` tinyint(1) NOT NULL,
  `no_plantas` int(11) NOT NULL,
  `rango_precio_min` int(11) NOT NULL,
  `rango_precio_max` int(11) NOT NULL,
  `compra_renta` tinyint(1) NOT NULL,
  PRIMARY KEY  (`id_cliente`),
  KEY `FK_COMPRA_ESTADO` (`id_estado_busca_inmueble`),
  KEY `FK_COMPRA_TIPO` (`id_tipo_inmueble`),
  KEY `FK_CLIENTE_COMPRA` (`id_cliente`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- 
-- Volcar la base de datos para la tabla `ct_perfil_cliente`
-- 


-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `ct_permisos_usuario`
-- 

CREATE TABLE `ct_permisos_usuario` (
  `id_usuario` int(10) unsigned NOT NULL,
  `administrar_permisos` tinyint(1) NOT NULL,
  `agenda` tinyint(1) NOT NULL,
  `administrar_usuarios` tinyint(1) NOT NULL,
  `registrar_venta` tinyint(1) NOT NULL,
  `registrar_inmueble` tinyint(1) NOT NULL,
  `registrar_cliente` tinyint(1) NOT NULL,
  `eliminar_inmueble` tinyint(1) NOT NULL,
  `eliminar_cliente` tinyint(1) NOT NULL,
  `registrar_pago_renta` tinyint(1) NOT NULL,
  `mensajes_inmobiliarias` tinyint(1) NOT NULL,
  `mensajes_usuarios` tinyint(1) NOT NULL,
  `inmobiliaria_amiga` tinyint(1) NOT NULL,
  `administrar_inmobiliaria` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`id_usuario`),
  KEY `FK_PERMISO_USUARIO` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- 
-- Volcar la base de datos para la tabla `ct_permisos_usuario`
-- 

INSERT INTO `ct_permisos_usuario` VALUES (1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1);
INSERT INTO `ct_permisos_usuario` VALUES (2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1);

-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `ct_renta`
-- 

CREATE TABLE `ct_renta` (
  `id_renta` int(10) unsigned NOT NULL auto_increment,
  `id_inmueble` int(10) unsigned NOT NULL,
  `cliente_alquila` int(10) unsigned NOT NULL,
  `fecha_registro` date NOT NULL,
  `periodo_renta` int(11) NOT NULL,
  `precio_renta` float NOT NULL,
  `proximo_cobro` date default NULL,
  `anotaciones` longtext collate latin1_spanish_ci,
  PRIMARY KEY  (`id_renta`),
  KEY `FK_RENTA_INMUEBLE` (`id_inmueble`),
  KEY `FK_RENTA_CLIENTE` (`cliente_alquila`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci AUTO_INCREMENT=1 ;

-- 
-- Volcar la base de datos para la tabla `ct_renta`
-- 


-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `ct_telefono_cliente`
-- 

CREATE TABLE `ct_telefono_cliente` (
  `id_telefono_cliente` int(10) unsigned NOT NULL auto_increment,
  `id_cliente` int(10) unsigned NOT NULL,
  `telefono_cliente` varchar(30) collate latin1_spanish_ci NOT NULL,
  PRIMARY KEY  (`id_telefono_cliente`),
  KEY `FK_TELEFONO_CLIENTE` (`id_cliente`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci AUTO_INCREMENT=1 ;

-- 
-- Volcar la base de datos para la tabla `ct_telefono_cliente`
-- 


-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `ct_telefono_inmobiliaria`
-- 

CREATE TABLE `ct_telefono_inmobiliaria` (
  `id_telefono` int(10) unsigned NOT NULL auto_increment,
  `id_inmobiliaria` int(10) unsigned NOT NULL,
  `telefono_inmobiliaria` varchar(30) collate latin1_spanish_ci NOT NULL,
  PRIMARY KEY  (`id_telefono`),
  KEY `FK_TELEFONO_INMOBILIARIA` (`id_inmobiliaria`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci AUTO_INCREMENT=2 ;

-- 
-- Volcar la base de datos para la tabla `ct_telefono_inmobiliaria`
-- 

INSERT INTO `ct_telefono_inmobiliaria` VALUES (1, 1, '5525620720');

-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `ct_tipo_inmueble`
-- 

CREATE TABLE `ct_tipo_inmueble` (
  `id_tipo_inmueble` int(10) unsigned NOT NULL auto_increment,
  `tipo_inmueble` varchar(60) collate latin1_spanish_ci NOT NULL,
  PRIMARY KEY  (`id_tipo_inmueble`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci AUTO_INCREMENT=14 ;

-- 
-- Volcar la base de datos para la tabla `ct_tipo_inmueble`
-- 

INSERT INTO `ct_tipo_inmueble` VALUES (1, 'Casa sola');
INSERT INTO `ct_tipo_inmueble` VALUES (2, 'Departamento');
INSERT INTO `ct_tipo_inmueble` VALUES (3, 'Casa en condominio');
INSERT INTO `ct_tipo_inmueble` VALUES (4, 'Terreno');
INSERT INTO `ct_tipo_inmueble` VALUES (5, 'Villa');
INSERT INTO `ct_tipo_inmueble` VALUES (6, 'Quinta');
INSERT INTO `ct_tipo_inmueble` VALUES (7, 'Rancho');
INSERT INTO `ct_tipo_inmueble` VALUES (8, 'Local comercial');
INSERT INTO `ct_tipo_inmueble` VALUES (9, 'Oficina Comercial');
INSERT INTO `ct_tipo_inmueble` VALUES (10, 'Local en centro comercial');
INSERT INTO `ct_tipo_inmueble` VALUES (11, 'Huerta');
INSERT INTO `ct_tipo_inmueble` VALUES (12, 'Bodega comercial');
INSERT INTO `ct_tipo_inmueble` VALUES (13, 'Oficina industrial');

-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `ct_usuario`
-- 

CREATE TABLE `ct_usuario` (
  `id_usuario` int(10) unsigned NOT NULL auto_increment,
  `nombre_usuario` varchar(60) collate latin1_spanish_ci default NULL,
  `id_inmobiliaria` int(10) unsigned default NULL,
  `nombres` varchar(50) collate latin1_spanish_ci default NULL,
  `apellido_p` varchar(40) collate latin1_spanish_ci default NULL,
  `apellido_m` varchar(40) collate latin1_spanish_ci default NULL,
  `correo` varchar(40) collate latin1_spanish_ci NOT NULL,
  `password` varchar(80) collate latin1_spanish_ci NOT NULL,
  `telefono_casa` varchar(30) collate latin1_spanish_ci default NULL,
  `telefono_celular` varchar(30) collate latin1_spanish_ci default NULL,
  `fecha_alta` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `fecha_nacimiento` date default NULL,
  `usuario_activo` tinyint(1) NOT NULL,
  `tokenGoogleAccount` text collate latin1_spanish_ci,
  PRIMARY KEY  (`id_usuario`),
  UNIQUE KEY `INDEX_NOMBRE_USUARIO` (`nombre_usuario`),
  KEY `FK_USUARIO_INMOBILIARIA` (`id_inmobiliaria`),
  KEY `INDEX_CORREO` (`correo`),
  KEY `INDEX_LOGIN_USUARIO` (`nombre_usuario`,`password`),
  KEY `INDEX_LOGIN_CORREO` (`correo`,`password`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci AUTO_INCREMENT=3 ;

-- 
-- Volcar la base de datos para la tabla `ct_usuario`
-- 

INSERT INTO `ct_usuario` VALUES (1, NULL, 1, 'Miguel', 'PÃ©rez', '', 'mperez@enginetec.com.mx', 'c5c7de4adc30ab026a30dc75320fa449', '5526021450', '55123014', '2013-10-06 10:57:20', NULL, 1, '{"access_token":"ya29.AHES6ZTYnk2FHRk7_Jb2HurpwH5lEpo96NH3Aai_QtYKjs8","token_type":"Bearer","expires_in":3600,"refresh_token":"1\\/syq0VE7VCsVTA9nEnln7fgXgKJRvqqS36O3JC73ts8Q","created":1382673871}');
INSERT INTO `ct_usuario` VALUES (2, NULL, 1, 'Daniel ', 'Catro', 'Carrilo', 'dan.cast@gmail.com', 'c5c7de4adc30ab026a30dc75320fa449', NULL, NULL, '2013-10-17 01:40:26', NULL, 1, NULL);

-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `ct_visita_virtual`
-- 

CREATE TABLE `ct_visita_virtual` (
  `id_visitavirtual` int(10) unsigned NOT NULL auto_increment,
  `id_inmueble` int(10) unsigned NOT NULL,
  `nombre_habitacion` varchar(150) collate latin1_spanish_ci NOT NULL,
  `url_visitavirtual` varchar(200) collate latin1_spanish_ci NOT NULL,
  PRIMARY KEY  (`id_visitavirtual`),
  KEY `FK_VISITAVIRTUAL_INMUEBLE` (`id_inmueble`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci AUTO_INCREMENT=1 ;

-- 
-- Volcar la base de datos para la tabla `ct_visita_virtual`
-- 


-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `ht_agenda_usuario`
-- 

CREATE TABLE `ht_agenda_usuario` (
  `id_registro` int(10) unsigned NOT NULL auto_increment,
  `id_usuario` int(10) unsigned NOT NULL,
  `titulo` varchar(200) collate latin1_spanish_ci NOT NULL,
  `detalles` longtext collate latin1_spanish_ci NOT NULL,
  `fecha_inicio` datetime NOT NULL,
  `fecha_termino` datetime default NULL,
  PRIMARY KEY  (`id_registro`),
  KEY `FK_EVENTO_USUARIO` (`id_usuario`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci PACK_KEYS=1 AUTO_INCREMENT=30 ;

-- 
-- Volcar la base de datos para la tabla `ht_agenda_usuario`
-- 

INSERT INTO `ht_agenda_usuario` VALUES (1, 1, 'Visitar cliente', 'Ir a visitar a un cliente', '2013-10-19 16:50:00', '0000-00-00 00:00:00');
INSERT INTO `ht_agenda_usuario` VALUES (15, 1, 'Evento prueba', 'Evento', '2013-10-24 23:20:00', '2013-10-24 23:30:00');
INSERT INTO `ht_agenda_usuario` VALUES (16, 1, 'Evento prueba', 'Evento', '2013-10-24 23:20:00', '2013-10-24 23:30:00');
INSERT INTO `ht_agenda_usuario` VALUES (17, 1, 'Evento prueba', 'Evento', '2013-10-24 23:20:00', '2013-10-24 23:30:00');
INSERT INTO `ht_agenda_usuario` VALUES (18, 1, 'Evento prueba', 'Evento', '2013-10-24 23:20:00', '2013-10-24 23:30:00');
INSERT INTO `ht_agenda_usuario` VALUES (19, 1, 'Evento prueba', 'Evento', '2013-10-24 23:20:00', '2013-10-24 23:30:00');
INSERT INTO `ht_agenda_usuario` VALUES (20, 1, 'Evento prueba', 'Evento', '2013-10-24 23:20:00', '2013-10-24 23:30:00');
INSERT INTO `ht_agenda_usuario` VALUES (21, 1, 'Evento prueba', 'Evento', '2013-10-24 23:20:00', '2013-10-24 23:30:00');
INSERT INTO `ht_agenda_usuario` VALUES (22, 1, 'Evento prueba', 'Evento', '2013-10-24 23:20:00', '2013-10-24 23:30:00');
INSERT INTO `ht_agenda_usuario` VALUES (23, 1, 'Evento prueba', 'Evento', '2013-10-24 23:20:00', '2013-10-24 23:30:00');
INSERT INTO `ht_agenda_usuario` VALUES (24, 1, 'Evento prueba', 'Evento', '2013-10-24 23:20:00', '2013-10-24 23:30:00');
INSERT INTO `ht_agenda_usuario` VALUES (25, 1, 'Evento prueba', 'Evento', '2013-10-24 23:20:00', '2013-10-24 23:30:00');
INSERT INTO `ht_agenda_usuario` VALUES (26, 1, 'Evento prueba', 'Evento', '2013-10-24 23:20:00', '2013-10-24 23:30:00');
INSERT INTO `ht_agenda_usuario` VALUES (27, 1, 'Evento prueba', 'Evento', '2013-10-24 23:20:00', '2013-10-24 23:30:00');
INSERT INTO `ht_agenda_usuario` VALUES (28, 1, 'Evento prueba', 'Evento', '2013-10-24 23:20:00', '2013-10-24 23:30:00');
INSERT INTO `ht_agenda_usuario` VALUES (29, 1, 'Probando el calendario', 'Este es un nuevo evento para mi calendario', '2013-10-25 00:45:00', '2013-10-25 02:20:00');

-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `ht_mensaje_inmobiliaria`
-- 

CREATE TABLE `ht_mensaje_inmobiliaria` (
  `id_mensaje` int(10) unsigned NOT NULL auto_increment,
  `id_inmobiliaria_emisor` int(10) unsigned NOT NULL,
  `id_inmobiliaria_receptor` int(10) unsigned NOT NULL,
  `asunto` varchar(200) collate latin1_spanish_ci NOT NULL,
  `mensaje` longtext collate latin1_spanish_ci NOT NULL,
  `fecha` datetime NOT NULL,
  `leido` tinyint(1) NOT NULL,
  `fecha_leido` datetime default NULL,
  `status_emisor` tinyint(1) NOT NULL,
  `status_receptor` tinyint(1) NOT NULL,
  PRIMARY KEY  (`id_mensaje`),
  KEY `FK_INMOBILIARIA_EMISOR` (`id_inmobiliaria_emisor`),
  KEY `FK_INMOBILIARIA_RECEPTOR` (`id_inmobiliaria_receptor`),
  KEY `INDEX_RECEPTOR_NO_LEIDOS` (`id_inmobiliaria_receptor`,`leido`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci AUTO_INCREMENT=1 ;

-- 
-- Volcar la base de datos para la tabla `ht_mensaje_inmobiliaria`
-- 


-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `ht_mensaje_usuario`
-- 

CREATE TABLE `ht_mensaje_usuario` (
  `id_mensaje` int(10) unsigned NOT NULL auto_increment,
  `id_usuario_emisor` int(10) unsigned NOT NULL,
  `id_usuario_receptor` int(10) unsigned NOT NULL,
  `asunto` varchar(200) collate latin1_spanish_ci NOT NULL,
  `mensaje` longtext collate latin1_spanish_ci NOT NULL,
  `fecha` datetime NOT NULL,
  `leido` tinyint(1) NOT NULL,
  `fecha_leido` datetime default NULL,
  `status_emisor` tinyint(1) NOT NULL,
  `status_receptor` tinyint(1) NOT NULL,
  PRIMARY KEY  (`id_mensaje`),
  KEY `FK_USUARIO_EMISOR` (`id_usuario_emisor`),
  KEY `FK_USUARIO_RECPETOR` (`id_usuario_receptor`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci AUTO_INCREMENT=5 ;

-- 
-- Volcar la base de datos para la tabla `ht_mensaje_usuario`
-- 

INSERT INTO `ht_mensaje_usuario` VALUES (1, 2, 1, 'Mike', 'Hola Mike', '2013-10-17 01:41:51', 1, '2013-10-19 14:53:30', 1, 0);
INSERT INTO `ht_mensaje_usuario` VALUES (2, 1, 2, 'Daniel Castro reportese', 'RepÃ³rtese en mi oficina maÃ±ana temprano.\r\n\r\nSaludos.', '2013-10-22 00:20:43', 0, NULL, 1, 1);
INSERT INTO `ht_mensaje_usuario` VALUES (3, 1, 1, 'Reporte', 'Miguel reporta', '2013-10-22 00:22:24', 1, '2013-10-22 00:22:32', 1, 1);
INSERT INTO `ht_mensaje_usuario` VALUES (4, 1, 1, 'Reportese ', 'RecibÃ­do\r\n\r\nCorra ', '2013-10-22 00:23:03', 1, '2013-10-22 00:23:11', 1, 1);

-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `ht_pago_renta`
-- 

CREATE TABLE `ht_pago_renta` (
  `id_pago_renta` int(10) unsigned NOT NULL auto_increment,
  `id_renta` int(10) unsigned NOT NULL,
  `cantidad_pagada` float NOT NULL,
  `fecha_pago` date NOT NULL,
  `periodo` varchar(250) collate latin1_spanish_ci NOT NULL,
  PRIMARY KEY  (`id_pago_renta`),
  KEY `FK_PAGO_ALQUILER` (`id_renta`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci AUTO_INCREMENT=1 ;

-- 
-- Volcar la base de datos para la tabla `ht_pago_renta`
-- 


-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `ht_venta`
-- 

CREATE TABLE `ht_venta` (
  `id_venta` int(10) unsigned NOT NULL auto_increment,
  `id_inmueble` int(10) unsigned NOT NULL,
  `id_vendedor` int(10) unsigned NOT NULL,
  `id_comprador` int(10) unsigned NOT NULL,
  `precio_venta` float NOT NULL,
  `ganancia_venta` float default NULL,
  `fecha_venta` date NOT NULL,
  `anotaciones` longtext collate latin1_spanish_ci,
  PRIMARY KEY  (`id_venta`),
  KEY `FK_VENTA_INMUEBLE` (`id_inmueble`),
  KEY `FK_VENTA_VENDEDOR` (`id_vendedor`),
  KEY `FK_VENTA_COMPRADOR` (`id_comprador`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci AUTO_INCREMENT=1 ;

-- 
-- Volcar la base de datos para la tabla `ht_venta`
-- 


-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `rl_inmobiliaria_amiga`
-- 

CREATE TABLE `rl_inmobiliaria_amiga` (
  `id_inmobiliaria` int(10) unsigned NOT NULL,
  `id_inmobiliaria_amiga` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`id_inmobiliaria`,`id_inmobiliaria_amiga`),
  KEY `fk_inmobiliaria_idx` (`id_inmobiliaria`),
  KEY `fk_inmobiliaria_amiga_idx` (`id_inmobiliaria_amiga`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- 
-- Volcar la base de datos para la tabla `rl_inmobiliaria_amiga`
-- 


-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `rl_inmueble_ofrecido_cliente`
-- 

CREATE TABLE `rl_inmueble_ofrecido_cliente` (
  `id_cliente` int(10) unsigned NOT NULL,
  `id_inmueble` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`id_cliente`,`id_inmueble`),
  KEY `CLIENTE_RECHAZA_INMUEBLE` (`id_cliente`),
  KEY `INMUEBLE_RECHAZADO_CLIENTE` (`id_inmueble`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- 
-- Volcar la base de datos para la tabla `rl_inmueble_ofrecido_cliente`
-- 


-- --------------------------------------------------------

-- 
-- Estructura Stand-in para la vista `vw_inmobiliaria_cliente`
-- 
CREATE TABLE `vw_inmobiliaria_cliente` (
`id_cliente` int(10) unsigned
,`id_usuario` int(10) unsigned
,`nombre` varchar(250)
,`correo` varchar(45)
,`telefono` varchar(80)
,`horario_llamada` varchar(140)
,`anotaciones` longtext
,`fecha_alta` date
,`id_inmobiliaria` int(10) unsigned
);
-- --------------------------------------------------------

-- 
-- Estructura Stand-in para la vista `vw_inmobiliaria_inmueble`
-- 
CREATE TABLE `vw_inmobiliaria_inmueble` (
`id_inmueble` int(10) unsigned
,`fecha_registro` date
,`id_tipo_inmueble` int(10) unsigned
,`metros_cuadrados` float
,`num_recamaras` int(11)
,`num_sanitarios` int(11)
,`alberca` tinyint(1)
,`cochera` tinyint(1)
,`num_autos_cochera` int(11)
,`num_plantas` int(11)
,`precio` bigint(20)
,`detalles` longtext
,`venta_renta` tinyint(1)
,`id_usuario` int(10) unsigned
,`vendida_rentada` tinyint(1)
,`id_propietario` int(10) unsigned
,`activo` tinyint(1)
,`id_inmobiliaria` int(10) unsigned
);
-- --------------------------------------------------------

-- 
-- Estructura para la vista `vw_inmobiliaria_cliente`
-- 
DROP TABLE IF EXISTS `vw_inmobiliaria_cliente`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `inmovitek`.`vw_inmobiliaria_cliente` AS select `cte`.`id_cliente` AS `id_cliente`,`cte`.`id_usuario` AS `id_usuario`,`cte`.`nombre` AS `nombre`,`cte`.`correo` AS `correo`,`cte`.`telefono` AS `telefono`,`cte`.`horario_llamada` AS `horario_llamada`,`cte`.`anotaciones` AS `anotaciones`,`cte`.`fecha_alta` AS `fecha_alta`,`usr`.`id_inmobiliaria` AS `id_inmobiliaria` from (`inmovitek`.`ct_cliente` `cte` join `inmovitek`.`ct_usuario` `usr`) where (`cte`.`id_usuario` = `usr`.`id_usuario`);

-- --------------------------------------------------------

-- 
-- Estructura para la vista `vw_inmobiliaria_inmueble`
-- 
DROP TABLE IF EXISTS `vw_inmobiliaria_inmueble`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `inmovitek`.`vw_inmobiliaria_inmueble` AS select `inm`.`id_inmueble` AS `id_inmueble`,`inm`.`fecha_registro` AS `fecha_registro`,`inm`.`id_tipo_inmueble` AS `id_tipo_inmueble`,`inm`.`metros_cuadrados` AS `metros_cuadrados`,`inm`.`num_recamaras` AS `num_recamaras`,`inm`.`num_sanitarios` AS `num_sanitarios`,`inm`.`alberca` AS `alberca`,`inm`.`cochera` AS `cochera`,`inm`.`num_autos_cochera` AS `num_autos_cochera`,`inm`.`num_plantas` AS `num_plantas`,`inm`.`precio` AS `precio`,`inm`.`detalles` AS `detalles`,`inm`.`venta_renta` AS `venta_renta`,`inm`.`id_usuario` AS `id_usuario`,`inm`.`vendida_rentada` AS `vendida_rentada`,`inm`.`id_propietario` AS `id_propietario`,`inm`.`activo` AS `activo`,`usr`.`id_inmobiliaria` AS `id_inmobiliaria` from (`inmovitek`.`ct_inmueble` `inm` join `inmovitek`.`ct_usuario` `usr`) where (`inm`.`id_usuario` = `usr`.`id_usuario`);

-- 
-- Filtros para las tablas descargadas (dump)
-- 

-- 
-- Filtros para la tabla `ct_cliente`
-- 
ALTER TABLE `ct_cliente`
  ADD CONSTRAINT `fk_cliente_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `ct_usuario` (`id_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- 
-- Filtros para la tabla `ct_direccion_inmueble`
-- 
ALTER TABLE `ct_direccion_inmueble`
  ADD CONSTRAINT `fk_direccion_inmueble` FOREIGN KEY (`id_inmueble`) REFERENCES `ct_inmueble` (`id_inmueble`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_estado_direccion_inmueble` FOREIGN KEY (`id_estado`) REFERENCES `ct_estado` (`id_estado`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- 
-- Filtros para la tabla `ct_foto_inmueble`
-- 
ALTER TABLE `ct_foto_inmueble`
  ADD CONSTRAINT `fk_foto_inmueble` FOREIGN KEY (`id_inmueble`) REFERENCES `ct_inmueble` (`id_inmueble`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- 
-- Filtros para la tabla `ct_info_inmueble`
-- 
ALTER TABLE `ct_info_inmueble`
  ADD CONSTRAINT `fk_info_inmueble` FOREIGN KEY (`id_inmueble`) REFERENCES `ct_inmueble` (`id_inmueble`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- 
-- Filtros para la tabla `ct_inmobiliaria`
-- 
ALTER TABLE `ct_inmobiliaria`
  ADD CONSTRAINT `fk_licencia` FOREIGN KEY (`licencia`) REFERENCES `ct_licencia` (`licencia`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- 
-- Filtros para la tabla `ct_inmueble`
-- 
ALTER TABLE `ct_inmueble`
  ADD CONSTRAINT `fk_propietario` FOREIGN KEY (`id_propietario`) REFERENCES `ct_cliente` (`id_cliente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_tipo_propiedad` FOREIGN KEY (`id_tipo_inmueble`) REFERENCES `ct_tipo_inmueble` (`id_tipo_inmueble`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `ct_usuario` (`id_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- 
-- Filtros para la tabla `ct_inmueble_promocionado`
-- 
ALTER TABLE `ct_inmueble_promocionado`
  ADD CONSTRAINT `fk_inmueble_promocionado` FOREIGN KEY (`id_inmueble`) REFERENCES `ct_inmueble` (`id_inmueble`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- 
-- Filtros para la tabla `ct_limite_usuario`
-- 
ALTER TABLE `ct_limite_usuario`
  ADD CONSTRAINT `fk_limite_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `ct_usuario` (`id_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- 
-- Filtros para la tabla `ct_perfil_cliente`
-- 
ALTER TABLE `ct_perfil_cliente`
  ADD CONSTRAINT `fk_cte_tipo_inmueble` FOREIGN KEY (`id_tipo_inmueble`) REFERENCES `ct_tipo_inmueble` (`id_tipo_inmueble`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_perfilcte_estado` FOREIGN KEY (`id_estado_busca_inmueble`) REFERENCES `ct_estado` (`id_estado`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_perfil_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `ct_cliente` (`id_cliente`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- 
-- Filtros para la tabla `ct_permisos_usuario`
-- 
ALTER TABLE `ct_permisos_usuario`
  ADD CONSTRAINT `fk_permisos_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `ct_usuario` (`id_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- 
-- Filtros para la tabla `ct_renta`
-- 
ALTER TABLE `ct_renta`
  ADD CONSTRAINT `fk_cliente_alquila` FOREIGN KEY (`cliente_alquila`) REFERENCES `ct_cliente` (`id_cliente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_renta_inmueble` FOREIGN KEY (`id_inmueble`) REFERENCES `ct_inmueble` (`id_inmueble`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- 
-- Filtros para la tabla `ct_telefono_cliente`
-- 
ALTER TABLE `ct_telefono_cliente`
  ADD CONSTRAINT `fk_telefono_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `ct_cliente` (`id_cliente`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- 
-- Filtros para la tabla `ct_telefono_inmobiliaria`
-- 
ALTER TABLE `ct_telefono_inmobiliaria`
  ADD CONSTRAINT `fk_telefono_inmobiliaria` FOREIGN KEY (`id_inmobiliaria`) REFERENCES `ct_inmobiliaria` (`id_inmobiliaria`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- 
-- Filtros para la tabla `ct_usuario`
-- 
ALTER TABLE `ct_usuario`
  ADD CONSTRAINT `fk_usuario_inmobiliaria` FOREIGN KEY (`id_inmobiliaria`) REFERENCES `ct_inmobiliaria` (`id_inmobiliaria`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- 
-- Filtros para la tabla `ct_visita_virtual`
-- 
ALTER TABLE `ct_visita_virtual`
  ADD CONSTRAINT `fk_virtual_inmueble` FOREIGN KEY (`id_inmueble`) REFERENCES `ct_inmueble` (`id_inmueble`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- 
-- Filtros para la tabla `ht_agenda_usuario`
-- 
ALTER TABLE `ht_agenda_usuario`
  ADD CONSTRAINT `fk_usuario_agenda` FOREIGN KEY (`id_usuario`) REFERENCES `ct_usuario` (`id_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- 
-- Filtros para la tabla `ht_mensaje_inmobiliaria`
-- 
ALTER TABLE `ht_mensaje_inmobiliaria`
  ADD CONSTRAINT `fk_inmobiliaria_emisor` FOREIGN KEY (`id_inmobiliaria_emisor`) REFERENCES `ct_inmobiliaria` (`id_inmobiliaria`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_inmobiliaria_receptor` FOREIGN KEY (`id_inmobiliaria_receptor`) REFERENCES `ct_inmobiliaria` (`id_inmobiliaria`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- 
-- Filtros para la tabla `ht_mensaje_usuario`
-- 
ALTER TABLE `ht_mensaje_usuario`
  ADD CONSTRAINT `fk_usuario_emisor` FOREIGN KEY (`id_usuario_emisor`) REFERENCES `ct_usuario` (`id_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_usuario_receptor` FOREIGN KEY (`id_usuario_receptor`) REFERENCES `ct_usuario` (`id_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- 
-- Filtros para la tabla `ht_pago_renta`
-- 
ALTER TABLE `ht_pago_renta`
  ADD CONSTRAINT `fk_pago_renta` FOREIGN KEY (`id_renta`) REFERENCES `ct_renta` (`id_renta`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- 
-- Filtros para la tabla `ht_venta`
-- 
ALTER TABLE `ht_venta`
  ADD CONSTRAINT `fk_cliente_compra` FOREIGN KEY (`id_comprador`) REFERENCES `ct_cliente` (`id_cliente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_inmueble_venta` FOREIGN KEY (`id_inmueble`) REFERENCES `ct_inmueble` (`id_inmueble`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_vendedor_venta` FOREIGN KEY (`id_vendedor`) REFERENCES `ct_usuario` (`id_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- 
-- Filtros para la tabla `rl_inmobiliaria_amiga`
-- 
ALTER TABLE `rl_inmobiliaria_amiga`
  ADD CONSTRAINT `fk_inmobiliaria_amiga` FOREIGN KEY (`id_inmobiliaria_amiga`) REFERENCES `ct_inmobiliaria` (`id_inmobiliaria`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_inmobiliaria_principal` FOREIGN KEY (`id_inmobiliaria`) REFERENCES `ct_inmobiliaria` (`id_inmobiliaria`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- 
-- Filtros para la tabla `rl_inmueble_ofrecido_cliente`
-- 
ALTER TABLE `rl_inmueble_ofrecido_cliente`
  ADD CONSTRAINT `fk_cliente_ofrecido` FOREIGN KEY (`id_cliente`) REFERENCES `ct_cliente` (`id_cliente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_inmueble_ofrecido_cte` FOREIGN KEY (`id_inmueble`) REFERENCES `ct_inmueble` (`id_inmueble`) ON DELETE NO ACTION ON UPDATE NO ACTION;
