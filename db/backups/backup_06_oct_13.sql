-- phpMyAdmin SQL Dump
-- version 2.10.3
-- http://www.phpmyadmin.net
-- 
-- Servidor: localhost
-- Tiempo de generación: 06-10-2013 a las 10:20:42
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

DROP TABLE IF EXISTS `ct_cliente`;
CREATE TABLE IF NOT EXISTS `ct_cliente` (
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
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci AUTO_INCREMENT=3 ;

-- 
-- Volcar la base de datos para la tabla `ct_cliente`
-- 

INSERT INTO `ct_cliente` VALUES (1, 1, 'Armando RamÃ­rez HernÃ¡ndez', 'armando@hernandez.com', '552563012', '07:00 - 20:20', NULL, '2013-09-08');
INSERT INTO `ct_cliente` VALUES (2, 1, 'Rodrigo Talavera Gutierrez', 'talavera@', '55261214', '12:00 - 20:00', NULL, '2013-09-08');

-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `ct_direccion_inmueble`
-- 

DROP TABLE IF EXISTS `ct_direccion_inmueble`;
CREATE TABLE IF NOT EXISTS `ct_direccion_inmueble` (
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
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- 
-- Volcar la base de datos para la tabla `ct_direccion_inmueble`
-- 

INSERT INTO `ct_direccion_inmueble` VALUES (6, 9, 'Av. Canal del Norte No. 356', 'Popular Rastro', 'Venustiano Carranza', 15240, 19.4506513363281, -99.1176895453858, NULL);
INSERT INTO `ct_direccion_inmueble` VALUES (7, 9, 'Calle X', 'No se', 'algo', 25306, 19.4605247660746, -99.0865330054688, NULL);
INSERT INTO `ct_direccion_inmueble` VALUES (8, 9, 'TipografÃ­a #237', '20 de Noviembre, 4to Tramo', 'Venustiano Carranza', 15300, 19.4502972575009, -99.1090313746857, NULL);

-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `ct_estado`
-- 

DROP TABLE IF EXISTS `ct_estado`;
CREATE TABLE IF NOT EXISTS `ct_estado` (
  `id_estado` int(10) unsigned NOT NULL,
  `nombre` varchar(100) collate latin1_spanish_ci NOT NULL,
  PRIMARY KEY  (`id_estado`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

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
INSERT INTO `ct_estado` VALUES (15, 'Estado de M&eacute;xico');
INSERT INTO `ct_estado` VALUES (16, ' Michoacan de Ocampo');
INSERT INTO `ct_estado` VALUES (17, ' Morelos');
INSERT INTO `ct_estado` VALUES (18, ' Nayarit');
INSERT INTO `ct_estado` VALUES (19, ' Nuevo Leon');
INSERT INTO `ct_estado` VALUES (20, ' Oaxaca');
INSERT INTO `ct_estado` VALUES (21, ' Puebla');
INSERT INTO `ct_estado` VALUES (22, ' Quer&eacute;taro');
INSERT INTO `ct_estado` VALUES (23, ' Quintana Roo');
INSERT INTO `ct_estado` VALUES (24, ' San Luis Potosi');
INSERT INTO `ct_estado` VALUES (25, ' Sinaloa');
INSERT INTO `ct_estado` VALUES (26, ' Sonora');
INSERT INTO `ct_estado` VALUES (27, ' Tabasco');
INSERT INTO `ct_estado` VALUES (28, ' Tamaulipas');
INSERT INTO `ct_estado` VALUES (29, ' Tlaxcala');
INSERT INTO `ct_estado` VALUES (30, ' Veracruz de Ignacio de la Llave');
INSERT INTO `ct_estado` VALUES (31, ' Yucatan');
INSERT INTO `ct_estado` VALUES (32, ' Zacatecas');

-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `ct_foto_inmueble`
-- 

DROP TABLE IF EXISTS `ct_foto_inmueble`;
CREATE TABLE IF NOT EXISTS `ct_foto_inmueble` (
  `id_foto` int(10) unsigned NOT NULL auto_increment,
  `id_inmueble` int(10) unsigned NOT NULL,
  `url_imagen` varchar(250) collate latin1_spanish_ci NOT NULL,
  PRIMARY KEY  (`id_foto`),
  KEY `FK_FOTO_INMUEBLE` (`id_inmueble`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci AUTO_INCREMENT=15 ;

-- 
-- Volcar la base de datos para la tabla `ct_foto_inmueble`
-- 


-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `ct_inmobiliaria`
-- 

DROP TABLE IF EXISTS `ct_inmobiliaria`;
CREATE TABLE IF NOT EXISTS `ct_inmobiliaria` (
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
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci AUTO_INCREMENT=2 ;

-- 
-- Volcar la base de datos para la tabla `ct_inmobiliaria`
-- 

INSERT INTO `ct_inmobiliaria` VALUES (1, NULL, 'Inmovitek MÃ©xico', 'KAL75-PQPCA-S9PLS-K486M-OPEUM', 'global\\inmobiliaria\\1', NULL, 1);

-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `ct_inmueble`
-- 

DROP TABLE IF EXISTS `ct_inmueble`;
CREATE TABLE IF NOT EXISTS `ct_inmueble` (
  `id_inmueble` int(10) unsigned NOT NULL auto_increment,
  `fecha_registro` date NOT NULL,
  `id_tipo_inmueble` int(10) unsigned NOT NULL,
  `metros_cuadrados` float NOT NULL,
  `num_recamaras` int(11) NOT NULL,
  `num_sanitarios` int(11) NOT NULL,
  `alberca` tinyint(1) NOT NULL,
  `cochera` tinyint(1) NOT NULL,
  `num_autos_cochera` int(11) NOT NULL,
  `num_plantas` int(11) NOT NULL,
  `precio` float NOT NULL,
  `detalles` longtext collate latin1_spanish_ci,
  `venta_renta` tinyint(1) NOT NULL,
  `id_usuario` int(10) unsigned NOT NULL,
  `vendida_rentada` tinyint(1) NOT NULL COMMENT 'Vendida = 1\nRentada = 1',
  `id_propietario` int(10) unsigned default NULL,
  `activo` tinyint(1) NOT NULL,
  PRIMARY KEY  (`id_inmueble`),
  KEY `FK_INMUEBLE_TIPO` (`id_tipo_inmueble`),
  KEY `FK_INMUEBLE_INMOBILIARIA` (`id_usuario`),
  KEY `FK_INMUEBLE_PROPIETARIO` (`id_propietario`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci AUTO_INCREMENT=9 ;

-- 
-- Volcar la base de datos para la tabla `ct_inmueble`
-- 

INSERT INTO `ct_inmueble` VALUES (8, '2013-10-06', 1, 57, 8, 2, 0, 1, 0, 2, 1.45e+006, 'Bonita Casa ubicada en colonia popular. Cuenta con varias ventanas y esta orientada hacia el este por lo cual contarÃ¡ con una excelente iluminaciÃ³n durante el dÃ­a.', 1, 1, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (7, '2013-08-22', 1, 450, 20, 2, 0, 0, 0, 2, 350000, 'Inmueble X', 1, 2, 0, NULL, 1);

-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `ct_inmueble_promocionado`
-- 

DROP TABLE IF EXISTS `ct_inmueble_promocionado`;
CREATE TABLE IF NOT EXISTS `ct_inmueble_promocionado` (
  `id_inmueble` int(10) unsigned NOT NULL,
  `rank` float NOT NULL default '0',
  `no_clicks` int(11) NOT NULL,
  `promocion_inicia` date NOT NULL,
  `promocion_termina` date NOT NULL,
  PRIMARY KEY  (`id_inmueble`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- 
-- Volcar la base de datos para la tabla `ct_inmueble_promocionado`
-- 


-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `ct_licencia`
-- 

DROP TABLE IF EXISTS `ct_licencia`;
CREATE TABLE IF NOT EXISTS `ct_licencia` (
  `licencia` varchar(30) collate latin1_spanish_ci NOT NULL,
  `activacion` tinyint(1) NOT NULL,
  `numero_usuarios` int(11) NOT NULL,
  `usuarios_activos` int(11) NOT NULL,
  `fecha_activacion` date NOT NULL,
  `fecha_termino` date NOT NULL,
  PRIMARY KEY  (`licencia`),
  KEY `INDEX_TERMINO` (`fecha_termino`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- 
-- Volcar la base de datos para la tabla `ct_licencia`
-- 

INSERT INTO `ct_licencia` VALUES ('KAL75-PQPCA-S9PLS-K486M-OPEUM', 1, 10, 3, '2013-07-18', '2014-07-18');

-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `ct_limite_usuario`
-- 

DROP TABLE IF EXISTS `ct_limite_usuario`;
CREATE TABLE IF NOT EXISTS `ct_limite_usuario` (
  `id_usuario` int(10) unsigned NOT NULL,
  `limite_inmuebles` int(11) NOT NULL default '0',
  `caducidad_cuenta` date NOT NULL,
  PRIMARY KEY  (`id_usuario`),
  KEY `FK_LIMITE_USUARIO` (`id_usuario`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- 
-- Volcar la base de datos para la tabla `ct_limite_usuario`
-- 

INSERT INTO `ct_limite_usuario` VALUES (1, 0, '2014-07-18');
INSERT INTO `ct_limite_usuario` VALUES (2, 3, '0000-00-00');

-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `ct_perfil_cliente`
-- 

DROP TABLE IF EXISTS `ct_perfil_cliente`;
CREATE TABLE IF NOT EXISTS `ct_perfil_cliente` (
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
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- 
-- Volcar la base de datos para la tabla `ct_perfil_cliente`
-- 


-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `ct_permisos_usuario`
-- 

DROP TABLE IF EXISTS `ct_permisos_usuario`;
CREATE TABLE IF NOT EXISTS `ct_permisos_usuario` (
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
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- 
-- Volcar la base de datos para la tabla `ct_permisos_usuario`
-- 

INSERT INTO `ct_permisos_usuario` VALUES (1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1);
INSERT INTO `ct_permisos_usuario` VALUES (2, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0);
INSERT INTO `ct_permisos_usuario` VALUES (6, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1);
INSERT INTO `ct_permisos_usuario` VALUES (7, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1);

-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `ct_renta`
-- 

DROP TABLE IF EXISTS `ct_renta`;
CREATE TABLE IF NOT EXISTS `ct_renta` (
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
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci AUTO_INCREMENT=1 ;

-- 
-- Volcar la base de datos para la tabla `ct_renta`
-- 


-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `ct_telefono_cliente`
-- 

DROP TABLE IF EXISTS `ct_telefono_cliente`;
CREATE TABLE IF NOT EXISTS `ct_telefono_cliente` (
  `id_telefono_cliente` int(10) unsigned NOT NULL auto_increment,
  `id_cliente` int(10) unsigned NOT NULL,
  `telefono_cliente` varchar(30) collate latin1_spanish_ci NOT NULL,
  PRIMARY KEY  (`id_telefono_cliente`),
  KEY `FK_TELEFONO_CLIENTE` (`id_cliente`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci AUTO_INCREMENT=1 ;

-- 
-- Volcar la base de datos para la tabla `ct_telefono_cliente`
-- 


-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `ct_telefono_inmobiliaria`
-- 

DROP TABLE IF EXISTS `ct_telefono_inmobiliaria`;
CREATE TABLE IF NOT EXISTS `ct_telefono_inmobiliaria` (
  `id_telefono` int(10) unsigned NOT NULL auto_increment,
  `id_inmobiliaria` int(10) unsigned NOT NULL,
  `telefono_inmobiliaria` varchar(30) collate latin1_spanish_ci NOT NULL,
  PRIMARY KEY  (`id_telefono`),
  KEY `FK_TELEFONO_INMOBILIARIA` (`id_inmobiliaria`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci AUTO_INCREMENT=2 ;

-- 
-- Volcar la base de datos para la tabla `ct_telefono_inmobiliaria`
-- 

INSERT INTO `ct_telefono_inmobiliaria` VALUES (1, 1, '5557429841');

-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `ct_tipo_inmueble`
-- 

DROP TABLE IF EXISTS `ct_tipo_inmueble`;
CREATE TABLE IF NOT EXISTS `ct_tipo_inmueble` (
  `id_tipo_inmueble` int(10) unsigned NOT NULL auto_increment,
  `tipo_inmueble` varchar(60) collate latin1_spanish_ci NOT NULL,
  PRIMARY KEY  (`id_tipo_inmueble`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci AUTO_INCREMENT=14 ;

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

DROP TABLE IF EXISTS `ct_usuario`;
CREATE TABLE IF NOT EXISTS `ct_usuario` (
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
  PRIMARY KEY  (`id_usuario`),
  UNIQUE KEY `INDEX_NOMBRE_USUARIO` (`nombre_usuario`),
  KEY `FK_USUARIO_INMOBILIARIA` (`id_inmobiliaria`),
  KEY `INDEX_CORREO` (`correo`),
  KEY `INDEX_LOGIN_USUARIO` (`nombre_usuario`,`password`),
  KEY `INDEX_LOGIN_CORREO` (`correo`,`password`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci AUTO_INCREMENT=8 ;

-- 
-- Volcar la base de datos para la tabla `ct_usuario`
-- 

INSERT INTO `ct_usuario` VALUES (1, NULL, 1, 'Miguel', 'PÃ©rez', 'Horta', 'maph6_5@hotmail.com', 'c5c7de4adc30ab026a30dc75320fa449', '5532987456', '5596788450', '2013-07-18 01:09:12', NULL, 1);
INSERT INTO `ct_usuario` VALUES (2, NULL, NULL, NULL, NULL, NULL, 'mperez@enginetec.com.mx', 'c5c7de4adc30ab026a30dc75320fa449', NULL, NULL, '2013-07-18 01:16:31', NULL, 1);
INSERT INTO `ct_usuario` VALUES (6, NULL, 1, 'Manuel', 'RodrÃ­guez', 'GarcÃ­a', 'manuel@enginetec.com.mx', 'c5c7de4adc30ab026a30dc75320fa449', NULL, NULL, '2013-08-25 16:27:36', NULL, 1);
INSERT INTO `ct_usuario` VALUES (7, NULL, 1, 'Tania', 'HernÃ¡ndez', 'Zarate', 'lizmaf@enginetec.com.mx', '23791671023ee3213adc701b5477fd5c', NULL, NULL, '2013-08-25 16:30:10', NULL, 1);

-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `ct_visita_virtual`
-- 

DROP TABLE IF EXISTS `ct_visita_virtual`;
CREATE TABLE IF NOT EXISTS `ct_visita_virtual` (
  `id_visitavirtual` int(10) unsigned NOT NULL auto_increment,
  `id_inmueble` int(10) unsigned NOT NULL,
  `nombre_habitacion` varchar(150) collate latin1_spanish_ci NOT NULL,
  `url_visitavirtual` varchar(200) collate latin1_spanish_ci NOT NULL,
  PRIMARY KEY  (`id_visitavirtual`),
  KEY `FK_VISITAVIRTUAL_INMUEBLE` (`id_inmueble`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci AUTO_INCREMENT=1 ;

-- 
-- Volcar la base de datos para la tabla `ct_visita_virtual`
-- 


-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `ht_agenda_usuario`
-- 

DROP TABLE IF EXISTS `ht_agenda_usuario`;
CREATE TABLE IF NOT EXISTS `ht_agenda_usuario` (
  `id_registro` int(10) unsigned NOT NULL auto_increment,
  `id_usuario` int(10) unsigned NOT NULL,
  `titulo` varchar(200) collate latin1_spanish_ci NOT NULL,
  `detalles` longtext collate latin1_spanish_ci NOT NULL,
  `fecha_inicio` datetime NOT NULL,
  `fecha_termino` datetime default NULL,
  PRIMARY KEY  (`id_registro`),
  KEY `FK_EVENTO_USUARIO` (`id_usuario`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci PACK_KEYS=1 AUTO_INCREMENT=3 ;

-- 
-- Volcar la base de datos para la tabla `ht_agenda_usuario`
-- 


-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `ht_mensaje_inmobiliaria`
-- 

DROP TABLE IF EXISTS `ht_mensaje_inmobiliaria`;
CREATE TABLE IF NOT EXISTS `ht_mensaje_inmobiliaria` (
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
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci AUTO_INCREMENT=1 ;

-- 
-- Volcar la base de datos para la tabla `ht_mensaje_inmobiliaria`
-- 


-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `ht_mensaje_usuario`
-- 

DROP TABLE IF EXISTS `ht_mensaje_usuario`;
CREATE TABLE IF NOT EXISTS `ht_mensaje_usuario` (
  `id_mensaje` int(10) unsigned NOT NULL auto_increment,
  `id_usuario_emisor` int(10) unsigned NOT NULL,
  `id_usuario_receptor` int(10) unsigned NOT NULL,
  `asunto` varchar(200) collate latin1_spanish_ci NOT NULL,
  `mensaje` longtext collate latin1_spanish_ci NOT NULL,
  `fecha` datetime NOT NULL,
  `leido` tinyint(1) NOT NULL,
  `fecha_leido` datetime default NULL,
  `satus_emisor` tinyint(1) NOT NULL,
  `status_receptor` tinyint(1) NOT NULL,
  PRIMARY KEY  (`id_mensaje`),
  KEY `FK_USUARIO_EMISOR` (`id_usuario_emisor`),
  KEY `FK_USUARIO_RECPETOR` (`id_usuario_receptor`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci AUTO_INCREMENT=1 ;

-- 
-- Volcar la base de datos para la tabla `ht_mensaje_usuario`
-- 


-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `ht_pago_renta`
-- 

DROP TABLE IF EXISTS `ht_pago_renta`;
CREATE TABLE IF NOT EXISTS `ht_pago_renta` (
  `id_pago_renta` int(10) unsigned NOT NULL auto_increment,
  `id_renta` int(10) unsigned NOT NULL,
  `cantidad_pagada` float NOT NULL,
  `fecha_pago` date NOT NULL,
  `periodo` varchar(250) collate latin1_spanish_ci NOT NULL,
  PRIMARY KEY  (`id_pago_renta`),
  KEY `FK_PAGO_ALQUILER` (`id_renta`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci AUTO_INCREMENT=1 ;

-- 
-- Volcar la base de datos para la tabla `ht_pago_renta`
-- 


-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `ht_venta`
-- 

DROP TABLE IF EXISTS `ht_venta`;
CREATE TABLE IF NOT EXISTS `ht_venta` (
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
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci AUTO_INCREMENT=1 ;

-- 
-- Volcar la base de datos para la tabla `ht_venta`
-- 


-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `rl_inmobiliaria_amiga`
-- 

DROP TABLE IF EXISTS `rl_inmobiliaria_amiga`;
CREATE TABLE IF NOT EXISTS `rl_inmobiliaria_amiga` (
  `id_inmobiliaria` int(10) unsigned NOT NULL,
  `id_inmobiliaria_amiga` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`id_inmobiliaria`,`id_inmobiliaria_amiga`),
  KEY `fk_inmobiliaria_idx` (`id_inmobiliaria`),
  KEY `fk_inmobiliaria_amiga_idx` (`id_inmobiliaria_amiga`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- 
-- Volcar la base de datos para la tabla `rl_inmobiliaria_amiga`
-- 


-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `rl_inmueble_ofrecido_cliente`
-- 

DROP TABLE IF EXISTS `rl_inmueble_ofrecido_cliente`;
CREATE TABLE IF NOT EXISTS `rl_inmueble_ofrecido_cliente` (
  `id_cliente` int(10) unsigned NOT NULL,
  `id_inmueble` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`id_cliente`,`id_inmueble`),
  KEY `CLIENTE_RECHAZA_INMUEBLE` (`id_cliente`),
  KEY `INMUEBLE_RECHAZADO_CLIENTE` (`id_inmueble`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- 
-- Volcar la base de datos para la tabla `rl_inmueble_ofrecido_cliente`
-- 


-- --------------------------------------------------------

-- 
-- Estructura Stand-in para la vista `vw_inmobiliaria_cliente`
-- 
CREATE TABLE IF NOT EXISTS `vw_inmobiliaria_cliente` (
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
CREATE TABLE IF NOT EXISTS `vw_inmobiliaria_inmueble` (
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
,`precio` float
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

DROP VIEW IF EXISTS `vw_inmobiliaria_cliente`;
CREATE ALGORITHM=UNDEFINED DEFINER=`inmovi`@`localhost` SQL SECURITY DEFINER VIEW `inmovitek`.`vw_inmobiliaria_cliente` AS select `cte`.`id_cliente` AS `id_cliente`,`cte`.`id_usuario` AS `id_usuario`,`cte`.`nombre` AS `nombre`,`cte`.`correo` AS `correo`,`cte`.`telefono` AS `telefono`,`cte`.`horario_llamada` AS `horario_llamada`,`cte`.`anotaciones` AS `anotaciones`,`cte`.`fecha_alta` AS `fecha_alta`,`usr`.`id_inmobiliaria` AS `id_inmobiliaria` from (`inmovitek`.`ct_cliente` `cte` join `inmovitek`.`ct_usuario` `usr`) where (`cte`.`id_usuario` = `usr`.`id_usuario`);

-- --------------------------------------------------------

-- 
-- Estructura para la vista `vw_inmobiliaria_inmueble`
-- 
DROP TABLE IF EXISTS `vw_inmobiliaria_inmueble`;

DROP VIEW IF EXISTS `vw_inmobiliaria_inmueble`;
CREATE ALGORITHM=UNDEFINED DEFINER=`inmovi`@`localhost` SQL SECURITY DEFINER VIEW `inmovitek`.`vw_inmobiliaria_inmueble` AS select `inm`.`id_inmueble` AS `id_inmueble`,`inm`.`fecha_registro` AS `fecha_registro`,`inm`.`id_tipo_inmueble` AS `id_tipo_inmueble`,`inm`.`metros_cuadrados` AS `metros_cuadrados`,`inm`.`num_recamaras` AS `num_recamaras`,`inm`.`num_sanitarios` AS `num_sanitarios`,`inm`.`alberca` AS `alberca`,`inm`.`cochera` AS `cochera`,`inm`.`num_autos_cochera` AS `num_autos_cochera`,`inm`.`num_plantas` AS `num_plantas`,`inm`.`precio` AS `precio`,`inm`.`detalles` AS `detalles`,`inm`.`venta_renta` AS `venta_renta`,`inm`.`id_usuario` AS `id_usuario`,`inm`.`vendida_rentada` AS `vendida_rentada`,`inm`.`id_propietario` AS `id_propietario`,`inm`.`activo` AS `activo`,`usr`.`id_inmobiliaria` AS `id_inmobiliaria` from (`inmovitek`.`ct_inmueble` `inm` join `inmovitek`.`ct_usuario` `usr`) where (`inm`.`id_usuario` = `usr`.`id_usuario`);
