SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

DROP SCHEMA IF EXISTS `inmovitek` ;
CREATE SCHEMA IF NOT EXISTS `inmovitek` DEFAULT CHARACTER SET latin1 COLLATE latin1_spanish_ci ;
USE `inmovitek` ;

-- -----------------------------------------------------
-- Table `inmovitek`.`ct_licencia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `inmovitek`.`ct_licencia` ;

CREATE TABLE IF NOT EXISTS `inmovitek`.`ct_licencia` (
  `licencia` VARCHAR(30) NOT NULL,
  `activacion` TINYINT(1) NOT NULL,
  `numero_usuarios` INT NOT NULL,
  `usuarios_activos` INT NOT NULL,
  `fecha_activacion` DATE NOT NULL,
  `fecha_termino` DATE NOT NULL,
  PRIMARY KEY (`licencia`))
DEFAULT CHARACTER SET = latin1     ENGINE = InnoDB
COLLATE = latin1_spanish_ci;

CREATE INDEX `INDEX_TERMINO` ON `inmovitek`.`ct_licencia` (`fecha_termino` ASC);


-- -----------------------------------------------------
-- Table `inmovitek`.`ct_inmobiliaria`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `inmovitek`.`ct_inmobiliaria` ;

CREATE TABLE IF NOT EXISTS `inmovitek`.`ct_inmobiliaria` (
  `id_inmobiliaria` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `identificador` VARCHAR(50) NULL,
  `nombre` VARCHAR(100) NOT NULL,
  `licencia` VARCHAR(30) NOT NULL,
  `directorio_archivos` VARCHAR(250) NULL,
  `url_logo` VARCHAR(250) NULL,
  `inmobiliaria_activa` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id_inmobiliaria`),
  CONSTRAINT `fk_licencia`
    FOREIGN KEY (`licencia`)
    REFERENCES `inmovitek`.`ct_licencia` (`licencia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1     ENGINE = InnoDB
COLLATE = latin1_spanish_ci;

CREATE INDEX `FK_INMOBILIARIA_LICENCIA` ON `inmovitek`.`ct_inmobiliaria` (`licencia` ASC);

CREATE UNIQUE INDEX `INDEX_IDENTIFICADOR` ON `inmovitek`.`ct_inmobiliaria` (`identificador` ASC);


-- -----------------------------------------------------
-- Table `inmovitek`.`ct_usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `inmovitek`.`ct_usuario` ;

CREATE TABLE IF NOT EXISTS `inmovitek`.`ct_usuario` (
  `id_usuario` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre_usuario` VARCHAR(60) NULL,
  `id_inmobiliaria` INT UNSIGNED NULL,
  `nombres` VARCHAR(50) NULL,
  `apellido_p` VARCHAR(40) NULL,
  `apellido_m` VARCHAR(40) NULL,
  `correo` VARCHAR(40) NOT NULL,
  `password` VARCHAR(80) NOT NULL,
  `telefono_casa` VARCHAR(30) NULL DEFAULT NULL,
  `telefono_celular` VARCHAR(30) NULL DEFAULT NULL,
  `fecha_alta` TIMESTAMP NOT NULL,
  `fecha_nacimiento` DATE NULL,
  `usuario_activo` TINYINT(1) NOT NULL,
  `tokenGoogleAccount` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id_usuario`),
  CONSTRAINT `fk_usuario_inmobiliaria`
    FOREIGN KEY (`id_inmobiliaria`)
    REFERENCES `inmovitek`.`ct_inmobiliaria` (`id_inmobiliaria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1     ENGINE = InnoDB
COLLATE = latin1_spanish_ci;

CREATE INDEX `FK_USUARIO_INMOBILIARIA` ON `inmovitek`.`ct_usuario` (`id_inmobiliaria` ASC);

CREATE UNIQUE INDEX `INDEX_NOMBRE_USUARIO` ON `inmovitek`.`ct_usuario` (`nombre_usuario` ASC);

CREATE INDEX `INDEX_CORREO` ON `inmovitek`.`ct_usuario` (`correo` ASC);

CREATE INDEX `INDEX_LOGIN_USUARIO` ON `inmovitek`.`ct_usuario` (`nombre_usuario` ASC, `password` ASC);

CREATE INDEX `INDEX_LOGIN_CORREO` ON `inmovitek`.`ct_usuario` (`correo` ASC, `password` ASC);


-- -----------------------------------------------------
-- Table `inmovitek`.`ht_agenda_usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `inmovitek`.`ht_agenda_usuario` ;

CREATE TABLE IF NOT EXISTS `inmovitek`.`ht_agenda_usuario` (
  `id_registro` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_usuario` INT UNSIGNED NOT NULL,
  `titulo` VARCHAR(200) NOT NULL,
  `detalles` LONGTEXT NOT NULL,
  `fecha_inicio` DATETIME NOT NULL,
  `fecha_termino` DATETIME NULL,
  PRIMARY KEY (`id_registro`),
  CONSTRAINT `fk_usuario_agenda`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `inmovitek`.`ct_usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1     ENGINE = InnoDB
COLLATE = latin1_spanish_ci
PACK_KEYS = 1;

CREATE INDEX `FK_EVENTO_USUARIO` ON `inmovitek`.`ht_agenda_usuario` (`id_usuario` ASC);


-- -----------------------------------------------------
-- Table `inmovitek`.`ct_tipo_inmueble`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `inmovitek`.`ct_tipo_inmueble` ;

CREATE TABLE IF NOT EXISTS `inmovitek`.`ct_tipo_inmueble` (
  `id_tipo_inmueble` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `tipo_inmueble` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`id_tipo_inmueble`))
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1     ENGINE = InnoDB
COLLATE = latin1_spanish_ci;


-- -----------------------------------------------------
-- Table `inmovitek`.`ct_cliente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `inmovitek`.`ct_cliente` ;

CREATE TABLE IF NOT EXISTS `inmovitek`.`ct_cliente` (
  `id_cliente` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_usuario` INT UNSIGNED NOT NULL,
  `nombre` VARCHAR(250) NOT NULL,
  `correo` VARCHAR(45) NULL,
  `telefono` VARCHAR(80) NULL,
  `horario_llamada` VARCHAR(140) NULL DEFAULT NULL,
  `anotaciones` LONGTEXT NULL DEFAULT NULL,
  `fecha_alta` DATE NOT NULL,
  PRIMARY KEY (`id_cliente`),
  CONSTRAINT `fk_cliente_usuario`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `inmovitek`.`ct_usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1     ENGINE = InnoDB
COLLATE = latin1_spanish_ci;

CREATE INDEX `FK_CLIENTE_INMOBILIARIA` ON `inmovitek`.`ct_cliente` (`id_usuario` ASC);


-- -----------------------------------------------------
-- Table `inmovitek`.`ct_inmueble`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `inmovitek`.`ct_inmueble` ;

CREATE TABLE IF NOT EXISTS `inmovitek`.`ct_inmueble` (
  `id_inmueble` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `fecha_registro` DATE NOT NULL,
  `id_tipo_inmueble` INT UNSIGNED NOT NULL,
  `metros_cuadrados` FLOAT NOT NULL,
  `num_recamaras` INT NOT NULL,
  `num_sanitarios` INT NOT NULL,
  `alberca` TINYINT(1) NOT NULL,
  `cochera` TINYINT(1) NOT NULL,
  `num_autos_cochera` INT NULL,
  `num_plantas` INT NOT NULL,
  `precio` BIGINT NOT NULL,
  `detalles` LONGTEXT NULL,
  `venta_renta` TINYINT(1) NOT NULL COMMENT 'Inmueble en venta = 1\nInmueble en renta = 2',
  `id_usuario` INT UNSIGNED NOT NULL,
  `vendida_rentada` TINYINT(1) NOT NULL COMMENT 'Vendida = 1\nRentada = 1',
  `id_propietario` INT UNSIGNED NULL,
  `activo` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id_inmueble`),
  CONSTRAINT `fk_tipo_propiedad`
    FOREIGN KEY (`id_tipo_inmueble`)
    REFERENCES `inmovitek`.`ct_tipo_inmueble` (`id_tipo_inmueble`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `inmovitek`.`ct_usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_propietario`
    FOREIGN KEY (`id_propietario`)
    REFERENCES `inmovitek`.`ct_cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = latin1     ENGINE = InnoDB
COLLATE = latin1_spanish_ci;

CREATE INDEX `FK_INMUEBLE_TIPO` ON `inmovitek`.`ct_inmueble` (`id_tipo_inmueble` ASC);

CREATE INDEX `FK_INMUEBLE_INMOBILIARIA` ON `inmovitek`.`ct_inmueble` (`id_usuario` ASC);

CREATE INDEX `FK_INMUEBLE_PROPIETARIO` ON `inmovitek`.`ct_inmueble` (`id_propietario` ASC);


-- -----------------------------------------------------
-- Table `inmovitek`.`ct_renta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `inmovitek`.`ct_renta` ;

CREATE TABLE IF NOT EXISTS `inmovitek`.`ct_renta` (
  `id_renta` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_inmueble` INT UNSIGNED NOT NULL,
  `cliente_alquila` INT UNSIGNED NOT NULL,
  `fecha_registro` DATE NOT NULL,
  `periodo_renta` INT NOT NULL,
  `precio_renta` FLOAT NOT NULL,
  `proximo_cobro` DATE NULL DEFAULT NULL,
  `anotaciones` LONGTEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id_renta`),
  CONSTRAINT `fk_renta_inmueble`
    FOREIGN KEY (`id_inmueble`)
    REFERENCES `inmovitek`.`ct_inmueble` (`id_inmueble`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cliente_alquila`
    FOREIGN KEY (`cliente_alquila`)
    REFERENCES `inmovitek`.`ct_cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1     ENGINE = InnoDB
COLLATE = latin1_spanish_ci;

CREATE INDEX `FK_RENTA_INMUEBLE` ON `inmovitek`.`ct_renta` (`id_inmueble` ASC);

CREATE INDEX `FK_RENTA_CLIENTE` ON `inmovitek`.`ct_renta` (`cliente_alquila` ASC);


-- -----------------------------------------------------
-- Table `inmovitek`.`ct_estado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `inmovitek`.`ct_estado` ;

CREATE TABLE IF NOT EXISTS `inmovitek`.`ct_estado` (
  `id_estado` INT UNSIGNED NOT NULL,
  `nombre` VARCHAR(100) NOT NULL,
  `codigo_estado` VARCHAR(50) NOT NULL,
  `latitud` DOUBLE NOT NULL,
  `longitud` DOUBLE NOT NULL,
  PRIMARY KEY (`id_estado`))
DEFAULT CHARACTER SET = latin1     ENGINE = InnoDB
COLLATE = latin1_spanish_ci;
;


-- -----------------------------------------------------
-- Table `inmovitek`.`ct_perfil_cliente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `inmovitek`.`ct_perfil_cliente` ;

CREATE TABLE IF NOT EXISTS `inmovitek`.`ct_perfil_cliente` (
  `id_cliente` INT UNSIGNED NOT NULL,
  `id_estado_busca_inmueble` INT UNSIGNED NOT NULL,
  `id_tipo_inmueble` INT UNSIGNED NOT NULL,
  `no_habitaciones_min` INT NOT NULL,
  `no_habitaciones_max` INT NOT NULL,
  `alberca` TINYINT(1) NOT NULL,
  `no_sanitarios_min` INT NOT NULL,
  `no_sanitarios_max` INT NOT NULL,
  `cochera` TINYINT(1) NOT NULL,
  `no_plantas` INT NOT NULL,
  `rango_precio_min` INT NOT NULL,
  `rango_precio_max` INT NOT NULL,
  `compra_renta` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id_cliente`),
  CONSTRAINT `fk_perfilcte_estado`
    FOREIGN KEY (`id_estado_busca_inmueble`)
    REFERENCES `inmovitek`.`ct_estado` (`id_estado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cte_tipo_inmueble`
    FOREIGN KEY (`id_tipo_inmueble`)
    REFERENCES `inmovitek`.`ct_tipo_inmueble` (`id_tipo_inmueble`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_perfil_cliente`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `inmovitek`.`ct_cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
DEFAULT CHARACTER SET = latin1     ENGINE = InnoDB
COLLATE = latin1_spanish_ci;

CREATE INDEX `FK_COMPRA_ESTADO` ON `inmovitek`.`ct_perfil_cliente` (`id_estado_busca_inmueble` ASC);

CREATE INDEX `FK_COMPRA_TIPO` ON `inmovitek`.`ct_perfil_cliente` (`id_tipo_inmueble` ASC);

CREATE INDEX `FK_CLIENTE_COMPRA` ON `inmovitek`.`ct_perfil_cliente` (`id_cliente` ASC);


-- -----------------------------------------------------
-- Table `inmovitek`.`ct_direccion_inmueble`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `inmovitek`.`ct_direccion_inmueble` ;

CREATE TABLE IF NOT EXISTS `inmovitek`.`ct_direccion_inmueble` (
  `id_inmueble` INT UNSIGNED NOT NULL,
  `id_estado` INT UNSIGNED NOT NULL,
  `calle_no` VARCHAR(200) NOT NULL,
  `colonia` VARCHAR(100) NOT NULL,
  `municipio` VARCHAR(100) NOT NULL,
  `cp` INT(6) NOT NULL,
  `latitud` DOUBLE NOT NULL,
  `longitud` DOUBLE NOT NULL,
  `domicilio_completo` VARCHAR(250) NULL,
  PRIMARY KEY (`id_inmueble`),
  CONSTRAINT `fk_estado_direccion_inmueble`
    FOREIGN KEY (`id_estado`)
    REFERENCES `inmovitek`.`ct_estado` (`id_estado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_direccion_inmueble`
    FOREIGN KEY (`id_inmueble`)
    REFERENCES `inmovitek`.`ct_inmueble` (`id_inmueble`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
DEFAULT CHARACTER SET = latin1     ENGINE = InnoDB
COLLATE = latin1_spanish_ci;

CREATE INDEX `FK_DIRECCION_INMUEBLE` ON `inmovitek`.`ct_direccion_inmueble` (`id_inmueble` ASC);

CREATE INDEX `FK_DIRECCION_ESTADO` ON `inmovitek`.`ct_direccion_inmueble` (`id_estado` ASC);

CREATE INDEX `INDEX_LATITUD` ON `inmovitek`.`ct_direccion_inmueble` (`latitud` ASC);

CREATE INDEX `INDEX_LONGITUD` ON `inmovitek`.`ct_direccion_inmueble` (`longitud` ASC);

CREATE INDEX `INDEX_CP` ON `inmovitek`.`ct_direccion_inmueble` (`cp` ASC);

CREATE INDEX `INDEX_MUNICIPIO` ON `inmovitek`.`ct_direccion_inmueble` (`municipio` ASC);


-- -----------------------------------------------------
-- Table `inmovitek`.`ct_foto_inmueble`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `inmovitek`.`ct_foto_inmueble` ;

CREATE TABLE IF NOT EXISTS `inmovitek`.`ct_foto_inmueble` (
  `id_foto` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_inmueble` INT UNSIGNED NOT NULL,
  `url_imagen` VARCHAR(250) NOT NULL,
  PRIMARY KEY (`id_foto`),
  CONSTRAINT `fk_foto_inmueble`
    FOREIGN KEY (`id_inmueble`)
    REFERENCES `inmovitek`.`ct_inmueble` (`id_inmueble`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1     ENGINE = InnoDB
COLLATE = latin1_spanish_ci;

CREATE INDEX `FK_FOTO_INMUEBLE` ON `inmovitek`.`ct_foto_inmueble` (`id_inmueble` ASC);


-- -----------------------------------------------------
-- Table `inmovitek`.`rl_inmueble_ofrecido_cliente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `inmovitek`.`rl_inmueble_ofrecido_cliente` ;

CREATE TABLE IF NOT EXISTS `inmovitek`.`rl_inmueble_ofrecido_cliente` (
  `id_cliente` INT UNSIGNED NOT NULL,
  `id_inmueble` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_cliente`, `id_inmueble`),
  CONSTRAINT `fk_cliente_ofrecido`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `inmovitek`.`ct_cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_inmueble_ofrecido_cte`
    FOREIGN KEY (`id_inmueble`)
    REFERENCES `inmovitek`.`ct_inmueble` (`id_inmueble`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
DEFAULT CHARACTER SET = latin1     ENGINE = InnoDB
COLLATE = latin1_spanish_ci;

CREATE INDEX `CLIENTE_RECHAZA_INMUEBLE` ON `inmovitek`.`rl_inmueble_ofrecido_cliente` (`id_cliente` ASC);

CREATE INDEX `INMUEBLE_RECHAZADO_CLIENTE` ON `inmovitek`.`rl_inmueble_ofrecido_cliente` (`id_inmueble` ASC);


-- -----------------------------------------------------
-- Table `inmovitek`.`ht_mensaje_inmobiliaria`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `inmovitek`.`ht_mensaje_inmobiliaria` ;

CREATE TABLE IF NOT EXISTS `inmovitek`.`ht_mensaje_inmobiliaria` (
  `id_mensaje` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_inmobiliaria_emisor` INT UNSIGNED NOT NULL,
  `id_inmobiliaria_receptor` INT UNSIGNED NOT NULL,
  `asunto` VARCHAR(200) NOT NULL,
  `mensaje` LONGTEXT NOT NULL,
  `fecha` DATETIME NOT NULL,
  `leido` TINYINT(1) NOT NULL,
  `fecha_leido` DATETIME NULL,
  `status_emisor` TINYINT(1) NOT NULL,
  `status_receptor` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id_mensaje`),
  CONSTRAINT `fk_inmobiliaria_emisor`
    FOREIGN KEY (`id_inmobiliaria_emisor`)
    REFERENCES `inmovitek`.`ct_inmobiliaria` (`id_inmobiliaria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_inmobiliaria_receptor`
    FOREIGN KEY (`id_inmobiliaria_receptor`)
    REFERENCES `inmovitek`.`ct_inmobiliaria` (`id_inmobiliaria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1     ENGINE = InnoDB
COLLATE = latin1_spanish_ci;

CREATE INDEX `FK_INMOBILIARIA_EMISOR` ON `inmovitek`.`ht_mensaje_inmobiliaria` (`id_inmobiliaria_emisor` ASC);

CREATE INDEX `FK_INMOBILIARIA_RECEPTOR` ON `inmovitek`.`ht_mensaje_inmobiliaria` (`id_inmobiliaria_receptor` ASC);

CREATE INDEX `INDEX_RECEPTOR_NO_LEIDOS` ON `inmovitek`.`ht_mensaje_inmobiliaria` (`id_inmobiliaria_receptor` ASC, `leido` ASC);


-- -----------------------------------------------------
-- Table `inmovitek`.`ht_mensaje_usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `inmovitek`.`ht_mensaje_usuario` ;

CREATE TABLE IF NOT EXISTS `inmovitek`.`ht_mensaje_usuario` (
  `id_mensaje` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_usuario_emisor` INT UNSIGNED NOT NULL,
  `id_usuario_receptor` INT UNSIGNED NOT NULL,
  `asunto` VARCHAR(200) NOT NULL,
  `mensaje` LONGTEXT NOT NULL,
  `fecha` DATETIME NOT NULL,
  `leido` TINYINT(1) NOT NULL,
  `fecha_leido` DATETIME NULL,
  `status_emisor` TINYINT(1) NOT NULL,
  `status_receptor` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id_mensaje`),
  CONSTRAINT `fk_usuario_emisor`
    FOREIGN KEY (`id_usuario_emisor`)
    REFERENCES `inmovitek`.`ct_usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_receptor`
    FOREIGN KEY (`id_usuario_receptor`)
    REFERENCES `inmovitek`.`ct_usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)

AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1     ENGINE = InnoDB
COLLATE = latin1_spanish_ci;

CREATE INDEX `FK_USUARIO_EMISOR` ON `inmovitek`.`ht_mensaje_usuario` (`id_usuario_emisor` ASC);

CREATE INDEX `FK_USUARIO_RECPETOR` ON `inmovitek`.`ht_mensaje_usuario` (`id_usuario_receptor` ASC);


-- -----------------------------------------------------
-- Table `inmovitek`.`ht_pago_renta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `inmovitek`.`ht_pago_renta` ;

CREATE TABLE IF NOT EXISTS `inmovitek`.`ht_pago_renta` (
  `id_pago_renta` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_renta` INT UNSIGNED NOT NULL,
  `cantidad_pagada` FLOAT NOT NULL,
  `fecha_pago` DATE NOT NULL,
  `periodo` VARCHAR(250) NOT NULL,
  PRIMARY KEY (`id_pago_renta`),
  CONSTRAINT `fk_pago_renta`
    FOREIGN KEY (`id_renta`)
    REFERENCES `inmovitek`.`ct_renta` (`id_renta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1     ENGINE = InnoDB
COLLATE = latin1_spanish_ci;

CREATE INDEX `FK_PAGO_ALQUILER` ON `inmovitek`.`ht_pago_renta` (`id_renta` ASC);


-- -----------------------------------------------------
-- Table `inmovitek`.`ct_permisos_usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `inmovitek`.`ct_permisos_usuario` ;

CREATE TABLE IF NOT EXISTS `inmovitek`.`ct_permisos_usuario` (
  `id_usuario` INT UNSIGNED NOT NULL,
  `administrar_permisos` TINYINT(1) NOT NULL,
  `agenda` TINYINT(1) NOT NULL,
  `administrar_usuarios` TINYINT(1) NOT NULL,
  `registrar_venta` TINYINT(1) NOT NULL,
  `registrar_inmueble` TINYINT(1) NOT NULL,
  `registrar_cliente` TINYINT(1) NOT NULL,
  `eliminar_inmueble` TINYINT(1) NOT NULL,
  `eliminar_cliente` TINYINT(1) NOT NULL,
  `registrar_pago_renta` TINYINT(1) NOT NULL,
  `mensajes_inmobiliarias` TINYINT(1) NOT NULL,
  `mensajes_usuarios` TINYINT(1) NOT NULL,
  `inmobiliaria_amiga` TINYINT(1) NOT NULL,
  `administrar_inmobiliaria` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_usuario`),
  CONSTRAINT `fk_permisos_usuario`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `inmovitek`.`ct_usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
DEFAULT CHARACTER SET = latin1     ENGINE = InnoDB
COLLATE = latin1_spanish_ci;

CREATE INDEX `FK_PERMISO_USUARIO` ON `inmovitek`.`ct_permisos_usuario` (`id_usuario` ASC);


-- -----------------------------------------------------
-- Table `inmovitek`.`ct_telefono_cliente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `inmovitek`.`ct_telefono_cliente` ;

CREATE TABLE IF NOT EXISTS `inmovitek`.`ct_telefono_cliente` (
  `id_telefono_cliente` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_cliente` INT UNSIGNED NOT NULL,
  `telefono_cliente` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id_telefono_cliente`),
  CONSTRAINT `fk_telefono_cliente`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `inmovitek`.`ct_cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1     ENGINE = InnoDB
COLLATE = latin1_spanish_ci;

CREATE INDEX `FK_TELEFONO_CLIENTE` ON `inmovitek`.`ct_telefono_cliente` (`id_cliente` ASC);


-- -----------------------------------------------------
-- Table `inmovitek`.`ct_telefono_inmobiliaria`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `inmovitek`.`ct_telefono_inmobiliaria` ;

CREATE TABLE IF NOT EXISTS `inmovitek`.`ct_telefono_inmobiliaria` (
  `id_telefono` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_inmobiliaria` INT UNSIGNED NOT NULL,
  `telefono_inmobiliaria` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id_telefono`),
  CONSTRAINT `fk_telefono_inmobiliaria`
    FOREIGN KEY (`id_inmobiliaria`)
    REFERENCES `inmovitek`.`ct_inmobiliaria` (`id_inmobiliaria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1     ENGINE = InnoDB
COLLATE = latin1_spanish_ci;

CREATE INDEX `FK_TELEFONO_INMOBILIARIA` ON `inmovitek`.`ct_telefono_inmobiliaria` (`id_inmobiliaria` ASC);


-- -----------------------------------------------------
-- Table `inmovitek`.`ht_venta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `inmovitek`.`ht_venta` ;

CREATE TABLE IF NOT EXISTS `inmovitek`.`ht_venta` (
  `id_venta` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_inmueble` INT UNSIGNED NOT NULL,
  `id_vendedor` INT UNSIGNED NOT NULL,
  `id_comprador` INT UNSIGNED NOT NULL,
  `precio_venta` FLOAT NOT NULL,
  `ganancia_venta` FLOAT NULL,
  `fecha_venta` DATE NOT NULL,
  `anotaciones` LONGTEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id_venta`),
  CONSTRAINT `fk_inmueble_venta`
    FOREIGN KEY (`id_inmueble`)
    REFERENCES `inmovitek`.`ct_inmueble` (`id_inmueble`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_vendedor_venta`
    FOREIGN KEY (`id_vendedor`)
    REFERENCES `inmovitek`.`ct_usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cliente_compra`
    FOREIGN KEY (`id_comprador`)
    REFERENCES `inmovitek`.`ct_cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1     ENGINE = InnoDB
COLLATE = latin1_spanish_ci;

CREATE INDEX `FK_VENTA_INMUEBLE` ON `inmovitek`.`ht_venta` (`id_inmueble` ASC);

CREATE INDEX `FK_VENTA_VENDEDOR` ON `inmovitek`.`ht_venta` (`id_vendedor` ASC);

CREATE INDEX `FK_VENTA_COMPRADOR` ON `inmovitek`.`ht_venta` (`id_comprador` ASC);


-- -----------------------------------------------------
-- Table `inmovitek`.`ct_visita_virtual`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `inmovitek`.`ct_visita_virtual` ;

CREATE TABLE IF NOT EXISTS `inmovitek`.`ct_visita_virtual` (
  `id_visitavirtual` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_inmueble` INT UNSIGNED NOT NULL,
  `nombre_habitacion` VARCHAR(150) NOT NULL,
  `url_visitavirtual` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`id_visitavirtual`),
  CONSTRAINT `fk_virtual_inmueble`
    FOREIGN KEY (`id_inmueble`)
    REFERENCES `inmovitek`.`ct_inmueble` (`id_inmueble`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1     ENGINE = InnoDB
COLLATE = latin1_spanish_ci;

CREATE INDEX `FK_VISITAVIRTUAL_INMUEBLE` ON `inmovitek`.`ct_visita_virtual` (`id_inmueble` ASC);


-- -----------------------------------------------------
-- Table `inmovitek`.`rl_inmobiliaria_amiga`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `inmovitek`.`rl_inmobiliaria_amiga` ;

CREATE TABLE IF NOT EXISTS `inmovitek`.`rl_inmobiliaria_amiga` (
  `id_inmobiliaria` INT UNSIGNED NOT NULL,
  `id_inmobiliaria_amiga` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_inmobiliaria`, `id_inmobiliaria_amiga`),
  CONSTRAINT `fk_inmobiliaria_principal`
    FOREIGN KEY (`id_inmobiliaria`)
    REFERENCES `inmovitek`.`ct_inmobiliaria` (`id_inmobiliaria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_inmobiliaria_amiga`
    FOREIGN KEY (`id_inmobiliaria_amiga`)
    REFERENCES `inmovitek`.`ct_inmobiliaria` (`id_inmobiliaria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
DEFAULT CHARACTER SET = latin1     ENGINE = InnoDB
COLLATE = latin1_spanish_ci;

CREATE INDEX `fk_inmobiliaria_idx` ON `inmovitek`.`rl_inmobiliaria_amiga` (`id_inmobiliaria` ASC);

CREATE INDEX `fk_inmobiliaria_amiga_idx` ON `inmovitek`.`rl_inmobiliaria_amiga` (`id_inmobiliaria_amiga` ASC);


-- -----------------------------------------------------
-- Table `inmovitek`.`ct_limite_usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `inmovitek`.`ct_limite_usuario` ;

CREATE TABLE IF NOT EXISTS `inmovitek`.`ct_limite_usuario` (
  `id_usuario` INT UNSIGNED NOT NULL,
  `limite_inmuebles` INT NOT NULL DEFAULT 0,
  `caducidad_cuenta` DATE NOT NULL,
  PRIMARY KEY (`id_usuario`),
  CONSTRAINT `fk_limite_usuario`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `inmovitek`.`ct_usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
DEFAULT CHARACTER SET = latin1     ENGINE = InnoDB
COLLATE = latin1_spanish_ci;

CREATE INDEX `FK_LIMITE_USUARIO` ON `inmovitek`.`ct_limite_usuario` (`id_usuario` ASC);


-- -----------------------------------------------------
-- Table `inmovitek`.`ct_inmueble_promocionado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `inmovitek`.`ct_inmueble_promocionado` ;

CREATE TABLE IF NOT EXISTS `inmovitek`.`ct_inmueble_promocionado` (
  `id_inmueble` INT UNSIGNED NOT NULL,
  `rank` FLOAT NOT NULL DEFAULT 0,
  `no_clicks` INT NOT NULL,
  `promocion_inicia` DATE NOT NULL,
  `promocion_termina` DATE NOT NULL,
  PRIMARY KEY (`id_inmueble`),
  CONSTRAINT `fk_inmueble_promocionado`
    FOREIGN KEY (`id_inmueble`)
    REFERENCES `inmovitek`.`ct_inmueble` (`id_inmueble`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
DEFAULT CHARACTER SET = latin1     ENGINE = InnoDB
COLLATE = latin1_spanish_ci;


-- -----------------------------------------------------
-- Table `inmovitek`.`ct_info_inmueble`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `inmovitek`.`ct_info_inmueble` ;

CREATE TABLE IF NOT EXISTS `inmovitek`.`ct_info_inmueble` (
  `id_info_extra` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_inmueble` INT UNSIGNED NOT NULL,
  `nombre_campo` VARCHAR(100) NOT NULL,
  `valor` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`id_info_extra`),
  CONSTRAINT `fk_info_inmueble`
    FOREIGN KEY (`id_inmueble`)
    REFERENCES `inmovitek`.`ct_inmueble` (`id_inmueble`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
DEFAULT CHARACTER SET = latin1     ENGINE = InnoDB
COLLATE = latin1_spanish_ci;

CREATE INDEX `fk_info_inmueble_idx` ON `inmovitek`.`ct_info_inmueble` (`id_inmueble` ASC);

USE `inmovitek` ;

-- -----------------------------------------------------
-- Placeholder table for view `inmovitek`.`vw_inmobiliaria_cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inmovitek`.`vw_inmobiliaria_cliente` (`id_cliente` INT, `id_usuario` INT, `nombre` INT, `correo` INT, `telefono` INT, `horario_llamada` INT, `anotaciones` INT, `fecha_alta` INT, `id_inmobiliaria` INT);

-- -----------------------------------------------------
-- Placeholder table for view `inmovitek`.`vw_inmobiliaria_inmueble`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inmovitek`.`vw_inmobiliaria_inmueble` (`id_inmueble` INT, `fecha_registro` INT, `id_tipo_inmueble` INT, `metros_cuadrados` INT, `num_recamaras` INT, `num_sanitarios` INT, `alberca` INT, `cochera` INT, `num_autos_cochera` INT, `num_plantas` INT, `precio` INT, `detalles` INT, `venta_renta` INT, `id_usuario` INT, `vendida_rentada` INT, `id_propietario` INT, `activo` INT, `id_inmobiliaria` INT);

-- -----------------------------------------------------
-- View `inmovitek`.`vw_inmobiliaria_cliente`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `inmovitek`.`vw_inmobiliaria_cliente` ;
DROP TABLE IF EXISTS `inmovitek`.`vw_inmobiliaria_cliente`;
USE `inmovitek`;
CREATE  OR REPLACE VIEW `inmovitek`.`vw_inmobiliaria_cliente` AS
SELECT cte.*, usr.id_inmobiliaria
FROM ct_cliente cte, ct_usuario usr 
WHERE cte.id_usuario = usr.id_usuario;


-- -----------------------------------------------------
-- View `inmovitek`.`vw_inmobiliaria_inmueble`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `inmovitek`.`vw_inmobiliaria_inmueble` ;
DROP TABLE IF EXISTS `inmovitek`.`vw_inmobiliaria_inmueble`;
USE `inmovitek`;
CREATE  OR REPLACE VIEW `inmovitek`.`vw_inmobiliaria_inmueble` AS
SELECT inm.*, usr.id_inmobiliaria
FROM ct_inmueble inm, ct_usuario usr 
WHERE inm.id_usuario = usr.id_usuario;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `inmovitek`.`ct_tipo_inmueble`
-- -----------------------------------------------------
START TRANSACTION;
USE `inmovitek`;
INSERT INTO `inmovitek`.`ct_tipo_inmueble` (`id_tipo_inmueble`, `tipo_inmueble`) VALUES (1, 'Casa sola');
INSERT INTO `inmovitek`.`ct_tipo_inmueble` (`id_tipo_inmueble`, `tipo_inmueble`) VALUES (2, 'Departamento');
INSERT INTO `inmovitek`.`ct_tipo_inmueble` (`id_tipo_inmueble`, `tipo_inmueble`) VALUES (3, 'Casa en condominio');
INSERT INTO `inmovitek`.`ct_tipo_inmueble` (`id_tipo_inmueble`, `tipo_inmueble`) VALUES (4, 'Terreno');
INSERT INTO `inmovitek`.`ct_tipo_inmueble` (`id_tipo_inmueble`, `tipo_inmueble`) VALUES (5, 'Villa');
INSERT INTO `inmovitek`.`ct_tipo_inmueble` (`id_tipo_inmueble`, `tipo_inmueble`) VALUES (6, 'Quinta');
INSERT INTO `inmovitek`.`ct_tipo_inmueble` (`id_tipo_inmueble`, `tipo_inmueble`) VALUES (7, 'Rancho');
INSERT INTO `inmovitek`.`ct_tipo_inmueble` (`id_tipo_inmueble`, `tipo_inmueble`) VALUES (8, 'Local comercial');
INSERT INTO `inmovitek`.`ct_tipo_inmueble` (`id_tipo_inmueble`, `tipo_inmueble`) VALUES (9, 'Oficina Comercial');
INSERT INTO `inmovitek`.`ct_tipo_inmueble` (`id_tipo_inmueble`, `tipo_inmueble`) VALUES (10, 'Local en centro comercial');
INSERT INTO `inmovitek`.`ct_tipo_inmueble` (`id_tipo_inmueble`, `tipo_inmueble`) VALUES (11, 'Huerta');
INSERT INTO `inmovitek`.`ct_tipo_inmueble` (`id_tipo_inmueble`, `tipo_inmueble`) VALUES (12, 'Bodega comercial');
INSERT INTO `inmovitek`.`ct_tipo_inmueble` (`id_tipo_inmueble`, `tipo_inmueble`) VALUES (13, 'Oficina industrial');

COMMIT;


-- -----------------------------------------------------
-- Data for table `inmovitek`.`ct_estado`
-- -----------------------------------------------------
START TRANSACTION;
USE `inmovitek`;
INSERT INTO `inmovitek`.`ct_estado` (`id_estado`, `nombre`, `codigo_estado`, `latitud`, `longitud`) VALUES (1, 'Aguascalientes', 'aguascalientes', 21.882766, -102.294573);
INSERT INTO `inmovitek`.`ct_estado` (`id_estado`, `nombre`, `codigo_estado`, `latitud`, `longitud`) VALUES (2, 'Baja California', 'baja-california', 32.62434, -115.443848);
INSERT INTO `inmovitek`.`ct_estado` (`id_estado`, `nombre`, `codigo_estado`, `latitud`, `longitud`) VALUES (3, 'Baja California Sur', 'baja-california-sur', 24.141428, -110.313088);
INSERT INTO `inmovitek`.`ct_estado` (`id_estado`, `nombre`, `codigo_estado`, `latitud`, `longitud`) VALUES (4, 'Campeche', 'campeche', 19.830098, -90.534481);
INSERT INTO `inmovitek`.`ct_estado` (`id_estado`, `nombre`, `codigo_estado`, `latitud`, `longitud`) VALUES (5, 'Coahuila de Zaragoza', 'coahuila', 25.423121, -100.997368);
INSERT INTO `inmovitek`.`ct_estado` (`id_estado`, `nombre`, `codigo_estado`, `latitud`, `longitud`) VALUES (6, 'Colima', 'colima', 19.244871, -103.732594);
INSERT INTO `inmovitek`.`ct_estado` (`id_estado`, `nombre`, `codigo_estado`, `latitud`, `longitud`) VALUES (7, 'Chiapas', 'chiapas', 16.748496, -93.109989);
INSERT INTO `inmovitek`.`ct_estado` (`id_estado`, `nombre`, `codigo_estado`, `latitud`, `longitud`) VALUES (8, 'Chihuahua', 'chihuahua', 28.636815, -106.084183);
INSERT INTO `inmovitek`.`ct_estado` (`id_estado`, `nombre`, `codigo_estado`, `latitud`, `longitud`) VALUES (9, 'Distrito Federal', 'distrito-federal', 19.430334, -99.133126);
INSERT INTO `inmovitek`.`ct_estado` (`id_estado`, `nombre`, `codigo_estado`, `latitud`, `longitud`) VALUES (10, 'Durango', 'durango', 24.024986, -104.653557);
INSERT INTO `inmovitek`.`ct_estado` (`id_estado`, `nombre`, `codigo_estado`, `latitud`, `longitud`) VALUES (11, 'Guanajuato', 'guanajuato', 21.018256, -101.257731);
INSERT INTO `inmovitek`.`ct_estado` (`id_estado`, `nombre`, `codigo_estado`, `latitud`, `longitud`) VALUES (12, 'Guerrero', 'guerrero', 17.5528, -99.504389);
INSERT INTO `inmovitek`.`ct_estado` (`id_estado`, `nombre`, `codigo_estado`, `latitud`, `longitud`) VALUES (13, 'Hidalgo', 'hidalgo', 20.099624, -98.762997);
INSERT INTO `inmovitek`.`ct_estado` (`id_estado`, `nombre`, `codigo_estado`, `latitud`, `longitud`) VALUES (14, 'Jalisco', 'jalisco', 20.673263, -103.343689);
INSERT INTO `inmovitek`.`ct_estado` (`id_estado`, `nombre`, `codigo_estado`, `latitud`, `longitud`) VALUES (15, 'Estado de México', 'edomex', 19.291702, -99.647477);
INSERT INTO `inmovitek`.`ct_estado` (`id_estado`, `nombre`, `codigo_estado`, `latitud`, `longitud`) VALUES (16, 'Michoacán de Ocampo', 'michoacan', 19.705466, -101.194924);
INSERT INTO `inmovitek`.`ct_estado` (`id_estado`, `nombre`, `codigo_estado`, `latitud`, `longitud`) VALUES (17, 'Morelos', 'morelos', 18.924556, -99.225611);
INSERT INTO `inmovitek`.`ct_estado` (`id_estado`, `nombre`, `codigo_estado`, `latitud`, `longitud`) VALUES (18, 'Nayarit', 'nayarit', 21.503547, -104.894768);
INSERT INTO `inmovitek`.`ct_estado` (`id_estado`, `nombre`, `codigo_estado`, `latitud`, `longitud`) VALUES (19, 'Nuevo León', 'nuevo-leon', 25.675877, -100.305573);
INSERT INTO `inmovitek`.`ct_estado` (`id_estado`, `nombre`, `codigo_estado`, `latitud`, `longitud`) VALUES (20, 'Oaxaca', 'oaxaca', 17.058754, -96.721672);
INSERT INTO `inmovitek`.`ct_estado` (`id_estado`, `nombre`, `codigo_estado`, `latitud`, `longitud`) VALUES (21, 'Puebla', 'puebla', 19.0407, -98.207184);
INSERT INTO `inmovitek`.`ct_estado` (`id_estado`, `nombre`, `codigo_estado`, `latitud`, `longitud`) VALUES (22, 'Querétaro', 'queretaro', 20.592295, -100.392235);
INSERT INTO `inmovitek`.`ct_estado` (`id_estado`, `nombre`, `codigo_estado`, `latitud`, `longitud`) VALUES (23, 'Quintana Roo', 'quintana-roo', 18.51697, -88.305544);
INSERT INTO `inmovitek`.`ct_estado` (`id_estado`, `nombre`, `codigo_estado`, `latitud`, `longitud`) VALUES (24, 'San Luis Potosí', 'san-luis', 22.158155, -100.978829);
INSERT INTO `inmovitek`.`ct_estado` (`id_estado`, `nombre`, `codigo_estado`, `latitud`, `longitud`) VALUES (25, 'Sinaloa', 'sinaloa', 24.805435, -107.397248);
INSERT INTO `inmovitek`.`ct_estado` (`id_estado`, `nombre`, `codigo_estado`, `latitud`, `longitud`) VALUES (26, 'Sonora', 'sonora', 29.101177, -110.966431);
INSERT INTO `inmovitek`.`ct_estado` (`id_estado`, `nombre`, `codigo_estado`, `latitud`, `longitud`) VALUES (27, 'Tabasco', 'tabasco', 17.986917, -92.929169);
INSERT INTO `inmovitek`.`ct_estado` (`id_estado`, `nombre`, `codigo_estado`, `latitud`, `longitud`) VALUES (28, 'Tamaulipas', 'tamaulipas', 23.741355, -99.1446);
INSERT INTO `inmovitek`.`ct_estado` (`id_estado`, `nombre`, `codigo_estado`, `latitud`, `longitud`) VALUES (29, 'Tlaxcala', 'tlaxcala', 19.318028, -98.239281);
INSERT INTO `inmovitek`.`ct_estado` (`id_estado`, `nombre`, `codigo_estado`, `latitud`, `longitud`) VALUES (30, 'Veracruz de Ignacio de la Llave', 'veracruz', 19.535525, -96.912315);
INSERT INTO `inmovitek`.`ct_estado` (`id_estado`, `nombre`, `codigo_estado`, `latitud`, `longitud`) VALUES (31, 'Yucatán', 'yucatan', 20.97811, -89.616508);
INSERT INTO `inmovitek`.`ct_estado` (`id_estado`, `nombre`, `codigo_estado`, `latitud`, `longitud`) VALUES (32, 'Zacatecas', 'zacatecas', 22.769375, -102.580547);

COMMIT;


-- -----------------------------------------------------
-- Volcado `inmovitek`.`ct_licencia`
-- -----------------------------------------------------

INSERT INTO `ct_licencia` VALUES ('YM5FH-9H9HN-17U68-XX8F8-QT0PM', 1, 10, 2, '2013-10-06', '2014-10-06');

-- -----------------------------------------------------
-- Volcado `inmovitek`.`ct_inmobiliaria`
-- -----------------------------------------------------

INSERT INTO `ct_inmobiliaria` VALUES (1, NULL, 'ENGINETEC de México', 'YM5FH-9H9HN-17U68-XX8F8-QT0PM', 'global\\inmobiliaria\\1', NULL, 1);

-- -----------------------------------------------------
-- Volcado `inmovitek`.`ct_usuario`
-- -----------------------------------------------------

INSERT INTO `ct_usuario` VALUES (1, NULL, 1, 'Miguel', 'Pérez', '', 'mperez@enginetec.com.mx', 'c5c7de4adc30ab026a30dc75320fa449', '5526021450', '55123014', '2013-10-06 10:57:20', NULL, 1, '{"access_token":"ya29.AHES6ZTYnk2FHRk7_Jb2HurpwH5lEpo96NH3Aai_QtYKjs8","token_type":"Bearer","expires_in":3600,"refresh_token":"1\\/syq0VE7VCsVTA9nEnln7fgXgKJRvqqS36O3JC73ts8Q","created":1382673871}');
INSERT INTO `ct_usuario` VALUES (2, NULL, 1, 'Daniel ', 'Catro', 'Carrilo', 'dan.cast@gmail.com', 'c5c7de4adc30ab026a30dc75320fa449', NULL, NULL, '2013-10-17 01:40:26', NULL, 1, NULL);


-- -----------------------------------------------------
-- Volcado `inmovitek`.`ct_permisos_usuario`
-- -----------------------------------------------------

INSERT INTO `ct_permisos_usuario` VALUES (1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1);
INSERT INTO `ct_permisos_usuario` VALUES (2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1);

-- -----------------------------------------------------
-- Volcado `inmovitek`.`ct_inmueble`
-- -----------------------------------------------------

INSERT INTO `ct_inmueble` VALUES (1, '2013-11-30', 9, 714, 3, 0, 0, 0, 0, 2, 1949000, 'Oriente 95 2604-5103, Tablas de San Aguistin, Gustavo A. Madero, 07860 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (2, '2013-11-30', 8, 590, 3, 0, 1, 0, 0, 3, 1303000, 'Nubes 224, Jardines del Pedregal, Álvaro Obregón, 01900 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (3, '2013-11-30', 11, 273, 2, 0, 1, 0, 0, 3, 2693000, 'Eje 4 Norte (Av. 510), San Juan de Aragón 4a Sección, Gustavo A. Madero, 07979 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (4, '2013-11-30', 12, 464, 2, 0, 0, 1, 0, 3, 6099000, 'Circuito Interior Avenida Río Mixcoac, Acacias, Benito Juarez, 03240 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (5, '2013-11-30', 4, 399, 2, 0, 0, 1, 0, 3, 4630000, 'Avenida de las Torres, Los Padres, Magdalena Contreras, 10340 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (6, '2013-11-30', 13, 571, 3, 0, 1, 1, 0, 2, 8081000, 'Avenida 475, San Juan de Aragón 7 Sección, Gustavo A. Madero, 07910 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (7, '2013-11-30', 2, 249, 2, 0, 1, 0, 0, 2, 9853000, 'Coacota, Zenón Delgado, Álvaro Obregón, 01220 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (8, '2013-11-30', 7, 532, 1, 0, 0, 1, 0, 1, 4605000, 'Prolongación Río Churubusco 10, Caracol, Venustiano Carranza, 15630 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (9, '2013-11-30', 2, 295, 2, 0, 0, 1, 0, 2, 7010000, 'Norte 81-A, Libertad, Azcapotzalco, 02050 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (10, '2013-11-30', 12, 606, 1, 0, 1, 1, 0, 2, 3823000, 'Moctezuma, Mixcoatl, Iztapalapa, 09708 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (11, '2013-11-30', 2, 469, 3, 0, 0, 0, 0, 1, 3934000, 'General Vicente Guerrero 30, 15 de Agosto, Gustavo A. Madero, 07050 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (12, '2013-11-30', 6, 245, 1, 0, 1, 0, 0, 1, 4397000, 'Avenida Instituto Politécnico Nacional, Magdalena de Las Salinas, Gustavo A. Madero, 07760 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (13, '2013-11-30', 11, 721, 3, 0, 0, 0, 0, 3, 8006000, 'Avenida Texcoco 29, Peñón de Los Baños, Venustiano Carranza, 15520 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (14, '2013-11-30', 5, 718, 4, 0, 1, 0, 0, 1, 2949000, 'Rabaul 448, San Rafael, Gustavo A. Madero, 02010 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (15, '2013-11-30', 4, 654, 2, 0, 0, 1, 0, 2, 3363000, 'Anaxágoras 715, Narvarte, Benito Juarez, 03000 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (16, '2013-11-30', 2, 628, 4, 0, 0, 0, 0, 2, 322000, 'Paseo de Alcázar, La Loma, Álvaro Obregón, 01260 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (17, '2013-11-30', 3, 520, 1, 0, 1, 0, 0, 3, 2888000, '1 MZ22LT25B, La Martinica, Álvaro Obregón, 01690 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (18, '2013-11-30', 3, 318, 2, 0, 0, 1, 0, 1, 1333000, 'Norte 59 825, Las Salinas, Azcapotzalco, 02360 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (19, '2013-11-30', 5, 320, 3, 0, 0, 0, 0, 2, 546000, 'Eje 4 Sur (Xola) 1302, Esperanza, Benito Juarez, 03020 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (20, '2013-11-30', 12, 715, 2, 0, 1, 1, 0, 1, 8980000, 'Alhelí 62, Nueva Santa María, Azcapotzalco, 02850 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (21, '2013-11-30', 10, 553, 3, 0, 1, 1, 0, 2, 5061000, 'Creta, Lomas de Axomiatla, Álvaro Obregón, 01820 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (22, '2013-11-30', 1, 707, 3, 0, 1, 0, 0, 2, 4502000, 'Camino CAMPESTRE 216(304), Campestre Aragón, Gustavo A. Madero, 07530 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (23, '2013-11-30', 13, 417, 2, 0, 0, 1, 0, 3, 9629000, 'Maíz 358, Valle del Sur, Iztapalapa, 09819 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (24, '2013-11-30', 5, 307, 2, 0, 0, 0, 0, 2, 5956000, 'Galeana 101, San Jerónimo Lídice, Magdalena Contreras, 10200 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (25, '2013-11-30', 1, 249, 2, 0, 0, 1, 0, 2, 4902000, 'San Francisco, San Bartolo Ameyalco, Álvaro Obregón, 01800 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (26, '2013-11-30', 4, 570, 1, 0, 1, 0, 0, 3, 752000, 'Avenida Felipe Villanueva 158, Peralvillo, Cuauhtémoc, 06220 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (27, '2013-11-30', 13, 358, 3, 0, 0, 1, 0, 2, 8473000, 'Calle Canarias, Portales, Benito Juarez, 03300 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (28, '2013-11-30', 10, 722, 4, 0, 1, 0, 0, 2, 2464000, 'Camino de La Amistad a 25-27, Campestre Aragón, Gustavo A. Madero, 07530 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (29, '2013-11-30', 3, 283, 4, 0, 1, 0, 0, 3, 3910000, 'Autopista México-Marquesa, Zedec Santa Fe, Álvaro Obregón, 01219 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (30, '2013-11-30', 8, 398, 4, 0, 0, 0, 0, 1, 7300000, 'Los Gipaetos, Lomas de Las Águilas, Álvaro Obregón, 01759 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (31, '2013-11-30', 5, 640, 2, 0, 0, 1, 0, 1, 3225000, 'Bosque de Canelos 95, Bosques de Las Lomas, Cuajimalpa, 05120 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (32, '2013-11-30', 10, 664, 4, 0, 1, 1, 0, 2, 8441000, 'Avenida Centenario, Lomas de Plateros, Álvaro Obregón, 01480 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (33, '2013-11-30', 7, 618, 4, 0, 0, 0, 0, 3, 3163000, 'Jilotepec MZ3 LT7, 2da Ampliación Santiago Acahualtepec, Iztapalapa, 09609 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (34, '2013-11-30', 9, 357, 3, 0, 0, 1, 0, 3, 3719000, 'Eje 2 Poniente Gabriel Mancera 1402, Del Valle, Benito Juarez, 03100 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (35, '2013-11-30', 2, 241, 4, 0, 0, 0, 0, 3, 9928000, 'Morelia 21, Roma Norte, Cuauhtémoc, 06700 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (36, '2013-11-30', 11, 752, 3, 0, 0, 1, 0, 2, 9578000, 'Ruiz Cortines, Pensador Mexicano, Venustiano Carranza, 15510 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (37, '2013-11-30', 9, 577, 1, 0, 0, 1, 0, 1, 9979000, 'Eje 1 Oriente (Av. Canal de Miramontes) 1832, Campestre Churubusco, Coyoacán, 04200 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (38, '2013-11-30', 7, 625, 2, 0, 0, 0, 0, 3, 4769000, 'Doctor Alfonso Caso Andrade, Pilares Águilas, Álvaro Obregón, 01710 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (39, '2013-11-30', 5, 349, 4, 0, 1, 1, 0, 3, 7261000, 'Tlalmiminolpan, San Bartolo Ameyalco, Álvaro Obregón, 01800 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (40, '2013-11-30', 5, 408, 4, 0, 1, 1, 0, 2, 1189000, 'Calle Salvador Novo 55, Santa Catarina, Coyoacán, 04010 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (41, '2013-11-30', 2, 691, 4, 0, 1, 0, 0, 2, 2280000, 'Loma Chica LB, Lomas de Tarango, Álvaro Obregón, 01620 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (42, '2013-11-30', 9, 600, 1, 0, 0, 1, 0, 3, 2718000, 'Sur 27 MZ39 LT407, Leyes de Reforma 2da. Sección, Iztapalapa, 09208 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (43, '2013-11-30', 4, 366, 2, 0, 1, 1, 0, 1, 3250000, 'Guelatao, Nueva Díaz Ordaz, Coyoacán, 04380 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (44, '2013-11-30', 12, 530, 1, 0, 0, 1, 0, 3, 5095000, 'Canadá Los Helechos 434, San Mateo Tlaltenango, Cuajimalpa, 05600 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (45, '2013-11-30', 11, 371, 2, 0, 1, 1, 0, 1, 888000, 'Calle 20 25, Olivar del Conde 1a. Sección, Álvaro Obregón, 01400 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (46, '2013-11-30', 11, 475, 3, 0, 1, 0, 0, 2, 3061000, '1a. Privada Vicente Guerrero, Culhuacan, Iztapalapa, 09800 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (47, '2013-11-30', 13, 201, 4, 0, 1, 1, 0, 2, 4075000, 'Iturbe 15, San Mateo Tlaltenango, Cuajimalpa, 05600 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (48, '2013-11-30', 6, 284, 2, 0, 0, 0, 0, 3, 9851000, 'Avenida Miguel Ángel de Quevedo 593, Cuadrante de San Francisco, Coyoacán, 04320 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (49, '2013-11-30', 5, 664, 2, 0, 1, 1, 0, 3, 915000, 'Paseo Hacienda Santa Fe, La Loma, Álvaro Obregón, 01260 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (50, '2013-11-30', 8, 638, 3, 0, 1, 0, 0, 1, 8267000, 'Calzada de La Ronda 109, Ex Hipódromo de Peralvillo, Cuauhtémoc, 06250 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (51, '2013-11-30', 10, 234, 2, 0, 0, 1, 0, 2, 8424000, 'Prolongacion Reforma 215, Paseo de Las Lomas, Cuajimalpa, 01330 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (52, '2013-11-30', 3, 731, 4, 0, 0, 0, 0, 3, 1501000, 'Vía Express Tapo, Aeropuerto Int de La Ciudad de México, Venustiano Carranza, 15620 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (53, '2013-11-30', 5, 414, 1, 0, 1, 1, 0, 3, 5167000, 'Vía Express Tapo *(VISUAL), Aeropuerto Int de La Ciudad de México, Venustiano Carranza, 15620 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (54, '2013-11-30', 10, 643, 4, 0, 1, 0, 0, 3, 560000, 'Ceylan 470B, San Miguel Amantla, Miguel Hidalgo, 02520 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (55, '2013-11-30', 8, 702, 4, 0, 0, 1, 0, 2, 1221000, 'Benemérito de Las Americas MZ15 LT4, Nueva Díaz Ordaz, Coyoacán, 04390 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (56, '2013-11-30', 3, 481, 4, 0, 0, 0, 0, 1, 8523000, 'Cda. Cuamichic 30, Santo Domingo (Pgal de Sto Domingo), Coyoacán, 04369 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (57, '2013-11-30', 5, 572, 4, 0, 0, 0, 0, 1, 9469000, 'Plaza Tzintzuntzan, Ctm V Culhuacan, Coyoacán, 04480 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (58, '2013-11-30', 8, 743, 4, 0, 0, 1, 0, 1, 8760000, 'Vía Express Tapo, Aeropuerto Int de La Ciudad de México, Venustiano Carranza, 15620 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (59, '2013-11-30', 11, 709, 3, 0, 0, 0, 0, 3, 7279000, 'Lázaro Cárdenas MZ117 LT1589, Ampliación Zona Urbana Ejidal Santa María Aztahuacan, Iztapalapa, 09570 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (60, '2013-11-30', 3, 355, 4, 0, 1, 0, 0, 2, 8564000, 'Avenida Bordo Xochiaca, Aeropuerto Int de La Ciudad de México, Venustiano Carranza, 15620 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (61, '2013-11-30', 3, 412, 1, 0, 1, 0, 0, 3, 8725000, 'Fernando Montes de Oca 71, Guadalupe del Moral, Iztapalapa, 09300 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (62, '2013-11-30', 5, 518, 2, 0, 0, 1, 0, 2, 2388000, 'Montes Apeninos 115, Lomas de Chapultepec, Miguel Hidalgo, 11000 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (63, '2013-11-30', 11, 504, 4, 0, 0, 1, 0, 1, 4825000, 'Avenida Santa Cruz Meyehualco 181, Santa Cruz Meyehualco, Iztapalapa, 09290 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (64, '2013-11-30', 6, 227, 3, 0, 0, 0, 0, 2, 6919000, 'Guadalupe Victoria MZ47 LT264, Zona Urbana Ejidal Santa María Aztahuacan, Iztapalapa, 09570 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (65, '2013-11-30', 7, 288, 2, 0, 0, 1, 0, 1, 4516000, 'Avenida Centenario 394, Merced Gómez, Álvaro Obregón, 01600 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (66, '2013-11-30', 10, 692, 3, 0, 0, 0, 0, 1, 5748000, 'Faisán 39, Granjas Modernas, Gustavo A. Madero, 07460 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (67, '2013-11-30', 4, 706, 4, 0, 0, 1, 0, 3, 540000, 'Martin Mendalde 915, Del Valle, Benito Juarez, 03100 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (68, '2013-11-30', 7, 710, 4, 0, 0, 0, 0, 1, 3422000, 'Tulum, Ctm V Culhuacan, Coyoacán, 04480 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (69, '2013-11-30', 1, 740, 2, 0, 1, 1, 0, 1, 4793000, 'Jose Ma. Morels, Culhuacan, Iztapalapa, 09800 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (70, '2013-11-30', 4, 608, 4, 0, 0, 0, 0, 3, 8977000, 'Antonio Valeriano 732, Ampliación Del Gas, Azcapotzalco, 02970 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (71, '2013-11-30', 11, 457, 4, 0, 0, 0, 0, 3, 9445000, 'Antonio Caso 199, San Rafael, Cuauhtémoc, 06470 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (72, '2013-11-30', 11, 395, 4, 0, 0, 0, 0, 2, 2440000, 'Avenida San Miguel, Buenavista, Iztapalapa, 09700 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (73, '2013-11-30', 8, 484, 3, 0, 0, 0, 0, 1, 7044000, 'Loma Tlapexco 95A, Lomas de Vista Hermosa, Cuajimalpa, 05100 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (74, '2013-11-30', 1, 597, 1, 0, 0, 0, 0, 1, 3303000, 'Ana María R. del Toro de Lazarín, Centro, Cuauhtémoc, 06000 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (75, '2013-11-30', 12, 372, 3, 0, 0, 1, 0, 2, 8515000, 'Vetagrande 14, Valle Gómez, Venustiano Carranza, 15210 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (76, '2013-11-30', 3, 753, 1, 0, 1, 1, 0, 3, 2058000, 'Bandera, Industrias Militares de Sedena, Álvaro Obregón, 01219 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (77, '2013-11-30', 4, 612, 4, 0, 0, 1, 0, 1, 2057000, 'Doctor ATL 92, Santa María La Ribera, Cuauhtémoc, 06400 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (78, '2013-11-30', 13, 623, 3, 0, 1, 0, 0, 3, 3078000, 'Avenida Tlahuac, San Andrés Tomatlan, Iztapalapa, 09870 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (79, '2013-11-30', 8, 373, 3, 0, 1, 1, 0, 2, 3664000, 'Loma de La Plata LB, Lomas de Tarango, Álvaro Obregón, 01620 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (80, '2013-11-30', 12, 227, 1, 0, 1, 1, 0, 1, 1079000, 'Anillo Periférico MZ1 LT55, U Habitacional Vicente Guerrero I II ÌII IV V VI VII, Iztapalapa, 09200 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (81, '2013-11-30', 12, 587, 2, 0, 0, 0, 0, 1, 1889000, 'Paseo de los Laureles 458, Lomas de Vista Hermosa, Miguel Hidalgo, 05120 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (82, '2013-11-30', 12, 462, 1, 0, 1, 1, 0, 3, 153000, 'Electricistas 91-A, 20 de Noviembre, Venustiano Carranza, 15300 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (83, '2013-11-30', 2, 252, 2, 0, 0, 0, 0, 2, 9662000, 'Avenida Santa Lucía 3B, Unidad Popular Emiliano Zapata, Álvaro Obregón, 01400 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (84, '2013-11-30', 6, 544, 2, 0, 1, 0, 0, 1, 1472000, 'Cascada 115, San Andrés Tetepilco, Iztapalapa, 09440 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (85, '2013-11-30', 12, 602, 1, 0, 1, 0, 0, 3, 744000, 'Al Olivo 22, Jardines de La Palma(Huizachito), Cuajimalpa, 05100 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (86, '2013-11-30', 4, 376, 2, 0, 0, 1, 0, 3, 1893000, 'Sur 105-A 611-640, Popular, Iztapalapa, 09060 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (87, '2013-11-30', 12, 236, 4, 0, 1, 0, 0, 3, 8727000, 'Cofre de Perote 44, La Pradera, Gustavo A. Madero, 07500 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (88, '2013-11-30', 6, 712, 4, 0, 1, 1, 0, 2, 6693000, 'Josué Escobedo, U Habitacional Vicente Guerrero I II ÌII IV V VI VII, Iztapalapa, 09200 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (89, '2013-11-30', 8, 348, 2, 0, 0, 0, 0, 1, 3299000, '2, Zenón Delgado, Álvaro Obregón, 01220 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (90, '2013-11-30', 11, 234, 4, 0, 1, 1, 0, 2, 2286000, 'Batallón de Zacapoaxtla 8, Ejército de Oriente Indeco II ISSSTE, Ejercito de Oriente, 09230 Iztapalapa, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (91, '2013-11-30', 10, 791, 2, 0, 1, 0, 0, 3, 6124000, 'Cumbres, Infonavit Iztacalco, Iztacalco, 08900 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (92, '2013-11-30', 2, 467, 3, 0, 0, 0, 0, 3, 9077000, 'Anillo de Circunvalación 24, Merced Balbuena, Cuauhtémoc, 15810 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (93, '2013-11-30', 3, 425, 4, 0, 1, 0, 0, 2, 4405000, 'Calle 71 3, Santa Cruz Meyehualco, Iztapalapa, 09290 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (94, '2013-11-30', 1, 357, 3, 0, 0, 1, 0, 3, 155000, 'Avenida De Los Maestros 264, Agricultura, Miguel Hidalgo, 11360 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (95, '2013-11-30', 10, 513, 2, 0, 1, 1, 0, 2, 9702000, 'HEROES 87, Guerrero, Cuauhtémoc, 06300 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (96, '2013-11-30', 8, 715, 1, 0, 1, 0, 0, 1, 9177000, 'Revolución Social MZ10 LT37, Constitución de 1917, Iztapalapa, 09200 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (97, '2013-11-30', 9, 731, 3, 0, 0, 0, 0, 3, 3479000, 'Granate 30, La Estrella, Gustavo A. Madero, 07810 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (98, '2013-11-30', 9, 554, 1, 0, 1, 1, 0, 1, 609000, '625 205-207, San Juan de Aragón 4a Sección, Gustavo A. Madero, 07979 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (99, '2013-11-30', 7, 238, 2, 0, 1, 0, 0, 3, 9328000, 'Norte 76 3725, La Joya, Gustavo A. Madero, 07890 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (100, '2013-11-30', 6, 403, 2, 0, 0, 1, 0, 1, 5928000, 'Norte 17-A 5254, Nueva Vallejo, Gustavo A. Madero, 07750 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (101, '2013-11-30', 7, 602, 1, 0, 0, 1, 0, 1, 9355000, 'Eje 1 Oriente F.C. Hidalgo 2301, La Joyita, Gustavo A. Madero, 07850 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (102, '2013-11-30', 13, 368, 2, 0, 1, 1, 0, 1, 4345000, 'Norte 75 2720, Obrero Popular, Azcapotzalco, 02840 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (103, '2013-11-30', 6, 762, 3, 0, 0, 0, 0, 2, 6833000, 'Vía Express Tapo *(VISUAL), Aeropuerto Int de La Ciudad de México, Venustiano Carranza, 15620 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (104, '2013-11-30', 2, 585, 1, 0, 1, 1, 0, 3, 9112000, 'Josué Escobedo, U Habitacional Vicente Guerrero I II ÌII IV V VI VII, Iztapalapa, 09200 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (105, '2013-11-30', 3, 467, 4, 0, 0, 0, 0, 3, 1849000, 'Eje 5 Sur (Prol. Marcelino Buendía), Chinampac de Juárez, Iztapalapa, 09208 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (106, '2013-11-30', 7, 265, 1, 0, 0, 1, 0, 1, 9007000, 'Santa Rosa 673, Valle Gómez, Venustiano Carranza, 15210 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (107, '2013-11-30', 1, 773, 3, 0, 1, 0, 0, 1, 7359000, 'San Diego, San Bartolo Ameyalco, Álvaro Obregón, 01800 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (108, '2013-11-30', 6, 399, 4, 0, 0, 1, 0, 3, 8986000, '2 E.Rosas MZ12 LT16, U Habitacional Vicente Guerrero I II ÌII IV V VI VII, Iztapalapa, 09200 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (109, '2013-11-30', 9, 575, 1, 0, 1, 1, 0, 3, 172000, 'Malintzin 46, Aragón La Villa(Aragón), Gustavo A. Madero, 07000 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (110, '2013-11-30', 5, 277, 4, 0, 1, 1, 0, 2, 3198000, 'Calle 1 39, Cuchilla Pantitlan, Venustiano Carranza, 15610 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (111, '2013-11-30', 10, 678, 3, 0, 1, 1, 0, 3, 4026000, 'Mario Pani 200, Santa Fe, Cuajimalpa, 05109 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (112, '2013-11-30', 7, 419, 1, 0, 0, 0, 0, 3, 6368000, 'Calzada Ings. Militares, San Lorenzo Tlaltenango, Miguel Hidalgo, 11219 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (113, '2013-11-30', 6, 209, 2, 0, 1, 1, 0, 2, 1027000, 'Avenida Vasco de Quiroga, Zedec Santa Fe, Álvaro Obregón, 01219 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (114, '2013-11-30', 6, 205, 3, 0, 0, 0, 0, 1, 4086000, 'Lázaro Cárdenas 12, Zacatepec, Iztapalapa, 09560 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (115, '2013-11-30', 12, 543, 4, 0, 1, 0, 0, 2, 5727000, 'Pajuil 49, Ave Real, Álvaro Obregón, 01560 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (116, '2013-11-30', 1, 412, 2, 0, 0, 1, 0, 2, 8230000, 'Jesús Gaona 21, Moctezuma 1a Sección, Venustiano Carranza, 15500 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (117, '2013-11-30', 7, 505, 1, 0, 0, 0, 0, 2, 6016000, 'Lago Caneguín 130, Argentina Antigua, Miguel Hidalgo, 11270 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (118, '2013-11-30', 9, 455, 3, 0, 0, 1, 0, 3, 5281000, 'Pozos MZ29 LT10, Buenavista, Iztapalapa, 09700 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (119, '2013-11-30', 2, 205, 4, 0, 0, 1, 0, 3, 325000, 'Rincón de Las Lomas 127, Lomas de Vista Hermosa, Cuajimalpa, 05100 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (120, '2013-11-30', 4, 606, 2, 0, 1, 0, 0, 2, 260000, 'Minerva 803, Florida, Benito Juarez, 01030 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (121, '2013-11-30', 6, 471, 1, 0, 0, 1, 0, 1, 5822000, 'Motolinía 4, Centro, Cuauhtémoc, 06000 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (122, '2013-11-30', 7, 242, 1, 0, 0, 1, 0, 1, 6269000, 'Luis González Obregón, Zona Urbana Ejidal Santa María Aztahuacan, Iztapalapa, 09570 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (123, '2013-11-30', 5, 431, 4, 0, 0, 1, 0, 1, 8878000, 'Moldeadores 328, Pro Hogar, Azcapotzalco, 02600 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (124, '2013-11-30', 12, 219, 3, 0, 1, 1, 0, 2, 1154000, 'General Guadalupe Victoria 58, 15 de Agosto, Gustavo A. Madero, 07050 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (125, '2013-11-30', 10, 461, 2, 0, 0, 0, 0, 1, 9753000, 'Avenida Telecomunicaciones, Unidad Habitacional Guelatao de Juárez II, Iztapalapa, 09208 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (126, '2013-11-30', 8, 263, 3, 0, 1, 0, 0, 3, 4645000, 'Estorninos, Lomas de Las Águilas, Álvaro Obregón, 01759 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (127, '2013-11-30', 10, 317, 4, 0, 0, 1, 0, 2, 2222000, '3a. Cerrada Torres Tepito, San Bartolo Ameyalco, Álvaro Obregón, 01800 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (128, '2013-11-30', 4, 740, 2, 0, 1, 0, 0, 1, 3011000, 'Arteaga y Salazar, El Contadero, Cuajimalpa, 05230 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (129, '2013-11-30', 1, 360, 3, 0, 0, 0, 0, 1, 3234000, '2 E.Rosas MZ12 LT15, U Habitacional Vicente Guerrero I II ÌII IV V VI VII, Iztapalapa, 09200 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (130, '2013-11-30', 6, 212, 4, 0, 0, 0, 0, 1, 3016000, 'Licenciado Sánchez Cordero MZ2 LT3, Tlacuitlapa Ampliación 2o. Reacomodo, Álvaro Obregón, 01650 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (131, '2013-11-30', 8, 282, 4, 0, 1, 1, 0, 2, 4399000, '4a. Cerrada, La Magdalena Culhuacan, Coyoacán, 04260 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (132, '2013-11-30', 6, 244, 1, 0, 0, 1, 0, 2, 4493000, 'Lucio Blanco, Rosendo Salazar, Azcapotzalco, 02400 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (133, '2013-11-30', 2, 710, 1, 0, 1, 1, 0, 1, 3125000, 'Leibnitz 44A, Anzures, Miguel Hidalgo, 11590 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (134, '2013-11-30', 2, 524, 4, 0, 1, 1, 0, 1, 4287000, 'Misioneros 23, Centro, Cuauhtémoc, 06000 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (135, '2013-11-30', 13, 664, 1, 0, 1, 1, 0, 2, 9430000, 'Norte 1, Cuchilla del Tesoro, Gustavo A. Madero, 07900 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (136, '2013-11-30', 8, 586, 1, 0, 1, 0, 0, 2, 9409000, 'Pozos MZ29 LT10, Buenavista, Iztapalapa, 09700 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (137, '2013-11-30', 11, 694, 3, 0, 0, 0, 0, 2, 605000, 'Iztaccihuatl, San Juan Joya, Iztapalapa, 09839 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (138, '2013-11-30', 5, 667, 3, 0, 0, 1, 0, 1, 1718000, 'San Pedro 151(89), Del Carmen, Coyoacán, 04100 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (139, '2013-11-30', 9, 753, 2, 0, 0, 1, 0, 3, 5127000, 'Amacuzac 499, El Retoño, Iztapalapa, 09440 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (140, '2013-11-30', 9, 616, 4, 0, 1, 0, 0, 2, 6525000, 'Minas, Lomas de La Estancia, Iztapalapa, 09640 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (141, '2013-11-30', 13, 528, 1, 0, 1, 0, 0, 2, 1824000, 'Bosque de Limas 1, Bosques de Las Lomas, Cuajimalpa, 05120 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (142, '2013-11-30', 13, 298, 4, 0, 1, 1, 0, 1, 2367000, 'Amacuzac 245, Santiago Sur, Iztacalco, 08800 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (143, '2013-11-30', 4, 368, 1, 0, 0, 1, 0, 1, 3058000, 'Pennsylvania 214, Ampliación Nápoles, Benito Juarez, 03840 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (144, '2013-11-30', 1, 395, 3, 0, 0, 0, 0, 1, 9471000, 'Emma, Nativitas, Benito Juarez, 03500 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (145, '2013-11-30', 6, 716, 1, 0, 0, 1, 0, 2, 5815000, 'Paseo de Alcázar, La Loma, Álvaro Obregón, 01260 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (146, '2013-11-30', 1, 278, 3, 0, 1, 0, 0, 1, 6665000, 'Calzada Melchor Ocampo 43, Tlaxpana, Miguel Hidalgo, 11370 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (147, '2013-11-30', 11, 599, 1, 0, 0, 1, 0, 2, 1032000, 'Eusebio Jáuregui 264, Ampliación San Pedro Xalpa, Azcapotzalco, 02719 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (148, '2013-11-30', 12, 545, 1, 0, 1, 0, 0, 3, 6721000, 'Secretaría de Marina 491, Lomas de Vista Hermosa, Cuajimalpa, 05100 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (149, '2013-11-30', 6, 747, 4, 0, 1, 0, 0, 2, 6297000, 'Norte 15-A 5264, Nueva Vallejo, Gustavo A. Madero, 07750 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (150, '2013-11-30', 13, 629, 4, 0, 0, 0, 0, 2, 7055000, 'F. C. Industrial, Vallejo, Gustavo A. Madero, 07870 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (151, '2013-11-30', 2, 584, 1, 0, 1, 0, 0, 1, 9207000, 'Emma, Del Carmen, Benito Juarez, 03500 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (152, '2013-11-30', 1, 339, 3, 0, 0, 0, 0, 3, 401000, 'Volcán Ajusco 142, La Pradera, Gustavo A. Madero, 07500 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (153, '2013-11-30', 1, 586, 1, 0, 1, 0, 0, 2, 7431000, 'Edo. de Querétaro 116, Providencia, Gustavo A. Madero, 07550 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (154, '2013-11-30', 7, 554, 1, 0, 0, 0, 0, 1, 9023000, 'Anillo Periférico MZ1 LT55, U Habitacional Vicente Guerrero I II ÌII IV V VI VII, Iztapalapa, 09200 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (155, '2013-11-30', 2, 532, 4, 0, 1, 1, 0, 1, 2031000, '2o. Andador Tamaulipas 53, De Santa Lucía, Álvaro Obregón, 15000 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (156, '2013-11-30', 8, 277, 1, 0, 1, 1, 0, 1, 2506000, '25 292, San Miguel Amantla, Azcapotzalco, 02600 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (157, '2013-11-30', 1, 394, 3, 0, 0, 1, 0, 3, 9566000, 'Canal Nacional, La Magdalena Culhuacan, Coyoacán, 04260 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (158, '2013-11-30', 5, 542, 2, 0, 1, 0, 0, 1, 5030000, 'Mimosa 33, Olivar de Los Padres, Álvaro Obregón, 01780 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (159, '2013-11-30', 2, 292, 1, 0, 0, 0, 0, 1, 1064000, 'Eje 5 Sur (Prol. Marcelino Buendía), Chinampac de Juárez, Iztapalapa, 09208 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (160, '2013-11-30', 12, 571, 2, 0, 1, 1, 0, 2, 5310000, '1 MZ22LT25B, La Martinica, Álvaro Obregón, 01690 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (161, '2013-11-30', 3, 390, 3, 0, 0, 1, 0, 2, 2030000, 'Sur 69, Banjidal, Iztapalapa, 09440 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (162, '2013-11-30', 3, 622, 2, 0, 0, 0, 0, 2, 5253000, 'F C Hidalgo, Felipe Pescador, Cuauhtémoc, 06280 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (163, '2013-11-30', 3, 681, 4, 0, 0, 0, 0, 2, 1361000, 'Del Vergel, Lomas de San Angel Inn, Álvaro Obregón, 01790 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (164, '2013-11-30', 13, 604, 3, 0, 0, 1, 0, 1, 3324000, 'Calle 63 98, Santa Cruz Meyehualco, Iztapalapa, 09290 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (165, '2013-11-30', 2, 675, 1, 0, 1, 1, 0, 1, 8472000, 'Pirules, El Tanque, Magdalena Contreras, 10320 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (166, '2013-11-30', 4, 203, 4, 0, 0, 1, 0, 3, 3783000, 'Paseo de la Reforma 155, Guerrero, Cuauhtémoc, 06500 Cuauhtémoc, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (167, '2013-11-30', 13, 689, 2, 0, 0, 0, 0, 2, 8115000, 'Calle Tarango, San Clemente Norte, Álvaro Obregón, 01740 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (168, '2013-11-30', 3, 359, 3, 0, 1, 0, 0, 2, 1549000, 'Camino Viejo a Mixcoac 3525, San Bartolo Ameyalco, Álvaro Obregón, 01800 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (169, '2013-11-30', 10, 550, 3, 0, 0, 0, 0, 3, 301000, 'Cofre de Perote 325, Lomas de Chapultepec, Miguel Hidalgo, 11000 Mexico City, State of Mexico, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (170, '2013-11-30', 7, 221, 1, 0, 0, 1, 0, 2, 1755000, 'Zaragoza 16, De Santa Lucía, Álvaro Obregón, 01509 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (171, '2013-11-30', 4, 331, 1, 0, 1, 0, 0, 3, 8598000, 'Avenida de las Minas, Xalpa, Iztapalapa, 09640 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (172, '2013-11-30', 7, 637, 3, 0, 1, 0, 0, 2, 1731000, 'Canadá Los Helechos 435-436, San Mateo Tlaltenango, Cuajimalpa, 05600 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (173, '2013-11-30', 8, 635, 3, 0, 0, 1, 0, 3, 8459000, 'Plaza Fray Bartolomé de Las Casas 38, Barrio de Tepito, Cuauhtémoc, 06200 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (174, '2013-11-30', 2, 613, 2, 0, 0, 0, 0, 3, 7604000, 'Santa María La Ribera 85, Santa María La Ribera, Cuauhtémoc, 06400 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (175, '2013-11-30', 12, 715, 3, 0, 1, 1, 0, 1, 1752000, 'Wake 183, Libertad, Azcapotzalco, 02060 Distrito Federal, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (176, '2013-11-30', 6, 369, 2, 0, 0, 0, 0, 3, 4643000, 'Nevado 111, Portales, Benito Juarez, 03300 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (177, '2013-11-30', 6, 348, 4, 0, 0, 0, 0, 1, 3991000, 'General G. Hernández 9, Doctores, Cuauhtémoc, 06720 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (178, '2013-11-30', 9, 623, 1, 0, 0, 0, 0, 3, 5455000, 'Calle 4, San Miguel Amantla, Azcapotzalco, 02970 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (179, '2013-11-30', 13, 707, 1, 0, 0, 0, 0, 1, 1731000, 'Rincón de Las Lomas 127, Lomas de Vista Hermosa, Cuajimalpa, 05100 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (180, '2013-11-30', 3, 223, 2, 0, 1, 1, 0, 3, 7898000, 'Norte 80 4227, La Malinche, Gustavo A. Madero, 07899 Gustavo a madero, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (181, '2013-11-30', 13, 471, 2, 0, 1, 1, 0, 1, 5524000, 'Autopista México-Marquesa, Zedec Santa Fe, Álvaro Obregón, 01219 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (182, '2013-11-30', 12, 709, 4, 0, 0, 1, 0, 2, 8863000, 'Rómulo Escobar Zerman 139, Industrial, Gustavo A. Madero, 07800 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (183, '2013-11-30', 8, 425, 1, 0, 0, 0, 0, 3, 5889000, 'Cuauhtémoc, El Paraíso, Iztapalapa, 09230 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (184, '2013-11-30', 6, 710, 1, 0, 1, 1, 0, 1, 2928000, '623 154, San Juan de Aragón 4a Sección, Gustavo A. Madero, 07979 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (185, '2013-11-30', 1, 351, 1, 0, 0, 1, 0, 1, 3405000, 'Quintana Roo 21-23, Villa Gustavo a Madero, Gustavo A. Madero, 07050 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (186, '2013-11-30', 8, 313, 2, 0, 0, 1, 0, 3, 8647000, 'Paseo Tolsa 509, San Mateo Tlaltenango, Cuajimalpa, 05600 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (187, '2013-11-30', 9, 412, 3, 0, 0, 1, 0, 2, 2885000, '20 de Noviembre, Palmitas, Iztapalapa, 09670 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (188, '2013-11-30', 4, 703, 2, 0, 1, 1, 0, 1, 3598000, 'Grabados 318, 2do Tramo 20 de Noviembre, Venustiano Carranza, 15300 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (189, '2013-11-30', 11, 480, 1, 0, 0, 0, 0, 3, 4955000, 'Hortensia 517, Los Angeles, Iztapalapa, 09839 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (190, '2013-11-30', 10, 481, 3, 0, 1, 1, 0, 1, 4364000, 'Calle Igancio Allende 25, Zacatepec, Iztapalapa, 09560 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (191, '2013-11-30', 6, 753, 3, 0, 0, 1, 0, 1, 8094000, 'Demetrio, Independencia San Ramón, Magdalena Contreras, 10100 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (192, '2013-11-30', 6, 653, 4, 0, 0, 1, 0, 3, 2767000, 'La Colina, Lomas de Vista Hermosa, Cuajimalpa, 05100 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (193, '2013-11-30', 12, 532, 2, 0, 0, 1, 0, 1, 1042000, 'América 319, Los Reyes, Barrio del Niño Jesús, 04330 Coyoacán, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (194, '2013-11-30', 2, 684, 3, 0, 0, 1, 0, 2, 3350000, 'Providencia 65, Axotla, Álvaro Obregón, 01030 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (195, '2013-11-30', 7, 400, 4, 0, 0, 1, 0, 2, 5524000, 'Calle 17 64, Santa Cruz Meyehualco, Iztapalapa, 09290 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (196, '2013-11-30', 7, 332, 3, 0, 0, 0, 0, 2, 7906000, 'Avenida Vasco de Quiroga, Zedec Santa Fe, Álvaro Obregón, 01219 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (197, '2013-11-30', 9, 363, 1, 0, 0, 1, 0, 1, 8787000, 'Calle Naranjo 346, Atlampa, Cuauhtémoc, 06450 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (198, '2013-11-30', 1, 257, 3, 0, 0, 1, 0, 2, 3736000, 'Calle 7, Lomas de Sotelo, Miguel Hidalgo, 11200 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (199, '2013-11-30', 8, 323, 2, 0, 1, 0, 0, 1, 753000, 'Ceylan 470B, San Miguel Amantla, Miguel Hidalgo, 02520 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (200, '2013-11-30', 11, 353, 3, 0, 0, 0, 0, 1, 7272000, 'Calle Madrid 18, Tabacalera, Cuauhtémoc, 06030 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (201, '2013-11-30', 11, 754, 3, 0, 1, 0, 0, 2, 9387000, 'Monte de Las Cruces 42, La Pradera, Gustavo A. Madero, 07500 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (202, '2013-11-30', 5, 336, 2, 0, 1, 1, 0, 1, 4353000, 'Eusebio Jáuregui 264, Ampliación San Pedro Xalpa, Azcapotzalco, 02719 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (203, '2013-11-30', 5, 309, 1, 0, 1, 0, 0, 2, 5764000, 'Primavera, Tepalcates, Iztapalapa, 09210 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (204, '2013-11-30', 11, 451, 2, 0, 1, 0, 0, 1, 2696000, 'Eje 3 Norte Av. Cuitláhuac 3325, Obrero Popular, Azcapotzalco, 02840 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (205, '2013-11-30', 2, 318, 3, 0, 1, 1, 0, 1, 7471000, 'Batallón de Zacapoaxtla 8, Ejército de Oriente Indeco II ISSSTE, Ejercito de Oriente, 09230 Iztapalapa, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (206, '2013-11-30', 12, 470, 2, 0, 0, 1, 0, 3, 4035000, 'Bosque de Tabachines 212, Bosques de Las Lomas, Cuajimalpa, 05120 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (207, '2013-11-30', 13, 720, 4, 0, 0, 0, 0, 1, 2459000, 'Primavera MZ3 LTSN, 2da Ampliación Santiago Acahualtepec, Iztapalapa, 09609 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (208, '2013-11-30', 1, 673, 3, 0, 1, 0, 0, 3, 941000, 'Cerro de La Juvencia 49, Campestre Churubusco, Coyoacán, 04200 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (209, '2013-11-30', 7, 473, 1, 0, 1, 0, 0, 2, 7311000, 'Santa Fe 453, Lomas de Santa Fe, Cuajimalpa, 01219 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (210, '2013-11-30', 7, 594, 4, 0, 0, 1, 0, 2, 521000, 'Camino de La Amistad a 3, Campestre Aragón, Gustavo A. Madero, 07530 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (211, '2013-11-30', 12, 662, 3, 0, 0, 1, 0, 1, 713000, 'Constitución de Apatzingán, Tepalcates, Iztapalapa, 09210 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (212, '2013-11-30', 3, 670, 1, 0, 1, 0, 0, 1, 537000, 'Avenida Tamaulipas 1240, Piru Xocomecatla, Álvaro Obregón, 01530 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (213, '2013-11-30', 3, 309, 3, 0, 1, 1, 0, 3, 318000, 'Zanja 22, San Mateo Tlaltenango, Cuajimalpa, 05600 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (214, '2013-11-30', 8, 434, 4, 0, 0, 1, 0, 3, 1857000, 'Concepción Beistegui 1465, Del Valle, Benito Juarez, 03020 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (215, '2013-11-30', 1, 577, 3, 0, 1, 1, 0, 1, 7602000, 'Plan de Ayala, Hank González, Iztapalapa, 09700 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (216, '2013-11-30', 7, 520, 2, 0, 1, 0, 0, 2, 3782000, 'Avenida Universidad 1499, Axotla, Álvaro Obregón, 01030 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (217, '2013-11-30', 13, 298, 3, 0, 1, 1, 0, 3, 9595000, 'Benito Juárez 7, Del Carmen, Coyoacán, 04100 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (218, '2013-11-30', 7, 640, 1, 0, 0, 0, 0, 3, 8672000, 'Jacarandas, San Jerónimo Lídice, Magdalena Contreras, 10200 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (219, '2013-11-30', 13, 740, 2, 0, 0, 0, 0, 2, 3208000, 'Corina 53, Del Carmen, Coyoacán, 04100 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (220, '2013-11-30', 13, 538, 3, 0, 1, 0, 0, 2, 1653000, 'Corina 25, Del Carmen, Coyoacán, 04100 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (221, '2013-11-30', 7, 635, 1, 0, 1, 1, 0, 1, 737000, 'Minerva 803, Florida, Benito Juarez, 01030 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (222, '2013-11-30', 13, 487, 1, 0, 0, 1, 0, 1, 4380000, 'Allende 18, Norte, Álvaro Obregón, 01410 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (223, '2013-11-30', 8, 529, 2, 0, 0, 1, 0, 1, 8062000, 'Plutarco Elías Calles, Chinampac de Juárez, Iztapalapa, 09208 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (224, '2013-11-30', 9, 512, 3, 0, 0, 1, 0, 3, 9303000, 'Avenida Carlos Lazo, Reserva Ecológica Torres de Potrero, Álvaro Obregón, 01848 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (225, '2013-11-30', 1, 707, 1, 0, 0, 0, 0, 2, 3412000, 'Calle 71, Santa Cruz Meyehualco, Iztapalapa, 09290 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (226, '2013-11-30', 9, 606, 3, 0, 0, 0, 0, 2, 9466000, '1ra Hidalgo, Zona Urbana Ejidal San Andrés Tomatlan, Iztapalapa, 09870 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (227, '2013-11-30', 8, 723, 3, 0, 0, 0, 0, 3, 9102000, 'Francisco J. Serrano 104, Lomas de Santa Fe, Desarrolo Urbano Santa Fe, 05348 Cuajimalpa de Morelos, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (228, '2013-11-30', 10, 778, 1, 0, 1, 1, 0, 1, 9353000, 'Cofre de Perote 325, Lomas de Chapultepec, Miguel Hidalgo, 11000 Mexico City, State of Mexico, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (229, '2013-11-30', 4, 577, 2, 0, 1, 0, 0, 1, 9681000, 'Cruz Gálvez, Nueva Santa María, Azcapotzalco, 02800 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (230, '2013-11-30', 9, 697, 3, 0, 0, 0, 0, 2, 7146000, 'Insurgentes Norte 1020, Tlacamaca, Gustavo A. Madero, 07380 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (231, '2013-11-30', 12, 450, 2, 0, 0, 0, 0, 3, 9424000, 'Avenida de las Torres, Los Padres, Magdalena Contreras, 10340 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (232, '2013-11-30', 4, 782, 2, 0, 1, 0, 0, 3, 7087000, 'Eje 2 Poniente Gabriel Mancera 1270, Del Valle, Benito Juarez, 03100 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (233, '2013-11-30', 11, 699, 4, 0, 1, 1, 0, 2, 1312000, 'Calle 10 41, Heron Proal, Álvaro Obregón, 01640 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (234, '2013-11-30', 13, 607, 4, 0, 0, 1, 0, 1, 4222000, 'Vía Express Tapo, Aeropuerto Int de La Ciudad de México, Venustiano Carranza, 15620 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (235, '2013-11-30', 12, 387, 1, 0, 1, 0, 0, 3, 1328000, 'Isabel la Católica 116, Centro, Cuauhtémoc, 06000 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (236, '2013-11-30', 5, 487, 2, 0, 0, 0, 0, 1, 816000, 'Maíz 263, Valle del Sur, Iztapalapa, 09819 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (237, '2013-11-30', 4, 728, 1, 0, 0, 1, 0, 1, 6144000, 'Villa Pozos, Desarrollo Urbano Quetzalcoatl, Iztapalapa, 09700 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (238, '2013-11-30', 4, 778, 1, 0, 0, 0, 0, 1, 6284000, 'Circuito, Olivar de Los Padres, Álvaro Obregón, 01780 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (239, '2013-11-30', 11, 601, 4, 0, 1, 0, 0, 2, 3116000, 'Carlos David Anderson MZ 1 LT B, Culhuacan, Iztapalapa, 09800 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (240, '2013-11-30', 2, 647, 4, 0, 0, 1, 0, 2, 76000, 'Calle Naranjo 267, Santa María La Ribera, Cuauhtémoc, 11320 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (241, '2013-11-30', 11, 707, 4, 0, 1, 1, 0, 1, 7374000, 'España 77, Cerro de La Estrella, Iztapalapa, 09860 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (242, '2013-11-30', 2, 781, 4, 0, 0, 1, 0, 3, 7779000, 'Vía Express Tapo, Aeropuerto Int de La Ciudad de México, Venustiano Carranza, 15620 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (243, '2013-11-30', 13, 447, 1, 0, 1, 1, 0, 3, 5159000, 'Manuel Acuña, Palmitas, Iztapalapa, 09670 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (244, '2013-11-30', 8, 382, 4, 0, 0, 0, 0, 2, 5770000, 'Avenida Tlahuac 220, Zona Urbana Ejidal Los Reyes Culhuacan, Iztapalapa, 09820 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (245, '2013-11-30', 6, 391, 3, 0, 1, 1, 0, 1, 5200000, 'Orion 112, Prado Churubusco, Coyoacán, 04230 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (246, '2013-11-30', 13, 762, 4, 0, 1, 1, 0, 2, 9902000, 'Cascada 420, Jardines del Pedregal, Álvaro Obregón, 01900 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (247, '2013-11-30', 1, 528, 1, 0, 1, 1, 0, 2, 8456000, 'Amores 923, Del Valle, Benito Juarez, 03100 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (248, '2013-11-30', 6, 267, 3, 0, 1, 0, 0, 2, 6140000, 'Miguel Laurent 17, Del Valle, Benito Juarez, 03100 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (249, '2013-11-30', 12, 752, 3, 0, 1, 0, 0, 1, 1164000, 'Eje 1 Poniente, Guerrero, Cuauhtémoc, 06300 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (250, '2013-11-30', 3, 441, 3, 0, 1, 0, 0, 1, 8212000, 'General Vicente Guerrero 28, 15 de Agosto, Gustavo A. Madero, 07050 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (251, '2013-11-30', 7, 764, 3, 0, 1, 1, 0, 3, 6642000, 'R. Figueroa 5, Álvaro Obregón, Iztapalapa, 09230 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (252, '2013-11-30', 3, 487, 3, 0, 1, 1, 0, 3, 322000, 'Cadereyta MZ C LT26, Lomas de Becerra, Álvaro Obregón, 01279 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (253, '2013-11-30', 4, 528, 4, 0, 0, 0, 0, 2, 537000, 'Minerva 803, Florida, Benito Juarez, 01030 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (254, '2013-11-30', 8, 443, 4, 0, 1, 0, 0, 2, 9505000, 'Eje 5 Sur (Prol. Marcelino Buendía), Cabeza de Juárez VI, Iztapalapa, 09225 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (255, '2013-11-30', 6, 488, 4, 0, 0, 1, 0, 2, 4582000, 'Profra. Aurora Reza 20, Los Reyes, Coyoacán, 04330 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (256, '2013-11-30', 8, 632, 4, 0, 0, 0, 0, 1, 6470000, 'Constitución de Apatzingán, Tepalcates, Iztapalapa, 09210 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (257, '2013-11-30', 1, 212, 1, 0, 1, 0, 0, 1, 7670000, 'Calle Dinamarca, Juárez, Cuauhtémoc, 06600 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (258, '2013-11-30', 10, 741, 4, 0, 0, 0, 0, 1, 7170000, 'Sur 129 8, Minerva, Iztapalapa, 09810 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (259, '2013-11-30', 5, 713, 4, 0, 0, 0, 0, 3, 9964000, '2, Olivar de Los Padres, Álvaro Obregón, 01780 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (260, '2013-11-30', 5, 421, 1, 0, 0, 0, 0, 1, 7958000, 'Bahía de San Hipólito, Anáhuac, Miguel Hidalgo, 11320 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (261, '2013-11-30', 1, 635, 3, 0, 0, 0, 0, 1, 6576000, 'Cerrada de Popocatépetl 36, Xoco, Benito Juarez, 03330 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (262, '2013-11-30', 12, 224, 1, 0, 0, 1, 0, 2, 2952000, 'Calzada Legaria 585, Lomas de Sotelo, Irrigación, 11200 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (263, '2013-11-30', 1, 610, 1, 0, 1, 0, 0, 1, 5121000, 'Avenida las Flores, Flor de María, Álvaro Obregón, 01760 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (264, '2013-11-30', 12, 548, 4, 0, 0, 0, 0, 3, 3758000, '20 de Noviembre, Palmitas, Iztapalapa, 09670 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (265, '2013-11-30', 13, 439, 2, 0, 0, 0, 0, 1, 4048000, 'Tlalmiminolpan, San Bartolo Ameyalco, Álvaro Obregón, 01800 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (266, '2013-11-30', 1, 230, 4, 0, 0, 1, 0, 1, 6334000, 'Alpes 650A, Lomas de Chapultepec, Miguel Hidalgo, 11000 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (267, '2013-11-30', 12, 704, 3, 0, 1, 0, 0, 2, 8156000, 'Avenida Paseo de Los Jardines 100, Paseos de Taxqueña, Coyoacán, 04250 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (268, '2013-11-30', 12, 204, 1, 0, 1, 0, 0, 2, 8341000, 'Rómulo Valdez Romero 144, Presidentes Ejidales, Coyoacán, 04470 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (269, '2013-11-30', 3, 722, 2, 0, 0, 0, 0, 2, 1672000, 'Bélgica 815, Portales, Benito Juarez, 03300 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (270, '2013-11-30', 12, 363, 1, 0, 0, 0, 0, 1, 3638000, 'Avenida Paseo de Los Jardines 74, Paseos de Taxqueña, Coyoacán, 04250 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (271, '2013-11-30', 9, 699, 1, 0, 1, 0, 0, 2, 4184000, 'Herminio Chavarría, Zona Urbana Ejidal Santa María Aztahuacan, Iztapalapa, 09570 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (272, '2013-11-30', 2, 338, 1, 0, 0, 0, 0, 1, 3172000, 'Francisco I. Madero, San Bartolo Ameyalco, Álvaro Obregón, 01800 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (273, '2013-11-30', 2, 486, 4, 0, 0, 1, 0, 2, 9922000, 'Eje 6 Sur (Av. Michoacán), Chinampac de Juárez, Iztapalapa, 09208 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (274, '2013-11-30', 10, 364, 2, 0, 0, 0, 0, 3, 1463000, 'Peñón, Morelos, Cuauhtémoc, 06200 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (275, '2013-11-30', 7, 357, 1, 0, 0, 0, 0, 3, 9362000, 'Avenida Telecomunicaciones, Chinampac de Juárez, Iztapalapa, 09208 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (276, '2013-11-30', 8, 359, 2, 0, 0, 0, 0, 3, 1942000, 'Coquimbo 756, Lindavista, Gustavo A. Madero, 07300 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (277, '2013-11-30', 2, 686, 1, 0, 0, 1, 0, 2, 5435000, 'Fray Servando Teresa de Mier 356, Centro, Cuauhtémoc, 06090 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (278, '2013-11-30', 5, 248, 2, 0, 1, 0, 0, 1, 3710000, '19 70B, San Miguel Amantla, Azcapotzalco, 02600 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (279, '2013-11-30', 7, 526, 3, 0, 0, 0, 0, 2, 9440000, 'Madrid MZ55 LT82, Cerro de La Estrella, Iztapalapa, 09860 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (280, '2013-11-30', 12, 446, 1, 0, 1, 0, 0, 2, 5255000, 'Monte de Las Cruces 42, La Pradera, Gustavo A. Madero, 07500 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (281, '2013-11-30', 11, 578, 4, 0, 1, 1, 0, 3, 379000, '508 199, San Juan de Aragón 4a Sección, Gustavo A. Madero, 07979 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (282, '2013-11-30', 6, 305, 4, 0, 0, 0, 0, 1, 1595000, 'Poniente 58 3909, Obrero Popular, Azcapotzalco, 02840 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (283, '2013-11-30', 2, 478, 3, 0, 1, 0, 0, 2, 6040000, 'Xochitlán Norte 52, El Arenal 4a Sección, Venustiano Carranza, 15640 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (284, '2013-11-30', 9, 723, 2, 0, 0, 0, 0, 1, 4645000, 'Vía Tapo (Av. 602), San Juan de Aragón 3a Sección, Gustavo A. Madero, 07970 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (285, '2013-11-30', 10, 326, 4, 0, 1, 0, 0, 1, 9869000, 'Jesús Gaona 21, Moctezuma 1a Sección, Venustiano Carranza, 15500 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (286, '2013-11-30', 11, 401, 1, 0, 1, 1, 0, 1, 1466000, 'Puerto Obregón, Ampliación Piloto Adolfo López Mateos, Álvaro Obregón, 01298 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (287, '2013-11-30', 4, 239, 3, 0, 0, 1, 0, 2, 7152000, 'San Borja 627, Del Valle, Benito Juarez, 03100 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (288, '2013-11-30', 11, 317, 1, 0, 1, 0, 0, 2, 9944000, 'Cerro Dulce MZ4 LT17, Los Cedros Santa Lucía, Álvaro Obregón, 01870 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (289, '2013-11-30', 7, 524, 1, 0, 1, 0, 0, 1, 723000, 'Wisconsin 103, Ampliación Nápoles, Benito Juarez, 03810 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (290, '2013-11-30', 13, 554, 3, 0, 0, 1, 0, 2, 8231000, '5 de Mayo, Zona Urbana Ejidal Los Reyes Culhuacan, Iztapalapa, 09840 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (291, '2013-11-30', 6, 266, 4, 0, 0, 1, 0, 3, 7326000, 'Antonio Caso 49-53, Tabacalera, Cuauhtémoc, 06030 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (292, '2013-11-30', 6, 770, 3, 0, 1, 1, 0, 2, 7944000, 'Moras 1260, Florida, Álvaro Obregón, 01030 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (293, '2013-11-30', 3, 400, 2, 0, 0, 1, 0, 2, 2950000, '2 217, Granjas San Antonio, Iztapalapa, 09070 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (294, '2013-11-30', 3, 636, 3, 0, 1, 0, 0, 2, 8065000, 'Río Madeira, Nueva Argentina (Argentina Poniente), Miguel Hidalgo, 11230 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (295, '2013-11-30', 12, 366, 1, 0, 0, 1, 0, 3, 1766000, 'Alpes 650A, Lomas de Chapultepec, Miguel Hidalgo, 11000 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (296, '2013-11-30', 2, 406, 1, 0, 0, 1, 0, 1, 4252000, 'Carlos David Anderson MZ 1 LT B, Culhuacan, Iztapalapa, 09800 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (297, '2013-11-30', 10, 276, 1, 0, 0, 1, 0, 3, 820000, 'San Miguel, Tetelpan, Álvaro Obregón, 01700 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (298, '2013-11-30', 9, 573, 3, 0, 1, 1, 0, 2, 3039000, 'Avenida Plan de San Luis 545, Hogar y Seguridad, Azcapotzalco, 02820 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (299, '2013-11-30', 11, 554, 4, 0, 1, 0, 0, 1, 7736000, '1a. Cerrada C. 4 27, Granjas San Antonio, Iztapalapa, 09070 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (300, '2013-11-30', 6, 497, 1, 0, 1, 1, 0, 1, 8368000, 'Prolongación Río Churubusco, Aeropuerto Int de La Ciudad de México, Venustiano Carranza, 15620 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (301, '2013-11-30', 6, 211, 3, 0, 1, 1, 0, 3, 6973000, 'Eje 1 Oriente (Av. Canal de Miramontes) 2340, Avante, Coyoacán, 04460 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (302, '2013-11-30', 9, 390, 2, 0, 1, 0, 0, 2, 2328000, 'Regina, Centro, Cuauhtémoc, 06000 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (303, '2013-11-30', 5, 331, 3, 0, 0, 1, 0, 3, 6321000, 'Darwin 61, Anzures, Miguel Hidalgo, 11590 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (304, '2013-11-30', 13, 531, 2, 0, 0, 1, 0, 2, 2722000, 'San Diego, San Bartolo Ameyalco, Álvaro Obregón, 01800 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (305, '2013-11-30', 3, 563, 4, 0, 1, 0, 0, 3, 236000, '1 MZ5 LT6, Xalpa, Iztapalapa, 09640 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (306, '2013-11-30', 5, 468, 2, 0, 0, 0, 0, 1, 1062000, 'Fernando Montes de Oca, Guadalupe del Moral, Iztapalapa, 09300 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (307, '2013-11-30', 11, 296, 2, 0, 1, 0, 0, 3, 2064000, 'Iznal MZ6 LT66, Xalpa, Iztapalapa, 09640 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (308, '2013-11-30', 5, 708, 3, 0, 0, 0, 0, 1, 4305000, 'Canadá Los Helechos 435, San Mateo Tlaltenango, Cuajimalpa, 05600 Mexico City, State of Mexico, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (309, '2013-11-30', 6, 283, 2, 0, 1, 1, 0, 1, 9947000, 'SIN NOMBRE No. 370 19, Narciso Bassols, Gustavo A. Madero, 07980 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (310, '2013-11-30', 5, 392, 1, 0, 0, 0, 0, 2, 2333000, 'Horacio 1603, Polanco, Miguel Hidalgo, 11550 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (311, '2013-11-30', 13, 549, 2, 0, 0, 0, 0, 1, 2476000, 'Sur 69 103, Banjidal, Prado, 09480 Iztapalapa, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (312, '2013-11-30', 8, 223, 2, 0, 1, 0, 0, 3, 4334000, 'Minas, Lomas de La Estancia, Iztapalapa, 09640 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (313, '2013-11-30', 6, 577, 4, 0, 1, 1, 0, 1, 4038000, '1a 5 de Mayo, Palmitas, Iztapalapa, 09670 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (314, '2013-11-30', 1, 550, 1, 0, 1, 0, 0, 3, 2875000, 'Eje 5 Norte (Calz. San Juan de Aragón) 214, Constitución de La República, Gustavo A. Madero, 07469 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (315, '2013-11-30', 2, 476, 3, 0, 1, 0, 0, 2, 2865000, 'Zaragoza 4, Santa Lucía Reacomodo, Álvaro Obregón, 01509 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (316, '2013-11-30', 12, 626, 4, 0, 0, 1, 0, 2, 2295000, 'Poniente 58 3909, Obrero Popular, Azcapotzalco, 02840 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (317, '2013-11-30', 5, 418, 3, 0, 0, 1, 0, 1, 7060000, 'Año de Juárez 253, Granjas San Antonio, Iztapalapa, 09070 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (318, '2013-11-30', 4, 489, 3, 0, 0, 1, 0, 1, 130000, 'Guillermo Prieto 121, San Rafael, Cuauhtémoc, 06740 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (319, '2013-11-30', 6, 504, 1, 0, 0, 0, 0, 1, 1161000, 'Pirul 13, Santa María Insurgentes, Cuauhtémoc, 06430 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (320, '2013-11-30', 3, 493, 1, 0, 1, 0, 0, 3, 5485000, 'Eje Central Lázaro Cárdenas 15, Nueva Vallejo, Gustavo A. Madero, 07750 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (321, '2013-11-30', 11, 657, 2, 0, 0, 0, 0, 1, 6000, 'Benito Juárez 58, Zacatepec, Iztapalapa, 09560 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (322, '2013-11-30', 5, 269, 3, 0, 0, 0, 0, 2, 9315000, 'Cascada 512, Banjidal, Iztapalapa, 09450 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (323, '2013-11-30', 7, 494, 4, 0, 0, 1, 0, 1, 4103000, 'Calle 20 25, Olivar del Conde 1a. Sección, Álvaro Obregón, 01400 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (324, '2013-11-30', 6, 276, 2, 0, 1, 1, 0, 3, 2108000, 'Callao 738, Lindavista, Gustavo A. Madero, 07300 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (325, '2013-11-30', 3, 715, 1, 0, 1, 0, 0, 2, 2741000, 'Avenida Montevideo 178-181, Lindavista, Gustavo A. Madero, 07300 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (326, '2013-11-30', 4, 625, 2, 0, 0, 0, 0, 3, 4966000, 'Allende 18, Norte, Álvaro Obregón, 01410 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (327, '2013-11-30', 3, 527, 4, 0, 0, 1, 0, 1, 5680000, 'Calzada de la Virgen Mz 9 Lt 14, Carmen Serdán, Coyoacán, 04910 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (328, '2013-11-30', 5, 248, 4, 0, 0, 0, 0, 3, 5891000, 'Satélite 115, Lomas de La Estancia, Iztapalapa, 09640 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (329, '2013-11-30', 9, 453, 3, 0, 1, 0, 0, 1, 2010000, 'San Francisco, Corpus Cristy, Álvaro Obregón, 01530 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (330, '2013-11-30', 6, 314, 3, 0, 0, 1, 0, 2, 6471000, 'Pedro Aguirre Cerda, 2a. Ampliación Presidentes, Álvaro Obregón, 01299 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (331, '2013-11-30', 10, 530, 1, 0, 1, 1, 0, 3, 8461000, 'Jumil 69-79, 35B, Coyoacán, 04369 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (332, '2013-11-30', 7, 482, 1, 0, 1, 0, 0, 3, 8326000, 'Emilio Elizondo, Ejército de Agua Prieta, Iztapalapa, 09578 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (333, '2013-11-30', 13, 302, 4, 0, 0, 1, 0, 2, 398000, 'Isabel la Católica 158, Centro, Cuauhtémoc, 06000 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (334, '2013-11-30', 10, 771, 2, 0, 0, 1, 0, 3, 1514000, 'Torres de Ixtapantongo 380, Olivar de Los Padres, Oliviar de los Padres, 01780 Álvaro Obregón, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (335, '2013-11-30', 12, 327, 4, 0, 1, 1, 0, 3, 6407000, 'Caracol 128, Caracol, Venustiano Carranza, 15630 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (336, '2013-11-30', 3, 257, 2, 0, 0, 0, 0, 1, 9183000, 'Villa Gatón MZ70B LT11, Desarrollo Urbano Quetzalcoatl, Iztapalapa, 09700 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (337, '2013-11-30', 7, 793, 1, 0, 1, 0, 0, 1, 6129000, 'Manzanas 56, Tlacoquemecatl del Valle, Benito Juarez, 03200 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (338, '2013-11-30', 9, 647, 2, 0, 0, 0, 0, 1, 5820000, 'Serenata 105, Colinas del Sur, Álvaro Obregón, 01430 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (339, '2013-11-30', 9, 268, 3, 0, 0, 1, 0, 3, 9214000, 'Privada Sidral, Santa María La Ribera, Cuauhtémoc, 06400 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (340, '2013-11-30', 9, 640, 4, 0, 1, 0, 0, 3, 9166000, 'Cedros, Ejido San Mateo, Álvaro Obregón, 01580 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (341, '2013-11-30', 1, 283, 4, 0, 0, 0, 0, 3, 2325000, '1a. Cerrada Amapola MZ5 LT5, Xalpa, Iztapalapa, 09640 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (342, '2013-11-30', 10, 226, 2, 0, 0, 1, 0, 3, 5728000, 'Adolfo López Mateos 70, Adolfo López Mateos, Venustiano Carranza, 15670 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (343, '2013-11-30', 10, 626, 1, 0, 0, 1, 0, 3, 6848000, 'San Francisco, San Bartolo Ameyalco, Álvaro Obregón, 01800 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (344, '2013-11-30', 7, 525, 1, 0, 1, 1, 0, 2, 627000, 'Avenida Ing. Eduardo Molina 4427, La Joya, Gustavo A. Madero, 07890 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (345, '2013-11-30', 13, 395, 3, 0, 1, 0, 0, 2, 2934000, 'Cofre de Perote 325, Lomas de Chapultepec, Miguel Hidalgo, 11000 Mexico City, State of Mexico, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (346, '2013-11-30', 13, 259, 4, 0, 1, 0, 0, 3, 8098000, 'Interior Avenida Río Churubusco 69, Del Carmen, Coyoacán, 04100 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (347, '2013-11-30', 3, 609, 3, 0, 0, 0, 0, 1, 4525000, 'López Cotilla 1143, Del Valle, Benito Juarez, 03100 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (348, '2013-11-30', 11, 241, 3, 0, 0, 0, 0, 3, 8939000, '2a. Cerrada de Minas, La Joya, Álvaro Obregón, 01280 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (349, '2013-11-30', 7, 343, 2, 0, 1, 1, 0, 1, 8730000, 'Reyna Xochitl, El Paraíso, Iztapalapa, 09230 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (350, '2013-11-30', 12, 542, 4, 0, 0, 1, 0, 1, 871000, 'Del IMSS, Magdalena de Las Salinas, Gustavo A. Madero, 07760 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (351, '2013-11-30', 13, 451, 3, 0, 0, 1, 0, 1, 7052000, 'Antonio Caso 49-53, Tabacalera, Cuauhtémoc, 06030 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (352, '2013-11-30', 3, 539, 1, 0, 1, 1, 0, 1, 7498000, 'Del Parque 23A, Avante, Coyoacán, 04460 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (353, '2013-11-30', 3, 208, 3, 0, 1, 1, 0, 3, 3995000, 'Estampado, 20 de Noviembre, Venustiano Carranza, 15300 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (354, '2013-11-30', 1, 643, 1, 0, 0, 0, 0, 3, 6501000, 'Conscripto 311, Lomas de Sotelo, Miguel Hidalgo, 11200 Naucalpan, State of Mexico, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (355, '2013-11-30', 4, 701, 2, 0, 0, 0, 0, 2, 3694000, 'Doctor Gabino Fraga MZ3 LT39, Tlacuitlapa Ampliación 2o. Reacomodo, Álvaro Obregón, 01650 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (356, '2013-11-30', 4, 602, 1, 0, 1, 0, 0, 1, 6089000, 'Lomas Quebradas 27, San Jerónimo Lídice, Magdalena Contreras, 10010 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (357, '2013-11-30', 13, 609, 2, 0, 0, 1, 0, 1, 6307000, 'Avenida De Los Maestros, Plutarco Elías Calles, Miguel Hidalgo, 11350 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (358, '2013-11-30', 6, 758, 4, 0, 1, 1, 0, 3, 7121000, '2, Olivar de Los Padres, Álvaro Obregón, 01780 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (359, '2013-11-30', 2, 489, 4, 0, 0, 0, 0, 1, 4683000, 'Avenida Rubén M. Campos, Villa de Cortes, Benito Juarez, 03530 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (360, '2013-11-30', 8, 383, 3, 0, 1, 1, 0, 1, 5674000, 'Hierro 28, Maza, Cuauhtémoc, 06240 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (361, '2013-11-30', 5, 594, 2, 0, 1, 1, 0, 1, 1117000, 'Cda. Montes Celestes 110, Lomas de Chapultepec, Miguel Hidalgo, 11000 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (362, '2013-11-30', 9, 519, 1, 0, 0, 1, 0, 3, 5957000, 'Eje 1 Oriente F.C. Hidalgo 2301, La Joyita, Gustavo A. Madero, 07850 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (363, '2013-11-30', 2, 709, 3, 0, 0, 0, 0, 3, 5991000, 'Avenida De Los Maestros 159, Santo Tomas, Miguel Hidalgo, 11340 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (364, '2013-11-30', 1, 200, 4, 0, 0, 1, 0, 3, 5756000, 'Eje 1 Oriente F.C. Hidalgo 14, La Joyita, Gustavo A. Madero, 07860 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (365, '2013-11-30', 1, 588, 1, 0, 1, 0, 0, 3, 2288000, 'Avenida Tlahuac 89, Santa Isabel Industrial, Iztapalapa, 09820 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (366, '2013-11-30', 7, 565, 2, 0, 1, 0, 0, 3, 5986000, 'Pedro Aguirre Cerda, 2a. Ampliación Presidentes, Álvaro Obregón, 01299 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (367, '2013-11-30', 10, 297, 3, 0, 1, 0, 0, 2, 6521000, 'Miguel Laurent 1164, Letrán Valle, Benito Juarez, 03650 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (368, '2013-11-30', 1, 217, 4, 0, 0, 1, 0, 1, 654000, '2, Zenón Delgado, Álvaro Obregón, 01220 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (369, '2013-11-30', 9, 554, 3, 0, 0, 1, 0, 1, 3380000, 'Calle de Balderas, Centro, Cuauhtémoc, 06000 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (370, '2013-11-30', 2, 425, 4, 0, 0, 0, 0, 2, 7772000, 'Anaxágoras 715, Narvarte, Benito Juarez, 03000 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (371, '2013-11-30', 2, 478, 2, 0, 0, 0, 0, 1, 9901000, 'Caniles MZ46 LT68, Cerro de La Estrella, Iztapalapa, 09860 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (372, '2013-11-30', 10, 213, 2, 0, 1, 1, 0, 3, 8861000, 'Avenida Centenario, Bosques Tarango, Álvaro Obregón, 01580 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (373, '2013-11-30', 4, 455, 1, 0, 1, 1, 0, 2, 7658000, 'Minas, Lomas de La Estancia, Iztapalapa, 09640 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (374, '2013-11-30', 2, 546, 4, 0, 0, 0, 0, 2, 3753000, 'Paseo Girasoles 7, Lomas de Vista Hermosa, Cuajimalpa, 05100 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (375, '2013-11-30', 13, 513, 3, 0, 0, 0, 0, 2, 4059000, 'Calle La Presa, (P .i.) Garcimarrero 090100001291-B, Álvaro Obregón, 01510 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (376, '2013-11-30', 3, 310, 4, 0, 1, 0, 0, 1, 1313000, 'Avenida Tlahuac, San Andrés Tomatlan, Iztapalapa, 09870 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (377, '2013-11-30', 9, 715, 4, 0, 1, 1, 0, 2, 9671000, 'Calle La Presa, (P .i.) Garcimarrero 090100001291-B, Álvaro Obregón, 01510 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (378, '2013-11-30', 13, 532, 1, 0, 0, 1, 0, 3, 6488000, 'Monte de Las Cruces 42, La Pradera, Gustavo A. Madero, 07500 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (379, '2013-11-30', 5, 293, 3, 0, 1, 1, 0, 3, 1957000, '2a. Cerrada C. 4 4, Granjas San Antonio, Iztapalapa, 09070 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (380, '2013-11-30', 9, 332, 3, 0, 0, 0, 0, 2, 1077000, 'Avenida Universidad 1046, Xoco, Benito Juarez, 03340 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (381, '2013-11-30', 8, 493, 1, 0, 1, 1, 0, 2, 1922000, 'Loma del Parque 134, Lomas de Vista Hermosa, Cuajimalpa, 05100 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (382, '2013-11-30', 11, 375, 4, 0, 0, 1, 0, 2, 7829000, 'Plomo 21, Valle Gómez, Cuauhtémoc, 06240 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (383, '2013-11-30', 5, 264, 2, 0, 1, 1, 0, 2, 8608000, 'Manuel Bonilla, Zona Urbana Ejidal Santa Martha Acatitla Sur, Iztapalapa, 09530 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (384, '2013-11-30', 7, 236, 2, 0, 0, 1, 0, 3, 9519000, 'Eje 2 Poniente Gabriel Mancera 1314, Del Valle, Benito Juarez, 03100 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (385, '2013-11-30', 5, 461, 1, 0, 1, 1, 0, 1, 7179000, 'Eje 4 Norte (Calz. Azcapotzalco La Villa), San Andrés de Las Salinas, Azcapotzalco, 02300 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (386, '2013-11-30', 11, 620, 4, 0, 0, 1, 0, 3, 2775000, '2a. Cerrada C. 4 4, Granjas San Antonio, Iztapalapa, 09070 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (387, '2013-11-30', 2, 492, 1, 0, 1, 1, 0, 3, 534000, 'Sierra Vertientes 335, Lomas de Chapultepec, Miguel Hidalgo, 11000 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (388, '2013-11-30', 1, 552, 4, 0, 1, 0, 0, 3, 4960000, 'Joyas 88, La Estrella, Gustavo A. Madero, 07810 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (389, '2013-11-30', 5, 482, 3, 0, 1, 1, 0, 3, 8922000, 'General Juan Cabral, Militar 1 K Lomas de Sotelo, Miguel Hidalgo, 11200 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (390, '2013-11-30', 11, 467, 2, 0, 1, 0, 0, 3, 4227000, 'Norte 11 4630, Defensores de La República, Gustavo A. Madero, 07780 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (391, '2013-11-30', 9, 606, 3, 0, 1, 0, 0, 3, 4515000, 'Rodríguez Puebla, Centro, Cuauhtémoc, 06000 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (392, '2013-11-30', 10, 390, 2, 0, 1, 0, 0, 2, 8960000, 'Yurécuaro 110-112, Janitzio, Venustiano Carranza, 15200 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (393, '2013-11-30', 6, 233, 3, 0, 0, 0, 0, 1, 9807000, 'Cda. de Tiro Al Pichón 29A, Lomas de Bezares, Miguel Hidalgo, 11910 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (394, '2013-11-30', 8, 698, 3, 0, 1, 1, 0, 3, 418000, 'Aretinos, Isidro Fabela, Álvaro Obregón, 01170 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (395, '2013-11-30', 9, 785, 2, 0, 0, 1, 0, 2, 1651000, 'Eje 1 Oriente (Av. Canal de Miramontes) 2273, Avante, Coyoacán, 04460 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (396, '2013-11-30', 8, 582, 4, 0, 1, 1, 0, 1, 5240000, 'Calzada Ings. Militares, San Lorenzo Tlaltenango, Miguel Hidalgo, 11210 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (397, '2013-11-30', 13, 748, 4, 0, 0, 0, 0, 3, 3133000, 'Circuito Interior Avenida Río Churubusco 1198, Portales, Benito Juarez, 03300 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (398, '2013-11-30', 4, 414, 4, 0, 1, 1, 0, 3, 2396000, 'Copa de Oro 69, Ciudad Jardín, Coyoacán, 04370 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (399, '2013-11-30', 2, 657, 2, 0, 0, 1, 0, 1, 4857000, 'Martin Mendalde 613, Del Valle, Benito Juarez, 03100 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (400, '2013-11-30', 1, 321, 3, 0, 0, 1, 0, 3, 8965000, 'Muitles, San Bartolo Ameyalco, Álvaro Obregón, 01800 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (401, '2013-11-30', 13, 764, 3, 0, 0, 1, 0, 3, 8620000, 'Carretera Federal 15 de Cuota, Lomas de Santa Fe, Cuajimalpa, 01219 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (402, '2013-11-30', 12, 784, 4, 0, 1, 1, 0, 3, 2736000, 'Abedul MZ245 LT20, 2da Ampliación Santiago Acahualtepec, Iztapalapa, 09609 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (403, '2013-11-30', 9, 695, 1, 0, 0, 0, 0, 1, 6152000, 'Agrario 11, San Simon Culhuacan, Iztapalapa, 09870 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (404, '2013-11-30', 8, 341, 4, 0, 0, 1, 0, 1, 3278000, 'Salvador Allende, Presidentes, Álvaro Obregón, 01299 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (405, '2013-11-30', 3, 312, 1, 0, 0, 1, 0, 3, 7355000, 'Tejamanil 198, Santo Domingo (Pgal de Sto Domingo), Coyoacán, 04369 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (406, '2013-11-30', 4, 465, 2, 0, 1, 1, 0, 2, 1350000, 'Prado Sur 285, Lomas de Chapultepec, Miguel Hidalgo, 11000 Miguel Hidalgo, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (407, '2013-11-30', 1, 785, 1, 0, 1, 0, 0, 1, 1949000, 'Malintzin 46, Aragón La Villa(Aragón), Gustavo A. Madero, 07000 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (408, '2013-11-30', 8, 312, 2, 0, 1, 0, 0, 2, 8743000, 'Ruiz Cortines, Pensador Mexicano, Venustiano Carranza, 15510 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (409, '2013-11-30', 8, 793, 2, 0, 1, 0, 0, 1, 2762000, 'Lomas de Sotelo 1130, Loma Hermosa, Miguel Hidalgo, 11200 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (410, '2013-11-30', 13, 323, 1, 0, 1, 0, 0, 1, 6099000, 'Calle Tarango, San Clemente Norte, Álvaro Obregón, 01740 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (411, '2013-11-30', 1, 586, 1, 0, 0, 1, 0, 2, 2479000, 'General Emiliano Zapata, Portales, Benito Juarez, 03300 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (412, '2013-11-30', 13, 723, 3, 0, 0, 1, 0, 1, 4448000, 'Maíz MZ18 LT17, Xalpa, Iztapalapa, 09640 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (413, '2013-11-30', 11, 784, 2, 0, 0, 0, 0, 2, 4917000, 'Caniles MZ46 LT68, Cerro de La Estrella, Iztapalapa, 09860 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (414, '2013-11-30', 11, 623, 1, 0, 1, 1, 0, 3, 8721000, 'Autopista México-Marquesa, Zedec Santa Fe, Álvaro Obregón, 01219 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (415, '2013-11-30', 12, 749, 3, 0, 0, 1, 0, 3, 1452000, 'Ret. Cerro del Hombre 69, Romero de Terreros, Coyoacán, 04310 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (416, '2013-11-30', 9, 673, 4, 0, 1, 1, 0, 3, 5595000, 'Tolteca 73, Industrial, Gustavo A. Madero, 07800 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (417, '2013-11-30', 5, 284, 4, 0, 0, 0, 0, 2, 7080000, 'Corregidora 135, San Jerónimo Lídice, Magdalena Contreras, 10200 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (418, '2013-11-30', 9, 498, 1, 0, 1, 0, 0, 2, 1443000, 'Chichen Itza 301, Letrán Valle, Benito Juarez, 03600 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (419, '2013-11-30', 6, 203, 2, 0, 0, 0, 0, 3, 3091000, 'Avenida Ing. Eduardo Molina 4429, La Joya, Gustavo A. Madero, 07890 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (420, '2013-11-30', 3, 478, 2, 0, 1, 0, 0, 2, 1583000, 'Zempoala 24, Hermosillo, Coyoacán, 04240 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (421, '2013-11-30', 3, 646, 4, 0, 0, 1, 0, 3, 1757000, 'Cuitláhuac MZ11 LT8, Zona Urbana Ejidal Los Reyes Culhuacan, Iztapalapa, 09840 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (422, '2013-11-30', 6, 441, 2, 0, 1, 1, 0, 1, 293000, 'Calle 21 323, Pro Hogar, Azcapotzalco, 02600 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (423, '2013-11-30', 3, 405, 3, 0, 1, 0, 0, 2, 3657000, 'Nueva York 264, Del Valle, Benito Juarez, 03810 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (424, '2013-11-30', 1, 697, 2, 0, 0, 0, 0, 2, 2493000, '1519 56, San Juan de Aragón 6a Sección, Gustavo A. Madero, 07918 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (425, '2013-11-30', 10, 592, 2, 0, 0, 1, 0, 1, 6654000, 'Pino, Del Cedromilpa, Álvaro Obregón, 01580 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (426, '2013-11-30', 4, 342, 3, 0, 0, 0, 0, 2, 1699000, 'Josafat F. Márquez, Colonial Iztapalapa, Iztapalapa, 09270 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (427, '2013-11-30', 13, 519, 2, 0, 1, 0, 0, 1, 5856000, '4 de Rivera Cambas 65, Jardín Balbuena, Venustiano Carranza, 15900 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (428, '2013-11-30', 11, 357, 3, 0, 0, 0, 0, 2, 256000, '631 241, San Juan de Aragón 4a Sección, Gustavo A. Madero, 07979 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (429, '2013-11-30', 5, 313, 3, 0, 1, 1, 0, 1, 1616000, 'Plutarco Elías Calles, Ampliación San Miguel, Iztapalapa, 09240 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (430, '2013-11-30', 2, 357, 3, 0, 1, 1, 0, 3, 6788000, 'San Francisco, San Bartolo Ameyalco, Álvaro Obregón, 01800 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (431, '2013-11-30', 9, 569, 2, 0, 0, 1, 0, 2, 7283000, '1a. Privada Vicente Guerrero, Culhuacan, Iztapalapa, 09800 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (432, '2013-11-30', 2, 797, 3, 0, 1, 1, 0, 3, 6634000, 'Iturbe 32, San Mateo Tlaltenango, Cuajimalpa, 05600 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (433, '2013-11-30', 9, 579, 4, 0, 1, 0, 0, 2, 7112000, 'Hierro 28, Maza, Cuauhtémoc, 06240 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (434, '2013-11-30', 10, 340, 1, 0, 0, 1, 0, 2, 7730000, 'Pelícano 75, Granjas Modernas, Gustavo A. Madero, 07460 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (435, '2013-11-30', 2, 478, 1, 0, 1, 0, 0, 2, 8811000, 'Insurgentes Norte 1725, Tepeyac Insurgentes, Gustavo A. Madero, 07020 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (436, '2013-11-30', 8, 582, 2, 0, 1, 1, 0, 1, 2469000, 'Providencia 343, San Miguel Amantla, Azcapotzalco, 02700 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (437, '2013-11-30', 9, 339, 4, 0, 1, 0, 0, 2, 8000, 'Wake 204, Libertad, Azcapotzalco, 02050 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (438, '2013-11-30', 8, 598, 4, 0, 0, 0, 0, 3, 5186000, 'Avenida Santa Cruz Meyehualco 181, Santa Cruz Meyehualco, Iztapalapa, 09290 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (439, '2013-11-30', 3, 231, 1, 0, 0, 1, 0, 3, 595000, 'Marcos N. Méndez MZ40 LT20, Zona Urbana Ejidal Santa Martha Acatitla Sur, Iztapalapa, 09530 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (440, '2013-11-30', 10, 264, 1, 0, 0, 0, 0, 2, 8906000, 'Norte 1, Cuchilla del Tesoro, Gustavo A. Madero, 07900 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (441, '2013-11-30', 10, 333, 2, 0, 1, 0, 0, 1, 4938000, '3a San Francisco, San Bartolo Ameyalco, Álvaro Obregón, 01800 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (442, '2013-11-30', 5, 289, 1, 0, 1, 0, 0, 3, 6202000, 'Avenida 608 29, San Juan de Aragón 3a Sección, Gustavo A. Madero, 07970 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (443, '2013-11-30', 1, 316, 3, 0, 1, 0, 0, 3, 1030000, 'Parroquia 830, Del Valle, Benito Juarez, 03100 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (444, '2013-11-30', 13, 518, 2, 0, 1, 1, 0, 2, 904000, 'Modesto Domínguez, Ejército de Agua Prieta, Iztapalapa, 09578 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (445, '2013-11-30', 2, 217, 2, 0, 1, 1, 0, 1, 8377000, 'Miguel Allende, El Parque, Venustiano Carranza, 15290 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (446, '2013-11-30', 12, 622, 3, 0, 0, 0, 0, 2, 6540000, 'Plaza del Loreto 37, Doctor Alfonso Ortiz Tirado, Iztapalapa, 09020 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (447, '2013-11-30', 2, 570, 4, 0, 1, 1, 0, 3, 6395000, 'Avenida Tlahuac 190, Santa Isabel Industrial, Iztapalapa, 09820 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (448, '2013-11-30', 7, 746, 1, 0, 0, 1, 0, 1, 3026000, 'Sierra Madre Oriental 49, La Pradera, Gustavo A. Madero, 07500 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (449, '2013-11-30', 3, 738, 2, 0, 0, 0, 0, 1, 3202000, 'Miguel Laurent 1164, Letrán Valle, Benito Juarez, 03650 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (450, '2013-11-30', 10, 428, 2, 0, 0, 1, 0, 1, 3325000, 'Xiutetelco MZC5 LT26, El Arenal 4a Sección, Venustiano Carranza, 15640 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (451, '2013-11-30', 13, 649, 2, 0, 1, 1, 0, 2, 5528000, 'Avenida Tamaulipas 257, Casa La Salle, Álvaro Obregón, 01357 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (452, '2013-11-30', 11, 265, 2, 0, 0, 1, 0, 1, 1582000, 'Miguel Negrete 34, Niños Heroes de Chapultepec, Benito Juarez, 03440 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (453, '2013-11-30', 13, 454, 3, 0, 1, 1, 0, 3, 6765000, 'San Esteban 48 A, Santo Tomas, Azcapotzalco, 02020 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (454, '2013-11-30', 8, 200, 2, 0, 1, 0, 0, 1, 1597000, 'Ret.68 61, Avante, Coyoacán, 04460 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (455, '2013-11-30', 10, 235, 4, 0, 0, 0, 0, 1, 5557000, 'Transmisiones Militares 15, Residencial Lomas de Sotelo, Fraccionamiento Lomas de Sotelo, 53390 Naucalpan, State of Mexico, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (456, '2013-11-30', 5, 445, 3, 0, 0, 1, 0, 2, 4462000, 'Amacuzac 42, San Andrés Tetepilco, Iztapalapa, 09440 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (457, '2013-11-30', 7, 524, 2, 0, 0, 0, 0, 1, 8446000, 'Las Fuentes 297, Jardines del Pedregal, Álvaro Obregón, 01900 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (458, '2013-11-30', 5, 416, 2, 0, 1, 0, 0, 1, 6161000, 'Sonora, Aeropuerto Int de La Ciudad de México, Venustiano Carranza, 15620 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (459, '2013-11-30', 2, 543, 2, 0, 1, 0, 0, 2, 6716000, 'Hermenegildo Galeana 26A, Guadalupe del Moral, Iztapalapa, 09300 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (460, '2013-11-30', 9, 625, 1, 0, 0, 0, 0, 1, 312000, 'Avenida Bernardo Quintana A., La Loma, Álvaro Obregón, 01260 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (461, '2013-11-30', 6, 781, 1, 0, 1, 0, 0, 3, 2630000, '481 84, San Juan de Aragón 7 Sección, Gustavo A. Madero, 07910 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (462, '2013-11-30', 12, 613, 1, 0, 1, 0, 0, 3, 1664000, 'Xochitlán Norte 59, El Arenal 4a Sección, Venustiano Carranza, 15640 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (463, '2013-11-30', 1, 669, 4, 0, 0, 0, 0, 3, 2909000, 'José Loreto Fabela 140, San Juan de Aragón 4a Sección, Gustavo A. Madero, 07979 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (464, '2013-11-30', 7, 664, 3, 0, 1, 0, 0, 2, 224000, 'Paseo de Las Palmas 805, Lomas de Chapultepec, Miguel Hidalgo, 11000 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (465, '2013-11-30', 2, 482, 4, 0, 1, 1, 0, 1, 1891000, 'D García Ramos, Lomas de Santa Fe, Cuajimalpa, 01219 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (466, '2013-11-30', 6, 221, 2, 0, 1, 1, 0, 3, 7893000, 'Ceylan 679, Las Salinas, Azcapotzalco, 02360 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (467, '2013-11-30', 13, 546, 4, 0, 0, 1, 0, 2, 5535000, 'Dalias, Lomas de Vista Hermosa, Cuajimalpa, 05100 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (468, '2013-11-30', 3, 761, 1, 0, 1, 0, 0, 3, 9801000, 'Meztli MZA1 LT48, El Arenal 4a Sección, Venustiano Carranza, 15640 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (469, '2013-11-30', 1, 777, 2, 0, 0, 0, 0, 2, 9252000, 'Enrique Añorve 107, Ampliación San Pedro Xalpa, Azcapotzalco, 02719 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (470, '2013-11-30', 11, 249, 1, 0, 0, 0, 0, 2, 3912000, 'Vencedora 48, Industrial, Gustavo A. Madero, 07800 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (471, '2013-11-30', 7, 729, 2, 0, 0, 1, 0, 2, 4267000, 'Propiedad (Polar), Lomas de La Estancia, Iztapalapa, 09640 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (472, '2013-11-30', 7, 629, 2, 0, 0, 1, 0, 2, 7848000, 'Loma Linda 270, Lomas de Vista Hermosa, Cuajimalpa, 05100 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (473, '2013-11-30', 3, 589, 4, 0, 0, 1, 0, 2, 2686000, 'Privada Felipe Angeles 5-8, Ampliación El Triunfo, Iztapalapa, 09438 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (474, '2013-11-30', 12, 212, 3, 0, 1, 1, 0, 1, 3314000, 'Benemérito de Las Americas MZ15 LT4, Nueva Díaz Ordaz, Coyoacán, 04390 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (475, '2013-11-30', 2, 348, 3, 0, 0, 1, 0, 1, 3001000, 'Jilotepec MZ3 LT7, 2da Ampliación Santiago Acahualtepec, Iztapalapa, 09609 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (476, '2013-11-30', 5, 496, 1, 0, 1, 0, 0, 1, 6783000, 'Xiutetelco MZC5 LT30, El Arenal 4a Sección, Venustiano Carranza, 15640 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (477, '2013-11-30', 13, 261, 1, 0, 1, 1, 0, 2, 8996000, '1a de Cipreces MZ207 LT105, 2da Ampliación Santiago Acahualtepec, Iztapalapa, 09609 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (478, '2013-11-30', 12, 321, 3, 0, 0, 0, 0, 3, 7380000, 'Calle Heroes, Guerrero, Cuauhtémoc, 06300 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (479, '2013-11-30', 8, 418, 4, 0, 0, 0, 0, 2, 6959000, 'Abasolo 26, Progreso Tizapan, Álvaro Obregón, 54200 Polotitlán, State of Mexico, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (480, '2013-11-30', 6, 210, 3, 0, 0, 1, 0, 3, 2022000, 'Guardiola 90, Doctor Alfonso Ortiz Tirado, Iztapalapa, 09020 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (481, '2013-11-30', 12, 744, 3, 0, 1, 0, 0, 2, 2330000, 'Calle Canarias 73, San Simon Ticumac, Benito Juarez, 03660 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (482, '2013-11-30', 6, 528, 4, 0, 0, 0, 0, 2, 8754000, 'San Bernabé 896, San Jerónimo Lídice, Magdalena Contreras, 10200 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (483, '2013-11-30', 3, 741, 2, 0, 0, 1, 0, 3, 6282000, 'Filipinas 314, Portales, Benito Juarez, 03300 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (484, '2013-11-30', 10, 252, 4, 0, 0, 0, 0, 2, 7087000, 'Poniente 116 649 B, Industrial Vallejo, Azcapotzalco, 02300 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (485, '2013-11-30', 9, 693, 2, 0, 0, 1, 0, 3, 1296000, 'Valentín Gómez Farias, Campamento 2 de Octubre, Iztacalco, 08930 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (486, '2013-11-30', 2, 350, 2, 0, 0, 1, 0, 1, 6176000, '1 Mercedes Abrego, Ctm VI Culhuacan, Coyoacán, 04480 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (487, '2013-11-30', 2, 562, 2, 0, 0, 1, 0, 1, 1422000, 'Campo 3 Brazos, San Pedro Xalpa, Azcapotzalco, 02710 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (488, '2013-11-30', 5, 796, 2, 0, 1, 0, 0, 3, 3762000, 'Ignacio Allende, Consejo Agrarista Mexicano, Iztapalapa, 09760 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (489, '2013-11-30', 9, 386, 1, 0, 0, 1, 0, 3, 8158000, 'Albino Terreros 26-28, Presidentes Ejidales, Coyoacán, 04470 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (490, '2013-11-30', 8, 347, 3, 0, 1, 1, 0, 3, 6166000, 'Sándalo 27, Santa María Insurgentes, Cuauhtémoc, 06430 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (491, '2013-11-30', 5, 695, 2, 0, 0, 0, 0, 1, 2487000, 'San Felipe 229, Xoco, Benito Juarez, 03330 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (492, '2013-11-30', 6, 339, 1, 0, 1, 0, 0, 3, 2975000, 'Paseo de Las Palmas 805, Lomas de Chapultepec, Miguel Hidalgo, 11000 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (493, '2013-11-30', 8, 614, 1, 0, 0, 1, 0, 2, 2855000, 'Avenida División del Norte 1611, Residencial Emperadores, Santa Cruz Atoyac, 03310 Benito Juárez, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (494, '2013-11-30', 9, 797, 1, 0, 0, 1, 0, 2, 2379000, 'De Las Presas MZ6 LT1A, Presa Sección Hornos, Álvaro Obregón, 01270 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (495, '2013-11-30', 4, 419, 2, 0, 1, 1, 0, 3, 9240000, 'Hoja de Árbol, Infonavit Iztacalco, Iztacalco, 08900 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (496, '2013-11-30', 9, 666, 3, 0, 1, 1, 0, 2, 6665000, 'Prolongación Misterios 133, Santa Isabel Tola, Gustavo A. Madero, 07010 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (497, '2013-11-30', 13, 760, 2, 0, 1, 0, 0, 1, 2770000, 'Mendelssohn 70, Vallejo, Gustavo A. Madero, 07870 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (498, '2013-11-30', 11, 213, 2, 0, 0, 0, 0, 3, 5495000, 'Nicolás San Juan 1527, Del Valle, Benito Juarez, 03100 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (499, '2013-11-30', 1, 711, 1, 0, 1, 1, 0, 3, 1444000, 'Jiquilpan 139, Janitzio, Venustiano Carranza, 15200 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (500, '2013-11-30', 5, 420, 1, 0, 0, 0, 0, 2, 8054000, 'Calzada de La Ronda 133, Ex Hipódromo de Peralvillo, Cuauhtémoc, 06250 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (501, '2013-11-30', 1, 268, 1, 0, 1, 1, 0, 1, 6836000, '631 238, San Juan de Aragón 4a Sección, Gustavo A. Madero, 07979 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (502, '2013-11-30', 9, 633, 3, 0, 0, 1, 0, 3, 5284000, 'Nicolás San Juan 1527, Del Valle, Benito Juarez, 03100 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (503, '2013-11-30', 13, 696, 1, 0, 1, 0, 0, 2, 4769000, 'San Jerónimo, Centro, Cuauhtémoc, 06000 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (504, '2013-11-30', 11, 345, 2, 0, 0, 0, 0, 2, 8437000, 'Abasolo 26, Progreso Tizapan, Álvaro Obregón, 54200 Polotitlán, State of Mexico, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (505, '2013-11-30', 1, 538, 3, 0, 0, 1, 0, 2, 3238000, 'Morelos, Pueblo Santa Fe, Álvaro Obregón, 01210 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (506, '2013-11-30', 5, 758, 1, 0, 1, 0, 0, 1, 3259000, 'Rosales, Zedec Santa Fe, Álvaro Obregón, 01219 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (507, '2013-11-30', 12, 705, 2, 0, 1, 1, 0, 1, 8061000, 'Transmisiones Militares 15, Residencial Lomas de Sotelo, Fraccionamiento Lomas de Sotelo, 53390 Naucalpan, State of Mexico, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (508, '2013-11-30', 8, 739, 3, 0, 1, 1, 0, 3, 4590000, '5 de Mayo 16A, San Francisco Culhuacan, Coyoacán, 04260 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (509, '2013-11-30', 5, 505, 2, 0, 0, 1, 0, 3, 570000, 'Juan B. Alberti, Integración Latinoamericana, Coyoacán, 04350 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (510, '2013-11-30', 11, 539, 1, 0, 0, 1, 0, 2, 2249000, 'Jaime Henrich, Los Gamitos, Álvaro Obregón, 01230 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (511, '2013-11-30', 8, 394, 3, 0, 0, 1, 0, 3, 1546000, 'Bosques de Palmitos, Lomas de Bezares, Miguel Hidalgo, 11910 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (512, '2013-11-30', 7, 366, 3, 0, 0, 1, 0, 3, 9191000, 'Misioneros 9, Centro, Cuauhtémoc, 06000 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (513, '2013-11-30', 7, 529, 3, 0, 1, 0, 0, 1, 7568000, 'Planeta, Lomas de La Estancia, Iztapalapa, 09640 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (514, '2013-11-30', 11, 631, 2, 0, 1, 0, 0, 3, 7555000, 'Estampado, 20 de Noviembre, Venustiano Carranza, 15300 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (515, '2013-11-30', 5, 586, 3, 0, 0, 1, 0, 2, 5053000, 'Filósofos 17, Nueva Rosita, Iztapalapa, 09420 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (516, '2013-11-30', 5, 621, 3, 0, 0, 0, 0, 2, 4657000, 'Eje 3 Norte Calzada San Isidro, Providencia, Azcapotzalco, 02440 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (517, '2013-11-30', 3, 747, 4, 0, 1, 1, 0, 2, 8079000, 'Esther Zuno, Consejo Agrarista Mexicano, Iztapalapa, 09760 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (518, '2013-11-30', 11, 466, 2, 0, 1, 1, 0, 1, 4323000, 'Maíz 263, Valle del Sur, Iztapalapa, 09819 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (519, '2013-11-30', 11, 406, 4, 0, 0, 0, 0, 1, 3263000, 'Mata Obscura, Jalalpa Tepito 2a. Ampliación, Álvaro Obregón, 01296 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (520, '2013-11-30', 4, 492, 4, 0, 0, 1, 0, 3, 5980000, 'Avenida Torres Ixtapaltongo, San José del Olivar, Álvaro Obregón, 01848 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (521, '2013-11-30', 4, 276, 1, 0, 0, 1, 0, 3, 2799000, 'Avenida 608 279, San Juan de Aragón 4a Sección, Gustavo A. Madero, 07979 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (522, '2013-11-30', 12, 398, 4, 0, 0, 1, 0, 2, 7199000, 'Cruz del Sur 62, Prado Churubusco, Coyoacán, 04230 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (523, '2013-11-30', 13, 748, 4, 0, 1, 0, 0, 1, 8180000, 'Cerrada Condor, Águilas Sección Hornos, Álvaro Obregón, 01048 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (524, '2013-11-30', 5, 288, 3, 0, 1, 0, 0, 1, 4021000, 'Mártires Irlandeses 22, Parque San Andrés, Coyoacán, 04040 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (525, '2013-11-30', 3, 628, 4, 0, 1, 0, 0, 3, 2003000, 'Coacota, Zenón Delgado, Álvaro Obregón, 01220 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (526, '2013-11-30', 4, 341, 2, 0, 1, 0, 0, 3, 5656000, 'General Vicente Guerrero 30, 15 de Agosto, Gustavo A. Madero, 07050 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (527, '2013-11-30', 1, 227, 2, 0, 1, 0, 0, 1, 5435000, 'Bandera, Lomas De santa Fe, Álvaro Obregón, 01219 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (528, '2013-11-30', 7, 415, 3, 0, 0, 1, 0, 2, 9427000, 'Anaxágoras 715, Narvarte, Benito Juarez, 03000 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (529, '2013-11-30', 2, 747, 4, 0, 0, 0, 0, 2, 6494000, 'Eje 4 Sur (Xola) 1302, Esperanza, Benito Juarez, 03020 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (530, '2013-11-30', 3, 375, 2, 0, 0, 1, 0, 1, 5355000, 'Creta, Lomas de Axomiatla, Álvaro Obregón, 01820 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (531, '2013-11-30', 11, 266, 4, 0, 1, 0, 0, 3, 7624000, 'Maíz 358, Valle del Sur, Iztapalapa, 09819 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (532, '2013-11-30', 2, 391, 2, 0, 1, 0, 0, 3, 5301000, 'Autopista México-Marquesa, Zedec Santa Fe, Álvaro Obregón, 01219 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (533, '2013-11-30', 5, 333, 1, 0, 0, 1, 0, 3, 8406000, 'Bosque de Canelos 95, Bosques de Las Lomas, Cuajimalpa, 05120 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (534, '2013-11-30', 12, 206, 4, 0, 1, 1, 0, 3, 5474000, 'Ruiz Cortines, Pensador Mexicano, Venustiano Carranza, 15510 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (535, '2013-11-30', 11, 562, 4, 0, 0, 1, 0, 1, 8847000, 'Doctor Alfonso Caso Andrade, Pilares Águilas, Álvaro Obregón, 01710 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (536, '2013-11-30', 12, 513, 3, 0, 0, 0, 0, 2, 9106000, 'Loma Chica LB, Lomas de Tarango, Álvaro Obregón, 01620 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (537, '2013-11-30', 9, 384, 1, 0, 0, 1, 0, 2, 3302000, 'Canadá Los Helechos 434, San Mateo Tlaltenango, Cuajimalpa, 05600 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (538, '2013-11-30', 9, 205, 1, 0, 0, 1, 0, 1, 8442000, 'Calle 20 25, Olivar del Conde 1a. Sección, Álvaro Obregón, 01400 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (539, '2013-11-30', 9, 546, 3, 0, 1, 1, 0, 2, 684000, 'San Luis 27, Corpus Cristy, Álvaro Obregón, 01530 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (540, '2013-11-30', 2, 473, 1, 0, 1, 1, 0, 2, 876000, 'San Miguel, Tetelpan, Álvaro Obregón, 01700 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (541, '2013-11-30', 3, 725, 4, 0, 0, 0, 0, 1, 8612000, 'Avenida Bordo Xochiaca, Aeropuerto Int de La Ciudad de México, Venustiano Carranza, 15620 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (542, '2013-11-30', 7, 386, 1, 0, 1, 1, 0, 1, 4988000, 'Raúl Zárate Machuca, Cuevitas, Álvaro Obregón, 01220 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (543, '2013-11-30', 4, 426, 3, 0, 1, 0, 0, 1, 8171000, 'Sur 22 129, Agrícola Oriental, Iztacalco, 08500 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (544, '2013-11-30', 13, 759, 4, 0, 0, 1, 0, 2, 6727000, 'Paseo Capulines 24, Paseos de Taxqueña, Coyoacán, 04250 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (545, '2013-11-30', 6, 657, 1, 0, 0, 1, 0, 1, 3570000, 'Vizcaínas 8-10, Doctor Alfonso Ortiz Tirado, Iztapalapa, 09020 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (546, '2013-11-30', 11, 207, 1, 0, 0, 0, 0, 2, 1517000, 'Vía Express Tapo *(VISUAL), Aeropuerto Int de La Ciudad de México, Venustiano Carranza, 15620 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (547, '2013-11-30', 5, 436, 1, 0, 0, 1, 0, 1, 4633000, 'Pisco 545, Churubusco Tepeyac, Gustavo A. Madero, 07730 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (548, '2013-11-30', 10, 492, 2, 0, 1, 1, 0, 3, 5188000, 'Plan de Agua Prieta 66, Plutarco Elías Calles, Miguel Hidalgo, 11340 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (549, '2013-11-30', 3, 463, 4, 0, 1, 0, 0, 2, 3818000, 'Artes 22, Santa Catarina, Coyoacán, 04010 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (550, '2013-11-30', 13, 787, 2, 0, 0, 1, 0, 2, 6310000, 'Rumania 609, Portales, Benito Juarez, 03300 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (551, '2013-11-30', 1, 790, 4, 0, 0, 1, 0, 1, 2162000, 'San Bartolo-Naucalpan 182 a, Nueva Argentina (Argentina Poniente), Argentina Poniente, 11230 Miguel Hidalgo, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (552, '2013-11-30', 5, 440, 1, 0, 1, 0, 0, 2, 7617000, 'Río Nilo, Puente Blanco, Iztapalapa, 09770 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (553, '2013-11-30', 12, 744, 3, 0, 0, 0, 0, 3, 7377000, 'Gregorio A. Tello 4, Constitución de 1917, Iztapalapa, 09260 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (554, '2013-11-30', 7, 340, 4, 0, 0, 0, 0, 1, 1693000, 'Campo 3 Brazos 11, San Antonio, Azcapotzalco, 02760 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (555, '2013-11-30', 7, 201, 4, 0, 1, 0, 0, 3, 6054000, 'Norte 11-A 4719, Defensores de La República, Gustavo A. Madero, 07780 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (556, '2013-11-30', 13, 517, 4, 0, 1, 1, 0, 1, 9909000, 'San Esteban 85, Santo Tomas, Azcapotzalco, 02020 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (557, '2013-11-30', 6, 432, 3, 0, 0, 0, 0, 3, 4325000, 'Roble, Garcimarreronorte, Álvaro Obregón, 01510 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (558, '2013-11-30', 11, 544, 1, 0, 0, 0, 0, 1, 185000, 'Pedro A. Chapa, Colonial Iztapalapa, Iztapalapa, 09270 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (559, '2013-11-30', 4, 694, 2, 0, 1, 1, 0, 3, 2583000, 'Zapata, La Magdalena Culhuacan, Coyoacán, 04260 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (560, '2013-11-30', 13, 655, 1, 0, 0, 0, 0, 1, 693000, 'Ceylan 585, Industrial Vallejo, Gustavo A. Madero, 07729 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (561, '2013-11-30', 13, 607, 1, 0, 1, 1, 0, 1, 361000, 'Calle Ignacio Zaragoza MZ127 LT1003, Zona Urbana Ejidal Santa Martha Acatitla Norte, Iztapalapa, 09140 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (562, '2013-11-30', 6, 564, 3, 0, 1, 1, 0, 1, 2220000, 'Año de Juárez 198, Granjas San Antonio, Iztapalapa, 09070 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (563, '2013-11-30', 3, 299, 2, 0, 1, 1, 0, 2, 6627000, 'Camino Viejo a Mixcoac 3525, San Bartolo Ameyalco, Álvaro Obregón, 01800 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (564, '2013-11-30', 10, 713, 2, 0, 0, 1, 0, 1, 7587000, 'Eje 2 Norte (Manuel González) 115, Ex Hipódromo de Peralvillo, Cuauhtémoc, 06250 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (565, '2013-11-30', 3, 735, 4, 0, 1, 0, 0, 1, 6165000, 'Matamoros, Morelos, Cuauhtémoc, 06200 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (566, '2013-11-30', 3, 703, 2, 0, 1, 1, 0, 1, 6965000, 'Paseo de la Reforma 24, Tabacalera, Cuauhtémoc, 06000 Mexico City, MX, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (567, '2013-11-30', 2, 649, 1, 0, 1, 0, 0, 1, 975000, 'Herreros 53, Morelos, Venustiano Carranza, 15940 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (568, '2013-11-30', 9, 759, 1, 0, 1, 1, 0, 2, 8014000, 'Horticultura 236, 20 de Noviembre, Venustiano Carranza, 15300 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (569, '2013-11-30', 8, 724, 2, 0, 1, 1, 0, 2, 7916000, 'Agua 160, Jardines del Pedregal, Álvaro Obregón, 01900 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (570, '2013-11-30', 7, 217, 1, 0, 1, 1, 0, 2, 3723000, 'La Joya, Bosques Tarango, Álvaro Obregón, 01580 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (571, '2013-11-30', 8, 492, 4, 0, 0, 0, 0, 1, 5879000, 'Manuel P. Romero 30, Zona Urbana Ejidal Santa Martha Acatitla Norte, Iztapalapa, 09140 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (572, '2013-11-30', 3, 624, 3, 0, 1, 1, 0, 1, 6152000, 'Morelos 44, Ampliación Zona Urbana Ejidal Santa María Aztahuacan, Iztapalapa, 09570 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (573, '2013-11-30', 10, 316, 3, 0, 1, 0, 0, 3, 6179000, 'Colipa, 2a. Ampliación Jalalpa El Grande, Álvaro Obregón, 01296 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (574, '2013-11-30', 6, 342, 2, 0, 0, 1, 0, 2, 8826000, 'Reyna Xochitl, El Paraíso, Iztapalapa, 09230 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (575, '2013-11-30', 11, 367, 1, 0, 0, 1, 0, 2, 85000, 'Mariquita Sánchez, Ctm VI Culhuacan, Coyoacán, 04480 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (576, '2013-11-30', 3, 315, 1, 0, 0, 0, 0, 1, 435000, 'San Francisco 1838-1856, Actipan, Benito Juarez, 03240 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (577, '2013-11-30', 3, 705, 2, 0, 0, 1, 0, 1, 6774000, 'Pennsylvania 280, Ciudad de Los Deportes, Benito Juarez, 03810 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (578, '2013-11-30', 13, 527, 4, 0, 1, 1, 0, 1, 829000, 'Río Nilo, Puente Blanco, Iztapalapa, 09770 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (579, '2013-11-30', 6, 446, 4, 0, 1, 0, 0, 1, 7138000, 'Emperadores 235, Residencial Emperadores, Santa Cruz Atoyac, 03320 Benito Juárez, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (580, '2013-11-30', 4, 397, 3, 0, 0, 1, 0, 2, 2546000, 'Carretera Federal Mexico - Toluca, Palo Alto(Granjas), Cuajimalpa, 05110 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (581, '2013-11-30', 2, 577, 1, 0, 0, 1, 0, 1, 5325000, 'Sur 69 476, Banjidal, Iztapalapa, 09450 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (582, '2013-11-30', 6, 767, 2, 0, 0, 1, 0, 2, 1998000, 'Calle 63 125, Santa Cruz Meyehualco, Iztapalapa, 09290 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (583, '2013-11-30', 10, 535, 2, 0, 1, 0, 0, 3, 2536000, 'Pensylvania 241, Nápoles, Benito Juarez, 03810 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (584, '2013-11-30', 1, 570, 2, 0, 1, 1, 0, 3, 3624000, '21 de Marzo MZ6 LT3, Ampliación Candelaria, Coyoacán, 04389 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (585, '2013-11-30', 9, 604, 2, 0, 1, 0, 0, 2, 3520000, 'Don Luis 69, Nativitas, Benito Juarez, 03500 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (586, '2013-11-30', 1, 252, 1, 0, 0, 0, 0, 2, 6891000, 'Eje 10 Sur (Canoa) 77, Progreso Tizapan, Álvaro Obregón, 01080 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (587, '2013-11-30', 5, 481, 1, 0, 1, 0, 0, 1, 1790000, 'Anfora 44B, Industrial, Gustavo A. Madero, 07800 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (588, '2013-11-30', 6, 470, 3, 0, 0, 0, 0, 3, 8689000, 'Fray Servando Teresa de Mier 356, Centro, Cuauhtémoc, 06090 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (589, '2013-11-30', 4, 528, 1, 0, 0, 0, 0, 2, 3308000, 'Copa de Oro 69, Ciudad Jardín, Coyoacán, 04370 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (590, '2013-11-30', 7, 302, 3, 0, 0, 0, 0, 2, 7329000, 'F.f. C.c. de Cuernavaca 318, Polanco, Miguel Hidalgo, 11550 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (591, '2013-11-30', 13, 237, 2, 0, 0, 1, 0, 2, 1403000, 'Benito Juárez, Progresista, Iztapalapa, 09240 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (592, '2013-11-30', 6, 517, 2, 0, 0, 1, 0, 3, 4069000, 'Pirules, Solidaridad, Iztapalapa, 09160 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (593, '2013-11-30', 11, 784, 4, 0, 1, 0, 0, 2, 1056000, 'Calle Tarango, San Clemente Norte, Álvaro Obregón, 01740 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (594, '2013-11-30', 5, 800, 3, 0, 1, 1, 0, 2, 9612000, 'Anillo Periférico 2773, San Jerónimo Lídice, Magdalena Contreras, 10200 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (595, '2013-11-30', 6, 485, 1, 0, 0, 1, 0, 2, 1407000, 'Norte 15-A 4918, Magdalena de Las Salinas, Azcapotzalco, 07760 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (596, '2013-11-30', 1, 619, 4, 0, 1, 1, 0, 2, 7721000, 'José María Morelos y Pavón, Torres de Potrero, Álvaro Obregón, 01840 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (597, '2013-11-30', 12, 609, 1, 0, 0, 1, 0, 1, 3536000, 'Gobernación, Zona Urbana Ejidal Estrella Culhuacan, Iztapalapa, 09800 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (598, '2013-11-30', 4, 629, 4, 0, 0, 0, 0, 1, 6859000, 'Repúblicas 205, Portales, Benito Juarez, 03300 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (599, '2013-11-30', 11, 569, 2, 0, 0, 0, 0, 1, 5501000, 'Orion 6, Prado Churubusco, Coyoacán, 04230 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (600, '2013-11-30', 1, 642, 4, 0, 1, 1, 0, 1, 459000, 'Ricardo Flores Magón 392, Santa María La Ribera, Cuauhtémoc, 06400 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (601, '2013-11-30', 10, 567, 4, 0, 0, 0, 0, 1, 1832000, 'Eje 1 Poniente (Av. Cuauhtémoc) 808, Narvarte, Benito Juarez, 03020 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (602, '2013-11-30', 6, 470, 4, 0, 1, 1, 0, 2, 9779000, 'Retorno 204, Modelo, Iztapalapa, 09089 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (603, '2013-11-30', 3, 430, 3, 0, 1, 1, 0, 2, 1251000, 'Norte 75 15, Popotla, Miguel Hidalgo, 11400 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (604, '2013-11-30', 12, 398, 4, 0, 1, 1, 0, 1, 2152000, 'Oriente 2, Cuchilla del Tesoro, Gustavo A. Madero, 07900 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (605, '2013-11-30', 12, 492, 3, 0, 0, 0, 0, 1, 4592000, 'Rosales, Zedec Santa Fe, Álvaro Obregón, 01219 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (606, '2013-11-30', 6, 676, 2, 0, 0, 1, 0, 3, 4414000, 'Gómez Farias 331, Zedec Santa Fe, Álvaro Obregón, 01219 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (607, '2013-11-30', 3, 635, 1, 0, 0, 1, 0, 1, 933000, 'Privada Corina 37, Del Carmen, Coyoacán, 04100 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (608, '2013-11-30', 3, 754, 2, 0, 0, 1, 0, 2, 8100000, 'Coxcox 75, El Arenal 3a Sección, Venustiano Carranza, 15660 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (609, '2013-11-30', 10, 483, 1, 0, 1, 0, 0, 2, 6449000, 'Laguna de Términos 395, Anáhuac, Miguel Hidalgo, 11320 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (610, '2013-11-30', 9, 253, 2, 0, 1, 1, 0, 3, 1450000, '3ER. Anillo de Circunvalación 270C, Granjas San Antonio, Iztapalapa, 09000 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (611, '2013-11-30', 9, 350, 4, 0, 1, 0, 0, 2, 2017000, 'Minerva 803, Axotla, Álvaro Obregón, 01030 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (612, '2013-11-30', 11, 209, 1, 0, 0, 0, 0, 2, 4692000, 'Desierto de Los Leones 5720, Cedros, Álvaro Obregón, 01729 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (613, '2013-11-30', 9, 549, 2, 0, 0, 1, 0, 1, 7625000, 'Avestruz, Golondrinas, Álvaro Obregón, 01270 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (614, '2013-11-30', 8, 376, 1, 0, 1, 1, 0, 3, 606000, 'Santa Lucía, Buenavista, Iztapalapa, 09700 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (615, '2013-11-30', 7, 788, 2, 0, 1, 0, 0, 1, 3146000, 'Francisco T. Contreras MZ4 LT9, Álvaro Obregón, Iztapalapa, 09230 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (616, '2013-11-30', 9, 226, 1, 0, 0, 1, 0, 3, 2957000, 'Donizetti 29, Vallejo, Gustavo A. Madero, 07870 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (617, '2013-11-30', 11, 252, 3, 0, 1, 0, 0, 2, 950000, 'Avenida Ing. Eduardo Molina 4427, La Joya, Gustavo A. Madero, 07890 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (618, '2013-11-30', 11, 518, 4, 0, 0, 1, 0, 3, 1596000, 'Flor de Nube, Torres de Potrero, Álvaro Obregón, 01840 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (619, '2013-11-30', 4, 650, 4, 0, 1, 1, 0, 1, 6421000, 'Avenida Ing. Eduardo Molina, El Parque, Venustiano Carranza, 15960 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (620, '2013-11-30', 8, 661, 2, 0, 0, 0, 0, 2, 5958000, 'Camino Campestre a 157, Campestre Aragón, Gustavo A. Madero, 07530 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (621, '2013-11-30', 1, 535, 3, 0, 1, 0, 0, 3, 5110000, 'General Vicente Guerrero 196, Martin Carrera, Gustavo A. Madero, 07070 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (622, '2013-11-30', 1, 252, 2, 0, 1, 0, 0, 2, 3029000, 'República del Salvador 44, Centro, Cuauhtémoc, 06000 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (623, '2013-11-30', 11, 253, 3, 0, 0, 1, 0, 1, 854000, 'Bahía de Descanso 16, Verónica Anzures, Miguel Hidalgo, 11300 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (624, '2013-11-30', 7, 579, 2, 0, 0, 1, 0, 2, 2756000, 'Emiliano Zapata MZ40 LT439, Zona Urbana Ejidal Santa María Aztahuacan, Iztapalapa, 09570 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (625, '2013-11-30', 7, 410, 4, 0, 0, 0, 0, 2, 2582000, 'Bogotá 649, Lindavista, Gustavo A. Madero, 07300 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (626, '2013-11-30', 13, 694, 1, 0, 0, 1, 0, 2, 4961000, 'Osa Menor 92, Prado Churubusco, Coyoacán, 04230 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (627, '2013-11-30', 9, 597, 4, 0, 0, 1, 0, 1, 6866000, 'Holbein, Ciudad de Los Deportes, Benito Juarez, 03710 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (628, '2013-11-30', 2, 700, 3, 0, 0, 1, 0, 1, 8343000, 'Tajín 763, Letrán Valle, Benito Juarez, 03650 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (629, '2013-11-30', 7, 652, 4, 0, 0, 1, 0, 1, 4448000, 'Callejón Benito Juárez 5, Norte, Álvaro Obregón, 01410 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (630, '2013-11-30', 7, 691, 2, 0, 1, 1, 0, 3, 9902000, 'Batalla de Celaya, Militar 1 K Lomas de Sotelo, Miguel Hidalgo, 11200 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (631, '2013-11-30', 8, 533, 3, 0, 0, 0, 0, 3, 7280000, 'Duraznos, Las Cruces, Magdalena Contreras, 10330 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (632, '2013-11-30', 12, 692, 3, 0, 1, 1, 0, 1, 2381000, 'Arroz 226, Santa Isabel Industrial, Iztapalapa, 09820 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (633, '2013-11-30', 5, 753, 1, 0, 1, 0, 0, 3, 276000, 'Pedro Monte, 2a. Ampliación Presidentes, Álvaro Obregón, 01299 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (634, '2013-11-30', 8, 580, 4, 0, 1, 0, 0, 3, 5336000, 'Ezequiel Montes 134, Tabacalera, Cuauhtémoc, 06030 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (635, '2013-11-30', 1, 328, 1, 0, 1, 0, 0, 1, 5619000, 'Avenida Ing. Eduardo Molina 3736, La Joya, Gustavo A. Madero, 07890 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (636, '2013-11-30', 7, 618, 2, 0, 1, 1, 0, 2, 1977000, 'Lomas del Angel 13, Lomas de Tarango, Álvaro Obregón, 01620 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (637, '2013-11-30', 8, 389, 2, 0, 0, 0, 0, 1, 7471000, 'Doctor José María Vertiz 12, Doctores, Cuauhtémoc, 06720 Cuauhtemoc, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (638, '2013-11-30', 7, 267, 2, 0, 0, 0, 0, 2, 2000, 'Nogales, Lomas de Capula, Álvaro Obregón, 01520 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (639, '2013-11-30', 13, 589, 2, 0, 0, 0, 0, 1, 1697000, '3 Pioquinto Roldán MZ3 LT52, U Habitacional Vicente Guerrero I II ÌII IV V VI VII, Iztapalapa, 09200 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (640, '2013-11-30', 4, 600, 1, 0, 1, 1, 0, 3, 1234000, 'Mar Marmara 379, Popotla, Miguel Hidalgo, 11400 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (641, '2013-11-30', 9, 310, 1, 0, 1, 0, 0, 2, 9429000, 'Violeta, Tlacoyaque, Álvaro Obregón, 01859 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (642, '2013-11-30', 12, 648, 4, 0, 1, 1, 0, 3, 5129000, 'Xoconoxtle 13, Infonavit Iztacalco, Iztacalco, 08900 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (643, '2013-11-30', 3, 788, 3, 0, 1, 1, 0, 1, 9480000, '16 de Septiembre, Culhuacan, Iztapalapa, 09800 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (644, '2013-11-30', 2, 581, 3, 0, 0, 1, 0, 3, 2267000, 'Secretaría de Marina 435, Lomas de Vista Hermosa, Cuajimalpa, 05100 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (645, '2013-11-30', 9, 509, 3, 0, 1, 1, 0, 1, 1176000, 'Calzada de la Naranja 867, Ampliación San Pedro Xalpa, San Isidro, 02710 Azcapotzalco, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (646, '2013-11-30', 13, 585, 4, 0, 1, 1, 0, 3, 4756000, 'Avenida Insurgentes Norte, Tlacamaca, Gustavo A. Madero, 07380 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (647, '2013-11-30', 6, 716, 4, 0, 1, 1, 0, 3, 4725000, 'Lomas del Angel 13, Lomas de Tarango, Álvaro Obregón, 01620 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (648, '2013-11-30', 10, 229, 3, 0, 1, 1, 0, 1, 6531000, 'Batallón de Zacapoaxtla 8, Ejército de Oriente Indeco II ISSSTE, Ejercito de Oriente, 09230 Iztapalapa, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (649, '2013-11-30', 12, 537, 3, 0, 0, 1, 0, 3, 6700000, 'Campo Colomo 24, San Antonio, Azcapotzalco, 02760 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (650, '2013-11-30', 7, 247, 2, 0, 0, 0, 0, 1, 344000, 'Río Lerma 100, Cuauhtémoc, Nueva Cobertura, 06500 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (651, '2013-11-30', 7, 375, 1, 0, 0, 1, 0, 2, 9116000, 'Pedro A. Chapa, Colonial Iztapalapa, Iztapalapa, 09270 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (652, '2013-11-30', 8, 749, 2, 0, 1, 1, 0, 3, 5510000, 'Avenida Tamaulipas 307, Lomas de Santa Fe, Cuajimalpa, 05600 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (653, '2013-11-30', 10, 281, 3, 0, 0, 1, 0, 3, 6575000, 'Al Manantial, San Mateo Tlaltenango, Cuajimalpa, 05600 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (654, '2013-11-30', 11, 405, 4, 0, 1, 0, 0, 1, 8311000, '604 315, Narciso Bassols, Gustavo A. Madero, 07980 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (655, '2013-11-30', 5, 519, 3, 0, 0, 0, 0, 3, 3383000, 'Avenida Panteón, San Juan Cerro, Iztapalapa, 09858 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (656, '2013-11-30', 3, 555, 2, 0, 0, 1, 0, 1, 5263000, 'Donceles 36, Centro, Cuauhtémoc, 06010 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (657, '2013-11-30', 9, 460, 1, 0, 0, 0, 0, 3, 2126000, 'Calle Nautla, Casa Blanca, Iztapalapa, 09860 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (658, '2013-11-30', 9, 270, 3, 0, 0, 1, 0, 1, 4071000, 'Sur 103 1110, El Parque, Venustiano Carranza, 15970 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (659, '2013-11-30', 8, 443, 1, 0, 1, 1, 0, 2, 5643000, 'Miguel Laurent 514, Del Valle, Benito Juarez, 03100 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (660, '2013-11-30', 7, 246, 2, 0, 1, 1, 0, 3, 7072000, 'Avenida 608 23, San Juan de Aragón 3a Sección, Gustavo A. Madero, 07970 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (661, '2013-11-30', 1, 753, 2, 0, 1, 1, 0, 1, 6611000, 'Del Rosal, Los Angeles, Iztapalapa, 09830 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (662, '2013-11-30', 1, 334, 2, 0, 0, 1, 0, 3, 4646000, 'Calle Justo Sierra MZ20 LT8, Santa Cruz Meyehualco, Iztapalapa, 09730 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (663, '2013-11-30', 9, 234, 2, 0, 0, 1, 0, 2, 1791000, 'Marcos López Jiménez MZ126 LT16, Zona Urbana Ejidal Santa Martha Acatitla Norte, Iztapalapa, 09140 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (664, '2013-11-30', 11, 448, 2, 0, 1, 0, 0, 2, 4569000, 'Javier Barros Sierra 225, Zedec Santa Fe, Álvaro Obregón, 01219 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (665, '2013-11-30', 3, 313, 2, 0, 1, 0, 0, 1, 3397000, 'Jose Antonio Alzate 70, Santa María La Ribera, Cuauhtémoc, 06400 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (666, '2013-11-30', 13, 215, 3, 0, 0, 1, 0, 3, 3027000, 'Frontera 36, Roma Norte, Cuauhtémoc, 06700 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (667, '2013-11-30', 7, 477, 1, 0, 0, 1, 0, 3, 5343000, 'Loma de Vista Hermosa 118, Lomas de Vista Hermosa, Cuajimalpa, 05100 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (668, '2013-11-30', 12, 513, 1, 0, 0, 0, 0, 2, 197000, 'Villa Fruela MZ70B LT19, Lomas de Santa Cruz, Iztapalapa, 09700 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (669, '2013-11-30', 10, 397, 3, 0, 0, 1, 0, 3, 7891000, 'Mina de Zinc, Tlacuitlapa Ampliación 2o. Reacomodo, Álvaro Obregón, 01650 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (670, '2013-11-30', 2, 572, 2, 0, 0, 0, 0, 1, 8480000, 'Herminio Chavarría, Zona Urbana Ejidal Santa María Aztahuacan, Iztapalapa, 09570 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (671, '2013-11-30', 9, 733, 4, 0, 0, 1, 0, 3, 4378000, 'Eje 3 Poniente (Av. Coyoacán) 739, Del Valle, Benito Juarez, 03100 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (672, '2013-11-30', 4, 551, 3, 0, 0, 0, 0, 2, 2184000, 'Cerrada de Popocatépetl 36, Xoco, Benito Juarez, 03330 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (673, '2013-11-30', 3, 509, 1, 0, 1, 0, 0, 3, 1969000, 'Árbol de Fuego 17, Valle del Sur, Iztapalapa, 09819 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (674, '2013-11-30', 5, 305, 2, 0, 0, 0, 0, 1, 7733000, 'Ave María 18, Santa Catarina, Coyoacán, 04010 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (675, '2013-11-30', 10, 220, 1, 0, 1, 0, 0, 1, 6701000, 'Doctor Mora 1, Centro, Cuauhtémoc, 06050 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (676, '2013-11-30', 3, 220, 3, 0, 1, 0, 0, 1, 5909000, 'Carlos David Anderson MZ 1 LT B, Culhuacan, Iztapalapa, 09800 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (677, '2013-11-30', 13, 530, 1, 0, 1, 0, 0, 3, 6680000, 'Plutarco Elías Calles, Chinampac de Juárez, Iztapalapa, 09208 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (678, '2013-11-30', 9, 796, 4, 0, 0, 0, 0, 1, 1385000, 'Rancho San Francisco, San Bartolo Ameyalco, Álvaro Obregón, 01800 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (679, '2013-11-30', 5, 230, 3, 0, 0, 1, 0, 1, 5047000, 'Lauro Aguirre 57, Agricultura, Miguel Hidalgo, 11360 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (680, '2013-11-30', 5, 563, 1, 0, 1, 1, 0, 3, 8454000, 'Donizetti 29, Vallejo, Gustavo A. Madero, 07870 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (681, '2013-11-30', 3, 545, 4, 0, 1, 0, 0, 2, 387000, 'Cruz Gálvez 13, Hogar y Seguridad, Azcapotzalco, 02820 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (682, '2013-11-30', 4, 797, 1, 0, 1, 0, 0, 3, 991000, 'Bernardo Quintana a, Zedec Santa Fe, Álvaro Obregón, 01219 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (683, '2013-11-30', 11, 527, 1, 0, 0, 0, 0, 1, 335000, 'San Diego, San Bartolo Ameyalco, Álvaro Obregón, 01800 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (684, '2013-11-30', 9, 281, 1, 0, 1, 1, 0, 3, 7170000, 'Donizetti 316, Vallejo, Gustavo A. Madero, 07870 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (685, '2013-11-30', 5, 704, 4, 0, 0, 1, 0, 2, 2317000, 'Avenida Tamaulipas 172, Santa Lucía Reacomodo, Álvaro Obregón, 01509 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (686, '2013-11-30', 1, 717, 3, 0, 1, 1, 0, 2, 8193000, 'Paseo de la Reforma SNS, Tabacalera, Cuauhtémoc, 06030 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (687, '2013-11-30', 9, 302, 1, 0, 0, 0, 0, 2, 6733000, 'José Cardel 10A, Ampliación San Pedro Xalpa, Azcapotzalco, 02719 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (688, '2013-11-30', 9, 340, 1, 0, 1, 1, 0, 2, 1098000, 'Eje 2 Norte (Eulalia Guzmán) 143, Atlampa, Cuauhtémoc, 06450 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (689, '2013-11-30', 11, 796, 3, 0, 1, 0, 0, 1, 1879000, 'Floricultura 270, 20 de Noviembre, Venustiano Carranza, 15300 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (690, '2013-11-30', 2, 444, 3, 0, 1, 0, 0, 1, 1388000, 'Álvaro Obregón, Lomas de Santa Cruz, Iztapalapa, 09709 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (691, '2013-11-30', 3, 379, 3, 0, 1, 1, 0, 3, 6158000, 'Avenida Rio San Joaquin, Panteón Francés, Miguel Hidalgo, 11470 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (692, '2013-11-30', 5, 229, 4, 0, 0, 1, 0, 3, 1281000, 'Maíz 283, Valle del Sur, Iztapalapa, 09819 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (693, '2013-11-30', 11, 565, 4, 0, 1, 1, 0, 3, 8560000, 'Cumbres de Maltrata 145, Narvarte, Benito Juarez, 03020 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (694, '2013-11-30', 13, 443, 3, 0, 0, 0, 0, 2, 8217000, 'Eje 1 Oriente (Av. Canal de Miramontes) 1680, Campestre Churubusco, Coyoacán, 04200 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (695, '2013-11-30', 6, 387, 4, 0, 1, 0, 0, 2, 3211000, 'Eje 4 Norte (Talismán) 279, Aragón Inguarán, Gustavo A. Madero, 07820 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (696, '2013-11-30', 8, 689, 2, 0, 0, 0, 0, 2, 6631000, '17, San Simon Ticumac, Benito Juarez, 03660 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (697, '2013-11-30', 11, 641, 1, 0, 0, 1, 0, 2, 3427000, 'Ezequiel Montes 132, Tabacalera, Cuauhtémoc, 06030 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (698, '2013-11-30', 3, 219, 4, 0, 1, 0, 0, 1, 2048000, 'Coxcox MZA2 LT10, El Arenal 4a Sección, Venustiano Carranza, 15640 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (699, '2013-11-30', 9, 485, 2, 0, 1, 0, 0, 2, 5763000, 'Circuito Interior Avenida Río Mixcoac, Florida, Álvaro Obregón, 03240 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (700, '2013-11-30', 1, 496, 1, 0, 0, 0, 0, 2, 6980000, 'Calle 7 216, Molino de Rosas, Álvaro Obregón, 01470 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (701, '2013-11-30', 12, 439, 2, 0, 1, 0, 0, 3, 7415000, 'Avenida Tamaulipas MZ5 LT22, Ejido San Mateo, Álvaro Obregón, 01580 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (702, '2013-11-30', 6, 387, 4, 0, 0, 0, 0, 3, 8259000, 'Calle Fresas, Tlacoquemecatl del Valle, Benito Juarez, 03200 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (703, '2013-11-30', 8, 699, 2, 0, 0, 1, 0, 3, 5370000, 'Oyamel MZ9 LT7, (P .i.) Garcimarrero 090100001291-B, Álvaro Obregón, 01510 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (704, '2013-11-30', 3, 372, 2, 0, 0, 0, 0, 3, 2276000, 'Tlalmiminolpan, San Bartolo Ameyalco, Álvaro Obregón, 01800 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (705, '2013-11-30', 6, 695, 1, 0, 0, 1, 0, 2, 2982000, 'Batalla de Celaya, Militar 1 K Lomas de Sotelo, Miguel Hidalgo, 11200 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (706, '2013-11-30', 9, 579, 3, 0, 1, 1, 0, 1, 5926000, 'Paseo de los Laureles 129, Bosques de Las Lomas, Cuajimalpa, 05120 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (707, '2013-11-30', 4, 550, 3, 0, 1, 1, 0, 3, 7231000, 'José Loreto Fabela 19A, Campestre Aragón, Gustavo A. Madero, 07530 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (708, '2013-11-30', 10, 433, 2, 0, 0, 1, 0, 2, 6309000, 'Atexzimal (Encinos), San Bartolo Ameyalco, Álvaro Obregón, 01800 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (709, '2013-11-30', 10, 203, 2, 0, 0, 1, 0, 1, 2990000, 'Anillo Periférico Canal de Garay MZ11LT34, Lomas de San Lorenzo, Iztapalapa, 09780 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (710, '2013-11-30', 4, 654, 4, 0, 0, 1, 0, 2, 4453000, 'Florida 85, Centro, Cuauhtémoc, 06000 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (711, '2013-11-30', 9, 728, 3, 0, 1, 0, 0, 3, 3671000, 'La Joya, Bosques Tarango, Álvaro Obregón, 01580 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (712, '2013-11-30', 6, 679, 4, 0, 0, 0, 0, 2, 265000, 'SIN NOMBRE No. 458 36, Narciso Bassols, Gustavo A. Madero, 07980 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (713, '2013-11-30', 13, 734, 1, 0, 1, 1, 0, 3, 4181000, 'Presidente Plutarco Elías Calles 1102, San Andrés Tetepilco, Iztapalapa, 09440 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (714, '2013-11-30', 5, 490, 4, 0, 1, 1, 0, 2, 7757000, 'Andador 7-C, Norte, Álvaro Obregón, 01410 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (715, '2013-11-30', 6, 698, 1, 0, 1, 1, 0, 1, 1110000, '8 170, Granjas San Antonio, Iztapalapa, 09070 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (716, '2013-11-30', 4, 625, 3, 0, 1, 0, 0, 1, 7737000, 'Lomas del Angel 13, Lomas de Tarango, Álvaro Obregón, 01620 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (717, '2013-11-30', 13, 462, 1, 0, 0, 0, 0, 3, 1738000, 'Paseo de Los Jardines 191, Paseos de Taxqueña, Coyoacán, 04250 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (718, '2013-11-30', 11, 614, 3, 0, 1, 1, 0, 2, 8796000, 'Eje 2 Poniente Florencia 20, Juárez, Cuauhtémoc, 06600 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (719, '2013-11-30', 4, 797, 4, 0, 1, 0, 0, 3, 4852000, 'Avenida Francisco Sosa 69, Santa Catarina, Coyoacán, 04100 Metro Coyoacán, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (720, '2013-11-30', 2, 349, 4, 0, 0, 1, 0, 2, 3996000, 'Sur 129 125-126, Santa Isabel Industrial, Iztapalapa, 09820 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (721, '2013-11-30', 13, 634, 2, 0, 1, 1, 0, 1, 8853000, 'Bahía de Ballenas 64, Verónica Anzures, Miguel Hidalgo, 11300 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (722, '2013-11-30', 6, 772, 3, 0, 1, 0, 0, 2, 2705000, 'Mixtecas 154(MZ80 LT5), Ajusco, Coyoacán, 04300 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (723, '2013-11-30', 4, 541, 3, 0, 0, 1, 0, 1, 6216000, '508 193, San Juan de Aragón 4a Sección, Gustavo A. Madero, 07979 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (724, '2013-11-30', 2, 386, 4, 0, 0, 1, 0, 1, 3504000, 'General Ildefonso Vázquez 3, Militar 1 K Lomas de Sotelo, Miguel Hidalgo, 11200 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (725, '2013-11-30', 6, 489, 3, 0, 1, 0, 0, 1, 3396000, 'Centeno 44, Granjas Esmeralda, Benito Juarez, 09810 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (726, '2013-11-30', 11, 593, 3, 0, 1, 1, 0, 3, 4282000, 'Yacatecutli MZ14 LT1, 1ra Ampliación Santiago Acahualtepec, Iztapalapa, 09608 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (727, '2013-11-30', 5, 734, 1, 0, 1, 0, 0, 2, 618000, 'Chabacano 30, San Mateo Tlaltenango, Cuajimalpa, 05600 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (728, '2013-11-30', 13, 578, 2, 0, 0, 0, 0, 3, 4735000, 'Moctezuma, Zona Urbana Ejidal Los Reyes Culhuacan, Iztapalapa, 09840 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (729, '2013-11-30', 4, 350, 3, 0, 0, 0, 0, 2, 9442000, 'Jacobo Watt, Culhuacan, Iztapalapa, 09800 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (730, '2013-11-30', 11, 527, 1, 0, 1, 1, 0, 3, 5286000, 'Calle Francisco Pimentel 99, San Rafael, Cuauhtémoc, 06470 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (731, '2013-11-30', 5, 373, 2, 0, 1, 0, 0, 1, 3765000, 'Avenida Hidalgo, San Miguel, Iztapalapa, 09360 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (732, '2013-11-30', 12, 338, 2, 0, 1, 0, 0, 1, 1093000, 'República de Ecuador 47, Centro, Cuauhtémoc, 06020 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (733, '2013-11-30', 2, 242, 2, 0, 1, 1, 0, 2, 5971000, 'Mar de La Sonda, Popotla, Miguel Hidalgo, 11400 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (734, '2013-11-30', 9, 235, 1, 0, 0, 1, 0, 1, 6743000, 'Mixtecas 154(MZ80 LT5), Ajusco, Coyoacán, 04300 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (735, '2013-11-30', 12, 235, 2, 0, 1, 0, 0, 1, 4961000, '11 1630, Aguilera, Azcapotzalco, 02900 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (736, '2013-11-30', 10, 479, 4, 0, 1, 1, 0, 1, 2279000, 'Ingeniería 23, Copilco El Alto, Coyoacán, 04360 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (737, '2013-11-30', 8, 588, 1, 0, 0, 1, 0, 3, 9218000, '1a. Privada Prolongación San Diego, San Bartolo Ameyalco, Álvaro Obregón, 01800 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (738, '2013-11-30', 6, 503, 1, 0, 0, 1, 0, 3, 1256000, 'Al Manantial, San Mateo Tlaltenango, Cuajimalpa, 05600 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (739, '2013-11-30', 9, 728, 1, 0, 0, 1, 0, 1, 1491000, 'Al Olivo 22, Jardines de La Palma(Huizachito), Cuajimalpa, 05100 Cuajimalpa de Morelos, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (740, '2013-11-30', 3, 563, 4, 0, 0, 1, 0, 2, 5188000, 'Lago Chalco, Anáhuac, Miguel Hidalgo, 11320 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (741, '2013-11-30', 10, 269, 1, 0, 0, 0, 0, 2, 1890000, 'Minas, Lomas de La Estancia, Iztapalapa, 09640 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (742, '2013-11-30', 1, 234, 3, 0, 1, 1, 0, 2, 4366000, 'Lázaro Cárdenas MZ100 LT1263, Ampliación Zona Urbana Ejidal Santa María Aztahuacan, Iztapalapa, 09570 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (743, '2013-11-30', 13, 336, 2, 0, 0, 1, 0, 3, 2869000, 'F. C. Industrial, Moctezuma 2a Sección, Venustiano Carranza, 15530 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (744, '2013-11-30', 6, 319, 1, 0, 0, 0, 0, 2, 3317000, '28, Porvenir, Azcapotzalco, 02940 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (745, '2013-11-30', 11, 731, 2, 0, 1, 1, 0, 1, 3974000, 'Eje 1 Oriente (Av. Canal de Miramontes) 2131, El Centinela, Coyoacán, 04450 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (746, '2013-11-30', 3, 767, 1, 0, 0, 0, 0, 2, 3780000, 'Bruselas 10, Juárez, Cuauhtémoc, 06600 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (747, '2013-11-30', 3, 651, 4, 0, 1, 0, 0, 3, 4740000, 'Calle de La Loma, Lomas de San Angel Inn, Álvaro Obregón, 01790 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (748, '2013-11-30', 13, 591, 3, 0, 0, 0, 0, 2, 7643000, '2 de Noviembre, Palmitas, Iztapalapa, 09670 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (749, '2013-11-30', 3, 757, 2, 0, 1, 0, 0, 2, 7908000, 'Desierto de Los Leones 5720, Cedros, Álvaro Obregón, 01729 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (750, '2013-11-30', 4, 345, 2, 0, 0, 1, 0, 2, 5368000, 'Eje 2 Poniente Florencia 20, Juárez, Cuauhtémoc, 06600 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (751, '2013-11-30', 13, 525, 1, 0, 1, 0, 0, 3, 3696000, 'Ejido Tepepan LB, San Francisco Culhuacan(Ejidos de Culhuacan), Coyoacán, 04470 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (752, '2013-11-30', 3, 744, 2, 0, 0, 0, 0, 2, 1043000, 'Santo Tomas 12, Centro, Cuauhtémoc, 06000 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (753, '2013-11-30', 9, 729, 2, 0, 1, 0, 0, 3, 7532000, 'Camino de La Amistad 290, Campestre Aragón, Gustavo A. Madero, 07530 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (754, '2013-11-30', 11, 313, 2, 0, 1, 1, 0, 3, 6865000, 'General López de Santa Anna 127-129, Martin Carrera, Gustavo A. Madero, 07070 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (755, '2013-11-30', 8, 284, 1, 0, 0, 0, 0, 2, 5298000, 'Jacaranda, San Clemente Norte, Álvaro Obregón, 01740 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (756, '2013-11-30', 9, 326, 1, 0, 1, 0, 0, 3, 4327000, 'Secretaría de Marina 491, Lomas de Vista Hermosa, Cuajimalpa, 05100 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (757, '2013-11-30', 1, 682, 2, 0, 0, 0, 0, 2, 5818000, 'Calle Fco Cesar M., Fuentes de Zaragoza, Iztapalapa, 09150 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (758, '2013-11-30', 4, 732, 1, 0, 1, 1, 0, 2, 4176000, 'Anillo de Circunvalación, Zona Urbana Ejidal Santa María Aztahuacan, Iztapalapa, 09570 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (759, '2013-11-30', 12, 303, 1, 0, 1, 0, 0, 3, 9807000, 'Borregos, Lomas de Los Angeles Tetelpan, Álvaro Obregón, 01790 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (760, '2013-11-30', 1, 694, 1, 0, 1, 1, 0, 2, 1594000, 'Calle 65 8, Santa Cruz Meyehualco, Iztapalapa, 09290 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (761, '2013-11-30', 13, 279, 2, 0, 0, 1, 0, 2, 3799000, 'Autopista México-Marquesa, Zedec Santa Fe, Álvaro Obregón, 01219 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (762, '2013-11-30', 8, 461, 4, 0, 1, 1, 0, 1, 9259000, 'Avenida Centenario, Bosques Tarango, Álvaro Obregón, 01580 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (763, '2013-11-30', 3, 557, 1, 0, 0, 1, 0, 1, 7348000, 'Calzada 22 de Septiembre de 1914, San Juan Tlihuaca, Azcapotzalco, 02400 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (764, '2013-11-30', 12, 562, 4, 0, 1, 1, 0, 1, 5481000, 'Cocoteros 150, Nueva Santa María, Azcapotzalco, 02800 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (765, '2013-11-30', 13, 387, 2, 0, 0, 1, 0, 2, 9051000, 'Otilio Montaño, Las Peñas, Iztapalapa, 09700 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (766, '2013-11-30', 7, 518, 1, 0, 0, 0, 0, 2, 7834000, 'Avenida de las Minas, Xalpa, Iztapalapa, 09640 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (767, '2013-11-30', 5, 782, 1, 0, 1, 0, 0, 2, 950000, 'Mar de La Sonda 16, Popotla, Miguel Hidalgo, 11400 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (768, '2013-11-30', 4, 522, 2, 0, 1, 1, 0, 3, 420000, 'Poniente 16, Cuchilla del Tesoro, Gustavo A. Madero, 07900 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (769, '2013-11-30', 6, 314, 1, 0, 0, 1, 0, 2, 334000, '2a. Cerrada San Joaquín, San Joaquín, Miguel Hidalgo, 11260 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (770, '2013-11-30', 3, 353, 2, 0, 1, 0, 0, 1, 7570000, 'And. León Guzmán, Campamento 2 de Octubre, Iztacalco, 08930 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (771, '2013-11-30', 9, 380, 1, 0, 0, 0, 0, 2, 318000, 'Presidente Masaryk 547, Polanco, Miguel Hidalgo, 11550 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (772, '2013-11-30', 11, 758, 4, 0, 0, 1, 0, 1, 8605000, 'Avenida de las Minas, Xalpa, Iztapalapa, 09640 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (773, '2013-11-30', 6, 536, 2, 0, 1, 0, 0, 2, 8775000, 'Eje Central Lázaro Cárdenas 878, Niños Heroes de Chapultepec, Niños Héroes, 03440 Benito Juárez, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (774, '2013-11-30', 4, 734, 1, 0, 0, 1, 0, 3, 9032000, 'Censos 10, El Retoño, Iztapalapa, 09440 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (775, '2013-11-30', 6, 409, 3, 0, 1, 0, 0, 3, 4954000, 'Eje 4 Norte (Av. 510), San Juan de Aragón 4a Sección, Gustavo A. Madero, 07979 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (776, '2013-11-30', 7, 572, 1, 0, 0, 1, 0, 1, 8777000, '12 21(MZ28 LT15), Olivar del Conde 1a. Sección, Álvaro Obregón, 01400 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (777, '2013-11-30', 4, 448, 4, 0, 0, 0, 0, 2, 3776000, 'Los Gipaetos, Lomas de Las Águilas, Álvaro Obregón, 01759 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (778, '2013-11-30', 7, 786, 1, 0, 0, 1, 0, 1, 2247000, 'Roldán 124-126, Centro, Cuauhtémoc, 06000 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (779, '2013-11-30', 12, 514, 1, 0, 0, 1, 0, 1, 102000, '1517 89, San Juan de Aragón 6a Sección, Gustavo A. Madero, 07918 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (780, '2013-11-30', 11, 459, 4, 0, 1, 0, 0, 1, 4302000, 'Del Recuerdo, El Mirador, Álvaro Obregón, 01708 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (781, '2013-11-30', 9, 445, 2, 0, 0, 0, 0, 3, 8223000, 'Herminio Chavarría, Zona Urbana Ejidal Santa María Aztahuacan, Iztapalapa, 09570 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (782, '2013-11-30', 9, 615, 4, 0, 0, 0, 0, 3, 6620000, 'Calle de Balderas, Centro, Cuauhtémoc, 06000 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (783, '2013-11-30', 3, 795, 2, 0, 0, 0, 0, 2, 2273000, 'N. Álvarez 2, Zacatepec, Iztapalapa, 09560 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (784, '2013-11-30', 4, 684, 4, 0, 1, 0, 0, 2, 2754000, 'General Ildefonso Vázquez 3, Militar 1 K Lomas de Sotelo, Miguel Hidalgo, 11200 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (785, '2013-11-30', 3, 441, 4, 0, 0, 1, 0, 1, 4351000, 'Norte 11 4626, Defensores de La República, Gustavo A. Madero, 07780 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (786, '2013-11-30', 1, 340, 2, 0, 1, 1, 0, 2, 7533000, 'Cerro Tlapacoyan 11, Copilco Universidad, Coyoacán, 04360 Coyoacan, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (787, '2013-11-30', 4, 300, 1, 0, 1, 1, 0, 1, 393000, 'Avenida Tamaulipas MZ5 LT22, Ejido San Mateo, Álvaro Obregón, 01580 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (788, '2013-11-30', 9, 689, 1, 0, 1, 1, 0, 2, 2174000, 'Allende 62, Centro, Cuauhtémoc, 06000 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (789, '2013-11-30', 8, 360, 1, 0, 1, 1, 0, 2, 9074000, 'Calle 71 16, Santa Cruz Meyehualco, Iztapalapa, 09290 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (790, '2013-11-30', 8, 498, 4, 0, 0, 0, 0, 2, 3719000, '3a. Cerrada de Tiro Al Pichón 17, Lomas de Bezares, Miguel Hidalgo, 11910 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (791, '2013-11-30', 4, 399, 1, 0, 0, 0, 0, 3, 3540000, 'Insurgentes Centro 62, Tabacalera, Cuauhtémoc, 06030 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (792, '2013-11-30', 12, 568, 4, 0, 1, 0, 0, 3, 3321000, 'Sur 69-A, Banjidal, Iztapalapa, 09450 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (793, '2013-11-30', 12, 715, 4, 0, 1, 0, 0, 1, 7890000, 'Rea MZ5 LT46, Sideral, Iztapalapa, 09320 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (794, '2013-11-30', 3, 743, 4, 0, 0, 1, 0, 1, 48000, 'SIN NOMBRE No. 41 4, San Francisco Culhuacan, Coyoacán, 04260 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (795, '2013-11-30', 4, 249, 1, 0, 0, 1, 0, 2, 6981000, 'Miranda 45, Aragón La Villa(Aragón), Gustavo A. Madero, 07000 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (796, '2013-11-30', 3, 589, 1, 0, 0, 0, 0, 1, 3777000, 'Calle 23 MZ6 LT20, Olivar del Conde 2a. Sección, Álvaro Obregón, 01408 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (797, '2013-11-30', 6, 777, 1, 0, 0, 0, 0, 2, 4598000, 'Autopista México-Marquesa, Zedec Santa Fe, Álvaro Obregón, 01219 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (798, '2013-11-30', 9, 391, 4, 0, 0, 1, 0, 1, 1142000, 'Africa 10, La Concepción, Coyoacán, 04020 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (799, '2013-11-30', 5, 401, 1, 0, 0, 0, 0, 1, 8396000, 'Providencia, San Jerónimo Lídice, Magdalena Contreras, 10200 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (800, '2013-11-30', 4, 417, 1, 0, 0, 1, 0, 3, 3294000, 'Reims, Fraccionamiento Villa Verdun, Álvaro Obregón, 01820 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (801, '2013-11-30', 10, 700, 3, 0, 1, 1, 0, 1, 6859000, 'Granados 135, Ex Hipódromo de Peralvillo, Cuauhtémoc, 06250 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (802, '2013-11-30', 2, 372, 4, 0, 1, 0, 0, 2, 1782000, 'Avenida 608 279, San Juan de Aragón 4a Sección, Gustavo A. Madero, 07979 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (803, '2013-11-30', 9, 588, 2, 0, 1, 1, 0, 2, 6941000, 'Calle Ignacio Zaragoza, Juan Escutia, Iztapalapa, 09100 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (804, '2013-11-30', 8, 761, 2, 0, 0, 0, 0, 3, 2376000, '1 Mercedes Abrego, Ctm VI Culhuacan, Coyoacán, 04480 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (805, '2013-11-30', 1, 459, 2, 0, 0, 1, 0, 1, 8658000, 'Independencia 55, Ampliación El Triunfo, Iztapalapa, 09438 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (806, '2013-11-30', 13, 374, 3, 0, 0, 1, 0, 3, 3372000, 'Francisco Villa, Zona Urbana Ejidal Santa María Aztahuacan, Iztapalapa, 09570 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (807, '2013-11-30', 1, 529, 2, 0, 1, 0, 0, 1, 4499000, 'Cerrada de Popocatépetl 36, Xoco, Benito Juarez, 03330 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (808, '2013-11-30', 1, 618, 4, 0, 0, 0, 0, 3, 7817000, 'Avenida Telecomunicaciones, Cabeza de Juárez VI, Iztapalapa, 09225 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (809, '2013-11-30', 11, 339, 3, 0, 0, 1, 0, 2, 502000, 'Avenida Carlos Lazo, Reserva Ecológica Torres de Potrero, Álvaro Obregón, 01848 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (810, '2013-11-30', 11, 435, 2, 0, 0, 0, 0, 2, 2750000, 'Avenida Vasco de Quiroga, Zedec Santa Fe, Álvaro Obregón, 01219 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (811, '2013-11-30', 9, 495, 4, 0, 1, 1, 0, 2, 5592000, 'Pilares 1013, Letrán Valle, Benito Juarez, 03650 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (812, '2013-11-30', 6, 547, 4, 0, 0, 1, 0, 1, 8508000, 'Allende 177, Guerrero, Cuauhtémoc, 06300 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (813, '2013-11-30', 1, 723, 3, 0, 1, 0, 0, 3, 6033000, 'Camino Real de Tetelpan 141, Lomas de Los Angeles Tetelpan, Álvaro Obregón, 01799 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (814, '2013-11-30', 3, 218, 1, 0, 0, 1, 0, 3, 8776000, 'Villa Figueroa, Desarrollo Urbano Quetzalcoatl, Iztapalapa, 09700 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (815, '2013-11-30', 2, 390, 1, 0, 0, 1, 0, 1, 9258000, 'Tigre 50, Del Valle, Benito Juarez, 03100 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (816, '2013-11-30', 4, 762, 2, 0, 1, 0, 0, 2, 7429000, 'Guerrerenses, Arturo Martínez, Álvaro Obregón, 01200 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (817, '2013-11-30', 7, 494, 1, 0, 0, 1, 0, 1, 241000, 'Rumania 507, Portales, Benito Juarez, 03300 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (818, '2013-11-30', 7, 479, 2, 0, 0, 1, 0, 3, 1290000, 'Avenida Tlahuac 105, Santa Isabel Industrial, Iztapalapa, 09820 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (819, '2013-11-30', 2, 584, 1, 0, 0, 0, 0, 2, 4256000, 'Estampado, 20 de Noviembre, Venustiano Carranza, 15300 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (820, '2013-11-30', 1, 506, 1, 0, 0, 0, 0, 2, 671000, 'Prolongación Río Churubusco, Aeropuerto Int de La Ciudad de México, Venustiano Carranza, 15620 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (821, '2013-11-30', 10, 313, 3, 0, 1, 0, 0, 1, 8051000, 'Guillermo Larrazábal, Campamento 2 de Octubre, Iztacalco, 08930 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (822, '2013-11-30', 7, 481, 1, 0, 0, 1, 0, 2, 8422000, 'Calle Miguel Hidalgo, Chinampac de Juárez, Iztapalapa, 09208 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (823, '2013-11-30', 1, 598, 4, 0, 1, 0, 0, 3, 8254000, '2a. Cerrada MZ18 LT18, Xalpa, Iztapalapa, 09640 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (824, '2013-11-30', 13, 760, 3, 0, 1, 0, 0, 1, 8908000, 'Jose Ma. Morels, Culhuacan, Iztapalapa, 09800 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (825, '2013-11-30', 1, 675, 3, 0, 1, 1, 0, 1, 5797000, 'De las Torres, Buenavista, Iztapalapa, 09700 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (826, '2013-11-30', 8, 602, 4, 0, 1, 0, 0, 2, 9850000, 'Censos 16, El Retoño, Iztapalapa, 09440 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (827, '2013-11-30', 11, 753, 4, 0, 1, 0, 0, 1, 5621000, 'General G. Hernández 9, Doctores, Cuauhtémoc, 06720 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (828, '2013-11-30', 1, 337, 4, 0, 0, 0, 0, 2, 6635000, 'Avenida Torres Ixtapaltongo, San José del Olivar, Álvaro Obregón, 01848 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (829, '2013-11-30', 5, 390, 4, 0, 0, 0, 0, 2, 6386000, 'Calle Tarango, San Clemente Norte, Álvaro Obregón, 01740 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (830, '2013-11-30', 8, 438, 1, 0, 1, 1, 0, 2, 2660000, '3 A. Hernández MZ3 LT28, U Habitacional Vicente Guerrero I II ÌII IV V VI VII, Iztapalapa, 09200 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (831, '2013-11-30', 6, 681, 1, 0, 1, 0, 0, 3, 6211000, 'Río Nilo, Puente Blanco, Iztapalapa, 09770 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (832, '2013-11-30', 9, 659, 1, 0, 0, 0, 0, 2, 6644000, 'Escocia 44, Parque San Andrés, Coyoacán, 04040 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (833, '2013-11-30', 6, 722, 3, 0, 0, 1, 0, 1, 2565000, 'Avenida Pacífico 281, La Concepción, Coyoacán, 04020 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (834, '2013-11-30', 10, 457, 4, 0, 0, 0, 0, 3, 2813000, '20 de Agosto 31, San Diego Churubusco, Iztapalapa, 09800 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (835, '2013-11-30', 6, 551, 3, 0, 0, 1, 0, 2, 402000, 'Año de Juárez 216, Granjas San Antonio, Iztapalapa, 09070 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (836, '2013-11-30', 3, 200, 2, 0, 0, 0, 0, 3, 113000, 'San Lorenzo 131, Tlacoquemecatl del Valle, Benito Juarez, 03100 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (837, '2013-11-30', 8, 750, 3, 0, 1, 0, 0, 1, 6504000, 'Monte de Las Cruces 42, La Pradera, Gustavo A. Madero, 07500 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (838, '2013-11-30', 13, 658, 4, 0, 0, 1, 0, 1, 5453000, 'Ojo de Agua 2a, 2a. Ampliación Presidentes, Álvaro Obregón, 01299 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (839, '2013-11-30', 6, 573, 4, 0, 1, 0, 0, 2, 959000, 'Topógrafos 15, Nueva Rosita, Iztapalapa, 09420 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (840, '2013-11-30', 1, 386, 4, 0, 1, 1, 0, 3, 6871000, 'San Pedro, San José del Olivar, Álvaro Obregón, 01770 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (841, '2013-11-30', 3, 743, 3, 0, 1, 0, 0, 1, 2324000, 'Avenida Pacífico 281, La Concepción, Coyoacán, 04020 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (842, '2013-11-30', 2, 205, 1, 0, 1, 0, 0, 3, 6463000, 'Interior Avenida Río Churubusco 37A, Del Carmen, Coyoacán, 04100 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (843, '2013-11-30', 7, 589, 4, 0, 1, 1, 0, 2, 7537000, 'Avenida Aztecas 322(MZ91 LT8), Ajusco, Coyoacán, 04300 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (844, '2013-11-30', 10, 227, 3, 0, 0, 0, 0, 1, 6722000, 'Privada Santa Cruz, San Simon Ticumac, Benito Juarez, 03660 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (845, '2013-11-30', 5, 517, 2, 0, 1, 0, 0, 3, 7436000, 'Autopista México-Marquesa, Zedec Santa Fe, Álvaro Obregón, 01219 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (846, '2013-11-30', 7, 501, 2, 0, 1, 0, 0, 1, 4123000, 'Isabel la Católica 116, Centro, Cuauhtémoc, 06800 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (847, '2013-11-30', 3, 605, 2, 0, 0, 1, 0, 3, 356000, 'Maíz MZ265 LT32, Xalpa, Iztapalapa, 09640 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (848, '2013-11-30', 13, 648, 4, 0, 0, 0, 0, 3, 6714000, 'Eje 8 Sur (Calz. Ermita Iztapalapa) CFAMSA, Granjas San Antonio, Iztapalapa, 09070 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (849, '2013-11-30', 5, 638, 1, 0, 0, 1, 0, 3, 2231000, 'Villa Hermosa, Buenavista, Iztapalapa, 09700 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (850, '2013-11-30', 8, 593, 3, 0, 1, 0, 0, 2, 1016000, 'Cocoteros 140, Nueva Santa María, Azcapotzalco, 02800 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (851, '2013-11-30', 10, 768, 2, 0, 1, 0, 0, 3, 6753000, 'Paseo de los Arquitectos, Lomas de Santa Fe, Cuajimalpa, 01219 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (852, '2013-11-30', 8, 533, 4, 0, 1, 1, 0, 3, 5004000, 'Clavelitos 28, El Retoño, Iztapalapa, 09440 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (853, '2013-11-30', 13, 575, 1, 0, 1, 1, 0, 3, 3836000, 'Estrella de Belén, Industrias Militares de Sedena, Álvaro Obregón, 01219 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (854, '2013-11-30', 13, 523, 1, 0, 0, 1, 0, 2, 3888000, 'Paseo de los Laureles 444, Bosques de Las Lomas, Cuajimalpa, 05100 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (855, '2013-11-30', 7, 691, 4, 0, 0, 0, 0, 3, 3764000, 'Mendelssohn 70, Vallejo, Gustavo A. Madero, 07870 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (856, '2013-11-30', 1, 356, 1, 0, 0, 0, 0, 1, 6389000, '10, Olivar del Conde 1a. Sección, Álvaro Obregón, 01400 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (857, '2013-11-30', 5, 655, 1, 0, 1, 1, 0, 3, 2081000, 'Anillo Periférico (Blvd. Adolfo Ruiz Cortines) 3376, Jardines del Pedregal, Álvaro Obregón, 01900 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (858, '2013-11-30', 6, 499, 2, 0, 0, 0, 0, 3, 9267000, 'Paseo de La Troje, La Loma, Álvaro Obregón, 01260 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (859, '2013-11-30', 11, 747, 1, 0, 1, 0, 0, 2, 7781000, 'Loma Tlapexco 162, Lomas de Vista Hermosa, Cuajimalpa, 05100 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (860, '2013-11-30', 5, 347, 2, 0, 1, 1, 0, 2, 5177000, 'Agustín Romero Ibáñez 144, Presidentes Ejidales, Coyoacán, 04470 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (861, '2013-11-30', 4, 516, 1, 0, 1, 0, 0, 2, 9808000, 'Nicolás Bravo, Pueblo Santa Fe, Álvaro Obregón, 01210 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (862, '2013-11-30', 7, 681, 4, 0, 1, 0, 0, 3, 5121000, 'Ejido de Los Reyes 100, San Francisco Culhuacan(Ejidos de Culhuacan), Coyoacán, 04470 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (863, '2013-11-30', 2, 383, 3, 0, 1, 0, 0, 1, 2605000, 'Progreso, Lomas de San Lorenzo, Iztapalapa, 09780 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (864, '2013-11-30', 10, 777, 3, 0, 1, 0, 0, 2, 540000, 'Prado Sur 285, Lomas de Chapultepec, Miguel Hidalgo, 11000 Miguel Hidalgo, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (865, '2013-11-30', 4, 390, 3, 0, 0, 0, 0, 1, 3615000, 'Ings. Grabadores 43, Jardínes de Churubusco, Iztapalapa, 09410 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (866, '2013-11-30', 8, 692, 3, 0, 1, 1, 0, 2, 2578000, 'Eje 2 Norte (Manuel González) 142, Tlatelolco, Cuauhtémoc, 06250 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (867, '2013-11-30', 7, 566, 2, 0, 1, 0, 0, 2, 5890000, 'Manuel Acuña 15(MZ3 LT4), Palmitas, Iztapalapa, 09730 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (868, '2013-11-30', 2, 644, 3, 0, 0, 1, 0, 2, 9177000, 'Cerrada Pino, San Andrés Tomatlan, Iztapalapa, 09870 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (869, '2013-11-30', 3, 735, 1, 0, 1, 1, 0, 1, 2304000, 'Avenida Santa Lucía 3B, Unidad Popular Emiliano Zapata, Álvaro Obregón, 01400 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (870, '2013-11-30', 2, 300, 4, 0, 1, 0, 0, 1, 8807000, 'Gómez Farias 331, Zedec Santa Fe, Álvaro Obregón, 01219 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (871, '2013-11-30', 5, 630, 1, 0, 1, 1, 0, 3, 9534000, 'Clave 293, Vallejo, Gustavo A. Madero, 07870 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (872, '2013-11-30', 8, 410, 4, 0, 0, 0, 0, 2, 9214000, 'Ricardo Monges López 19, Educación, Coyoacán, 04400 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (873, '2013-11-30', 6, 498, 2, 0, 1, 1, 0, 2, 9362000, 'Berlín 80, Del Carmen, Coyoacán, 04100 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (874, '2013-11-30', 1, 470, 4, 0, 0, 1, 0, 3, 8391000, 'Paso de Los Libres, La Palmita, Álvaro Obregón, 01260 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (875, '2013-11-30', 2, 695, 3, 0, 1, 1, 0, 1, 5359000, 'Donizetti 33-35, Vallejo, Gustavo A. Madero, 07870 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (876, '2013-11-30', 6, 599, 2, 0, 1, 0, 0, 1, 5685000, 'Potrero Hondo, Lomas de La Estancia, Iztapalapa, 09640 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (877, '2013-11-30', 1, 403, 1, 0, 0, 0, 0, 1, 9491000, 'Flor de Nubes, Torres de Potrero, Álvaro Obregón, 01840 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (878, '2013-11-30', 9, 418, 3, 0, 1, 1, 0, 1, 5773000, 'Avenida del Bosque, Parque Tarango, Álvaro Obregón, 01580 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (879, '2013-11-30', 1, 793, 1, 0, 1, 1, 0, 2, 8108000, 'Coquimbo 699, Lindavista, Gustavo A. Madero, 07300 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (880, '2013-11-30', 11, 471, 2, 0, 1, 1, 0, 1, 7306000, 'Hortensia, Los Angeles, Iztapalapa, 09830 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (881, '2013-11-30', 12, 561, 3, 0, 1, 1, 0, 2, 4390000, 'Lemus, Xalpa, Iztapalapa, 09640 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (882, '2013-11-30', 11, 465, 1, 0, 0, 1, 0, 3, 3328000, 'Moctezuma 14, Villa Coyoacán, Coyoacán, 04000 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (883, '2013-11-30', 3, 376, 1, 0, 1, 0, 0, 1, 9217000, 'Gavilán 185, Gavilán, Iztapalapa, 09369 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (884, '2013-11-30', 11, 757, 3, 0, 0, 0, 0, 1, 7514000, 'Calzada Ings. Militares, San Lorenzo Tlaltenango, Miguel Hidalgo, 11219 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (885, '2013-11-30', 11, 572, 1, 0, 1, 1, 0, 1, 7490000, 'De La Santísima 19, Centro, Cuauhtémoc, 06000 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (886, '2013-11-30', 9, 351, 3, 0, 1, 1, 0, 3, 5783000, 'Violeta, Tlacoyaque, Álvaro Obregón, 01859 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (887, '2013-11-30', 5, 207, 2, 0, 1, 1, 0, 2, 4586000, '613 121, San Juan de Aragón 4a Sección, Gustavo A. Madero, 07979 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (888, '2013-11-30', 10, 575, 2, 0, 0, 0, 0, 3, 1757000, 'Lago Chalco, Anáhuac, Miguel Hidalgo, 11320 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (889, '2013-11-30', 10, 347, 1, 0, 1, 0, 0, 3, 523000, 'Amores 854, Del Valle, Benito Juarez, 03100 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (890, '2013-11-30', 4, 640, 2, 0, 1, 0, 0, 3, 6592000, 'Jesús Gaona 39, Moctezuma 1a Sección, Venustiano Carranza, 15500 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (891, '2013-11-30', 2, 601, 4, 0, 0, 1, 0, 2, 2920000, 'Mayorazgo de Orduña 33, Xoco, Benito Juarez, 03330 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (892, '2013-11-30', 4, 610, 3, 0, 0, 1, 0, 1, 6110000, 'Oriente 1, Cuchilla del Tesoro, Gustavo A. Madero, 07900 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (893, '2013-11-30', 3, 311, 4, 0, 0, 1, 0, 3, 6264000, 'Calzada de la Virgen, Presidentes Ejidales, Coyoacán, 04470 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (894, '2013-11-30', 5, 317, 2, 0, 1, 0, 0, 1, 4599000, 'Chichimecas 154(MZ81 LT9), Ajusco, Coyoacán, 04300 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (895, '2013-11-30', 7, 276, 2, 0, 0, 0, 0, 2, 3692000, 'Calzada Ings. Militares 18, Periodista, Miguel Hidalgo, 11200 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (896, '2013-11-30', 8, 785, 2, 0, 1, 0, 0, 2, 66000, 'Presidente Masaryk 526, Polanco, Miguel Hidalgo, 11550 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (897, '2013-11-30', 3, 469, 4, 0, 1, 0, 0, 1, 1658000, 'Tapicería 38, Penitenciaria, Venustiano Carranza, 15350 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (898, '2013-11-30', 2, 565, 1, 0, 1, 0, 0, 3, 9549000, 'Volcán Pico de Orizaba 70, La Pradera, Gustavo A. Madero, 07500 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (899, '2013-11-30', 4, 792, 1, 0, 1, 0, 0, 2, 8007000, 'Bandera, Industrias Militares de Sedena, Álvaro Obregón, 01219 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (900, '2013-11-30', 9, 382, 1, 0, 1, 0, 0, 2, 3493000, '49 34, Avante, Coyoacán, 04460 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (901, '2013-11-30', 5, 638, 2, 0, 1, 0, 0, 3, 3417000, 'Loma de la Palma 133, Lomas de Vista Hermosa, Cuajimalpa, 05100 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (902, '2013-11-30', 4, 536, 4, 0, 0, 0, 0, 2, 8280000, 'Ajusco 29, Jardines del Pedregal, Álvaro Obregón, 01900 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (903, '2013-11-30', 10, 501, 4, 0, 0, 0, 0, 1, 65000, 'Minas, Lomas de La Estancia, Iztapalapa, 09640 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (904, '2013-11-30', 12, 604, 4, 0, 1, 0, 0, 1, 2829000, 'Emiliano Zapata, Miguel Hidalgo, Venustiano Carranza, 15470 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (905, '2013-11-30', 5, 569, 1, 0, 1, 1, 0, 1, 2433000, 'Avenida Vasco de Quiroga, Lomas de Santa Fe, Cuajimalpa, 01219 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (906, '2013-11-30', 11, 392, 1, 0, 0, 1, 0, 3, 7679000, 'Cda. González Ortega, Morelos, Cuauhtémoc, 06200 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (907, '2013-11-30', 13, 618, 3, 0, 1, 1, 0, 3, 94000, 'Pirules, Solidaridad, Iztapalapa, 09160 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (908, '2013-11-30', 12, 789, 2, 0, 0, 1, 0, 3, 4534000, 'San Borja 1310, Vertiz Narvarte, Benito Juarez, 03600 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (909, '2013-11-30', 12, 248, 4, 0, 1, 1, 0, 1, 4503000, '3a. Cerrada 5 de Mayo, San Francisco Culhuacan, Coyoacán, 04260 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (910, '2013-11-30', 3, 561, 2, 0, 0, 1, 0, 2, 3103000, 'Al Manantial, San Mateo Tlaltenango, Cuajimalpa, 05600 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (911, '2013-11-30', 10, 234, 3, 0, 1, 1, 0, 2, 9514000, 'José Loreto Fabela 192, Campestre Aragón, Gustavo A. Madero, 07530 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (912, '2013-11-30', 10, 587, 1, 0, 1, 1, 0, 1, 7532000, 'Ojapan, Zenón Delgado, Álvaro Obregón, 01220 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (913, '2013-11-30', 2, 719, 2, 0, 1, 0, 0, 2, 1863000, 'Cicalco 321, Santo Domingo (Pgal de Sto Domingo), Coyoacán, 04369 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (914, '2013-11-30', 10, 615, 3, 0, 0, 0, 0, 3, 2068000, '10, Olivar del Conde 1a. Sección, Álvaro Obregón, 01400 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (915, '2013-11-30', 11, 714, 2, 0, 1, 1, 0, 3, 4124000, 'Vernet 8, San Antonio, Azcapotzalco, 02760 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (916, '2013-11-30', 9, 592, 4, 0, 0, 1, 0, 1, 3883000, 'Plan de Agua Prieta 66, Plutarco Elías Calles, Miguel Hidalgo, 11340 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (917, '2013-11-30', 7, 453, 3, 0, 1, 1, 0, 1, 3792000, 'Yácatas 418, Narvarte, Benito Juarez, 03020 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (918, '2013-11-30', 12, 322, 1, 0, 0, 1, 0, 2, 4514000, 'Avenida Venustiano Carranza, Progresista, Iztapalapa, 09240 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (919, '2013-11-30', 11, 408, 1, 0, 0, 0, 0, 2, 4258000, 'Javier Barros Sierra 225, Zedec Santa Fe, Álvaro Obregón, 01219 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (920, '2013-11-30', 10, 695, 2, 0, 1, 1, 0, 1, 2785000, 'Antigua Vía a La Venta MZ7 LT6, Arturo Martínez, Álvaro Obregón, 01200 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (921, '2013-11-30', 7, 595, 3, 0, 0, 1, 0, 1, 4287000, 'Eje 4 Norte (Talismán) 284, Granjas Modernas, Gustavo A. Madero, 07460 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (922, '2013-11-30', 1, 688, 1, 0, 1, 0, 0, 1, 8705000, 'Norte 76 3808, La Joya, Gustavo A. Madero, 07890 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (923, '2013-11-30', 12, 291, 3, 0, 0, 0, 0, 3, 6803000, 'Circuito Interior Avenida Río Churubusco, Modelo, Iztapalapa, 09089 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (924, '2013-11-30', 6, 660, 4, 0, 1, 1, 0, 1, 607000, 'Impresores 74, 20 de Noviembre, 20 de Novienbre, 15300 Venustiano Carranza, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (925, '2013-11-30', 9, 562, 4, 0, 0, 1, 0, 1, 2215000, 'Raúl Zárate Machuca, Cuevitas, Álvaro Obregón, 01220 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (926, '2013-11-30', 2, 374, 4, 0, 1, 1, 0, 3, 6637000, 'Yácatas 418, Narvarte, Benito Juarez, 03020 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (927, '2013-11-30', 12, 479, 3, 0, 1, 0, 0, 3, 7726000, 'Calle 7, Lomas de Sotelo, Miguel Hidalgo, 11200 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (928, '2013-11-30', 4, 253, 1, 0, 1, 0, 0, 3, 5013000, 'Eje 1 Pte. (Guerrero) 198, Colonia Buenavista, Cuauhtémoc, 06350 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (929, '2013-11-30', 3, 632, 1, 0, 1, 0, 0, 1, 1125000, '10, 2da Ampliación Santiago Acahualtepec, Iztapalapa, 09609 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (930, '2013-11-30', 10, 549, 1, 0, 1, 1, 0, 1, 8120000, 'Calle 23 MZ6 LT22, Olivar del Conde 2a. Sección, Álvaro Obregón, 01408 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (931, '2013-11-30', 1, 544, 3, 0, 1, 0, 0, 1, 1174000, 'Imperial 73, Industrial, Gustavo A. Madero, 07800 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (932, '2013-11-30', 12, 305, 1, 0, 1, 1, 0, 1, 4664000, '11 1608, Pro Hogar, Azcapotzalco, 02600 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (933, '2013-11-30', 1, 406, 4, 0, 1, 1, 0, 1, 6529000, 'Santa Fe Milpa Alta 5, Merced Gómez, Álvaro Obregón, 01600 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (934, '2013-11-30', 5, 294, 1, 0, 1, 1, 0, 3, 9185000, 'Playa Mirador 436, Militar Marte, Iztacalco, 08830 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (935, '2013-11-30', 12, 307, 1, 0, 0, 1, 0, 2, 9520000, 'Ricardo Flores Magón 392, Santa María La Ribera, Cuauhtémoc, 06400 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (936, '2013-11-30', 3, 655, 4, 0, 0, 1, 0, 1, 2772000, 'Chocolin, San Juan Cerro, Iztapalapa, 09858 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (937, '2013-11-30', 11, 577, 4, 0, 0, 0, 0, 3, 5426000, 'Cjon. Las Flores 15, Los Reyes, Coyoacán, 04330 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (938, '2013-11-30', 4, 616, 2, 0, 0, 1, 0, 2, 3950000, 'Saúco, San Bartolo Ameyalco, Álvaro Obregón, 01800 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (939, '2013-11-30', 5, 687, 2, 0, 0, 0, 0, 2, 3653000, 'Talavera 4, Centro, Cuauhtémoc, 06000 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (940, '2013-11-30', 12, 753, 1, 0, 0, 1, 0, 3, 7206000, 'General Martin Carrera 139, Martin Carrera, Gustavo A. Madero, 07070 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (941, '2013-11-30', 13, 608, 2, 0, 1, 0, 0, 3, 6403000, 'Desierto de Los Leones, San Bartolo Ameyalco, Álvaro Obregón, 01800 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (942, '2013-11-30', 2, 783, 2, 0, 1, 1, 0, 1, 3726000, 'Calzada Ings. Militares, San Lorenzo Tlaltenango, Miguel Hidalgo, 11219 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (943, '2013-11-30', 3, 444, 4, 0, 0, 0, 0, 1, 9111000, 'Playa Chac Mool 20, Santiago Sur, Iztacalco, 08800 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (944, '2013-11-30', 4, 307, 4, 0, 1, 1, 0, 2, 8232000, 'Pasaje San Pablo 63, Centro, Cuauhtémoc, 06000 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (945, '2013-11-30', 11, 707, 4, 0, 1, 1, 0, 1, 7374000, 'Radio 20, Valle Gómez, Cuauhtémoc, 06240 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (946, '2013-11-30', 2, 781, 4, 0, 0, 1, 0, 3, 7779000, 'Fray Bartolomé de Las Casas, Morelos, Cuauhtémoc, 06200 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (947, '2013-11-30', 8, 382, 4, 0, 0, 0, 0, 2, 5770000, 'Paseo de la Reforma 155, Guerrero, Cuauhtémoc, 06500 Cuauhtémoc, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (948, '2013-11-30', 6, 391, 3, 0, 1, 1, 0, 1, 5200000, 'Sanctorum 5, Lomas de Sotelo, Miguel Hidalgo, 11200 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (949, '2013-11-30', 13, 762, 4, 0, 1, 1, 0, 2, 9902000, 'Norte 13 4908, Magdalena de Las Salinas, Gustavo A. Madero, 07770 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (950, '2013-11-30', 2, 211, 4, 0, 0, 0, 0, 3, 8260000, 'Campo Colomo 24, San Antonio, Azcapotzalco, 02760 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (951, '2013-11-30', 9, 251, 2, 0, 0, 1, 0, 3, 1641000, 'Avenida 3 179-181, Educación, Coyoacán, 04400 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (952, '2013-11-30', 7, 201, 4, 0, 1, 0, 0, 3, 6054000, 'Gardenia, Arcos de Centenario, Álvaro Obregón, 01618 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (953, '2013-11-30', 13, 517, 4, 0, 1, 1, 0, 1, 9909000, 'Cda. Portales 21, Sta Cruz Atoyac, Benito Juarez, 03310 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (954, '2013-11-30', 6, 432, 3, 0, 0, 0, 0, 3, 4325000, 'Paseo de la Reforma, Zedec Santa Fe, Álvaro Obregón, 01219 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (955, '2013-11-30', 1, 528, 1, 0, 1, 1, 0, 2, 8456000, 'Minerva 803, Florida, Benito Juarez, 01030 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (956, '2013-11-30', 6, 267, 3, 0, 1, 0, 0, 2, 6140000, 'Eje 2 Norte (Manuel González) 408, Tlatelolco, Cuauhtémoc, 06900 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (957, '2013-11-30', 3, 487, 3, 0, 1, 1, 0, 3, 322000, 'Ignacio Zaragoza 13, Zacatepec, Iztapalapa, 09560 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (958, '2013-11-30', 10, 713, 2, 0, 0, 1, 0, 1, 7587000, 'San Francisco, Corpus Cristy, Álvaro Obregón, 01530 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (959, '2013-11-30', 3, 735, 4, 0, 1, 0, 0, 1, 6165000, 'San Bernabé, Progreso, Álvaro Obregón, 01080 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (960, '2013-11-30', 6, 672, 4, 0, 0, 0, 0, 1, 2425000, 'Desierto de Los Leones 5720, Cedros, Álvaro Obregón, 01729 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (961, '2013-11-30', 12, 358, 3, 0, 0, 0, 0, 1, 6793000, 'Rumania 308, Portales, Benito Juarez, 03300 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (962, '2013-11-30', 4, 528, 4, 0, 0, 0, 0, 2, 537000, 'Bosque de Huizaches 3, Bosques de Las Lomas, Cuajimalpa, 11000 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (963, '2013-11-30', 7, 393, 3, 0, 1, 0, 0, 2, 1642000, 'Eje 2 Oriente Av. H. Congreso de la Unión 5719A, Granjas Modernas, Gustavo A. Madero, 07460 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (964, '2013-11-30', 6, 793, 4, 0, 0, 1, 0, 1, 8405000, 'Juchique, Jalalpa Tepito 2a. Ampliación, Álvaro Obregón, 01296 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (965, '2013-11-30', 10, 393, 4, 0, 1, 1, 0, 1, 950000, 'Ruiz Cortines, Pensador Mexicano, Venustiano Carranza, 15510 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (966, '2013-11-30', 8, 724, 2, 0, 1, 1, 0, 2, 7916000, 'Río Danubio, Cuauhtémoc, Nueva Cobertura, 06500 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (967, '2013-11-30', 7, 217, 1, 0, 1, 1, 0, 2, 3723000, 'Francisco I. Madero 43, Centro, Cuauhtémoc, 06000 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (968, '2013-11-30', 10, 509, 1, 0, 1, 1, 0, 1, 3947000, 'Niños Heroes, Palmitas, Iztapalapa, 09670 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (969, '2013-11-30', 8, 730, 3, 0, 1, 1, 0, 1, 1895000, 'Alberto S. Díaz, Ejército de Agua Prieta, Iztapalapa, 09578 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (970, '2013-11-30', 2, 769, 1, 0, 0, 1, 0, 2, 2003000, 'Cjon. Maxtla 36, El Arenal 2a Sección, Venustiano Carranza, 15680 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (971, '2013-11-30', 8, 443, 4, 0, 1, 0, 0, 2, 9505000, 'Canal Nacional, Ctm VII Culhuacan, Coyoacán, 04489 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (972, '2013-11-30', 3, 722, 2, 0, 1, 1, 0, 2, 6623000, 'Eje 1 Poniente, Guerrero, Cuauhtémoc, 06300 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (973, '2013-11-30', 1, 230, 4, 0, 0, 1, 0, 1, 6334000, '3a. Cerrada de Minas, Arvide, Álvaro Obregón, 01280 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (974, '2013-11-30', 12, 704, 3, 0, 1, 0, 0, 2, 8156000, 'Prolongación Río Churubusco, Aeropuerto Int de La Ciudad de México, Venustiano Carranza, 15620 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (975, '2013-11-30', 10, 364, 2, 0, 0, 0, 0, 3, 1463000, '2a. Cerrada Robles, San Bartolo Ameyalco, Álvaro Obregón, 01800 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (976, '2013-11-30', 6, 342, 2, 0, 0, 1, 0, 2, 8826000, 'Cerro 2 Conejos 60, Romero de Terreros, Coyoacán, 04310 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (977, '2013-11-30', 11, 367, 1, 0, 0, 1, 0, 2, 85000, 'Norte 52 3815, Emiliano Zapata, Gustavo A. Madero, 07889 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (978, '2013-11-30', 3, 315, 1, 0, 0, 0, 0, 1, 435000, 'Avenida Torres Ixtapaltongo, Olivar de Los Padres, Álvaro Obregón, 01780 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (979, '2013-11-30', 3, 705, 2, 0, 0, 1, 0, 1, 6774000, 'Historiadores 282, Ampliación El Triunfo, Iztapalapa, 09438 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (980, '2013-11-30', 4, 397, 3, 0, 0, 1, 0, 2, 2546000, 'Jose Ma. Morels, Culhuacan, Iztapalapa, 09800 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (981, '2013-11-30', 7, 357, 1, 0, 0, 0, 0, 3, 9362000, '1a. Privada Vicente Guerrero, Culhuacan, Iztapalapa, 09800 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (982, '2013-11-30', 2, 478, 3, 0, 1, 0, 0, 2, 6040000, 'Carretera Federal 15 de Cuota, Lomas de Santa Fe, Cuajimalpa, 01219 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (983, '2013-11-30', 9, 723, 2, 0, 0, 0, 0, 1, 4645000, 'Río Nilo, Puente Blanco, Iztapalapa, 09770 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (984, '2013-11-30', 13, 751, 1, 0, 0, 1, 0, 3, 4031000, 'Rómulo O''farril 14, Miguel Hidalgo, Álvaro Obregón, 01789 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (985, '2013-11-30', 13, 727, 4, 0, 1, 1, 0, 2, 5251000, 'Yuncas, Tlacuitlapa Ampliación 2o. Reacomodo, Álvaro Obregón, 01650 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (986, '2013-11-30', 9, 635, 3, 0, 1, 0, 0, 1, 5092000, 'Bandera, Lomas De santa Fe, Álvaro Obregón, 01219 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (987, '2013-11-30', 10, 326, 4, 0, 1, 0, 0, 1, 9869000, 'Calle 10 41, Heron Proal, Álvaro Obregón, 01640 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (988, '2013-11-30', 11, 401, 1, 0, 1, 1, 0, 1, 1466000, 'SIN NOMBRE No. 370 18, Narciso Bassols, Gustavo A. Madero, 07980 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (989, '2013-11-30', 11, 317, 1, 0, 1, 0, 0, 2, 9944000, 'San Juan 2, Corpus Cristy, Álvaro Obregón, 01530 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (990, '2013-11-30', 7, 506, 3, 0, 1, 1, 0, 1, 4830000, '633 226, San Juan de Aragón 4a Sección, Gustavo A. Madero, 07979 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (991, '2013-11-30', 6, 406, 3, 0, 1, 0, 0, 3, 1779000, 'Minas, Lomas de La Estancia, Iztapalapa, 09640 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (992, '2013-11-30', 12, 623, 4, 0, 0, 0, 0, 3, 7535000, 'Universidad, Ejército Constitucionalista I II y ÌII, Iztapalapa, 09220 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (993, '2013-11-30', 7, 524, 1, 0, 1, 0, 0, 1, 723000, 'Calzada de La Ronda 105-109, Ex Hipódromo de Peralvillo, Cuauhtémoc, 06250 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (994, '2013-11-30', 6, 770, 3, 0, 1, 1, 0, 2, 7944000, 'Larín 35, Industrial, Gustavo A. Madero, 07800 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (995, '2013-11-30', 3, 430, 3, 0, 1, 1, 0, 2, 1251000, 'Eje 1 Poniente 982, Narvarte, Benito Juarez, 03020 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (996, '2013-11-30', 2, 283, 2, 0, 0, 0, 0, 1, 5096000, 'N 75, La Concepción, Coyoacán, 04020 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (997, '2013-11-30', 2, 406, 1, 0, 0, 1, 0, 1, 4252000, 'Calle Sufrajio Efectivo, San Miguel Amantla, Azcapotzalco, 02700 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (998, '2013-11-30', 2, 666, 4, 0, 1, 1, 0, 3, 4782000, '23 63, Santa Cruz Meyehualco, Iztapalapa, 09290 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (999, '2013-11-30', 10, 761, 1, 0, 0, 1, 0, 3, 7823000, 'Norte 1, Cuchilla del Tesoro, Gustavo A. Madero, 07900 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1000, '2013-11-30', 11, 352, 1, 0, 0, 1, 0, 3, 5091000, 'Circunvalación 210, Janitzio, Venustiano Carranza, 15200 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1001, '2013-11-30', 3, 453, 2, 0, 0, 1, 0, 1, 8940000, 'Sidar y Rovirosa, El Parque, Venustiano Carranza, 15960 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1002, '2013-11-30', 9, 526, 3, 0, 1, 1, 0, 1, 1026000, 'Casma 637, Lindavista, Gustavo A. Madero, 07300 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1003, '2013-11-30', 9, 524, 2, 0, 0, 0, 0, 1, 127000, 'Muitles, San Bartolo Ameyalco, Álvaro Obregón, 01800 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1004, '2013-11-30', 12, 398, 4, 0, 1, 1, 0, 1, 2152000, '679 59, C. T. M. Aragón, Gustavo A. Madero, 07990 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1005, '2013-11-30', 6, 676, 2, 0, 0, 1, 0, 3, 4414000, 'General Miguel Miramón 159, Martin Carrera, Gustavo A. Madero, 07070 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1006, '2013-11-30', 9, 213, 3, 0, 0, 1, 0, 1, 48000, 'Calle Libertad, Morelos, Cuauhtémoc, 06200 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1007, '2013-11-30', 3, 635, 1, 0, 0, 1, 0, 1, 933000, 'José Loreto Fabela 140, San Juan de Aragón 4a Sección, Gustavo A. Madero, 07979 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1008, '2013-11-30', 3, 754, 2, 0, 0, 1, 0, 2, 8100000, 'Cruz Verde 26, Los Reyes, Coyoacán, 04330 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1009, '2013-11-30', 8, 311, 4, 0, 0, 1, 0, 3, 2701000, 'Centeno 66, Granjas Esmeralda, Iztapalapa, 09810 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1010, '2013-11-30', 3, 607, 1, 0, 0, 0, 0, 1, 8578000, 'Calle Aluminio 450, 2do Tramo 20 de Noviembre, Venustiano Carranza, 15300 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1011, '2013-11-30', 2, 316, 2, 0, 1, 1, 0, 3, 6477000, 'Paseo de Los Jardines 222, Paseos de Taxqueña, Paseos Taxqueña, 04250 Coyoacán, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1012, '2013-11-30', 7, 579, 2, 0, 0, 1, 0, 2, 2756000, 'Avenida Carlos Lazo, Ejido San Mateo, Álvaro Obregón, 01580 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1013, '2013-11-30', 5, 624, 4, 0, 0, 1, 0, 2, 5556000, 'Calle Fco Cesar M. MZ125 LT3, Zona Urbana Ejidal Santa Martha Acatitla Norte, Iztapalapa, 09140 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1014, '2013-11-30', 13, 459, 4, 0, 1, 0, 0, 1, 935000, 'Hoja de Árbol, Infonavit Iztacalco, Iztacalco, 08900 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1015, '2013-11-30', 11, 554, 4, 0, 1, 0, 0, 1, 7736000, 'Misioneros 20, Centro, Cuauhtémoc, 06000 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1016, '2013-11-30', 11, 455, 3, 0, 1, 1, 0, 2, 8451000, 'Avilés, Constitución de 1917, Iztapalapa, 09260 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1017, '2013-11-30', 1, 728, 4, 0, 0, 0, 0, 1, 5155000, 'Minas, Pilares Águilas, Álvaro Obregón, 01710 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1018, '2013-11-30', 10, 208, 2, 0, 1, 1, 0, 2, 5878000, 'Plaza Gregorio Torres Quintero, Centro, Cuauhtémoc, 06000 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1019, '2013-11-30', 4, 642, 2, 0, 0, 0, 0, 1, 1449000, 'Eje 8 Sur (Calz. Ermita Iztapalapa) 557, Granjas Esmeralda, Iztapalapa, 09810 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1020, '2013-11-30', 7, 410, 4, 0, 0, 0, 0, 2, 2582000, 'Balderas 68, Centro, Cuauhtémoc, 06050 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1021, '2013-11-30', 9, 509, 3, 0, 1, 1, 0, 1, 1176000, 'San Juan de Los Lagos, Lomas de La Estancia, Iztapalapa, 09640 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1022, '2013-11-30', 12, 345, 2, 0, 1, 1, 0, 1, 4975000, 'Eje 5 Sur (Prol. Marcelino Buendía), Chinampac de Juárez, Iztapalapa, 09208 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1023, '2013-11-30', 6, 395, 4, 0, 1, 0, 0, 2, 956000, 'Asia 2, La Concepción, Coyoacán, 04020 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1024, '2013-11-30', 11, 434, 3, 0, 0, 1, 0, 3, 3937000, 'Terbio 390, Cuchilla Pantitlan, Venustiano Carranza, 15610 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1025, '2013-11-30', 9, 270, 3, 0, 0, 1, 0, 1, 4071000, 'Tejamanil 141, Santo Domingo (Pgal de Sto Domingo), Coyoacán, 04369 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1026, '2013-11-30', 13, 283, 4, 0, 1, 1, 0, 1, 740000, 'México - Toluca 2990, Lomas de Bezares, Miguel Hidalgo, 11910 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1027, '2013-11-30', 11, 245, 4, 0, 0, 1, 0, 1, 8157000, 'Paseo de Las Trojes, Paseos de Taxqueña, Coyoacán, 04280 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1028, '2013-11-30', 3, 762, 3, 0, 0, 1, 0, 2, 6934000, 'Sonora, Aeropuerto Int de La Ciudad de México, Venustiano Carranza, 15620 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1029, '2013-11-30', 3, 563, 3, 0, 0, 1, 0, 3, 4098000, 'Canadá Los Helechos 435-436, San Mateo Tlaltenango, Cuajimalpa, 05600 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1030, '2013-11-30', 4, 491, 1, 0, 0, 1, 0, 1, 2215000, 'José Loreto Fabela 192, Campestre Aragón, Gustavo A. Madero, 07530 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1031, '2013-11-30', 5, 372, 4, 0, 0, 0, 0, 2, 1585000, 'Nueva York 264, Del Valle, Benito Juarez, 03810 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1032, '2013-11-30', 9, 355, 3, 0, 0, 1, 0, 1, 3815000, 'Ejido de Los Reyes 100, San Francisco Culhuacan(Ejidos de Culhuacan), Coyoacán, 04470 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1033, '2013-11-30', 10, 411, 2, 0, 1, 0, 0, 1, 8523000, 'Paseo de la Reforma 325, Lomas Virreyes, Miguel Hidalgo, 06500 Mexico City (Distrito Federal), Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1034, '2013-11-30', 4, 509, 1, 0, 0, 0, 0, 1, 3649000, '10 30, Olivar del Conde 1a. Sección, Álvaro Obregón, 01400 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1035, '2013-11-30', 9, 390, 2, 0, 1, 0, 0, 2, 2328000, 'Vicente Guerrero 9, Zacatepec, Iztapalapa, 09560 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1036, '2013-11-30', 13, 524, 1, 0, 0, 1, 0, 1, 3792000, 'Cerro de Compostela 15, Campestre Churubusco, Coyoacán, 04200 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1037, '2013-11-30', 1, 550, 1, 0, 1, 0, 0, 3, 2875000, 'Azueta, Centro, Cuauhtémoc, 06000 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1038, '2013-11-30', 4, 233, 1, 0, 1, 1, 0, 3, 403000, 'Al Olivo 22, Jardines de La Palma(Huizachito), Cuajimalpa, 05100 Cuajimalpa de Morelos, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1039, '2013-11-30', 3, 558, 2, 0, 1, 1, 0, 3, 3391000, 'General Miguel Miramón 156BIS, Martin Carrera, Gustavo A. Madero, 07070 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1040, '2013-12-09', 6, 394, 3, 0, 1, 0, 0, 1, 9960000, 'Oriente 237 108, Agrícola Oriental, Iztacalco, 08500 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1041, '2013-12-09', 12, 654, 3, 0, 1, 1, 0, 1, 2969000, 'Avenida Oceanía 130, Romero Rubio, Venustiano Carranza, 15400 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1042, '2013-12-09', 9, 501, 2, 0, 1, 1, 0, 1, 2342000, 'Avenida del Bosque, Parque Tarango, Álvaro Obregón, 01580 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1043, '2013-12-09', 13, 357, 4, 0, 0, 1, 0, 2, 4612000, 'Calle Doctor Martínez del Río, Doctores, Cuauhtémoc, 06720 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1044, '2013-12-09', 1, 360, 2, 0, 0, 0, 0, 2, 2144000, 'Avenida Constituyentes 671, América, Miguel Hidalgo, 11820 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1045, '2013-12-09', 1, 795, 2, 0, 0, 1, 0, 2, 4055000, 'Nubes 121, Jardines del Pedregal, Álvaro Obregón, 01900 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1046, '2013-12-09', 2, 296, 2, 0, 1, 0, 0, 3, 1867000, 'Conscripto 311, Lomas de Sotelo, Miguel Hidalgo, 11200 Naucalpan, State of Mexico, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1047, '2013-12-09', 13, 567, 4, 0, 1, 1, 0, 3, 5002000, 'Bellini 47-48, Peralvillo, Cuauhtémoc, 06220 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1048, '2013-12-09', 7, 389, 2, 0, 1, 1, 0, 3, 5791000, 'F. C. Industrial, Vallejo, Gustavo A. Madero, 07870 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1049, '2013-12-09', 2, 790, 4, 0, 0, 0, 0, 2, 3842000, 'Las Torres, Xalpa, Iztapalapa, 09640 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1050, '2013-12-09', 9, 694, 4, 0, 0, 1, 0, 3, 5157000, 'Huitzilihuitl 22, La Preciosa, Azcapotzalco, 02460 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1051, '2013-12-09', 5, 309, 3, 0, 0, 0, 0, 2, 1903000, 'Avenida Revolucion 682, Nonoalco, Benito Juarez, 03700 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1052, '2013-12-09', 3, 610, 3, 0, 0, 1, 0, 3, 4429000, 'Eje 10 Sur (Monserrat), Conjunto Mariana, Coyoacán, 04330 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1053, '2013-12-09', 7, 774, 4, 0, 0, 1, 0, 2, 5285000, 'Eje 3 Sur (Añil) 217, Granjas México, Iztacalco, 08400 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1054, '2013-12-09', 6, 647, 4, 0, 0, 1, 0, 2, 4927000, 'Avenida de las Torres, 2da Ampliación Santiago Acahualtepec, Iztapalapa, 09609 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1055, '2013-12-09', 5, 749, 1, 0, 1, 0, 0, 2, 5611000, 'La Zanja 40, San Mateo Tlaltenango, Cuajimalpa, 05600 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1056, '2013-12-09', 6, 435, 2, 0, 0, 1, 0, 2, 7404000, 'Zempoala 62, Hermosillo, Coyoacán, 04240 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1057, '2013-12-09', 8, 473, 3, 0, 0, 0, 0, 2, 5035000, 'Niños Heroes de Chapultepec 102, Niños Heroes de Chapultepec, Benito Juarez, 03440 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1058, '2013-12-09', 8, 352, 2, 0, 1, 1, 0, 3, 3012000, 'Oriente 112 2307, Gabriel Ramos Millán, Iztacalco, 08730 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1059, '2013-12-09', 12, 734, 1, 0, 0, 0, 0, 3, 2596000, 'Marcelino Dávalos 13, Algarín, Cuauhtémoc, 06880 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1060, '2013-12-09', 6, 347, 2, 0, 0, 0, 0, 2, 6762000, 'Avenida Universidad 1495, Axotla, Álvaro Obregón, 01030 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1061, '2013-12-09', 4, 270, 3, 0, 1, 1, 0, 3, 2587000, 'Ignacio Allende 10_1, Agrícola, Álvaro Obregón, 01050 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1062, '2013-12-09', 13, 303, 1, 0, 1, 0, 0, 3, 6440000, 'Avenida Toluca 411, Olivar de Los Padres, Álvaro Obregón, 01780 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1063, '2013-12-09', 12, 415, 2, 0, 0, 0, 0, 2, 9725000, 'Hermenegildo Galeana 134, Guadalupe del Moral, Iztapalapa, 09300 Iztapalapa, Mexico, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1064, '2013-12-09', 13, 482, 1, 0, 1, 1, 0, 3, 6348000, '533 258, San Juan de Aragón 1a Sección, Gustavo A. Madero, 07969 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1065, '2013-12-09', 13, 675, 3, 0, 1, 0, 0, 3, 4116000, 'Defensa Nacional, Xalpa, Iztapalapa, 09640 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1066, '2013-12-09', 5, 376, 2, 0, 1, 1, 0, 3, 8525000, 'Solón Argüello, Zona Urbana Ejidal Santa Martha Acatitla Sur, Iztapalapa, 09530 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1067, '2013-12-09', 11, 568, 3, 0, 0, 1, 0, 2, 6687000, 'Calle José Ma. Parras 81, Juan Escutia, Iztapalapa, 09100 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1068, '2013-12-09', 8, 431, 3, 0, 0, 1, 0, 3, 958000, 'Zapotecas 248, Ajusco, Coyoacán, 04300 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1069, '2013-12-09', 1, 395, 3, 0, 1, 1, 0, 2, 4519000, 'Eje 4 Oriente (Avenida Río Churubusco), Granjas México, Iztacalco, 08400 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1070, '2013-12-09', 3, 687, 4, 0, 0, 0, 0, 1, 4248000, 'Campos Elíseos 71, Base 3, Miguel Hidalgo, 11580 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1071, '2013-12-09', 2, 474, 3, 0, 1, 0, 0, 1, 3056000, 'Eje 1 Poniente (Av. Cuahutemoc) 1090, Letrán Valle, Benito Juarez, 03650 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1072, '2013-12-09', 9, 611, 3, 0, 1, 1, 0, 2, 2451000, 'Calle 3, Ampliación Jalalpa, Álvaro Obregón, 01296 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1073, '2013-12-09', 9, 308, 3, 0, 1, 1, 0, 3, 8434000, 'Alejandro Dumas 71, Polanco, Miguel Hidalgo, 11550 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1074, '2013-12-09', 10, 591, 1, 0, 0, 1, 0, 2, 5564000, 'Trabajo y Previsión Social 510, Federal, Venustiano Carranza, 15700 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1075, '2013-12-09', 10, 578, 3, 0, 0, 0, 0, 3, 2655000, 'Del Carmen, Ixtlahuacan, Iztapalapa, 09690 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1076, '2013-12-09', 9, 502, 2, 0, 0, 0, 0, 3, 2246000, 'Tasmania 362, Cosmopolita, Azcapotzalco, 02670 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1077, '2013-12-09', 11, 443, 1, 0, 1, 1, 0, 1, 8813000, 'Colorines, Tenorios, Iztapalapa, 09680 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1078, '2013-12-09', 7, 659, 1, 0, 1, 1, 0, 2, 3378000, '5 de Mayo 14, La Martinica II, Álvaro Obregón, 01630 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1079, '2013-12-09', 1, 532, 4, 0, 0, 0, 0, 1, 5398000, 'Calle 4, Pantitlan, Iztacalco, 08100 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1080, '2013-12-09', 1, 492, 1, 0, 1, 0, 0, 1, 8948000, 'Parque Vía Reforma 2035, Lomas de Chapultepec, Miguel Hidalgo, 11000 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1081, '2013-12-09', 13, 412, 2, 0, 1, 1, 0, 2, 1598000, '2a. Cerrada Benito Juárez, Zona Urbana Ejidal Santa María Aztahuacan, Iztapalapa, 09570 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1082, '2013-12-09', 11, 349, 1, 0, 0, 0, 0, 3, 331000, 'Canal Nacional 2034, Valle del Sur, Iztapalapa, 09819 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1083, '2013-12-09', 5, 547, 4, 0, 0, 0, 0, 1, 1876000, '2 A. Pérez MZ11 LT24, U Habitacional Vicente Guerrero I II ÌII IV V VI VII, Iztapalapa, 09200 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1084, '2013-12-09', 2, 222, 3, 0, 0, 0, 0, 1, 9084000, 'Laureano Estudillo MZ166 LT40, Zona Urbana Ejidal Santa Martha Acatitla Norte, Iztapalapa, 09140 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1085, '2013-12-09', 10, 440, 1, 0, 1, 0, 0, 2, 9101000, 'San Pedro 57(103)101, Del Carmen, Coyoacán, 04100 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1086, '2013-12-09', 2, 625, 3, 0, 0, 0, 0, 1, 9518000, 'Sagitario 154, Prado Churubusco, Coyoacán, 04230 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1087, '2013-12-09', 11, 330, 1, 0, 0, 0, 0, 2, 673000, 'Serafín Olarte 85, Independencia, Benito Juarez, 03630 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1088, '2013-12-09', 8, 287, 1, 0, 0, 0, 0, 2, 5106000, 'Paseo del Río (Joaquín Gallo) 101, Chimalistac, Coyoacán, 04460 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1089, '2013-12-09', 6, 388, 4, 0, 0, 1, 0, 1, 8163000, 'Eje 5 Norte Av. 412 MZ1 LT15, Ejidos San Juan de Aragón 2a Sección, Gustavo A. Madero, 07919 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1090, '2013-12-09', 7, 260, 1, 0, 0, 0, 0, 1, 6023000, 'Primer Retorno de Canal Nacional 41b, Ctm VII Culhuacan, Coyoacán, 04489 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1091, '2013-12-09', 9, 272, 2, 0, 0, 1, 0, 1, 6155000, 'Díaz de León, Morelos, Cuauhtémoc, 06200 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1092, '2013-12-09', 6, 263, 2, 0, 1, 1, 0, 3, 289000, 'Calle Cairo 46, San Miguel Amantla, Miguel Hidalgo, 02080 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1093, '2013-12-09', 5, 304, 3, 0, 1, 1, 0, 2, 8919000, 'Melchor Ocampo 257, Verónica Anzures, Veronica Ansurez, 11300 Miguel Hidalgo, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1094, '2013-12-09', 6, 388, 3, 0, 0, 1, 0, 2, 7073000, 'Anillo Periférico 2141, Ejército Constitucionalista, Iztapalapa, 09220 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1095, '2013-12-09', 1, 358, 4, 0, 0, 1, 0, 1, 1150000, 'Atlamaya, Flor de María, Álvaro Obregón, 01760 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1096, '2013-12-09', 2, 308, 4, 0, 1, 0, 0, 3, 4871000, 'Río Salado, Puente Colorado, Álvaro Obregón, 01730 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1097, '2013-12-09', 5, 634, 1, 0, 0, 1, 0, 2, 9246000, 'EDISON 139, San Rafael, Cuauhtémoc, 06470 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1098, '2013-12-09', 6, 232, 1, 0, 1, 0, 0, 1, 8716000, 'Luis Carracci, San Juan, Benito Juarez, 03730 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1099, '2013-12-09', 11, 332, 2, 0, 0, 0, 0, 2, 1572000, 'Loma del Recuerdo 50, Lomas de Vista Hermosa, Cuajimalpa, 05100 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1100, '2013-12-09', 3, 684, 4, 0, 0, 1, 0, 3, 1169000, 'Oriente 182, Moctezuma 2a Sección, Venustiano Carranza, 15530 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1101, '2013-12-09', 5, 599, 1, 0, 0, 0, 0, 1, 7962000, 'Debussy 4419, Guadalupe Victoria, Gustavo A. Madero, 07790 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1102, '2013-12-09', 2, 757, 2, 0, 1, 0, 0, 2, 1276000, 'Avenida Carlos Lazo, Lomas de Santa Fe, Cuajimalpa, 01219 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1103, '2013-12-09', 4, 644, 3, 0, 0, 0, 0, 2, 7395000, 'Magdalena 727, Del Valle, Benito Juarez, 03100 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1104, '2013-12-09', 12, 635, 1, 0, 1, 1, 0, 1, 6082000, 'Cabalgata 12, Colinas del Sur, Álvaro Obregón, 01430 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1105, '2013-12-09', 13, 734, 1, 0, 0, 0, 0, 2, 9133000, 'Santa Balbina 96, Molino de Santo Domingo, Álvaro Obregón, 01130 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1106, '2013-12-09', 5, 761, 2, 0, 0, 1, 0, 3, 4158000, 'Misión, El Santuario, Iztapalapa, 09820 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1107, '2013-12-09', 4, 706, 3, 0, 0, 1, 0, 2, 4401000, 'Bertha 81, Nativitas, Benito Juarez, 03500 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1108, '2013-12-09', 11, 371, 3, 0, 1, 1, 0, 1, 7026000, 'Niños Heroes 202, Doctores, Cuauhtémoc, 06720 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1109, '2013-12-09', 4, 218, 2, 0, 0, 1, 0, 3, 1548000, 'Tlaloc 3, Ampliación El Triunfo, Iztapalapa, 09438 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1110, '2013-12-09', 7, 378, 2, 0, 1, 0, 0, 1, 4967000, 'Avenida Telecomunicaciones, Unidad Habitacional Guelatao de Juárez II, Iztapalapa, 09208 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1111, '2013-12-09', 5, 340, 1, 0, 0, 1, 0, 2, 6246000, 'Miguel M. Acosta MZ11 LT9, Álvaro Obregón, Iztapalapa, 09230 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1112, '2013-12-09', 10, 760, 3, 0, 1, 0, 0, 1, 690000, 'Calle Lago Zurich 210, Ampliación Granada, Miguel Hidalgo, 11529 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1113, '2013-12-09', 9, 638, 1, 0, 0, 0, 0, 3, 2130000, 'Anillo Periférico, Chinampac de Juárez, Iztapalapa, 09208 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1114, '2013-12-09', 5, 329, 1, 0, 1, 0, 0, 3, 5423000, 'Amatista 9, La Esmeralda 1a Sección, Gustavo A. Madero, 07549 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1115, '2013-12-09', 11, 395, 2, 0, 0, 1, 0, 2, 8577000, '2a Cda del Refugio, San Bartolo Ameyalco, Álvaro Obregón, 01800 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1116, '2013-12-09', 10, 329, 3, 0, 1, 1, 0, 2, 2949000, 'Reforma 6, Lomas de San Lorenzo, Iztapalapa, 09780 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1117, '2013-12-09', 12, 487, 4, 0, 1, 0, 0, 3, 6560000, 'Libra 94, Prado Churubusco, Coyoacán, 04230 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1118, '2013-12-09', 11, 456, 2, 0, 1, 1, 0, 1, 632000, 'Sur 73-B, Sinatel, Iztapalapa, 09470 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1119, '2013-12-09', 10, 640, 1, 0, 0, 1, 0, 3, 6890000, 'Cda. Pincel 221, Santo Domingo (Pgal de Sto Domingo), Coyoacán, 04369 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1120, '2013-12-09', 8, 505, 3, 0, 0, 0, 0, 3, 1559000, 'Cedro 82, Santa María La Ribera, Cuauhtémoc, 06400 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1121, '2013-12-09', 13, 530, 4, 0, 0, 1, 0, 3, 542000, 'Norte 60-A 5415, Tablas de San Aguistin, Gustavo A. Madero, 07860 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1122, '2013-12-09', 5, 774, 3, 0, 1, 0, 0, 2, 929000, 'Fernando Montes de Oca 135, Guadalupe del Moral, Iztapalapa, 06140 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1123, '2013-12-09', 9, 368, 2, 0, 0, 0, 0, 1, 9494000, 'FARALLON 200, Jardines del Pedregal, Álvaro Obregón, 01900 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1124, '2013-12-09', 1, 219, 4, 0, 1, 1, 0, 2, 463000, 'Circuito Interior Avenida Río Churubusco 1644, Campestre Churubusco, Iztapalapa, 04200 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1125, '2013-12-09', 9, 571, 2, 0, 1, 1, 0, 2, 7091000, 'Ret. 707 11, El Centinela, Coyoacán, 04450 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1126, '2013-12-09', 11, 302, 1, 0, 0, 0, 0, 2, 4951000, 'San Francisco, San Bartolo Ameyalco, Álvaro Obregón, 01800 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1127, '2013-12-09', 6, 383, 1, 0, 0, 0, 0, 1, 5179000, 'Avenida Aquiles Serdan, Tacuba, Miguel Hidalgo, 11410 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1128, '2013-12-09', 1, 273, 2, 0, 1, 0, 0, 1, 7543000, 'Francisco Sarabia, Aeropuerto Int de La Ciudad de México, Venustiano Carranza, 15620 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1129, '2013-12-09', 13, 733, 2, 0, 1, 0, 0, 1, 416000, 'Rafael Sierra, San Juan, Iztapalapa, 09830 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1130, '2013-12-09', 12, 757, 3, 0, 0, 0, 0, 2, 9195000, 'Millet 13, Tlacoquemecatl del Valle, Benito Juarez, 03100 BENITO JUAREZ, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1131, '2013-12-09', 2, 468, 3, 0, 1, 0, 0, 2, 4030000, 'Rosa Amarilla 77, El Alfalfar, Álvaro Obregón, 01470 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1132, '2013-12-09', 2, 744, 3, 0, 1, 0, 0, 2, 548000, 'Ceylan 585, Industrial Vallejo, Gustavo A. Madero, 07729 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1133, '2013-12-09', 9, 459, 3, 0, 1, 1, 0, 1, 9945000, 'De Los Buharros, Lomas de Las Águilas, Álvaro Obregón, 01759 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1134, '2013-12-09', 7, 638, 4, 0, 0, 1, 0, 3, 7773000, 'Aldama 75, Colonia Buenavista, Cuauhtémoc, 06350 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1135, '2013-12-09', 6, 515, 1, 0, 0, 1, 0, 2, 3075000, 'Mixtecas 150, Ajusco, Coyoacán, 04300 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1136, '2013-12-09', 11, 376, 2, 0, 1, 1, 0, 1, 3872000, 'Ignacio Allende, Consejo Agrarista Mexicano, Iztapalapa, 09760 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1137, '2013-12-09', 13, 616, 3, 0, 0, 1, 0, 3, 286000, 'Fueguinos, Puerta Grande Ampliación, Álvaro Obregón, 01630 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1138, '2013-12-09', 3, 281, 3, 0, 0, 0, 0, 3, 3011000, 'Calle Justo Sierra MZ20 LT8, Santa Cruz Meyehualco, Iztapalapa, 09730 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1139, '2013-12-09', 13, 352, 3, 0, 1, 0, 0, 3, 5586000, 'Francita 132, Petrolera, Azcapotzalco, 02480 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1140, '2013-12-09', 7, 465, 1, 0, 0, 0, 0, 2, 3429000, 'Estela 144, Guadalupe Tepeyac, Gustavo A. Madero, 07840 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1141, '2013-12-09', 2, 646, 3, 0, 1, 1, 0, 2, 8985000, 'Cantera 8, Villa Gustavo a Madero, Gustavo A. Madero, 07050 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1142, '2013-12-09', 5, 483, 3, 0, 1, 0, 0, 2, 3875000, '1a. Cerrada Legaria, Torre Blanca, Miguel Hidalgo, 11280 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1143, '2013-12-09', 9, 572, 2, 0, 0, 0, 0, 1, 2044000, 'Coronado, El Paraíso, Iztapalapa, 09230 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1144, '2013-12-09', 2, 719, 2, 0, 0, 1, 0, 3, 6911000, 'Leopoldo Blakaller 15, Ampliación San Pedro Xalpa, Azcapotzalco, 02719 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1145, '2013-12-09', 4, 361, 2, 0, 1, 0, 0, 1, 5314000, 'Calzada de la Naranja 195B, Santiago Ahuizotla, Azcapotzalco, 02750 Mexico City, State of Mexico, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1146, '2013-12-09', 11, 329, 2, 0, 1, 1, 0, 3, 8491000, 'Oriente 172, Ampliación Sinatel, Iztapalapa, 09479 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1147, '2013-12-09', 10, 228, 3, 0, 1, 1, 0, 1, 1675000, 'Rodolfo Usigli 1221, Heroes de Churubusco, Rodolfo Usigli, 09090 Iztapalapa, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1148, '2013-12-09', 7, 424, 3, 0, 1, 0, 0, 3, 8166000, 'San Agustín, Buenavista, Iztapalapa, 09700 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1149, '2013-12-09', 6, 630, 2, 0, 0, 1, 0, 1, 6167000, 'Plan de Ayala, Plutarco Elías Calles, Miguel Hidalgo, 11350 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1150, '2013-12-09', 12, 693, 2, 0, 1, 0, 0, 3, 6147000, 'Gustavo Díaz Ordaz, 2a. Ampliación Presidentes, Álvaro Obregón, 01299 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1151, '2013-12-09', 2, 386, 3, 0, 1, 1, 0, 1, 7365000, 'Sur 114 20, Cove, Miguel Hidalgo, 01120 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1152, '2013-12-09', 12, 312, 1, 0, 1, 0, 0, 2, 2504000, 'Avenida Torres Ixtapaltongo, Olivar de Los Padres, Álvaro Obregón, 01780 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1153, '2013-12-09', 6, 359, 1, 0, 1, 0, 0, 3, 2538000, 'Avenida Fortuna 429, Churubusco Tepeyac, Gustavo A. Madero, 07730 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1154, '2013-12-09', 12, 544, 4, 0, 0, 1, 0, 1, 679000, 'Lucas Alamán 138, Obrera, Cuauhtémoc, 06800 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1155, '2013-12-09', 2, 800, 2, 0, 1, 0, 0, 2, 8623000, 'Avenida División del Norte 2420, Portales, Benito Juarez, 03300 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1156, '2013-12-09', 13, 233, 2, 0, 1, 1, 0, 1, 6738000, 'Calle 5, San Miguel Amantla, Azcapotzalco, 02950 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1157, '2013-12-09', 9, 319, 4, 0, 0, 1, 0, 2, 5397000, 'Yosemite 80, Nápoles, Benito Juarez, 03810 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1158, '2013-12-09', 11, 309, 3, 0, 1, 1, 0, 2, 4972000, 'Juan Aldama 800, Centro, Cuauhtémoc, 88780 Reynosa, Tamaulipas, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1159, '2013-12-09', 10, 440, 4, 0, 1, 0, 0, 2, 2963000, 'Camino de Los Viveros, Lomas Estrella 1RA. Sección, Iztapalapa, 09880 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1160, '2013-12-09', 8, 448, 1, 0, 0, 0, 0, 2, 8627000, 'Avenida Melchor Ocampo 272, Santa Catarina, Coyoacán, 04010 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1161, '2013-12-09', 5, 343, 2, 0, 0, 0, 0, 1, 7145000, 'Eje 2 Oriente Heroica Escuela Naval Militar 480, San Francisco Culhuacan, Coyoacán, 04260 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1162, '2013-12-09', 4, 429, 1, 0, 1, 1, 0, 3, 161000, 'Flor Silvestre MZ6 LT8, 2da Ampliación Santiago Acahualtepec, Iztapalapa, 09609 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1163, '2013-12-09', 7, 472, 3, 0, 1, 0, 0, 1, 3546000, 'Plan de San Luis, Zona Urbana Ejidal Santa María Aztahuacan, Iztapalapa, 09570 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1164, '2013-12-09', 4, 434, 2, 0, 0, 0, 0, 3, 868000, 'Calzada San Simon 92, San Simon Tolnahuac, Cuauhtémoc, 06920 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1165, '2013-12-09', 8, 220, 1, 0, 0, 1, 0, 3, 3436000, 'Bosque de Ciruelos 9, Bosques de Las Lomas, Miguel Hidalgo, 11700 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1166, '2013-12-09', 9, 264, 4, 0, 1, 1, 0, 2, 1183000, 'Cuautla 66, Colonia Condesa, Cuauhtémoc, 06140 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1167, '2013-12-09', 6, 489, 4, 0, 0, 0, 0, 1, 4486000, 'Vía Express Tapo *(VISUAL), Aeropuerto Int de La Ciudad de México, Venustiano Carranza, 15620 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1168, '2013-12-09', 3, 495, 1, 0, 0, 0, 0, 3, 5294000, 'Prolongación Vicente Guerrero 4, San Mateo Tlaltenango, Cuajimalpa, 05600 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1169, '2013-12-09', 9, 205, 3, 0, 1, 0, 0, 3, 7256000, 'Irolo, Del Carmen, Benito Juarez, 03540 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1170, '2013-12-09', 7, 618, 1, 0, 1, 1, 0, 3, 887000, '3ER. Callejón Colón, San Miguel, Iztapalapa, 09360 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1171, '2013-12-09', 9, 683, 2, 0, 0, 1, 0, 3, 377000, 'Calzada México-Tacuba 870, Torre Blanca, Miguel Hidalgo, 11280 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1172, '2013-12-09', 2, 336, 1, 0, 1, 0, 0, 3, 3364000, 'Pino, Garcimarreronorte, Álvaro Obregón, 01510 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1173, '2013-12-09', 10, 698, 3, 0, 0, 1, 0, 1, 3684000, 'De La Rosa MZ2 LT15A, Reforma Política, Iztapalapa, 09730 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1174, '2013-12-09', 8, 455, 1, 0, 1, 1, 0, 2, 2510000, 'Melchor Ocampo 68-79, El Triunfo, Iztapalapa, 09430 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1175, '2013-12-09', 4, 346, 4, 0, 1, 0, 0, 3, 2501000, 'Procuraduría General de Justicia 247, Federal, Venustiano Carranza, 15700 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1176, '2013-12-09', 2, 775, 1, 0, 0, 0, 0, 2, 9938000, 'Pedro Vélez, Insurgentes, Iztapalapa, 09750 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1177, '2013-12-09', 6, 607, 2, 0, 1, 0, 0, 3, 8381000, 'Cerrada de Capuchinas 83, San José Insurgentes, Benito Juarez, 03900 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1178, '2013-12-09', 4, 740, 2, 0, 1, 0, 0, 2, 8058000, 'Miguel Barragán 13, Martin Carrera, Gustavo A. Madero, 07070 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1179, '2013-12-09', 6, 464, 3, 0, 0, 1, 0, 3, 754000, 'Presa la Amistad 13, Lomas de Sotelo, Miguel Hidalgo, 11200 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1180, '2013-12-09', 4, 327, 3, 0, 0, 0, 0, 2, 6705000, 'Santa Teresita MZ30 LT17 Y LT19, Molino de Santo Domingo, Álvaro Obregón, 01130 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1181, '2013-12-09', 3, 435, 4, 0, 0, 1, 0, 3, 373000, 'Leopoldo Auer 68, Vallejo Poniente, Gustavo A. Madero, 07790 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1182, '2013-12-09', 2, 787, 1, 0, 1, 0, 0, 2, 6805000, 'Avenida de Los Compositores, Bosque de Chapultepec II, Miguel Hidalgo, 11100 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1183, '2013-12-09', 6, 389, 2, 0, 0, 1, 0, 1, 9253000, 'Cataratas, Los Alpes, Álvaro Obregón, 01710 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1184, '2013-12-09', 13, 574, 3, 0, 1, 0, 0, 2, 2842000, 'Bosque de Canelos 85, Bosques de Las Lomas, Cuajimalpa, 05120 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1185, '2013-12-09', 12, 273, 2, 0, 1, 1, 0, 1, 9325000, 'Díaz Soto y Gama MZ14 LT40, U Habitacional Vicente Guerrero I II ÌII IV V VI VII, Iztapalapa, 09200 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1186, '2013-12-09', 4, 306, 3, 0, 0, 1, 0, 3, 7142000, 'Calle Miguel Hidalgo, Zona Urbana Ejidal Santa María Aztahuacan, Iztapalapa, 09570 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1187, '2013-12-09', 3, 511, 2, 0, 0, 0, 0, 2, 2963000, 'Lafayette 67, Cedros, Álvaro Obregón, 01870 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1188, '2013-12-09', 1, 443, 3, 0, 0, 1, 0, 1, 9802000, 'Rivero 100, Barrio de Tepito, Cuauhtémoc, 06200 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1189, '2013-12-09', 13, 760, 3, 0, 0, 1, 0, 2, 3956000, 'Detroit 14, Noche Buena, Benito Juarez, 03720 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1190, '2013-12-09', 4, 236, 4, 0, 0, 0, 0, 3, 7440000, 'Eje 2 Oriente Av. H. Congreso de la Unión 6413, Granjas Modernas, Gustavo A. Madero, 07460 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1191, '2013-12-09', 4, 385, 4, 0, 1, 1, 0, 2, 1818000, 'Granjas 39, Palo Alto(Granjas), Palo Alto, 01000 Cuajimalpa de Morelos, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1192, '2013-12-09', 5, 603, 4, 0, 1, 0, 0, 2, 5994000, 'Avenida Tamaulipas MZ5 LT22, Ejido San Mateo, Álvaro Obregón, 01580 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1193, '2013-12-09', 2, 547, 4, 0, 0, 1, 0, 1, 3657000, 'Ejido Tlahuac 12, San Francisco Culhuacan(Ejidos de Culhuacan), Coyoacán, 04470 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1194, '2013-12-09', 3, 403, 4, 0, 0, 0, 0, 1, 4939000, 'Jesús Carranza 23, Morelos, Cuauhtémoc, 06200 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1195, '2013-12-09', 7, 311, 1, 0, 1, 1, 0, 3, 2206000, 'Carretera Federal 85, Colonia Buenavista, Cuauhtémoc, 06350 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1196, '2013-12-09', 1, 784, 1, 0, 1, 0, 0, 3, 7092000, 'De Colina, Águilas, Álvaro Obregón, 01710 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1197, '2013-12-09', 5, 501, 2, 0, 1, 1, 0, 2, 2538000, 'Luis de La Rosa 8, Constitución de La República, Gustavo A. Madero, 07469 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1198, '2013-12-09', 2, 668, 3, 0, 1, 1, 0, 1, 6867000, 'Galeana 352, Pueblo Santa Fe, Álvaro Obregón, 01210 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1199, '2013-12-09', 13, 262, 4, 0, 1, 1, 0, 1, 1178000, 'Eje 8 Sur (Calz. Ermita Iztapalapa) 1334, San Pablo, Iztapalapa, 09000 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1200, '2013-12-09', 9, 444, 4, 0, 1, 1, 0, 3, 9409000, 'Avenida 1 35, Educación, Coyoacán, 04400 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1201, '2013-12-09', 11, 535, 4, 0, 0, 0, 0, 3, 3031000, 'Francisco Villa MZP LT13, Acuilotla, Álvaro Obregón, 01540 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1202, '2013-12-09', 1, 248, 2, 0, 1, 0, 0, 3, 9949000, 'Alpes 324, Lomas de Chapultepec, Miguel Hidalgo, 11000 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1203, '2013-12-09', 1, 454, 1, 0, 1, 1, 0, 3, 9536000, 'Avenida Rio San Joaquin 36, Base 3, Granada Polanco, 11520 Miguel Hidalgo, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1204, '2013-12-09', 6, 384, 2, 0, 1, 1, 0, 3, 6270000, 'Hojalatería 174, Emilio Carranza, Venustiano Carranza, 15230 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1205, '2013-12-09', 1, 401, 4, 0, 0, 0, 0, 1, 3545000, 'Ignacio Rayon, San Juan de Aragón, Gustavo A. Madero, 07950 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1206, '2013-12-09', 2, 552, 4, 0, 1, 0, 0, 1, 6641000, 'Norte 45 660, Industrial Vallejo, Azcapotzalco, 02300 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1207, '2013-12-09', 7, 381, 1, 0, 1, 1, 0, 3, 6956000, 'Sur 105, Heroes de Churubusco, Iztapalapa, 09090 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1208, '2013-12-09', 13, 501, 2, 0, 0, 1, 0, 1, 1054000, 'Calle 4 5, San Pedro de Los Pinos, Álvaro Obregón, 01180 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1209, '2013-12-09', 6, 216, 2, 0, 0, 0, 0, 2, 4909000, 'Calzada Legaria 662, Lomas de Sotelo, Miguel Hidalgo, 11200 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1210, '2013-12-09', 13, 732, 1, 0, 1, 1, 0, 2, 9325000, 'Saratoga 302, Portales, Benito Juarez, 03300 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1211, '2013-12-09', 3, 412, 4, 0, 1, 0, 0, 3, 2587000, 'Limón 7, Centro, Venustiano Carranza, 15100 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1212, '2013-12-09', 10, 435, 2, 0, 0, 1, 0, 3, 1166000, 'Constitución de Apatzingán, Tepalcates, Iztapalapa, 09210 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1213, '2013-12-09', 4, 587, 3, 0, 1, 0, 0, 1, 8324000, 'Coras 34, Ajusco, Coyoacán, 04300 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1214, '2013-12-09', 2, 424, 4, 0, 0, 0, 0, 1, 2916000, 'Supervía Poniente, Parque Tarango, Álvaro Obregón, 01580 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1215, '2013-12-09', 8, 357, 4, 0, 0, 0, 0, 2, 8176000, 'De Los Bosques 103, Lomas del Chamizal, Cuajimalpa, 05129 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1216, '2013-12-09', 2, 571, 4, 0, 1, 0, 0, 2, 6299000, 'Puerto México, Piloto Adolfo López Mateos, Álvaro Obregón, 01290 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1217, '2013-12-09', 12, 781, 1, 0, 0, 1, 0, 3, 5699000, 'Zaragoza 29, Centro de Azcapotzalco, Azcapotzalco, 02000 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1218, '2013-12-09', 13, 517, 3, 0, 0, 0, 0, 3, 8723000, 'Torres Adalid 1165, Narvarte, Benito Juarez, 03100 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1219, '2013-12-09', 13, 642, 4, 0, 1, 0, 0, 1, 3826000, 'Cda. And. 4 16, Granjas México, Iztacalco, 08400 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1220, '2013-12-09', 4, 668, 3, 0, 1, 0, 0, 1, 5085000, 'Moctezuma 243, Colonia Buenavista, Cuauhtémoc, 06300 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1221, '2013-12-09', 11, 603, 1, 0, 1, 0, 0, 3, 4111000, 'México, Desarrollo Urbano El Piru, Álvaro Obregón, 01520 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1222, '2013-12-09', 8, 689, 4, 0, 0, 0, 0, 2, 5541000, 'San Nicolás Tolentino 29, Presidentes de México, Iztapalapa, 09740 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1223, '2013-12-09', 5, 206, 3, 0, 0, 0, 0, 3, 2405000, 'Anillo Periférico 54, Constitución de 1917, Iztapalapa, 09260 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1224, '2013-12-09', 9, 616, 3, 0, 1, 1, 0, 3, 5434000, 'Juan de Dios Peza 85, Obrera, Cuauhtémoc, 06800 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1225, '2013-12-09', 8, 648, 2, 0, 0, 1, 0, 3, 9187000, 'Ventura G.Tena 25, Asturias, Cuauhtémoc, 06850 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1226, '2013-12-09', 3, 678, 3, 0, 1, 1, 0, 1, 2143000, '49 45, Avante, Coyoacán, 04460 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1227, '2013-12-09', 5, 586, 2, 0, 1, 1, 0, 2, 2282000, 'Rafael Heliodoro Valle 427, Lorenzo Boturini, Venustiano Carranza, 15820 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1228, '2013-12-09', 3, 206, 3, 0, 1, 1, 0, 2, 9138000, 'Avenida Tamaulipas 24, Universal Infonavit, Álvaro Obregón, 01357 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1229, '2013-12-09', 13, 607, 2, 0, 1, 1, 0, 1, 6499000, '2a. Cda. Zacatecas MZ378 LT10, Peñón de Los Baños, Venustiano Carranza, 15520 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1230, '2013-12-09', 11, 785, 1, 0, 1, 0, 0, 2, 2146000, 'Poniente 116 576, Industrial Vallejo, Azcapotzalco, 02350 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1231, '2013-12-09', 10, 405, 4, 0, 1, 0, 0, 3, 1774000, '10 226, Porvenir, Azcapotzalco, 02940 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1232, '2013-12-09', 13, 763, 1, 0, 1, 0, 0, 1, 898000, 'Gabriel Carmona LB, Canutillo, Álvaro Obregón, 01560 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1233, '2013-12-09', 13, 741, 2, 0, 1, 0, 0, 3, 3112000, 'Calle Del Golf 219, Country Club, Coyoacán, 04220 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1234, '2013-12-09', 1, 712, 2, 0, 1, 1, 0, 1, 2438000, 'Avenida Batallones Rojos, Albarrada, Iztapalapa, 09200 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1235, '2013-12-09', 12, 682, 3, 0, 1, 0, 0, 1, 5323000, '5 de Febrero, Algarín, Cuauhtémoc, 06880 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1236, '2013-12-09', 1, 798, 2, 0, 1, 0, 0, 1, 3767000, 'Piedra del Sol 82, Avante, Coyoacán, 04460 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1237, '2013-12-09', 10, 312, 3, 0, 0, 1, 0, 2, 8147000, 'Ricardo Flores Magón 164 A, Guerrero, Cuauhtémoc, 06300 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1238, '2013-12-09', 9, 666, 2, 0, 1, 1, 0, 2, 527000, 'Auditorio Nacional, Bosque de Chapultepec I, Miguel Hidalgo, 11100 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1239, '2013-12-09', 4, 771, 4, 0, 1, 0, 0, 3, 7354000, 'Prolongación Canario 208, Tolteca, Álvaro Obregón, 01150 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1240, '2013-12-09', 5, 474, 1, 0, 0, 0, 0, 1, 8997000, 'Miguel Olivares 53, Presidentes Ejidales, Coyoacán, 04470 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1241, '2013-12-09', 11, 698, 1, 0, 1, 0, 0, 1, 7545000, 'Ricarte 474, Churubusco Tepeyac, Gustavo A. Madero, 07730 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1242, '2013-12-09', 10, 730, 1, 0, 0, 0, 0, 1, 6250000, 'Centeotl 274, Santa Lucía, Idustrial San Antonio, 02760 Azcapotzalco, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1243, '2013-12-09', 6, 583, 3, 0, 1, 1, 0, 2, 1878000, 'Fernando M. Villalpando 43, Guadalupe Inn, Álvaro Obregón, 01020 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1244, '2013-12-09', 13, 401, 2, 0, 1, 0, 0, 1, 9683000, 'Sierra Vertientes 1020, Bosques de Las Lomas, Miguel Hidalgo, 11000 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1245, '2013-12-09', 5, 308, 2, 0, 0, 0, 0, 1, 909000, 'Mafafa 119, El Manto, Iztapalapa, 09830 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1246, '2013-12-09', 6, 699, 2, 0, 0, 0, 0, 3, 7152000, 'Eje 4 Norte (Av. 510), San Juan de Aragón 4a Sección, Gustavo A. Madero, 07979 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1247, '2013-12-09', 12, 375, 4, 0, 1, 0, 0, 2, 9414000, 'Avenida Santiago, Moderna, Benito Juarez, 03510 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1248, '2013-12-09', 7, 670, 4, 0, 1, 0, 0, 3, 4202000, 'Ceylan 470, San Miguel Amantla, Miguel Hidalgo, 02520 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1249, '2013-12-09', 10, 334, 3, 0, 1, 0, 0, 3, 5933000, 'Villa Oso MZ70B LT15, Desarrollo Urbano Quetzalcoatl, Iztapalapa, 09700 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1250, '2013-12-09', 9, 454, 4, 0, 1, 0, 0, 1, 3100000, 'Árbol del Fuego 80, El Rosario Coyoacán, Coyoacán, 04380 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1251, '2013-12-09', 13, 278, 4, 0, 1, 0, 0, 3, 7756000, 'Eje Central Lázaro Cárdenas 1157, Letrán Valle, Benito Juarez, 03650 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1252, '2013-12-09', 10, 508, 3, 0, 1, 1, 0, 2, 2857000, 'Desierto de Los Leones 5469, Cedros, Álvaro Obregón, 01870 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1253, '2013-12-09', 2, 681, 2, 0, 1, 1, 0, 3, 2547000, '1a. Cerrada Francisco Villa, Tlacoyaque, Álvaro Obregón, 01859 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1254, '2013-12-09', 3, 569, 3, 0, 0, 1, 0, 1, 1938000, 'Avenida 608 251, San Juan de Aragón 4a Sección, Gustavo A. Madero, 07979 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1255, '2013-12-09', 7, 748, 2, 0, 1, 1, 0, 1, 8972000, 'Avenida Revolución 7, San Ángel, Álvaro Obregón, 01000 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1256, '2013-12-09', 2, 412, 4, 0, 1, 0, 0, 2, 5954000, 'Cerro San Francisco 248, Campestre Churubusco, Coyoacán, 04200 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1257, '2013-12-09', 12, 663, 3, 0, 1, 1, 0, 1, 5665000, 'Albéniz 4418, Guadalupe Victoria, Gustavo A. Madero, 07780 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1258, '2013-12-09', 13, 767, 1, 0, 1, 0, 0, 2, 610000, 'Sur 111-A 2317, Tlacotal Ramos Millán, Iztacalco, 08720 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1259, '2013-12-09', 4, 697, 2, 0, 0, 1, 0, 2, 711000, 'Universidad, Las Americas, Iztapalapa, 09250 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1260, '2013-12-09', 12, 589, 4, 0, 0, 1, 0, 2, 2883000, 'Villa del Rey MZ20 LT11, Desarrollo Urbano Quetzalcoatl, Iztapalapa, 09700 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1261, '2013-12-09', 6, 344, 1, 0, 0, 1, 0, 3, 911000, 'Eje 5 Norte Av. 412 370, San Juan de Aragón 6a Sección, Gustavo A. Madero, 07918 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1262, '2013-12-09', 1, 469, 4, 0, 1, 1, 0, 1, 3439000, 'Prisciliano Sánchez 67, Juan Escutia, Iztapalapa, 09100 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1263, '2013-12-09', 5, 212, 3, 0, 1, 0, 0, 2, 5293000, '2a. Cerrada 11 de Abril, Escandón, Miguel Hidalgo, 11800 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1264, '2013-12-09', 11, 390, 3, 0, 0, 0, 0, 2, 1733000, 'Prolongación Río Churubusco, Aeropuerto Int de La Ciudad de México, Venustiano Carranza, 15620 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1265, '2013-12-09', 4, 693, 2, 0, 0, 0, 0, 3, 7631000, '1 B (Omecihuatl), Adolfo Ruiz Cortines, Coyoacán, 04630 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1266, '2013-12-09', 7, 705, 1, 0, 1, 1, 0, 1, 5486000, 'Carlos Hank González, Zona Urbana Ejidal Santa María Tomatlan, Iztapalapa, 09870 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1267, '2013-12-09', 11, 256, 2, 0, 0, 0, 0, 3, 2843000, '1a. Cerrada Piedra Bengala, Molino de Rosas, Álvaro Obregón, 01470 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1268, '2013-12-09', 9, 635, 4, 0, 1, 0, 0, 3, 6183000, 'Eje 1 Norte (Av. Hangares de Aviación Fuerza Aérea Mexicana) 41, Federal, Venustiano Carranza, 15700 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1269, '2013-12-09', 2, 470, 1, 0, 1, 0, 0, 3, 6115000, 'De La Paz 26, Chimalistac, Álvaro Obregón, 01070 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1270, '2013-12-09', 3, 367, 1, 0, 0, 0, 0, 2, 6521000, 'Ejército Nacional 613, Base 3, Cuauhtémoc, 06000 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1271, '2013-12-09', 13, 711, 2, 0, 1, 1, 0, 3, 7582000, 'Villa Castin, Desarrollo Urbano Quetzalcoatl, Iztapalapa, 09700 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1272, '2013-12-09', 3, 230, 1, 0, 0, 0, 0, 1, 691000, 'Eusebio Jáuregui 59, Ampliación San Pedro Xalpa, Azcapotzalco, 02719 Mexico City, State of Mexico, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1273, '2013-12-09', 3, 209, 1, 0, 0, 0, 0, 2, 6176000, 'Villaco, Desarrollo Urbano Quetzalcoatl, Iztapalapa, 09700 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1274, '2013-12-09', 2, 633, 4, 0, 1, 1, 0, 3, 3306000, 'Jericó 6, Romero Rubio, Venustiano Carranza, 15400 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1275, '2013-12-09', 4, 500, 1, 0, 0, 0, 0, 3, 9862000, 'Oriente 157, El Coyol, Gustavo A. Madero, 07420 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1276, '2013-12-09', 3, 333, 4, 0, 0, 1, 0, 1, 9097000, 'Debussy 4419, Guadalupe Victoria, Gustavo A. Madero, 07790 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1277, '2013-12-09', 3, 571, 1, 0, 1, 0, 0, 2, 9070000, 'Avenida Carlos Lazo, Lomas de Santa Fe, Cuajimalpa, 01219 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1278, '2013-12-09', 5, 668, 4, 0, 1, 1, 0, 3, 7760000, 'Magdalena 727, Del Valle, Benito Juarez, 03100 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1279, '2013-12-09', 9, 462, 1, 0, 1, 0, 0, 3, 1935000, 'Cabalgata 12, Colinas del Sur, Álvaro Obregón, 01430 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1280, '2013-12-09', 10, 792, 3, 0, 1, 0, 0, 3, 7214000, 'Reforma Urbana MZ22 LT17, Reforma Política, Iztapalapa, 09730 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1281, '2013-12-09', 5, 245, 2, 0, 0, 1, 0, 1, 3902000, 'Obraje, Guerrero, Cuauhtémoc, 06300 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1282, '2013-12-09', 6, 752, 4, 0, 0, 1, 0, 2, 4233000, 'UAM-I, Los Angeles, Iztapalapa, 09830 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1283, '2013-12-09', 9, 649, 2, 0, 0, 1, 0, 1, 4044000, 'Plutarco Elías Calles, Chinampac de Juárez, Iztapalapa, 09208 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1284, '2013-12-09', 2, 678, 3, 0, 1, 0, 0, 3, 462000, '1 Sur 12-B 18, Agrícola Oriental, Iztacalco, 08500 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1285, '2013-12-09', 6, 547, 4, 0, 1, 1, 0, 3, 3461000, 'Oriente 255 465, Agrícola Oriental, Iztacalco, 08500 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1286, '2013-12-09', 2, 510, 2, 0, 0, 0, 0, 3, 6426000, 'Bosque de Alisos 45, Palo Alto(Granjas), Cuajimalpa, 05210 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1287, '2013-12-09', 13, 229, 2, 0, 1, 0, 0, 2, 3659000, 'Lucero, Doce de Diciembre, Iztapalapa, 09870 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1288, '2013-12-09', 12, 670, 3, 0, 0, 0, 0, 1, 9547000, 'Napoleón, Moderna, Benito Juarez, 03510 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1289, '2013-12-09', 12, 311, 1, 0, 0, 0, 0, 1, 2600000, 'Avenida Oceanía, Pensador Mexicano, Venustiano Carranza, 15510 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1290, '2013-12-09', 3, 255, 2, 0, 1, 0, 0, 1, 9374000, 'Cañada 281, Jardines del Pedregal, Álvaro Obregón, 01900 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1291, '2013-12-09', 7, 299, 4, 0, 1, 1, 0, 3, 4249000, 'Liga de Carreteras, 7 de Julio, Venustiano Carranza, 15390 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1292, '2013-12-09', 5, 778, 1, 0, 1, 1, 0, 1, 7869000, '5 de Febrero 14, Centro, Cuauhtémoc, 06000 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1293, '2013-12-09', 13, 222, 1, 0, 1, 1, 0, 2, 9776000, 'Avenida 585 45, San Juan de Aragón 3a Sección, Gustavo A. Madero, 07970 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1294, '2013-12-09', 3, 544, 4, 0, 1, 1, 0, 1, 482000, 'Río Soto La Marina SN S ESC CARLOS SANDOVAL, Real del Moral, Iztapalapa, 09010 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1295, '2013-12-09', 9, 586, 2, 0, 1, 0, 0, 1, 2086000, 'Aguayo 58, Del Carmen, Coyoacán, 04100 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1296, '2013-12-09', 6, 282, 2, 0, 0, 1, 0, 2, 4995000, 'Sur 159 1684, Ampliación Gabriel Ramos Millán, Iztacalco, 08020 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1297, '2013-12-09', 1, 429, 2, 0, 0, 1, 0, 3, 8080000, 'Oriente 65 a 2924, Ampliación Asturias, Cuauhtémoc, 06890 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1298, '2013-12-09', 3, 702, 3, 0, 1, 1, 0, 1, 9736000, 'Manuel Bonilla, Zona Urbana Ejidal Santa Martha Acatitla Sur, Iztapalapa, 09530 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1299, '2013-12-09', 1, 509, 1, 0, 0, 0, 0, 1, 8798000, 'Privada Mercurio 8, Cuchilla Pantitlan, Venustiano Carranza, 15610 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1300, '2013-12-09', 3, 622, 2, 0, 0, 1, 0, 1, 206000, '5 de Mayo Manuel Gonzalez 286, Tlatelolco, Cuauhtémoc, 06900 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1301, '2013-12-09', 2, 598, 2, 0, 1, 1, 0, 3, 5978000, 'Tamagno 102 B, Peralvillo, Cuauhtémoc, 06220 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1302, '2013-12-09', 2, 258, 2, 0, 0, 0, 0, 3, 7502000, 'San Diego, San Bartolo Ameyalco, Álvaro Obregón, 01800 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1303, '2013-12-09', 12, 406, 2, 0, 0, 0, 0, 1, 7124000, '3, Río Pánuco 76, Cuauhtémoc, 06500 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1304, '2013-12-09', 1, 391, 2, 0, 0, 1, 0, 1, 3716000, 'Calle 11 de Abril, Escandón, Miguel Hidalgo, 11800 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1305, '2013-12-09', 10, 765, 4, 0, 1, 1, 0, 1, 4764000, 'Avenida Central, Colonia Buenavista, Cuauhtémoc, 06350 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1306, '2013-12-09', 8, 443, 2, 0, 0, 1, 0, 2, 1782000, 'Herminio Chavarría, Zona Urbana Ejidal Santa María Aztahuacan, Iztapalapa, 09570 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1307, '2013-12-09', 3, 415, 2, 0, 0, 1, 0, 2, 9624000, 'Pedro Moreno 10, Guerrero, Cuauhtémoc, 06300 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1308, '2013-12-09', 1, 401, 3, 0, 0, 1, 0, 1, 7407000, 'Paseo de Los Tamarindos 109, Bosques de Las Lomas, Cuajimalpa, 05120 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1309, '2013-12-09', 1, 323, 4, 0, 0, 1, 0, 1, 4912000, 'Huitzitzilin 31, Santo Domingo (Pgal de Sto Domingo), Coyoacán, 04369 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1310, '2013-12-09', 6, 316, 4, 0, 0, 1, 0, 3, 2418000, 'Desierto de Los Leones 5916, Cedros, Álvaro Obregón, 01870 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1311, '2013-12-09', 6, 455, 1, 0, 0, 0, 0, 3, 925000, 'Ahuizotl 78, La Preciosa, Azcapotzalco, 02460 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1312, '2013-12-09', 12, 276, 3, 0, 0, 0, 0, 3, 5176000, 'Oriente 184, Moctezuma 2a Sección, Venustiano Carranza, 15530 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1313, '2013-12-09', 2, 584, 4, 0, 1, 0, 0, 2, 8117000, 'Avenida 602 118, San Juan de Aragón 3a Sección, Gustavo A. Madero, 07970 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1314, '2013-12-09', 7, 329, 3, 0, 0, 1, 0, 3, 9779000, 'Minas, Lomas de La Estancia, Iztapalapa, 09640 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1315, '2013-12-09', 10, 688, 3, 0, 0, 0, 0, 3, 1084000, 'Zumarraga 101-127, Villa Gustavo a Madero, Gustavo A. Madero, 07050 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1316, '2013-12-09', 13, 396, 3, 0, 0, 0, 0, 3, 7790000, 'Bahía de San Hipólito, Anáhuac, Miguel Hidalgo, 11320 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1317, '2013-12-09', 13, 500, 3, 0, 1, 0, 0, 2, 2241000, '1er. Andador de Carlos Arruza, San Lorenzo Tlaltenango, Miguel Hidalgo, 11210 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1318, '2013-12-09', 13, 503, 4, 0, 1, 0, 0, 3, 8187000, 'Reforma Política, Los Reyes, Coyoacán, 04330 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1319, '2013-12-09', 13, 606, 1, 0, 1, 0, 0, 2, 5408000, 'Eje 1 Oriente F.C. Hidalgo 2301, La Joyita, Gustavo A. Madero, 07850 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1320, '2013-12-09', 6, 777, 4, 0, 0, 0, 0, 2, 1827000, 'Fortín Chimalistac 34, Oxtopulco Universidad, Coyoacán, 04360 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1321, '2013-12-09', 8, 421, 2, 0, 0, 1, 0, 1, 8948000, 'Crisantema, Tlatilco, Azcapotzalco, 02860 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1322, '2013-12-09', 9, 766, 3, 0, 1, 1, 0, 3, 3083000, 'Eugenio Sue 51, Polanco, Miguel Hidalgo, 11550 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1323, '2013-12-09', 11, 532, 1, 0, 0, 1, 0, 1, 3318000, 'Havre 43, Juárez, Cuauhtémoc, 06600 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1324, '2013-12-09', 2, 220, 3, 0, 1, 0, 0, 1, 9276000, 'Playa Pichilingue 156, Reforma Iztaccihuatl Sur, Iztacalco, 08840 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1325, '2013-12-09', 5, 512, 3, 0, 1, 0, 0, 3, 4452000, 'Avenida Vasco de Quiroga, Zedec Santa Fe, Álvaro Obregón, 01219 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1326, '2013-12-09', 7, 688, 3, 0, 0, 0, 0, 1, 7913000, 'Clavel 70-S, Ampliación Candelaria, Coyoacán, 04389 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1327, '2013-12-09', 12, 519, 4, 0, 1, 0, 0, 1, 3085000, 'Eje 4 Oriente (Avenida Río Churubusco), Cuchilla Agrícola Oriental, Iztacalco, 08420 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1328, '2013-12-09', 8, 754, 4, 0, 0, 0, 0, 2, 7307000, 'Jose Antonio Torres Xocongo 647, Ampliación Asturias, Cuauhtémoc, 06860 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1329, '2013-12-09', 4, 497, 3, 0, 0, 1, 0, 3, 8964000, 'Prolongación Lerdo B, San Simon Tolnahuac, Cuauhtémoc, 06920 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1330, '2013-12-09', 11, 544, 4, 0, 0, 0, 0, 2, 9093000, 'Maíz 169, Granjas Esmeralda, Iztapalapa, 09810 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1331, '2013-12-09', 3, 256, 1, 0, 1, 1, 0, 2, 3141000, 'Eje 1 Oriente Av. Andrés Molina Enríquez 4349, Viaducto Piedad, Iztacalco, 08200 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1332, '2013-12-09', 2, 790, 1, 0, 1, 1, 0, 2, 1566000, 'Plinio 108, Granada, Miguel Hidalgo, 11560 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1333, '2013-12-09', 5, 682, 2, 0, 0, 0, 0, 1, 5621000, 'Gorostiza 78, Morelos, Cuauhtémoc, 06200 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1334, '2013-12-09', 10, 730, 1, 0, 1, 0, 0, 1, 1299000, 'Eje Central Lázaro Cárdenas 13-A, Centro, Cuauhtémoc, 06000 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1335, '2013-12-09', 7, 417, 4, 0, 0, 0, 0, 3, 422000, 'San Bartolo-Naucalpan 182 a, Nueva Argentina (Argentina Poniente), Argentina Poniente, 11230 Miguel Hidalgo, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1336, '2013-12-09', 13, 727, 1, 0, 0, 0, 0, 2, 1390000, '1a. Cerrada Hidalgo, San Bartolo Ameyalco, Álvaro Obregón, 01800 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1337, '2013-12-09', 3, 211, 1, 0, 1, 0, 0, 2, 5984000, 'Avenida Estrella, Estrella del Sur, Iztapalapa, 09820 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1338, '2013-12-09', 5, 311, 3, 0, 1, 1, 0, 3, 6759000, 'Rosario Aldama, Hank González, Iztapalapa, 09700 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1339, '2013-12-09', 7, 608, 3, 0, 0, 1, 0, 3, 6105000, 'Luis Buitimea MZ132 LT22, Zona Urbana Ejidal Santa Martha Acatitla Norte, Iztapalapa, 09140 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1340, '2013-12-09', 10, 284, 1, 0, 0, 0, 0, 3, 8564000, 'Navanco 5, Juventino Rosas, Iztacalco, 08700 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1341, '2013-12-09', 3, 386, 1, 0, 0, 1, 0, 1, 6275000, 'Calle Alfredo Chavero 112, Obrera, Cuauhtémoc, 06800 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1342, '2013-12-09', 9, 531, 2, 0, 0, 0, 0, 1, 7871000, 'Guty Cárdenas 8, Guadalupe Inn, Álvaro Obregón, 01020 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1343, '2013-12-09', 11, 260, 1, 0, 1, 0, 0, 1, 875000, 'Paseo Tetlalpa MZ5 LT5, 2da Ampliación Santiago Acahualtepec, Iztapalapa, 09609 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1344, '2013-12-09', 2, 394, 1, 0, 0, 1, 0, 3, 2339000, 'Francisco J. Clavijero 22, Esperanza, Cuauhtémoc, 06840 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1345, '2013-12-09', 12, 522, 4, 0, 1, 0, 0, 3, 1213000, 'Real del Monte 56, Ampliación El Triunfo, Iztapalapa, 09438 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1346, '2013-12-09', 13, 751, 4, 0, 1, 1, 0, 1, 2941000, '1 Soledad, San Sebastián, Azcapotzalco, 02040 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1347, '2013-12-09', 2, 349, 4, 0, 0, 1, 0, 2, 3996000, '3a. Cerrada Boulevard Capri, Lomas Estrella 1RA. Sección, Iztapalapa, 09880 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1348, '2013-12-09', 3, 401, 2, 0, 0, 0, 0, 3, 2854000, 'Cerro Capilla de San Miguel 85, Campestre Churubusco, Coyoacán, 04200 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1349, '2013-12-09', 13, 634, 2, 0, 1, 1, 0, 1, 8853000, 'Eje 3 Norte (Av. Cuitláhuac) 17, Guadalupe Victoria, Gustavo A. Madero, 07790 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1350, '2013-12-09', 13, 578, 2, 0, 0, 0, 0, 3, 4735000, 'Avenida Sur 4, Cuchilla Agrícola Oriental, Iztacalco, 08420 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1351, '2013-12-09', 5, 348, 3, 0, 0, 0, 0, 1, 1220000, 'Villa Atuel SN, Desarrollo Urbano Quetzalcoatl, Desarrollo Urbano, 09700 Iztapalapa, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1352, '2013-12-09', 6, 763, 2, 0, 1, 1, 0, 1, 3966000, 'Madrid 8, Del Carmen, Coyoacán, 04100 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1353, '2013-12-09', 5, 318, 3, 0, 0, 1, 0, 3, 642000, 'Netzahualcóyotl, Estrella del Sur, Iztapalapa, 09820 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1354, '2013-12-09', 6, 454, 1, 0, 1, 0, 0, 3, 5972000, 'Poniente 2, Cuchilla del Tesoro, Gustavo A. Madero, 07900 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1355, '2013-12-09', 4, 734, 2, 0, 1, 0, 0, 3, 5171000, 'Eje 3 Oriente (Francisco del Paso y Troncoso), Kennedy, Venustiano Carranza, 15950 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1356, '2013-12-09', 9, 235, 1, 0, 0, 1, 0, 1, 6743000, 'Antonio Solis 102, Obrera, Cuauhtémoc, 06800 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1357, '2013-12-09', 13, 586, 1, 0, 1, 1, 0, 2, 5846000, 'Itzuco MZ7 LT7, Carlos Zapata Vela, Iztacalco, 08040 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1358, '2013-12-09', 12, 235, 2, 0, 1, 0, 0, 1, 4961000, 'Lago Atitlán 88, Deportiva Pensil, Miguel Hidalgo, 11470 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1359, '2013-12-09', 1, 249, 4, 0, 1, 1, 0, 3, 1040000, 'Fausto Vega, Sede Delegacional, Álvaro Obregón, 01150 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1360, '2013-12-09', 12, 489, 3, 0, 0, 1, 0, 3, 4784000, '8 MZ10A LT3, Olivar del Conde 1a. Sección, Álvaro Obregón, 01400 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1361, '2013-12-09', 8, 588, 1, 0, 0, 1, 0, 3, 9218000, 'Cda.de F.c. 96B, Ampliación Granada, Miguel Hidalgo, 11529 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1362, '2013-12-09', 9, 418, 3, 0, 0, 0, 0, 2, 821000, 'Calzada Legaria 608, Lomas de Sotelo, Miguel Hidalgo, 11200 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1363, '2013-12-09', 3, 744, 2, 0, 0, 0, 0, 2, 1043000, 'Calle del Fresno, Santa María La Ribera, Cuauhtémoc, 06400 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1364, '2013-12-09', 9, 565, 3, 0, 0, 1, 0, 1, 5390000, '1er And Benito Juárez (1ra Cda Benito Juárez), Norte, Álvaro Obregón, 01410 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1365, '2013-12-09', 13, 439, 4, 0, 0, 0, 0, 3, 1277000, 'Avenida Rio San Joaquin 5805, Popo, Miguel Hidalgo, 11480 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1366, '2013-12-09', 3, 627, 4, 0, 0, 1, 0, 2, 2099000, 'Calle Prolongacion Calle 10 8, San Pedro de Los Pinos, Benito Juarez, 03800 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1367, '2013-12-09', 7, 501, 1, 0, 1, 0, 0, 1, 7985000, '4a. Cerrada 16, El Retoño, Iztapalapa, 09440 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1368, '2013-12-09', 9, 428, 3, 0, 0, 0, 0, 1, 9463000, 'Calle Cuauhtémoc, Los Reyes Culhuacan, Iztapalapa, 09840 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1369, '2013-12-09', 13, 387, 2, 0, 0, 1, 0, 2, 9051000, 'Circuito Interior Avenida Río Churubusco 1908, Gabriel Ramos Millán, Iztacalco, 08730 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1370, '2013-12-09', 4, 734, 1, 0, 0, 1, 0, 3, 9032000, 'Eje 4 Sur (Av. Plutarco Elías Calles) 765, Nueva Sta Anita, Iztacalco, 08210 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1371, '2013-12-09', 8, 735, 3, 0, 0, 0, 0, 1, 4878000, 'Gaviota 18, Tacubaya, Miguel Hidalgo, 11870 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1372, '2013-12-09', 2, 696, 3, 0, 0, 0, 0, 3, 5264000, 'Providencia 1522, Tlacoquemecatl del Valle, Benito Juarez, 03200 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1373, '2013-12-09', 6, 241, 3, 0, 0, 0, 0, 3, 8641000, 'Prolongación Río Churubusco, Aeropuerto Int de La Ciudad de México, Venustiano Carranza, 15620 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1374, '2013-12-09', 7, 225, 1, 0, 1, 1, 0, 1, 6419000, 'Víctor Hugo 151, Portales, Benito Juarez, 03300 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1375, '2013-12-09', 5, 611, 1, 0, 0, 1, 0, 2, 9876000, 'Oriente 184, Moctezuma 2a Sección, Venustiano Carranza, 15530 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1376, '2013-12-09', 9, 679, 3, 0, 0, 1, 0, 3, 7392000, 'Sur 107 1314-1318, Aeronáutica Militar, Venustiano Carranza, 15970 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1377, '2013-12-09', 2, 523, 2, 0, 0, 0, 0, 3, 7153000, 'Doctor José María Vertiz 669, Narvarte, Benito Juarez, 03020 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1378, '2013-12-09', 10, 308, 1, 0, 0, 0, 0, 3, 6158000, 'Pesado, Colonia Buenavista, Cuauhtémoc, 06350 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1379, '2013-12-09', 9, 224, 2, 0, 1, 1, 0, 2, 872000, 'Oriente 5, Cuchilla del Tesoro, Gustavo A. Madero, 07900 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1380, '2013-12-09', 10, 349, 2, 0, 1, 0, 0, 3, 6469000, 'Joaquín A. Pérez 16, San Miguel Chapultepec, Miguel Hidalgo, 11850 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1381, '2013-12-09', 4, 210, 3, 0, 0, 1, 0, 1, 8851000, 'Eje 4 Norte (Pte. 128) 67, Nueva Vallejo, Gustavo A. Madero, 07750 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1382, '2013-12-09', 13, 565, 3, 0, 0, 1, 0, 3, 9054000, 'Puente Nacional 100, Lomas de Las Águilas, Álvaro Obregón, 01730 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1383, '2013-12-09', 2, 604, 4, 0, 0, 0, 0, 1, 7679000, 'Oriente 172, Justo Sierra, Iztapalapa, 09460 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1384, '2013-12-09', 6, 409, 3, 0, 1, 0, 0, 3, 4954000, 'Papalotl 80, Santo Domingo (Pgal de Sto Domingo), Coyoacán, 04369 Pedregal de Santo Domingo, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1385, '2013-12-09', 6, 605, 2, 0, 1, 1, 0, 1, 3621000, 'Sur 109 2428, Tlazintla, Iztacalco, 08720 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1386, '2013-12-09', 9, 689, 1, 0, 1, 1, 0, 2, 2174000, 'Salvador Díaz Mirón 374, Santo Tomas, Miguel Hidalgo, 11340 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1387, '2013-12-09', 11, 433, 4, 0, 0, 0, 0, 1, 1756000, 'Río Churubusco 2359, Puebla, Venustiano Carranza, 15020 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1388, '2013-12-09', 7, 686, 2, 0, 1, 0, 0, 3, 1967000, '5a. Cerrada Morelos, San Antonio Culhuacan, Iztapalapa, 09800 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1389, '2013-12-09', 11, 355, 4, 0, 0, 0, 0, 1, 8170000, 'Adolfo Prieto 1644, Del Valle, Benito Juarez, 03100 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1390, '2013-12-09', 7, 331, 4, 0, 0, 0, 0, 3, 678000, 'Sur 16 509, Agrícola Oriental, Iztacalco, 08500 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1391, '2013-12-09', 8, 360, 1, 0, 1, 1, 0, 2, 9074000, 'Monrovia 1210A, Portales, Benito Juarez, 03300 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1392, '2013-12-09', 9, 212, 3, 0, 1, 0, 0, 1, 5096000, 'De Los Montes 16, Portales Oriente, Benito Juarez, 03570 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1393, '2013-12-09', 5, 401, 1, 0, 0, 0, 0, 1, 8396000, 'Nardo 10, Los Angeles Apanoaya, Iztapalapa, 09710 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1394, '2013-12-09', 7, 764, 2, 0, 1, 0, 0, 3, 5551000, 'Calzada Ings. Militares, San Lorenzo Tlaltenango, Miguel Hidalgo, 11219 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1395, '2013-12-09', 10, 458, 4, 0, 1, 1, 0, 2, 7764000, 'Aerolito 6228, Tres Estrellas, Gustavo A. Madero, 07820 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1396, '2013-12-09', 11, 524, 2, 0, 1, 0, 0, 1, 3297000, 'Defensa Nacional, Xalpa, Iztapalapa, 09640 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1397, '2013-12-09', 1, 604, 4, 0, 1, 1, 0, 2, 6095000, 'Bosque de Encinos 286, Bosques de Las Lomas, Cuajimalpa, 11700 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1398, '2013-12-09', 1, 529, 2, 0, 1, 0, 0, 1, 4499000, 'Altavista 192, San Angel Inn, Álvaro Obregón, 01060 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1399, '2013-12-09', 1, 618, 4, 0, 0, 0, 0, 3, 7817000, 'Avenida del Bosque, Parque Tarango, Álvaro Obregón, 01580 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1400, '2013-12-09', 5, 451, 3, 0, 1, 0, 0, 1, 7350000, 'Iztacalco, Pantitlan, Iztacalco, 08100 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1401, '2013-12-09', 4, 588, 1, 0, 1, 1, 0, 3, 506000, 'Eucalipto, San Juan Cerro, Iztapalapa, 09858 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1402, '2013-12-09', 1, 535, 1, 0, 0, 1, 0, 3, 6296000, 'SIN NOMBRE No. 314 12, Santo Domingo (Pgal de Sto Domingo), Coyoacán, 04369 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1403, '2013-12-09', 7, 642, 1, 0, 0, 0, 0, 1, 3528000, '27 123, Ignacio Zaragoza, Venustiano Carranza, 15000 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1404, '2013-12-09', 6, 739, 4, 0, 1, 0, 0, 3, 7463000, '2a. Privada Aztecas, La Asunción, Iztapalapa, 09000 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1405, '2013-12-09', 3, 531, 4, 0, 1, 0, 0, 2, 3712000, '1a. Cerrada Camino Viejo a Mixcoac, San Bartolo Ameyalco, Álvaro Obregón, 01800 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1406, '2013-12-09', 3, 716, 1, 0, 0, 0, 0, 3, 7597000, 'Jumil 153, Santo Domingo (Pgal de Sto Domingo), Coyoacán, 04369 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1407, '2013-12-09', 11, 435, 2, 0, 0, 0, 0, 2, 2750000, 'Avenida México 31, Hipódromo, Cuauhtémoc, 06100 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1408, '2013-12-09', 6, 508, 4, 0, 1, 1, 0, 2, 4144000, 'Julio García 13, Zapotla, Iztacalco, 08610 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1409, '2013-12-09', 7, 494, 1, 0, 0, 1, 0, 1, 241000, 'Jacobo Watt, Culhuacan, Iztapalapa, 09800 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1410, '2013-12-09', 7, 479, 2, 0, 0, 1, 0, 3, 1290000, 'Eje 2 Oriente Av. H. Congreso de la Unión 225-229, Merced Balbuena, Venustiano Carranza, 15810 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1411, '2013-12-09', 7, 307, 3, 0, 1, 1, 0, 2, 313000, 'Grieg 40, Ex Hipódromo de Peralvillo, Cuauhtémoc, 06250 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1412, '2013-12-09', 8, 483, 3, 0, 0, 1, 0, 2, 2093000, 'Eje 1 Oriente (Av. Canal de Miramontes) 1630, Campestre Churubusco, Coyoacán, 04200 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1413, '2013-12-09', 8, 438, 1, 0, 1, 1, 0, 2, 2660000, 'Avenida Gran Canal, Gertrudis Sánchez 3a Sección, Gustavo A. Madero, 07839 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1414, '2013-12-09', 13, 651, 1, 0, 0, 1, 0, 2, 7612000, 'Ixtlahuaca, San Bartolo Ameyalco, Álvaro Obregón, 01800 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1415, '2013-12-09', 8, 593, 3, 0, 1, 0, 0, 2, 1016000, 'Avenida Gran Canal 586A, 2do Tramo 20 de Noviembre, Venustiano Carranza, 15300 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1416, '2013-12-09', 2, 583, 4, 0, 1, 1, 0, 3, 8213000, 'Circuito Interior Bicentenario (Avenida Instituto Técnico Industrial), Agricultura, Miguel Hidalgo, 11360 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1417, '2013-12-09', 6, 755, 4, 0, 0, 0, 0, 1, 8993000, 'Cerámica 266, 2do Tramo 20 de Noviembre, Venustiano Carranza, 15300 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1418, '2013-12-09', 10, 768, 2, 0, 1, 0, 0, 3, 6753000, 'Benito Juárez, El Tanque, Magdalena Contreras, 10320 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1419, '2013-12-09', 1, 367, 1, 0, 1, 1, 0, 2, 4936000, 'Avenida 601, San Juan de Aragón 3a Sección, Gustavo A. Madero, 07970 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1420, '2013-12-09', 7, 691, 4, 0, 0, 0, 0, 3, 3764000, 'Puerto Cozumel 174, Ampliación Casas Alemán, Gustavo A. Madero, 07580 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1421, '2013-12-09', 6, 324, 1, 0, 1, 0, 0, 3, 6301000, 'Eje 4 Sur (Av. Plutarco Elías Calles) 547-549, Santa Anita, Iztacalco, 08300 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1422, '2013-12-09', 3, 581, 4, 0, 1, 1, 0, 2, 9989000, 'Presidente Mazarik 321, Base 3, Polanco Chapultepec, 11560 Miguel Hidalgo, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1423, '2013-12-09', 3, 351, 1, 0, 0, 0, 0, 1, 1624000, 'Sastrería 32, Penitenciaria, Venustiano Carranza, 15350 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1424, '2013-12-09', 13, 455, 1, 0, 1, 1, 0, 3, 7855000, 'Prolongación Lerdo 340, Ex Hipódromo de Peralvillo, Cuauhtémoc, 06250 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1425, '2013-12-09', 2, 488, 4, 0, 1, 0, 0, 2, 9730000, 'Playa Miramar 389, Militar Marte, Iztacalco, 08830 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1426, '2013-12-09', 9, 476, 3, 0, 1, 0, 0, 1, 4747000, 'Calle del Fresno, Santa María La Ribera, Cuauhtémoc, 06400 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1427, '2013-12-09', 5, 586, 4, 0, 0, 0, 0, 2, 6144000, 'Zapotecas 314, Ajusco, Coyoacán, 04300 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1428, '2013-12-09', 6, 430, 4, 0, 1, 0, 0, 2, 5607000, 'De Los Virreyes 1315, Lomas de Chapultepec, Miguel Hidalgo, 11000 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1429, '2013-12-09', 2, 656, 2, 0, 1, 0, 0, 3, 4953000, 'Sur 6 6, Cuchilla Agrícola Oriental, Iztacalco, 08420 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1430, '2013-12-09', 4, 711, 1, 0, 0, 1, 0, 3, 6294000, 'Viaducto Río Piedad 279, La Cruz Coyuya, Iztacalco, 08320 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1431, '2013-12-09', 9, 668, 3, 0, 0, 1, 0, 3, 6473000, 'México-contreras 579, San Jerónimo Lídice, Magdalena Contreras, 10200 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1432, '2013-12-09', 7, 596, 4, 0, 0, 0, 0, 2, 5281000, 'Avenida Carlos Lazo, Parque Tarango, Álvaro Obregón, 01580 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1433, '2013-12-09', 3, 365, 4, 0, 1, 1, 0, 2, 5622000, 'Plan de Ayala, Zona Urbana Ejidal Santa María Aztahuacan, Iztapalapa, 09570 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1434, '2013-12-09', 1, 356, 1, 0, 0, 0, 0, 1, 6389000, 'SIN NOMBRE No. 570 LB, Las Águilas Ampliación 2o. Parque, Álvaro Obregón, 01750 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1435, '2013-12-09', 2, 798, 1, 0, 0, 0, 0, 2, 2677000, 'Villa San Pedro MZ16 LT2, Desarrollo Urbano Quetzalcoatl, Iztapalapa, 09700 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1436, '2013-12-09', 4, 516, 1, 0, 1, 0, 0, 2, 9808000, 'Avenida Universidad 1788, Oxtopulco Universidad, Coyoacán, 04360 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1437, '2013-12-09', 2, 508, 4, 0, 0, 0, 0, 2, 4341000, 'Avenida de Los Compositores, Bosque de Chapultepec II, Miguel Hidalgo, 11100 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1438, '2013-12-09', 2, 327, 1, 0, 1, 0, 0, 1, 7300000, 'Calle Fco Cesar M., Fuentes de Zaragoza, Iztapalapa, 09160 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1439, '2013-12-09', 7, 681, 4, 0, 1, 0, 0, 3, 5121000, 'Oriente 157 3736, Salvador Díaz Mirón, Gustavo A. Madero, 07400 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1440, '2013-12-09', 2, 695, 3, 0, 1, 1, 0, 1, 5359000, 'Centeno 579, Granjas México, Iztacalco, 08400 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1441, '2013-12-09', 7, 276, 2, 0, 0, 0, 0, 2, 3692000, 'Carretera Federal Mexico - Toluca 1725, Palo Alto(Granjas), Cuajimalpa, 05110 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1442, '2013-12-09', 5, 485, 3, 0, 0, 0, 0, 3, 8730000, 'San Miguel 49, San Lucas, Coyoacán, 04030 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1443, '2013-12-09', 12, 644, 4, 0, 0, 0, 0, 1, 2050000, 'Avenida 517 213, San Juan de Aragón 1a Sección, Gustavo A. Madero, 07969 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1444, '2013-12-09', 1, 345, 4, 0, 0, 0, 0, 1, 9331000, 'Avenida 543 47, San Juan de Aragón 2a Sección, Gustavo A. Madero, 07969 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1445, '2013-12-09', 11, 533, 4, 0, 1, 0, 0, 3, 3222000, 'Miguel Alemán, Presidentes de México, Iztapalapa, 09740 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1446, '2013-12-09', 10, 324, 1, 0, 1, 0, 0, 2, 6104000, 'Santa Fe 170, Lomas De santa Fe, Álvaro Obregón, 01210 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1447, '2013-12-09', 4, 403, 4, 0, 1, 0, 0, 1, 1572000, 'Magnolia, Tlacoyaque, Álvaro Obregón, 01859 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1448, '2013-12-09', 12, 709, 2, 0, 0, 1, 0, 2, 6092000, 'Avenida San Jeronimo 630, Jardines del Pedregal, Álvaro Obregón, 01090 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1449, '2013-12-09', 8, 785, 2, 0, 1, 0, 0, 2, 66000, 'Aquiles, Lomas de Axomiatla, Álvaro Obregón, 01820 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1450, '2013-12-09', 10, 587, 1, 0, 1, 1, 0, 1, 7532000, '2da. Cerrada de La Era, San Bartolo Ameyalco, Álvaro Obregón, 01800 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1451, '2013-12-09', 10, 565, 1, 0, 0, 0, 0, 3, 8065000, 'Cuauhtémoc 35, Del Carmen, Coyoacán, 04100 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1452, '2013-12-09', 3, 348, 1, 0, 0, 1, 0, 1, 6863000, 'Miguel Laurent 1164, Letrán Valle, Benito Juarez, 03650 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1453, '2013-12-09', 10, 328, 3, 0, 1, 1, 0, 1, 8093000, 'Francisco Flores, Ejército de Agua Prieta, Iztapalapa, 09530 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1454, '2013-12-09', 8, 679, 2, 0, 0, 1, 0, 2, 5712000, 'Cráter 161, Jardines del Pedregal, Álvaro Obregón, 01900 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1455, '2013-12-09', 11, 595, 3, 0, 1, 0, 0, 1, 9137000, 'Avenida Acuario, Bosque de Chapultepec I, Miguel Hidalgo, 11100 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1456, '2013-12-09', 11, 319, 3, 0, 1, 0, 0, 2, 5891000, 'Avenida 521 131, San Juan de Aragón 1a Sección, Gustavo A. Madero, 07969 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1457, '2013-12-09', 3, 449, 1, 0, 0, 1, 0, 3, 3186000, 'Calle 1, Pantitlan, Iztacalco, 08100 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1458, '2013-12-09', 7, 695, 4, 0, 1, 1, 0, 1, 1796000, 'San Francisco 429, Granjas Estrella, Iztapalapa, 09880 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1459, '2013-12-09', 12, 473, 3, 0, 1, 0, 0, 2, 9885000, 'Omega 219, Romero de Terreros, Coyoacán, 04310 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1460, '2013-12-09', 12, 322, 1, 0, 0, 1, 0, 2, 4514000, 'Eje 1 Oriente F.C. Hidalgo 2301, La Joyita, Gustavo A. Madero, 07850 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1461, '2013-12-09', 11, 408, 1, 0, 0, 0, 0, 2, 4258000, 'Higura 35, La Concepción, Coyoacán, 04000 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1462, '2013-12-09', 12, 479, 3, 0, 1, 0, 0, 3, 7726000, '1a. Privada José Loreto Fabela 35, San Juan de Aragón, Gustavo A. Madero, 07950 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1463, '2013-12-09', 1, 544, 3, 0, 1, 0, 0, 1, 1174000, 'México - Toluca 2990, Lomas de Bezares, Miguel Hidalgo, 11910 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1464, '2013-12-09', 11, 253, 4, 0, 0, 1, 0, 1, 6992000, 'Américo Vespucio, Lomas de Capula, Álvaro Obregón, 01270 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1465, '2013-12-09', 6, 268, 2, 0, 1, 1, 0, 3, 3273000, 'Sierra Amatepec 251, Lomas de Chapultepec, Miguel Hidalgo, 11000 Mexico City, State of Mexico, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1466, '2013-12-09', 6, 201, 2, 0, 1, 0, 0, 2, 3283000, 'Avenida del Panteón 96, Los Reyes, Coyoacán, 04330 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1467, '2013-12-09', 13, 382, 4, 0, 0, 0, 0, 2, 2206000, 'Avenida Centenario, Lomas de Tarango, Álvaro Obregón, 01620 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1468, '2013-12-09', 11, 496, 4, 0, 1, 0, 0, 1, 3714000, 'Bosque de Zapotes 117, Bosques de Las Lomas, Miguel Hidalgo, 11700 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1469, '2013-12-09', 3, 473, 2, 0, 0, 0, 0, 1, 3551000, 'Refinería Azcapotzalco 3, Petrolera Taxqueña, Coyoacán, 04410 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1470, '2013-12-09', 1, 657, 1, 0, 0, 1, 0, 1, 2086000, 'Huecampool, Xalpa, Iztapalapa, 09640 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1471, '2013-12-09', 13, 769, 1, 0, 0, 0, 0, 2, 3785000, 'Poniente 116 571, Industrial Vallejo, Azcapotzalco, 02300 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1472, '2013-12-09', 12, 305, 1, 0, 1, 1, 0, 1, 4664000, 'Salvador Díaz Mirón 55, Santa María La Ribera, Cuauhtémoc, 06400 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1473, '2013-12-09', 11, 627, 4, 0, 0, 1, 0, 1, 615000, 'Guillermo Prieto 147, Magdalena Mixiuhca, Venustiano Carranza, 15860 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1474, '2013-12-09', 7, 415, 3, 0, 1, 0, 0, 3, 4475000, 'Rosales, Zedec Santa Fe, Álvaro Obregón, 01219 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1475, '2013-12-09', 1, 359, 4, 0, 1, 1, 0, 3, 6101000, 'Gavilán 185, Gavilán, Iztapalapa, 09369 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1476, '2013-12-09', 7, 438, 2, 0, 0, 0, 0, 1, 2165000, 'Oriente 170 88, Moctezuma 2a Sección, Venustiano Carranza, 15530 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1477, '2013-12-09', 7, 425, 1, 0, 0, 0, 0, 2, 9256000, '2a. Cda. Av. 679, C. T. M. Aragón, Gustavo A. Madero, 07990 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1478, '2013-12-09', 3, 655, 4, 0, 0, 1, 0, 1, 2772000, 'San Esteban 85, Santo Tomas, Azcapotzalco, 02020 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1479, '2013-12-09', 7, 797, 4, 0, 0, 0, 0, 2, 8022000, 'Avenida 613 22, San Juan de Aragón 5a Sección, Gustavo A. Madero, 07970 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1480, '2013-12-09', 2, 783, 2, 0, 1, 1, 0, 1, 3726000, '205 de Av. Río Churubusco, Modelo, Iztapalapa, 09089 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1481, '2013-12-09', 1, 523, 1, 0, 1, 0, 0, 3, 521000, 'Francisco Morazán 842, Villa de Aragón, Gustavo A. Madero, 07570 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1482, '2013-12-09', 6, 667, 4, 0, 1, 0, 0, 2, 9537000, 'Patabam 3904, Del Gas, Azcapotzalco, 02950 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1483, '2013-12-09', 4, 579, 2, 0, 1, 1, 0, 1, 9490000, 'Puente Zacate, Ampliación Gabriel Ramos Millán, Iztacalco, 08020 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1484, '2013-12-09', 4, 307, 4, 0, 1, 1, 0, 2, 8232000, 'Desierto de Los Leones 5096, Cedros, Álvaro Obregón, 01870 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1485, '2013-12-09', 1, 490, 1, 0, 1, 1, 0, 3, 4092000, 'Camino a Santa Fe 17(MZ36 LT5(MZ36C LT5)), Lomas de Becerra, Álvaro Obregón, 01279 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1486, '2013-12-09', 12, 451, 3, 0, 0, 1, 0, 1, 420000, 'Rif 920, Sta Cruz Atoyac, Benito Juarez, 03310 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1487, '2013-12-09', 11, 445, 1, 0, 1, 1, 0, 3, 8717000, 'Alsacia 36, San Andrés Tetepilco, Iztapalapa, 09440 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1488, '2013-12-09', 11, 475, 4, 0, 0, 1, 0, 3, 4248000, 'Sur 14-A 18, Agrícola Oriental, Iztacalco, 08500 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1489, '2013-12-09', 11, 487, 4, 0, 1, 1, 0, 3, 4975000, 'Ferrocarril de Cuernavaca 415, San Jerónimo Lídice, Magdalena Contreras, 10200 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1490, '2013-12-09', 6, 386, 4, 0, 0, 1, 0, 3, 3307000, 'Monte Blanco 745, Lomas de Chapultepec, Miguel Hidalgo, 11000 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1491, '2013-12-09', 8, 311, 3, 0, 1, 1, 0, 3, 4977000, 'Eje 3 Norte Calzada San Isidro, Ampliación Petrolera, Azcapotzalco, 02470 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1492, '2013-12-09', 6, 721, 3, 0, 0, 0, 0, 3, 2661000, 'Loma de la Palma 133, Lomas de Vista Hermosa, Cuajimalpa, 05100 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1493, '2013-12-09', 13, 319, 3, 0, 1, 1, 0, 3, 9157000, 'Bosque de Olivos 291, Bosques de Las Lomas, Miguel Hidalgo, 11700 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1494, '2013-12-09', 7, 576, 4, 0, 1, 1, 0, 2, 5719000, 'Anillo Periférico 2141, Ejército Constitucionalista, Iztapalapa, 09220 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1495, '2013-12-09', 3, 522, 2, 0, 1, 0, 0, 1, 8834000, 'Paseo de Los Ahuehuetes Norte 1139, Bosques de Las Lomas, Miguel Hidalgo, 05120 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1496, '2013-12-09', 11, 415, 4, 0, 1, 0, 0, 2, 7049000, '6 de Marzo, Revolución, Venustiano Carranza, 15460 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1497, '2013-12-09', 1, 244, 4, 0, 0, 1, 0, 2, 3009000, 'Bondojito 25, Michoacana, Venustiano Carranza, 15250 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1498, '2013-12-09', 11, 371, 1, 0, 1, 1, 0, 1, 9797000, 'Privada Galio 11, Cuchilla Pantitlan, Venustiano Carranza, 15610 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1499, '2013-12-09', 6, 237, 2, 0, 1, 0, 0, 1, 2791000, 'Doctor J. Navarro 30, Doctores, Cuauhtémoc, 06720 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1500, '2013-12-09', 4, 624, 4, 0, 1, 1, 0, 2, 8923000, 'Eje 4 Oriente (Avenida Río Churubusco) 578, Cuchilla Pantitlan, Venustiano Carranza, 15610 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1501, '2013-12-09', 1, 642, 4, 0, 1, 0, 0, 2, 5507000, '2a. Cerrada Calle 10 204, Granjas San Antonio, Iztapalapa, 09070 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1502, '2013-12-09', 8, 563, 1, 0, 0, 1, 0, 2, 1624000, 'Youita, Santa Lucía, Álvaro Obregón, 01580 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1503, '2013-12-09', 8, 776, 3, 0, 1, 1, 0, 3, 4003000, 'Eje 5 Sur (Prol. Marcelino Buendía), Cabeza de Juárez VI, Iztapalapa, 09225 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1504, '2013-12-09', 12, 534, 2, 0, 1, 1, 0, 2, 5897000, 'Canal de Tezontle 916, Paseos de Churubusco, Iztapalapa, 09030 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1505, '2013-12-09', 10, 391, 3, 0, 0, 1, 0, 1, 5003000, 'Reforma Religiosa MZ41 LTSN, Reforma Política, Iztapalapa, 09730 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1506, '2013-12-09', 8, 512, 2, 0, 0, 0, 0, 1, 6628000, 'Cerro Creston 139, Campestre Churubusco, Coyoacán, 04200 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1507, '2013-12-09', 8, 690, 4, 0, 1, 1, 0, 1, 493000, 'Avenida Tamaulipas 307, Lomas de Santa Fe, Cuajimalpa, 05600 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1508, '2013-12-09', 4, 464, 3, 0, 0, 0, 0, 3, 2536000, 'Calle Marsella 19, Juárez, Cuauhtémoc, 06600 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1509, '2013-12-09', 8, 575, 4, 0, 0, 0, 0, 1, 2448000, 'José María Mendivil 124, Daniel Garza, Miguel Hidalgo, 11830 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1510, '2013-12-09', 2, 491, 2, 0, 0, 0, 0, 2, 6767000, 'José María Morelos 116, San Miguel Amantla, Azcapotzalco, 02700 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1511, '2013-12-09', 6, 631, 4, 0, 1, 0, 0, 3, 4981000, 'José Antonio Torres 842, Viaducto Piedad, Iztacalco, 08200 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1512, '2013-12-09', 6, 442, 3, 0, 1, 1, 0, 3, 1383000, 'Prolongación Canario, Tolteca, Álvaro Obregón, 01150 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1513, '2013-12-09', 6, 303, 3, 0, 0, 0, 0, 1, 5648000, 'Atlixaco 126, Santa Apolonia, Azcapotzalco, 02780 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1514, '2013-12-09', 4, 303, 2, 0, 0, 1, 0, 1, 1292000, 'Wagner 50, Ex Hipódromo de Peralvillo, Cuauhtémoc, 06250 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1515, '2013-12-09', 9, 361, 2, 0, 0, 1, 0, 3, 6702000, 'Eucalipto, Tenorios, Iztapalapa, 09680 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1516, '2013-12-09', 1, 584, 4, 0, 0, 0, 0, 1, 1485000, 'Comisión Nacional Agraria 40, Federal, Venustiano Carranza, 15700 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1517, '2013-12-09', 3, 646, 1, 0, 0, 1, 0, 2, 2847000, 'Lechuzas, Alcantarilla, Álvaro Obregón, 01729 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1518, '2013-12-09', 6, 412, 3, 0, 1, 1, 0, 3, 9714000, 'Calle 5, Porvenir, Azcapotzalco, 02940 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1519, '2013-12-09', 4, 360, 2, 0, 0, 1, 0, 2, 362000, 'Fresnos 101, Palo Alto(Granjas), Cuajimalpa, 05110 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1520, '2013-12-09', 11, 306, 1, 0, 1, 0, 0, 3, 2983000, 'Oriente 217-B 19, Cuchilla Agrícola Oriental, Iztacalco, 08420 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1521, '2013-12-09', 10, 341, 4, 0, 1, 0, 0, 3, 4863000, 'Beta 91, Romero de Terreros, Coyoacán, 04310 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1522, '2013-12-09', 5, 793, 4, 0, 1, 1, 0, 1, 1773000, 'Oriente 259 28, Agrícola Oriental, Iztacalco, 08500 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1523, '2013-12-09', 5, 711, 3, 0, 1, 0, 0, 3, 4018000, 'Rodríguez Saro 424, Del Valle, Benito Juarez, 03100 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1524, '2013-12-09', 8, 314, 3, 0, 0, 0, 0, 2, 4690000, 'Belisario Domínguez 1, Zacatepec, Iztapalapa, 09560 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1525, '2013-12-09', 11, 542, 3, 0, 0, 0, 0, 1, 8099000, 'Francisco J. Clavijero, Esperanza, Cuauhtémoc, 06840 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1526, '2013-12-09', 1, 592, 4, 0, 0, 1, 0, 1, 9228000, 'Sur 8 139, Agrícola Oriental, Iztacalco, 08500 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1527, '2013-12-09', 12, 759, 1, 0, 1, 0, 0, 2, 6232000, 'Creta, Lomas de Axomiatla, Álvaro Obregón, 01820 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1528, '2013-12-09', 12, 223, 3, 0, 1, 0, 0, 3, 4138000, 'Calzada Ignacio Zaragoza 790, Aviación Civil, Venustiano Carranza, 15740 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1529, '2013-12-09', 6, 356, 1, 0, 1, 1, 0, 3, 7777000, 'Siporex 3, Alce Blanco, Industrial Alce Blanco, 53370 Naucalpan, State of Mexico, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1530, '2013-12-09', 10, 408, 2, 0, 0, 0, 0, 1, 8715000, 'Eje 4 Sur (Xola) 1806, Narvarte, Benito Juarez, 03020 Mexico City, MX, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1531, '2013-12-09', 2, 761, 3, 0, 0, 1, 0, 1, 2079000, 'Ruiz Cortines, Pensador Mexicano, Venustiano Carranza, 15510 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1532, '2013-12-09', 2, 530, 2, 0, 1, 1, 0, 3, 1036000, 'Tejocotes 164, Tlacoquemecatl del Valle, Benito Juarez, 03200 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1533, '2013-12-09', 7, 475, 1, 0, 1, 1, 0, 3, 5535000, '506 (Eje 3 Norte), San Juan de Aragón 1a Sección, Gustavo A. Madero, 07969 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1534, '2013-12-09', 5, 221, 3, 0, 0, 0, 0, 2, 7398000, 'Canal Nacional 110-210, La Magdalena Culhuacan, Coyoacán, 04260 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1535, '2013-12-09', 10, 765, 2, 0, 1, 1, 0, 1, 8625000, 'Luis de La Rosa, Jardín Balbuena, Venustiano Carranza, 15900 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1536, '2013-12-09', 7, 399, 4, 0, 0, 0, 0, 3, 5620000, 'Cayetano Andrade 6, Santa Martha Acatitla, Iztapalapa, 09510 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1537, '2013-12-09', 7, 282, 3, 0, 1, 1, 0, 1, 2719000, '1, Olivar de Los Padres, Álvaro Obregón, 01780 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1538, '2013-12-09', 1, 744, 4, 0, 1, 1, 0, 2, 6686000, 'Canadá Los Helechos 447, San Mateo Tlaltenango, Cuajimalpa, 05600 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1539, '2013-12-09', 2, 348, 3, 0, 1, 0, 0, 3, 7953000, 'Calle Chinameca, Zenón Delgado, Álvaro Obregón, 01220 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1540, '2013-12-09', 2, 439, 4, 0, 0, 1, 0, 3, 9494000, 'Cordilleras 158, Águilas, Álvaro Obregón, 01710 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1541, '2013-12-09', 12, 379, 3, 0, 0, 1, 0, 3, 6355000, 'Pastores MZ8 LTSN, Ampliación Ricardo Flores Magón, Iztapalapa, 09828 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1542, '2013-12-09', 10, 458, 1, 0, 0, 0, 0, 2, 3903000, 'Bernardo Quintana 400, La Loma, Loma Santa Fé, 01219 Alvaro Obregón, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1543, '2013-12-09', 5, 595, 2, 0, 1, 0, 0, 3, 1021000, 'Moliere 328, Polanco, Miguel Hidalgo, 11520 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1544, '2013-12-09', 10, 694, 4, 0, 0, 0, 0, 2, 6742000, 'Barreteros 13, Azteca, Venustiano Carranza, 15320 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1545, '2013-12-09', 9, 238, 4, 0, 0, 0, 0, 1, 8732000, 'Sierra Vertientes 1125, Lomas de Chapultepec, Miguel Hidalgo, 11000 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1546, '2013-12-09', 11, 404, 2, 0, 0, 1, 0, 3, 2269000, 'Tratados de Sabinas (And 3), Zona Urbana Ejidal Santa María Aztahuacan, Iztapalapa, 09570 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1547, '2013-12-09', 3, 511, 4, 0, 0, 1, 0, 2, 9101000, 'Cjon. Juárez, Sta Cruz Atoyac, Benito Juarez, 03310 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1548, '2013-12-09', 11, 765, 4, 0, 1, 1, 0, 2, 1397000, 'José Santos Chocano, Balcones de Ceguayo, Álvaro Obregón, 01540 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1549, '2013-12-09', 7, 698, 4, 0, 1, 0, 0, 3, 6556000, 'Loma Linda 130, Lomas de Vista Hermosa, Cuajimalpa, 05100 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1550, '2013-12-09', 2, 518, 2, 0, 0, 0, 0, 3, 4170000, 'Avenida de las Torres MZ22 LT218, Zona Urbana Ejidal Santa María Aztahuacan, Iztapalapa, 09570 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1551, '2013-12-09', 8, 620, 1, 0, 0, 1, 0, 3, 695000, 'Tecoyotitla 97-147, Agrícola, Álvaro Obregón, 01050 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1552, '2013-12-09', 1, 397, 1, 0, 1, 1, 0, 2, 466000, 'Avenida Guelatao, Ejército de Agua Prieta, Iztapalapa, 09578 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1553, '2013-12-09', 5, 283, 1, 0, 1, 1, 0, 1, 7176000, 'República de Perú 131, Centro, Cuauhtémoc, 06010 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1554, '2013-12-09', 8, 203, 1, 0, 1, 1, 0, 3, 3586000, 'Antonio Rodríguez, San Simon Ticumac, Benito Juarez, 03660 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1555, '2013-12-09', 1, 511, 2, 0, 1, 1, 0, 1, 9696000, 'Mayas 59, Los Reyes, Coyoacán, 04330 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1556, '2013-12-09', 5, 478, 4, 0, 1, 1, 0, 2, 5939000, 'Mimosas, Santa María Insurgentes, Cuauhtémoc, 06430 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1557, '2013-12-09', 9, 371, 3, 0, 1, 0, 0, 1, 5441000, 'Norte 88 6215, Gertrudis Sánchez 2a Sección, Gustavo A. Madero, 07839 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1558, '2013-12-09', 1, 254, 2, 0, 0, 1, 0, 3, 7885000, 'Loma de Vista Hermosa 71, Lomas de Vista Hermosa, Cuajimalpa, 05100 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1559, '2013-12-09', 10, 572, 3, 0, 0, 1, 0, 1, 9767000, 'Tungsteno, San Juan Cerro, Iztapalapa, 09858 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1560, '2013-12-09', 1, 655, 3, 0, 0, 1, 0, 1, 6139000, 'Iztaccihuatl, Moctezuma 2a Sección, Venustiano Carranza, 15530 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1561, '2013-12-09', 5, 630, 3, 0, 0, 1, 0, 1, 2306000, 'Cuahutémoc 1154, Letrán Valle, Benito Juarez, 03310 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1562, '2013-12-09', 11, 535, 3, 0, 0, 0, 0, 2, 260000, 'Avenida Tlahuac, Culhuacan, Iztapalapa, 09800 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1563, '2013-12-09', 11, 500, 4, 0, 1, 1, 0, 3, 6793000, 'Henry Ford 25, Guadalupe Tepeyac, Gustavo A. Madero, 07840 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1564, '2013-12-09', 6, 671, 3, 0, 1, 1, 0, 2, 6382000, 'Olivo 78, Florida, Álvaro Obregón, 01030 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1565, '2013-12-09', 4, 608, 1, 0, 0, 0, 0, 3, 5116000, 'Playa Mocambo 469, Militar Marte, Iztacalco, 08830 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1566, '2013-12-09', 2, 308, 1, 0, 1, 0, 0, 1, 7642000, 'Av. Cuauhtémoc 462, Del Valle, Benito Juarez, 03000 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1567, '2013-12-09', 6, 269, 4, 0, 1, 1, 0, 2, 7038000, 'Secretaría del Trabajo, Cuatro Árboles, Venustiano Carranza, 15730 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1568, '2013-12-09', 13, 216, 2, 0, 1, 0, 0, 2, 1841000, 'EJE 3 Oriente (AV. Ingeniero EDUARDO MOLINA) 7224A, Constitución de La República, Gustavo A. Madero, 07469 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1569, '2013-12-09', 3, 343, 2, 0, 1, 1, 0, 1, 3879000, '3a. Cerrada Carril, 2da Ampliación Barrio San Miguel (San Felipe Terremotes), Iztapalapa, 09360 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1570, '2013-12-09', 13, 799, 3, 0, 1, 1, 0, 2, 3177000, 'Sur 16-B 58, Agrícola Oriental, Iztacalco, 08500 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1571, '2013-12-09', 2, 713, 2, 0, 1, 0, 0, 3, 8975000, 'Lago Alberto 319, Ampliación Granada, Miguel Hidalgo, 11520 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1572, '2013-12-09', 10, 628, 1, 0, 0, 1, 0, 3, 5072000, 'Avenida Ing. Eduardo Molina 421, 20 de Noviembre, Venustiano Carranza, 15300 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1573, '2013-12-09', 4, 203, 2, 0, 0, 1, 0, 3, 4873000, 'Licenciado Luis Cabrera, Jacarandas, Iztapalapa, 09280 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1574, '2013-12-09', 7, 653, 4, 0, 1, 0, 0, 3, 9399000, 'Neptuno 44, San Simon Tolnahuac, Cuauhtémoc, 06920 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1575, '2013-12-09', 6, 540, 1, 0, 0, 1, 0, 3, 669000, '2a. 539 4, San Juan de Aragón 2a Sección, Gustavo A. Madero, 07969 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1576, '2013-12-09', 1, 380, 3, 0, 0, 1, 0, 2, 2893000, 'Naranjos 146, Petrolera, Azcapotzalco, 02480 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1577, '2013-12-09', 3, 453, 4, 0, 1, 0, 0, 2, 127000, 'Ribera de San Cosme 157, Santa María La Ribera, Cuauhtémoc, 06400 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1578, '2013-12-09', 2, 316, 2, 0, 0, 1, 0, 1, 1525000, 'Bahía Santa Barbara 414, Anáhuac, Miguel Hidalgo, 11320 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1579, '2013-12-09', 11, 669, 3, 0, 1, 0, 0, 2, 8058000, 'Pto. Catania 35, Ejidos San Juan de Aragón 1a Sección, Gustavo A. Madero, 07940 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1580, '2013-12-09', 7, 254, 1, 0, 0, 0, 0, 2, 8183000, 'Primero de Mayo 5, Tacubaya, Miguel Hidalgo, 11870 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1581, '2013-12-09', 7, 578, 1, 0, 0, 1, 0, 3, 1666000, 'Medina 20, Pantitlan, Iztacalco, 08100 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1582, '2013-12-09', 13, 348, 1, 0, 0, 0, 0, 1, 8644000, '1 MZ22LT25B, La Martinica, Álvaro Obregón, 01690 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1583, '2013-12-09', 13, 584, 3, 0, 1, 1, 0, 2, 3761000, 'Labradores 7, Morelos, Cuauhtémoc, 15270 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1584, '2013-12-09', 4, 399, 2, 0, 0, 1, 0, 3, 4630000, 'Tlaxcala 1, Progreso, Álvaro Obregón, 01090 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1585, '2013-12-09', 7, 532, 1, 0, 0, 1, 0, 1, 4605000, 'Pedro Calderon de la Barca 305, Polanco, Miguel Hidalgo, 11550 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1586, '2013-12-09', 12, 447, 2, 0, 0, 1, 0, 3, 1298000, 'Leo, San José del Olivar, Álvaro Obregón, 01770 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1587, '2013-12-09', 6, 328, 2, 0, 1, 1, 0, 3, 2056000, 'Eje Central Lázaro Cárdenas 866, Niños Heroes de Chapultepec, Benito Juarez, 03440 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1588, '2013-12-09', 1, 253, 3, 0, 1, 1, 0, 3, 4024000, 'Estenógrafo 20, Magdalena Atlazolpa, Iztapalapa, 09410 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1589, '2013-12-09', 1, 543, 4, 0, 0, 1, 0, 3, 8992000, 'Licenciado Ignacio Ramos 219, Constitución de 1917, Iztapalapa, 09260 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1590, '2013-12-09', 2, 295, 2, 0, 0, 1, 0, 2, 7010000, 'Carlos Fernández, Del Valle, Benito Juarez, 03100 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1591, '2013-12-09', 10, 378, 1, 0, 0, 1, 0, 1, 2095000, '2 Sur 12-B 50, Agrícola Oriental, Iztacalco, 08500 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1592, '2013-12-09', 1, 567, 4, 0, 1, 0, 0, 1, 1635000, 'Norte 45 829, Industrial Vallejo, Azcapotzalco, 02330 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1593, '2013-12-09', 8, 231, 2, 0, 0, 0, 0, 2, 7030000, 'Hortensias 78, Ciudad Jardín, Coyoacán, 04370 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1594, '2013-12-09', 7, 293, 4, 0, 0, 1, 0, 1, 1362000, 'Cda. Doctor José Ignacio Bartolache, Del Valle, Benito Juarez, 03100 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1595, '2013-12-09', 10, 293, 4, 0, 1, 1, 0, 3, 4532000, 'Emilio Balli, Chinampac de Juárez, Iztapalapa, 09208 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1596, '2013-12-09', 11, 750, 2, 0, 1, 1, 0, 1, 3632000, 'Enrique Rébsamen 617, Narvarte, Benito Juarez, 03020 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1597, '2013-12-09', 1, 610, 4, 0, 0, 0, 0, 1, 8982000, 'Calle Diamante 7, La Estrella, Gustavo A. Madero, 07810 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1598, '2013-12-09', 2, 446, 1, 0, 0, 0, 0, 1, 8425000, 'De Fresno, Pueblo Santa Fe, Álvaro Obregón, 01210 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1599, '2013-12-09', 9, 312, 4, 0, 1, 1, 0, 2, 2605000, 'Alpes 964, Lomas de Chapultepec, Miguel Hidalgo, 11000 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1600, '2013-12-09', 12, 606, 1, 0, 1, 1, 0, 2, 3823000, 'Balboa 802, Portales, Benito Juarez, 03300 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1601, '2013-12-09', 1, 707, 3, 0, 1, 0, 0, 2, 4502000, 'Picos VI B And 4, Los Picos VI B, Iztapalapa, 09420 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1602, '2013-12-09', 2, 522, 3, 0, 1, 0, 0, 3, 3292000, 'Jorge Enciso 1810, Mexicaltzingo, Iztapalapa, 09060 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1603, '2013-12-09', 4, 570, 1, 0, 1, 0, 0, 3, 752000, 'Oriente 172 143, Moctezuma 2a Sección, Venustiano Carranza, 15530 Mexico City, Federal District, Mexico', 1, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1604, '2013-12-09', 13, 358, 3, 0, 0, 1, 0, 2, 8473000, '5 C. del Valle MZ23 LT32, U Habitacional Vicente Guerrero I II ÌII IV V VI VII, Iztapalapa, 09200 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1605, '2013-12-09', 8, 718, 3, 0, 0, 0, 0, 3, 5028000, 'Doctor José María Vertiz 262, Doctores, Cuauhtémoc, 06720 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1606, '2013-12-09', 7, 618, 4, 0, 0, 0, 0, 3, 3163000, 'Necaxa 130, Portales, Benito Juarez, 03300 Mexico City, Federal District, Mexico', 0, 2, 0, NULL, 1);
INSERT INTO `ct_inmueble` VALUES (1607, '2013-12-09', 6, 749, 4, 0, 0, 0, 0, 3, 1154000, 'Cuitláhuac 2506-b, Clavería, Laveria, 02090 Azcapotzalco, Federal District, Mexico', 0, 2, 0, NULL, 1);


-- -----------------------------------------------------
-- volcado `inmovitek`.`ct_direccion_inmueble`
-- -----------------------------------------------------

INSERT INTO `ct_direccion_inmueble` VALUES (1, 9, 'Oriente 95 2604-5103', ' Tablas de San Aguistin', ' Gustavo A. Madero', 7860, 19.325555, -99.157362, 'Oriente 95 2604-5103, Tablas de San Aguistin, Gustavo A. Madero, 07860 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (2, 9, 'Nubes 224', ' Jardines del Pedregal', ' Álvaro Obregón', 1900, 19.325555, -99.157362, 'Nubes 224, Jardines del Pedregal, Álvaro Obregón, 01900 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (3, 9, 'Eje 4 Norte (Av. 510)', ' San Juan de Aragón 4a Sección', ' Gustavo A. Madero', 7979, 19.389656, -99.217372, 'Eje 4 Norte (Av. 510), San Juan de Aragón 4a Sección, Gustavo A. Madero, 07979 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (4, 9, 'Circuito Interior Avenida Río Mixcoac', ' Acacias', ' Benito Juarez', 3240, 19.389656, -99.217372, 'Circuito Interior Avenida Río Mixcoac, Acacias, Benito Juarez, 03240 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (5, 9, 'Avenida de las Torres', ' Los Padres', ' Magdalena Contreras', 10340, 19.329655, -99.206383, 'Avenida de las Torres, Los Padres, Magdalena Contreras, 10340 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (6, 9, 'Avenida 475', ' San Juan de Aragón 7 Sección', ' Gustavo A. Madero', 7910, 19.329655, -99.206383, 'Avenida 475, San Juan de Aragón 7 Sección, Gustavo A. Madero, 07910 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (7, 9, 'Coacota', ' Zenón Delgado', ' Álvaro Obregón', 1220, 19.329655, -99.206383, 'Coacota, Zenón Delgado, Álvaro Obregón, 01220 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (8, 9, 'Prolongación Río Churubusco 10', ' Caracol', ' Venustiano Carranza', 15630, 19.428656, -99.206373, 'Prolongación Río Churubusco 10, Caracol, Venustiano Carranza, 15630 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (9, 9, 'Norte 81-A', ' Libertad', ' Azcapotzalco', 2050, 19.428656, -99.206373, 'Norte 81-A, Libertad, Azcapotzalco, 02050 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (10, 9, 'Moctezuma', ' Mixcoatl', ' Iztapalapa', 9708, 19.428656, -99.206373, 'Moctezuma, Mixcoatl, Iztapalapa, 09708 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (11, 9, 'General Vicente Guerrero 30', ' 15 de Agosto', ' Gustavo A. Madero', 7050, 19.464556, -99.246372, 'General Vicente Guerrero 30, 15 de Agosto, Gustavo A. Madero, 07050 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (12, 9, 'Avenida Instituto Politécnico Nacional', ' Magdalena de Las Salinas', ' Gustavo A. Madero', 7760, 19.464556, -99.246372, 'Avenida Instituto Politécnico Nacional, Magdalena de Las Salinas, Gustavo A. Madero, 07760 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (13, 9, 'Avenida Texcoco 29', ' Peñón de Los Baños', ' Venustiano Carranza', 15520, 19.456665, -99.077372, 'Avenida Texcoco 29, Peñón de Los Baños, Venustiano Carranza, 15520 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (14, 9, 'Rabaul 448', ' San Rafael', ' Gustavo A. Madero', 2010, 19.456665, -99.077372, 'Rabaul 448, San Rafael, Gustavo A. Madero, 02010 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (15, 9, 'Anaxágoras 715', ' Narvarte', ' Benito Juarez', 3000, 19.456665, -99.077372, 'Anaxágoras 715, Narvarte, Benito Juarez, 03000 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (16, 9, 'Paseo de Alcázar', ' La Loma', ' Álvaro Obregón', 1260, 19.463556, -99.107373, 'Paseo de Alcázar, La Loma, Álvaro Obregón, 01260 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (17, 9, '1 MZ22LT25B', ' La Martinica', ' Álvaro Obregón', 1690, 19.463556, -99.107373, '1 MZ22LT25B, La Martinica, Álvaro Obregón, 01690 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (18, 9, 'Norte 59 825', ' Las Salinas', ' Azcapotzalco', 2360, 19.463556, -99.107373, 'Norte 59 825, Las Salinas, Azcapotzalco, 02360 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (19, 9, 'Eje 4 Sur (Xola) 1302', ' Esperanza', ' Benito Juarez', 3020, 19.449566, -99.206372, 'Eje 4 Sur (Xola) 1302, Esperanza, Benito Juarez, 03020 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (20, 9, 'Alhelí 62', ' Nueva Santa María', ' Azcapotzalco', 2850, 19.383556, -99.077373, 'Alhelí 62, Nueva Santa María, Azcapotzalco, 02850 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (21, 9, 'Creta', ' Lomas de Axomiatla', ' Álvaro Obregón', 1820, 19.383556, -99.077373, 'Creta, Lomas de Axomiatla, Álvaro Obregón, 01820 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (22, 9, 'Camino CAMPESTRE 216(304)', ' Campestre Aragón', ' Gustavo A. Madero', 7530, 19.466656, -99.176362, 'Camino CAMPESTRE 216(304), Campestre Aragón, Gustavo A. Madero, 07530 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (23, 9, 'Maíz 358', ' Valle del Sur', ' Iztapalapa', 9819, 19.466656, -99.176362, 'Maíz 358, Valle del Sur, Iztapalapa, 09819 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (24, 9, 'Galeana 101', ' San Jerónimo Lídice', ' Magdalena Contreras', 10200, 19.359656, -99.046363, 'Galeana 101, San Jerónimo Lídice, Magdalena Contreras, 10200 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (25, 9, 'San Francisco', ' San Bartolo Ameyalco', ' Álvaro Obregón', 1800, 19.354555, -99.147373, 'San Francisco, San Bartolo Ameyalco, Álvaro Obregón, 01800 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (26, 9, 'Avenida Felipe Villanueva 158', ' Peralvillo', ' Cuauhtémoc', 6220, 19.354555, -99.147373, 'Avenida Felipe Villanueva 158, Peralvillo, Cuauhtémoc, 06220 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (27, 9, 'Calle Canarias', ' Portales', ' Benito Juarez', 3300, 19.354555, -99.147373, 'Calle Canarias, Portales, Benito Juarez, 03300 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (28, 9, 'Camino de La Amistad a 25-27', ' Campestre Aragón', ' Gustavo A. Madero', 7530, 19.353555, -99.127362, 'Camino de La Amistad a 25-27, Campestre Aragón, Gustavo A. Madero, 07530 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (29, 9, 'Autopista México-Marquesa', ' Zedec Santa Fe', ' Álvaro Obregón', 1219, 19.353555, -99.127362, 'Autopista México-Marquesa, Zedec Santa Fe, Álvaro Obregón, 01219 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (30, 9, 'Los Gipaetos', ' Lomas de Las Águilas', ' Álvaro Obregón', 1759, 19.488655, -99.027352, 'Los Gipaetos, Lomas de Las Águilas, Álvaro Obregón, 01759 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (31, 9, 'Bosque de Canelos 95', ' Bosques de Las Lomas', ' Cuajimalpa', 5120, 19.488655, -99.027352, 'Bosque de Canelos 95, Bosques de Las Lomas, Cuajimalpa, 05120 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (32, 9, 'Avenida Centenario', ' Lomas de Plateros', ' Álvaro Obregón', 1480, 19.338655, -99.236373, 'Avenida Centenario, Lomas de Plateros, Álvaro Obregón, 01480 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (33, 9, 'Jilotepec MZ3 LT7', ' 2da Ampliación Santiago Acahualtepec', ' Iztapalapa', 9609, 19.338655, -99.236373, 'Jilotepec MZ3 LT7, 2da Ampliación Santiago Acahualtepec, Iztapalapa, 09609 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (34, 9, 'Eje 2 Poniente Gabriel Mancera 1402', ' Del Valle', ' Benito Juarez', 3100, 19.338655, -99.236373, 'Eje 2 Poniente Gabriel Mancera 1402, Del Valle, Benito Juarez, 03100 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (35, 9, 'Morelia 21', ' Roma Norte', ' Cuauhtémoc', 6700, 19.333666, -99.216373, 'Morelia 21, Roma Norte, Cuauhtémoc, 06700 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (36, 9, 'Ruiz Cortines', ' Pensador Mexicano', ' Venustiano Carranza', 15510, 19.333666, -99.216373, 'Ruiz Cortines, Pensador Mexicano, Venustiano Carranza, 15510 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (37, 9, 'Eje 1 Oriente (Av. Canal de Miramontes) 1832', ' Campestre Churubusco', ' Coyoacán', 4200, 19.459565, -99.016352, 'Eje 1 Oriente (Av. Canal de Miramontes) 1832, Campestre Churubusco, Coyoacán, 04200 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (38, 9, 'Doctor Alfonso Caso Andrade', ' Pilares Águilas', ' Álvaro Obregón', 1710, 19.459565, -99.016352, 'Doctor Alfonso Caso Andrade, Pilares Águilas, Álvaro Obregón, 01710 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (39, 9, 'Tlalmiminolpan', ' San Bartolo Ameyalco', ' Álvaro Obregón', 1800, 19.459565, -99.016352, 'Tlalmiminolpan, San Bartolo Ameyalco, Álvaro Obregón, 01800 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (40, 9, 'Calle Salvador Novo 55', ' Santa Catarina', ' Coyoacán', 4010, 19.352566, -99.016362, 'Calle Salvador Novo 55, Santa Catarina, Coyoacán, 04010 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (41, 9, 'Loma Chica LB', ' Lomas de Tarango', ' Álvaro Obregón', 1620, 19.352566, -99.016362, 'Loma Chica LB, Lomas de Tarango, Álvaro Obregón, 01620 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (42, 9, 'Sur 27 MZ39 LT407', ' Leyes de Reforma 2da. Sección', ' Iztapalapa', 9208, 19.369656, -99.137362, 'Sur 27 MZ39 LT407, Leyes de Reforma 2da. Sección, Iztapalapa, 09208 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (43, 9, 'Guelatao', ' Nueva Díaz Ordaz', ' Coyoacán', 4380, 19.369656, -99.137362, 'Guelatao, Nueva Díaz Ordaz, Coyoacán, 04380 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (44, 9, 'Canadá Los Helechos 434', ' San Mateo Tlaltenango', ' Cuajimalpa', 5600, 19.369656, -99.137362, 'Canadá Los Helechos 434, San Mateo Tlaltenango, Cuajimalpa, 05600 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (45, 9, 'Calle 20 25', ' Olivar del Conde 1a. Sección', ' Álvaro Obregón', 1400, 19.468566, -99.107372, 'Calle 20 25, Olivar del Conde 1a. Sección, Álvaro Obregón, 01400 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (46, 9, '1a. Privada Vicente Guerrero', ' Culhuacan', ' Iztapalapa', 9800, 19.427656, -99.247382, '1a. Privada Vicente Guerrero, Culhuacan, Iztapalapa, 09800 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (47, 9, 'Iturbe 15', ' San Mateo Tlaltenango', ' Cuajimalpa', 5600, 19.427656, -99.247382, 'Iturbe 15, San Mateo Tlaltenango, Cuajimalpa, 05600 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (48, 9, 'Avenida Miguel Ángel de Quevedo 593', ' Cuadrante de San Francisco', ' Coyoacán', 4320, 19.482665, -99.157363, 'Avenida Miguel Ángel de Quevedo 593, Cuadrante de San Francisco, Coyoacán, 04320 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (49, 9, 'Paseo Hacienda Santa Fe', ' La Loma', ' Álvaro Obregón', 1260, 19.482665, -99.157363, 'Paseo Hacienda Santa Fe, La Loma, Álvaro Obregón, 01260 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (50, 9, 'Calzada de La Ronda 109', ' Ex Hipódromo de Peralvillo', ' Cuauhtémoc', 6250, 19.363556, -99.277383, 'Calzada de La Ronda 109, Ex Hipódromo de Peralvillo, Cuauhtémoc, 06250 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (51, 9, 'Prolongacion Reforma 215', ' Paseo de Las Lomas', ' Cuajimalpa', 1330, 19.453666, -99.177353, 'Prolongacion Reforma 215, Paseo de Las Lomas, Cuajimalpa, 01330 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (52, 9, 'Vía Express Tapo', ' Aeropuerto Int de La Ciudad de México', ' Venustiano Carranza', 15620, 19.453666, -99.177353, 'Vía Express Tapo, Aeropuerto Int de La Ciudad de México, Venustiano Carranza, 15620 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (53, 9, 'Vía Express Tapo *(VISUAL)', ' Aeropuerto Int de La Ciudad de México', ' Venustiano Carranza', 15620, 19.434555, -99.246373, 'Vía Express Tapo *(VISUAL), Aeropuerto Int de La Ciudad de México, Venustiano Carranza, 15620 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (54, 9, 'Ceylan 470B', ' San Miguel Amantla', ' Miguel Hidalgo', 2520, 19.434555, -99.246373, 'Ceylan 470B, San Miguel Amantla, Miguel Hidalgo, 02520 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (55, 9, 'Benemérito de Las Americas MZ15 LT4', ' Nueva Díaz Ordaz', ' Coyoacán', 4390, 19.434555, -99.246373, 'Benemérito de Las Americas MZ15 LT4, Nueva Díaz Ordaz, Coyoacán, 04390 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (56, 9, 'Cda. Cuamichic 30', ' Santo Domingo (Pgal de Sto Domingo)', ' Coyoacán', 4369, 19.333656, -99.256372, 'Cda. Cuamichic 30, Santo Domingo (Pgal de Sto Domingo), Coyoacán, 04369 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (57, 9, 'Plaza Tzintzuntzan', ' Ctm V Culhuacan', ' Coyoacán', 4480, 19.486655, -99.216362, 'Plaza Tzintzuntzan, Ctm V Culhuacan, Coyoacán, 04480 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (58, 9, 'Vía Express Tapo', ' Aeropuerto Int de La Ciudad de México', ' Venustiano Carranza', 15620, 19.367556, -99.056362, 'Vía Express Tapo, Aeropuerto Int de La Ciudad de México, Venustiano Carranza, 15620 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (59, 9, 'Lázaro Cárdenas MZ117 LT1589', ' Ampliación Zona Urbana Ejidal Santa María Aztahuacan', ' Iztapalapa', 9570, 19.367556, -99.056362, 'Lázaro Cárdenas MZ117 LT1589, Ampliación Zona Urbana Ejidal Santa María Aztahuacan, Iztapalapa, 09570 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (60, 9, 'Avenida Bordo Xochiaca', ' Aeropuerto Int de La Ciudad de México', ' Venustiano Carranza', 15620, 19.367556, -99.056362, 'Avenida Bordo Xochiaca, Aeropuerto Int de La Ciudad de México, Venustiano Carranza, 15620 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (61, 9, 'Fernando Montes de Oca 71', ' Guadalupe del Moral', ' Iztapalapa', 9300, 19.389565, -99.067373, 'Fernando Montes de Oca 71, Guadalupe del Moral, Iztapalapa, 09300 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (62, 9, 'Montes Apeninos 115', ' Lomas de Chapultepec', ' Miguel Hidalgo', 11000, 19.346566, -99.007372, 'Montes Apeninos 115, Lomas de Chapultepec, Miguel Hidalgo, 11000 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (63, 9, 'Avenida Santa Cruz Meyehualco 181', ' Santa Cruz Meyehualco', ' Iztapalapa', 9290, 19.349656, -99.206352, 'Avenida Santa Cruz Meyehualco 181, Santa Cruz Meyehualco, Iztapalapa, 09290 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (64, 9, 'Guadalupe Victoria MZ47 LT264', ' Zona Urbana Ejidal Santa María Aztahuacan', ' Iztapalapa', 9570, 19.349656, -99.206352, 'Guadalupe Victoria MZ47 LT264, Zona Urbana Ejidal Santa María Aztahuacan, Iztapalapa, 09570 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (65, 9, 'Avenida Centenario 394', ' Merced Gómez', ' Álvaro Obregón', 1600, 19.373566, -99.016353, 'Avenida Centenario 394, Merced Gómez, Álvaro Obregón, 01600 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (66, 9, 'Faisán 39', ' Granjas Modernas', ' Gustavo A. Madero', 7460, 19.325556, -99.277382, 'Faisán 39, Granjas Modernas, Gustavo A. Madero, 07460 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (67, 9, 'Martin Mendalde 915', ' Del Valle', ' Benito Juarez', 3100, 19.325556, -99.277382, 'Martin Mendalde 915, Del Valle, Benito Juarez, 03100 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (68, 9, 'Tulum', ' Ctm V Culhuacan', ' Coyoacán', 4480, 19.377666, -99.027363, 'Tulum, Ctm V Culhuacan, Coyoacán, 04480 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (69, 9, 'Jose Ma. Morels', ' Culhuacan', ' Iztapalapa', 9800, 19.452565, -99.126372, 'Jose Ma. Morels, Culhuacan, Iztapalapa, 09800 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (70, 9, 'Antonio Valeriano 732', ' Ampliación Del Gas', ' Azcapotzalco', 2970, 19.452565, -99.126372, 'Antonio Valeriano 732, Ampliación Del Gas, Azcapotzalco, 02970 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (71, 9, 'Antonio Caso 199', ' San Rafael', ' Cuauhtémoc', 6470, 19.465555, -99.077362, 'Antonio Caso 199, San Rafael, Cuauhtémoc, 06470 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (72, 9, 'Avenida San Miguel', ' Buenavista', ' Iztapalapa', 9700, 19.345555, -99.226372, 'Avenida San Miguel, Buenavista, Iztapalapa, 09700 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (73, 9, 'Loma Tlapexco 95A', ' Lomas de Vista Hermosa', ' Cuajimalpa', 5100, 19.336565, -99.157372, 'Loma Tlapexco 95A, Lomas de Vista Hermosa, Cuajimalpa, 05100 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (74, 9, 'Ana María R. del Toro de Lazarín', ' Centro', ' Cuauhtémoc', 6000, 19.333665, -99.267362, 'Ana María R. del Toro de Lazarín, Centro, Cuauhtémoc, 06000 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (75, 9, 'Vetagrande 14', ' Valle Gómez', ' Venustiano Carranza', 15210, 19.333665, -99.267362, 'Vetagrande 14, Valle Gómez, Venustiano Carranza, 15210 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (76, 9, 'Bandera', ' Industrias Militares de Sedena', ' Álvaro Obregón', 1219, 19.479655, -99.136382, 'Bandera, Industrias Militares de Sedena, Álvaro Obregón, 01219 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (77, 9, 'Doctor ATL 92', ' Santa María La Ribera', ' Cuauhtémoc', 6400, 19.422656, -99.147362, 'Doctor ATL 92, Santa María La Ribera, Cuauhtémoc, 06400 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (78, 9, 'Avenida Tlahuac', ' San Andrés Tomatlan', ' Iztapalapa', 9870, 19.375655, -99.106383, 'Avenida Tlahuac, San Andrés Tomatlan, Iztapalapa, 09870 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (79, 9, 'Loma de La Plata LB', ' Lomas de Tarango', ' Álvaro Obregón', 1620, 19.437656, -99.037363, 'Loma de La Plata LB, Lomas de Tarango, Álvaro Obregón, 01620 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (80, 9, 'Anillo Periférico MZ1 LT55', ' U Habitacional Vicente Guerrero I II ÌII IV V VI VII', ' Iztapalapa', 9200, 19.489566, -99.076372, 'Anillo Periférico MZ1 LT55, U Habitacional Vicente Guerrero I II ÌII IV V VI VII, Iztapalapa, 09200 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (81, 9, 'Paseo de los Laureles 458', ' Lomas de Vista Hermosa', ' Miguel Hidalgo', 5120, 19.328655, -99.166362, 'Paseo de los Laureles 458, Lomas de Vista Hermosa, Miguel Hidalgo, 05120 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (82, 9, 'Electricistas 91-A', ' 20 de Noviembre', ' Venustiano Carranza', 15300, 19.387556, -99.016353, 'Electricistas 91-A, 20 de Noviembre, Venustiano Carranza, 15300 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (83, 9, 'Avenida Santa Lucía 3B', ' Unidad Popular Emiliano Zapata', ' Álvaro Obregón', 1400, 19.435655, -99.276363, 'Avenida Santa Lucía 3B, Unidad Popular Emiliano Zapata, Álvaro Obregón, 01400 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (84, 9, 'Cascada 115', ' San Andrés Tetepilco', ' Iztapalapa', 9440, 19.466666, -99.057373, 'Cascada 115, San Andrés Tetepilco, Iztapalapa, 09440 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (85, 9, 'Al Olivo 22', ' Jardines de La Palma(Huizachito)', ' Cuajimalpa', 5100, 19.476656, -99.247352, 'Al Olivo 22, Jardines de La Palma(Huizachito), Cuajimalpa, 05100 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (86, 9, 'Sur 105-A 611-640', ' Popular', ' Iztapalapa', 9060, 19.432656, -99.217372, 'Sur 105-A 611-640, Popular, Iztapalapa, 09060 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (87, 9, 'Cofre de Perote 44', ' La Pradera', ' Gustavo A. Madero', 7500, 19.363665, -99.056353, 'Cofre de Perote 44, La Pradera, Gustavo A. Madero, 07500 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (88, 9, 'Josué Escobedo', ' U Habitacional Vicente Guerrero I II ÌII IV V VI VII', ' Iztapalapa', 9200, 19.355566, -99.136353, 'Josué Escobedo, U Habitacional Vicente Guerrero I II ÌII IV V VI VII, Iztapalapa, 09200 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (89, 9, '2', ' Zenón Delgado', ' Álvaro Obregón', 1220, 19.345665, -99.027383, '2, Zenón Delgado, Álvaro Obregón, 01220 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (90, 9, 'Batallón de Zacapoaxtla 8', ' Ejército de Oriente Indeco II ISSSTE', ' Ejercito de Oriente', 9230, 19.426656, -99.146362, 'Batallón de Zacapoaxtla 8, Ejército de Oriente Indeco II ISSSTE, Ejercito de Oriente, 09230 Iztapalapa, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (91, 9, 'Cumbres', ' Infonavit Iztacalco', ' Iztacalco', 8900, 19.383656, -99.147383, 'Cumbres, Infonavit Iztacalco, Iztacalco, 08900 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (92, 9, 'Anillo de Circunvalación 24', ' Merced Balbuena', ' Cuauhtémoc', 15810, 19.344655, -99.017373, 'Anillo de Circunvalación 24, Merced Balbuena, Cuauhtémoc, 15810 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (93, 9, 'Calle 71 3', ' Santa Cruz Meyehualco', ' Iztapalapa', 9290, 19.324666, -99.137383, 'Calle 71 3, Santa Cruz Meyehualco, Iztapalapa, 09290 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (94, 9, 'Avenida De Los Maestros 264', ' Agricultura', ' Miguel Hidalgo', 11360, 19.459666, -99.077352, 'Avenida De Los Maestros 264, Agricultura, Miguel Hidalgo, 11360 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (95, 9, 'HEROES 87', ' Guerrero', ' Cuauhtémoc', 6300, 19.485556, -99.226373, 'HEROES 87, Guerrero, Cuauhtémoc, 06300 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (96, 9, 'Revolución Social MZ10 LT37', ' Constitución de 1917', ' Iztapalapa', 9200, 19.378655, -99.256373, 'Revolución Social MZ10 LT37, Constitución de 1917, Iztapalapa, 09200 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (97, 9, 'Granate 30', ' La Estrella', ' Gustavo A. Madero', 7810, 19.387566, -99.076382, 'Granate 30, La Estrella, Gustavo A. Madero, 07810 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (98, 9, '625 205-207', ' San Juan de Aragón 4a Sección', ' Gustavo A. Madero', 7979, 19.333565, -99.107363, '625 205-207, San Juan de Aragón 4a Sección, Gustavo A. Madero, 07979 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (99, 9, 'Norte 76 3725', ' La Joya', ' Gustavo A. Madero', 7890, 19.474655, -99.126383, 'Norte 76 3725, La Joya, Gustavo A. Madero, 07890 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (100, 9, 'Norte 17-A 5254', ' Nueva Vallejo', ' Gustavo A. Madero', 7750, 19.458655, -99.226363, 'Norte 17-A 5254, Nueva Vallejo, Gustavo A. Madero, 07750 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (101, 9, 'Eje 1 Oriente F.C. Hidalgo 2301', ' La Joyita', ' Gustavo A. Madero', 7850, 19.353666, -99.147363, 'Eje 1 Oriente F.C. Hidalgo 2301, La Joyita, Gustavo A. Madero, 07850 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (102, 9, 'Norte 75 2720', ' Obrero Popular', ' Azcapotzalco', 2840, 19.359566, -99.137383, 'Norte 75 2720, Obrero Popular, Azcapotzalco, 02840 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (103, 9, 'Vía Express Tapo *(VISUAL)', ' Aeropuerto Int de La Ciudad de México', ' Venustiano Carranza', 15620, 19.466666, -99.046352, 'Vía Express Tapo *(VISUAL), Aeropuerto Int de La Ciudad de México, Venustiano Carranza, 15620 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (104, 9, 'Josué Escobedo', ' U Habitacional Vicente Guerrero I II ÌII IV V VI VII', ' Iztapalapa', 9200, 19.446556, -99.206353, 'Josué Escobedo, U Habitacional Vicente Guerrero I II ÌII IV V VI VII, Iztapalapa, 09200 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (105, 9, 'Eje 5 Sur (Prol. Marcelino Buendía)', ' Chinampac de Juárez', ' Iztapalapa', 9208, 19.426566, -99.156352, 'Eje 5 Sur (Prol. Marcelino Buendía), Chinampac de Juárez, Iztapalapa, 09208 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (106, 9, 'Santa Rosa 673', ' Valle Gómez', ' Venustiano Carranza', 15210, 19.377665, -99.116372, 'Santa Rosa 673, Valle Gómez, Venustiano Carranza, 15210 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (107, 9, 'San Diego', ' San Bartolo Ameyalco', ' Álvaro Obregón', 1800, 19.439656, -99.177373, 'San Diego, San Bartolo Ameyalco, Álvaro Obregón, 01800 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (108, 9, '2 E.Rosas MZ12 LT16', ' U Habitacional Vicente Guerrero I II ÌII IV V VI VII', ' Iztapalapa', 9200, 19.439656, -99.177373, '2 E.Rosas MZ12 LT16, U Habitacional Vicente Guerrero I II ÌII IV V VI VII, Iztapalapa, 09200 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (109, 9, 'Malintzin 46', ' Aragón La Villa(Aragón)', ' Gustavo A. Madero', 7000, 19.442665, -99.107372, 'Malintzin 46, Aragón La Villa(Aragón), Gustavo A. Madero, 07000 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (110, 9, 'Calle 1 39', ' Cuchilla Pantitlan', ' Venustiano Carranza', 15610, 19.442665, -99.107372, 'Calle 1 39, Cuchilla Pantitlan, Venustiano Carranza, 15610 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (111, 9, 'Mario Pani 200', ' Santa Fe', ' Cuajimalpa', 5109, 19.442665, -99.107372, 'Mario Pani 200, Santa Fe, Cuajimalpa, 05109 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (112, 9, 'Calzada Ings. Militares', ' San Lorenzo Tlaltenango', ' Miguel Hidalgo', 11219, 19.488655, -99.057383, 'Calzada Ings. Militares, San Lorenzo Tlaltenango, Miguel Hidalgo, 11219 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (113, 9, 'Avenida Vasco de Quiroga', ' Zedec Santa Fe', ' Álvaro Obregón', 1219, 19.488655, -99.057383, 'Avenida Vasco de Quiroga, Zedec Santa Fe, Álvaro Obregón, 01219 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (114, 9, 'Lázaro Cárdenas 12', ' Zacatepec', ' Iztapalapa', 9560, 19.366655, -99.217373, 'Lázaro Cárdenas 12, Zacatepec, Iztapalapa, 09560 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (115, 9, 'Pajuil 49', ' Ave Real', ' Álvaro Obregón', 1560, 19.366655, -99.217373, 'Pajuil 49, Ave Real, Álvaro Obregón, 01560 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (116, 9, 'Jesús Gaona 21', ' Moctezuma 1a Sección', ' Venustiano Carranza', 15500, 19.366655, -99.217373, 'Jesús Gaona 21, Moctezuma 1a Sección, Venustiano Carranza, 15500 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (117, 9, 'Lago Caneguín 130', ' Argentina Antigua', ' Miguel Hidalgo', 11270, 19.328655, -99.056363, 'Lago Caneguín 130, Argentina Antigua, Miguel Hidalgo, 11270 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (118, 9, 'Pozos MZ29 LT10', ' Buenavista', ' Iztapalapa', 9700, 19.328655, -99.056363, 'Pozos MZ29 LT10, Buenavista, Iztapalapa, 09700 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (119, 9, 'Rincón de Las Lomas 127', ' Lomas de Vista Hermosa', ' Cuajimalpa', 5100, 19.328655, -99.056363, 'Rincón de Las Lomas 127, Lomas de Vista Hermosa, Cuajimalpa, 05100 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (120, 9, 'Minerva 803', ' Florida', ' Benito Juarez', 1030, 19.444566, -99.256372, 'Minerva 803, Florida, Benito Juarez, 01030 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (121, 9, 'Motolinía 4', ' Centro', ' Cuauhtémoc', 6000, 19.446555, -99.256363, 'Motolinía 4, Centro, Cuauhtémoc, 06000 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (122, 9, 'Luis González Obregón', ' Zona Urbana Ejidal Santa María Aztahuacan', ' Iztapalapa', 9570, 19.353555, -99.027353, 'Luis González Obregón, Zona Urbana Ejidal Santa María Aztahuacan, Iztapalapa, 09570 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (123, 9, 'Moldeadores 328', ' Pro Hogar', ' Azcapotzalco', 2600, 19.353555, -99.027353, 'Moldeadores 328, Pro Hogar, Azcapotzalco, 02600 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (124, 9, 'General Guadalupe Victoria 58', ' 15 de Agosto', ' Gustavo A. Madero', 7050, 19.353555, -99.027353, 'General Guadalupe Victoria 58, 15 de Agosto, Gustavo A. Madero, 07050 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (125, 9, 'Avenida Telecomunicaciones', ' Unidad Habitacional Guelatao de Juárez II', ' Iztapalapa', 9208, 19.364656, -99.177373, 'Avenida Telecomunicaciones, Unidad Habitacional Guelatao de Juárez II, Iztapalapa, 09208 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (126, 9, 'Estorninos', ' Lomas de Las Águilas', ' Álvaro Obregón', 1759, 19.364656, -99.177373, 'Estorninos, Lomas de Las Águilas, Álvaro Obregón, 01759 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (127, 9, '3a. Cerrada Torres Tepito', ' San Bartolo Ameyalco', ' Álvaro Obregón', 1800, 19.364656, -99.177373, '3a. Cerrada Torres Tepito, San Bartolo Ameyalco, Álvaro Obregón, 01800 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (128, 9, 'Arteaga y Salazar', ' El Contadero', ' Cuajimalpa', 5230, 19.383655, -99.056373, 'Arteaga y Salazar, El Contadero, Cuajimalpa, 05230 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (129, 9, '2 E.Rosas MZ12 LT15', ' U Habitacional Vicente Guerrero I II ÌII IV V VI VII', ' Iztapalapa', 9200, 19.383655, -99.056373, '2 E.Rosas MZ12 LT15, U Habitacional Vicente Guerrero I II ÌII IV V VI VII, Iztapalapa, 09200 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (130, 9, 'Licenciado Sánchez Cordero MZ2 LT3', ' Tlacuitlapa Ampliación 2o. Reacomodo', ' Álvaro Obregón', 1650, 19.458665, -99.247363, 'Licenciado Sánchez Cordero MZ2 LT3, Tlacuitlapa Ampliación 2o. Reacomodo, Álvaro Obregón, 01650 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (131, 9, '4a. Cerrada', ' La Magdalena Culhuacan', ' Coyoacán', 4260, 19.458665, -99.247363, '4a. Cerrada, La Magdalena Culhuacan, Coyoacán, 04260 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (132, 9, 'Lucio Blanco', ' Rosendo Salazar', ' Azcapotzalco', 2400, 19.458665, -99.247363, 'Lucio Blanco, Rosendo Salazar, Azcapotzalco, 02400 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (133, 9, 'Leibnitz 44A', ' Anzures', ' Miguel Hidalgo', 11590, 19.458665, -99.247363, 'Leibnitz 44A, Anzures, Miguel Hidalgo, 11590 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (134, 9, 'Misioneros 23', ' Centro', ' Cuauhtémoc', 6000, 19.434555, -99.136362, 'Misioneros 23, Centro, Cuauhtémoc, 06000 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (135, 9, 'Norte 1', ' Cuchilla del Tesoro', ' Gustavo A. Madero', 7900, 19.434555, -99.136362, 'Norte 1, Cuchilla del Tesoro, Gustavo A. Madero, 07900 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (136, 9, 'Pozos MZ29 LT10', ' Buenavista', ' Iztapalapa', 9700, 19.434555, -99.136362, 'Pozos MZ29 LT10, Buenavista, Iztapalapa, 09700 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (137, 9, 'Iztaccihuatl', ' San Juan Joya', ' Iztapalapa', 9839, 19.333555, -99.146372, 'Iztaccihuatl, San Juan Joya, Iztapalapa, 09839 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (138, 9, 'San Pedro 151(89)', ' Del Carmen', ' Coyoacán', 4100, 19.333555, -99.146372, 'San Pedro 151(89), Del Carmen, Coyoacán, 04100 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (139, 9, 'Amacuzac 499', ' El Retoño', ' Iztapalapa', 9440, 19.466565, -99.107353, 'Amacuzac 499, El Retoño, Iztapalapa, 09440 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (140, 9, 'Minas', ' Lomas de La Estancia', ' Iztapalapa', 9640, 19.466565, -99.107353, 'Minas, Lomas de La Estancia, Iztapalapa, 09640 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (141, 9, 'Bosque de Limas 1', ' Bosques de Las Lomas', ' Cuajimalpa', 5120, 19.466565, -99.107353, 'Bosque de Limas 1, Bosques de Las Lomas, Cuajimalpa, 05120 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (142, 9, 'Amacuzac 245', ' Santiago Sur', ' Iztacalco', 8800, 19.444556, -99.007372, 'Amacuzac 245, Santiago Sur, Iztacalco, 08800 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (143, 9, 'Pennsylvania 214', ' Ampliación Nápoles', ' Benito Juarez', 3840, 19.444556, -99.007372, 'Pennsylvania 214, Ampliación Nápoles, Benito Juarez, 03840 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (144, 9, 'Emma', ' Nativitas', ' Benito Juarez', 3500, 19.467655, -99.127373, 'Emma, Nativitas, Benito Juarez, 03500 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (145, 9, 'Paseo de Alcázar', ' La Loma', ' Álvaro Obregón', 1260, 19.467655, -99.127373, 'Paseo de Alcázar, La Loma, Álvaro Obregón, 01260 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (146, 9, 'Calzada Melchor Ocampo 43', ' Tlaxpana', ' Miguel Hidalgo', 11370, 19.467655, -99.127373, 'Calzada Melchor Ocampo 43, Tlaxpana, Miguel Hidalgo, 11370 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (147, 9, 'Eusebio Jáuregui 264', ' Ampliación San Pedro Xalpa', ' Azcapotzalco', 2719, 19.384665, -99.116383, 'Eusebio Jáuregui 264, Ampliación San Pedro Xalpa, Azcapotzalco, 02719 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (148, 9, 'Secretaría de Marina 491', ' Lomas de Vista Hermosa', ' Cuajimalpa', 5100, 19.342555, -99.047353, 'Secretaría de Marina 491, Lomas de Vista Hermosa, Cuajimalpa, 05100 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (149, 9, 'Norte 15-A 5264', ' Nueva Vallejo', ' Gustavo A. Madero', 7750, 19.342555, -99.047353, 'Norte 15-A 5264, Nueva Vallejo, Gustavo A. Madero, 07750 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (150, 9, 'F. C. Industrial', ' Vallejo', ' Gustavo A. Madero', 7870, 19.342555, -99.047353, 'F. C. Industrial, Vallejo, Gustavo A. Madero, 07870 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (151, 9, 'Emma', ' Del Carmen', ' Benito Juarez', 3500, 19.368655, -99.006383, 'Emma, Del Carmen, Benito Juarez, 03500 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (152, 9, 'Volcán Ajusco 142', ' La Pradera', ' Gustavo A. Madero', 7500, 19.368655, -99.006383, 'Volcán Ajusco 142, La Pradera, Gustavo A. Madero, 07500 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (153, 9, 'Edo. de Querétaro 116', ' Providencia', ' Gustavo A. Madero', 7550, 19.368655, -99.006383, 'Edo. de Querétaro 116, Providencia, Gustavo A. Madero, 07550 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (154, 9, 'Anillo Periférico MZ1 LT55', ' U Habitacional Vicente Guerrero I II ÌII IV V VI VII', ' Iztapalapa', 9200, 19.343555, -99.147382, 'Anillo Periférico MZ1 LT55, U Habitacional Vicente Guerrero I II ÌII IV V VI VII, Iztapalapa, 09200 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (155, 9, '2o. Andador Tamaulipas 53', ' De Santa Lucía', ' Álvaro Obregón', 15000, 19.343555, -99.147382, '2o. Andador Tamaulipas 53, De Santa Lucía, Álvaro Obregón, 15000 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (156, 9, '25 292', ' San Miguel Amantla', ' Azcapotzalco', 2600, 19.343565, -99.157362, '25 292, San Miguel Amantla, Azcapotzalco, 02600 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (157, 9, 'Canal Nacional', ' La Magdalena Culhuacan', ' Coyoacán', 4260, 19.343565, -99.157362, 'Canal Nacional, La Magdalena Culhuacan, Coyoacán, 04260 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (158, 9, 'Mimosa 33', ' Olivar de Los Padres', ' Álvaro Obregón', 1780, 19.343565, -99.157362, 'Mimosa 33, Olivar de Los Padres, Álvaro Obregón, 01780 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (159, 9, 'Eje 5 Sur (Prol. Marcelino Buendía)', ' Chinampac de Juárez', ' Iztapalapa', 9208, 19.375665, -99.267353, 'Eje 5 Sur (Prol. Marcelino Buendía), Chinampac de Juárez, Iztapalapa, 09208 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (160, 9, '1 MZ22LT25B', ' La Martinica', ' Álvaro Obregón', 1690, 19.383566, -99.017373, '1 MZ22LT25B, La Martinica, Álvaro Obregón, 01690 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (161, 9, 'Sur 69', ' Banjidal', ' Iztapalapa', 9440, 19.383566, -99.017373, 'Sur 69, Banjidal, Iztapalapa, 09440 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (162, 9, 'F C Hidalgo', ' Felipe Pescador', ' Cuauhtémoc', 6280, 19.383566, -99.017373, 'F C Hidalgo, Felipe Pescador, Cuauhtémoc, 06280 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (163, 9, 'Del Vergel', ' Lomas de San Angel Inn', ' Álvaro Obregón', 1790, 19.335566, -99.077383, 'Del Vergel, Lomas de San Angel Inn, Álvaro Obregón, 01790 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (164, 9, 'Calle 63 98', ' Santa Cruz Meyehualco', ' Iztapalapa', 9290, 19.448566, -99.157373, 'Calle 63 98, Santa Cruz Meyehualco, Iztapalapa, 09290 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (165, 9, 'Pirules', ' El Tanque', ' Magdalena Contreras', 10320, 19.448566, -99.157373, 'Pirules, El Tanque, Magdalena Contreras, 10320 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (166, 9, 'Paseo de la Reforma 155', ' Guerrero', ' Cuauhtémoc', 6500, 19.475555, -99.247383, 'Paseo de la Reforma 155, Guerrero, Cuauhtémoc, 06500 Cuauhtémoc, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (167, 9, 'Calle Tarango', ' San Clemente Norte', ' Álvaro Obregón', 1740, 19.432566, -99.016352, 'Calle Tarango, San Clemente Norte, Álvaro Obregón, 01740 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (168, 9, 'Camino Viejo a Mixcoac 3525', ' San Bartolo Ameyalco', ' Álvaro Obregón', 1800, 19.432566, -99.016352, 'Camino Viejo a Mixcoac 3525, San Bartolo Ameyalco, Álvaro Obregón, 01800 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (169, 9, 'Cofre de Perote 325', ' Lomas de Chapultepec', ' Miguel Hidalgo', 11000, 19.383566, -99.126373, 'Cofre de Perote 325, Lomas de Chapultepec, Miguel Hidalgo, 11000 Mexico City, State of Mexico, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (170, 9, 'Zaragoza 16', ' De Santa Lucía', ' Álvaro Obregón', 1509, 19.383566, -99.126373, 'Zaragoza 16, De Santa Lucía, Álvaro Obregón, 01509 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (171, 9, 'Avenida de las Minas', ' Xalpa', ' Iztapalapa', 9640, 19.383566, -99.126373, 'Avenida de las Minas, Xalpa, Iztapalapa, 09640 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (172, 9, 'Canadá Los Helechos 435-436', ' San Mateo Tlaltenango', ' Cuajimalpa', 5600, 19.458565, -99.006362, 'Canadá Los Helechos 435-436, San Mateo Tlaltenango, Cuajimalpa, 05600 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (173, 9, 'Plaza Fray Bartolomé de Las Casas 38', ' Barrio de Tepito', ' Cuauhtémoc', 6200, 19.388565, -99.157363, 'Plaza Fray Bartolomé de Las Casas 38, Barrio de Tepito, Cuauhtémoc, 06200 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (174, 9, 'Santa María La Ribera 85', ' Santa María La Ribera', ' Cuauhtémoc', 6400, 19.483666, -99.277372, 'Santa María La Ribera 85, Santa María La Ribera, Cuauhtémoc, 06400 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (175, 9, 'Wake 183', ' Libertad', ' Azcapotzalco', 2060, 19.343566, -99.126353, 'Wake 183, Libertad, Azcapotzalco, 02060 Distrito Federal, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (176, 9, 'Nevado 111', ' Portales', ' Benito Juarez', 3300, 19.362665, -99.137373, 'Nevado 111, Portales, Benito Juarez, 03300 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (177, 9, 'General G. Hernández 9', ' Doctores', ' Cuauhtémoc', 6720, 19.362665, -99.137373, 'General G. Hernández 9, Doctores, Cuauhtémoc, 06720 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (178, 9, 'Calle 4', ' San Miguel Amantla', ' Azcapotzalco', 2970, 19.435566, -99.266353, 'Calle 4, San Miguel Amantla, Azcapotzalco, 02970 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (179, 9, 'Rincón de Las Lomas 127', ' Lomas de Vista Hermosa', ' Cuajimalpa', 5100, 19.434566, -99.216363, 'Rincón de Las Lomas 127, Lomas de Vista Hermosa, Cuajimalpa, 05100 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (180, 9, 'Norte 80 4227', ' La Malinche', ' Gustavo A. Madero', 7899, 19.423656, -99.267383, 'Norte 80 4227, La Malinche, Gustavo A. Madero, 07899 Gustavo a madero, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (181, 9, 'Autopista México-Marquesa', ' Zedec Santa Fe', ' Álvaro Obregón', 1219, 19.423656, -99.267383, 'Autopista México-Marquesa, Zedec Santa Fe, Álvaro Obregón, 01219 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (182, 9, 'Rómulo Escobar Zerman 139', ' Industrial', ' Gustavo A. Madero', 7800, 19.352665, -99.047352, 'Rómulo Escobar Zerman 139, Industrial, Gustavo A. Madero, 07800 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (183, 9, 'Cuauhtémoc', ' El Paraíso', ' Iztapalapa', 9230, 19.329555, -99.066352, 'Cuauhtémoc, El Paraíso, Iztapalapa, 09230 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (184, 9, '623 154', ' San Juan de Aragón 4a Sección', ' Gustavo A. Madero', 7979, 19.453556, -99.246372, '623 154, San Juan de Aragón 4a Sección, Gustavo A. Madero, 07979 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (185, 9, 'Quintana Roo 21-23', ' Villa Gustavo a Madero', ' Gustavo A. Madero', 7050, 19.453556, -99.246372, 'Quintana Roo 21-23, Villa Gustavo a Madero, Gustavo A. Madero, 07050 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (186, 9, 'Paseo Tolsa 509', ' San Mateo Tlaltenango', ' Cuajimalpa', 5600, 19.382556, -99.136362, 'Paseo Tolsa 509, San Mateo Tlaltenango, Cuajimalpa, 05600 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (187, 9, '20 de Noviembre', ' Palmitas', ' Iztapalapa', 9670, 19.359655, -99.227382, '20 de Noviembre, Palmitas, Iztapalapa, 09670 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (188, 9, 'Grabados 318', ' 2do Tramo 20 de Noviembre', ' Venustiano Carranza', 15300, 19.367565, -99.267372, 'Grabados 318, 2do Tramo 20 de Noviembre, Venustiano Carranza, 15300 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (189, 9, 'Hortensia 517', ' Los Angeles', ' Iztapalapa', 9839, 19.469655, -99.026382, 'Hortensia 517, Los Angeles, Iztapalapa, 09839 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (190, 9, 'Calle Igancio Allende 25', ' Zacatepec', ' Iztapalapa', 9560, 19.436665, -99.007363, 'Calle Igancio Allende 25, Zacatepec, Iztapalapa, 09560 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (191, 9, 'Demetrio', ' Independencia San Ramón', ' Magdalena Contreras', 10100, 19.354656, -99.166372, 'Demetrio, Independencia San Ramón, Magdalena Contreras, 10100 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (192, 9, 'La Colina', ' Lomas de Vista Hermosa', ' Cuajimalpa', 5100, 19.354656, -99.166372, 'La Colina, Lomas de Vista Hermosa, Cuajimalpa, 05100 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (193, 9, 'América 319', ' Los Reyes', ' Barrio del Niño Jesús', 4330, 19.483565, -99.277383, 'América 319, Los Reyes, Barrio del Niño Jesús, 04330 Coyoacán, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (194, 9, 'Providencia 65', ' Axotla', ' Álvaro Obregón', 1030, 19.462565, -99.117372, 'Providencia 65, Axotla, Álvaro Obregón, 01030 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (195, 9, 'Calle 17 64', ' Santa Cruz Meyehualco', ' Iztapalapa', 9290, 19.467665, -99.177373, 'Calle 17 64, Santa Cruz Meyehualco, Iztapalapa, 09290 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (196, 9, 'Avenida Vasco de Quiroga', ' Zedec Santa Fe', ' Álvaro Obregón', 1219, 19.364665, -99.026363, 'Avenida Vasco de Quiroga, Zedec Santa Fe, Álvaro Obregón, 01219 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (197, 9, 'Calle Naranjo 346', ' Atlampa', ' Cuauhtémoc', 6450, 19.337565, -99.256383, 'Calle Naranjo 346, Atlampa, Cuauhtémoc, 06450 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (198, 9, 'Calle 7', ' Lomas de Sotelo', ' Miguel Hidalgo', 11200, 19.486666, -99.267363, 'Calle 7, Lomas de Sotelo, Miguel Hidalgo, 11200 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (199, 9, 'Ceylan 470B', ' San Miguel Amantla', ' Miguel Hidalgo', 2520, 19.439555, -99.076363, 'Ceylan 470B, San Miguel Amantla, Miguel Hidalgo, 02520 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (200, 9, 'Calle Madrid 18', ' Tabacalera', ' Cuauhtémoc', 6030, 19.326656, -99.227373, 'Calle Madrid 18, Tabacalera, Cuauhtémoc, 06030 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (201, 9, 'Monte de Las Cruces 42', ' La Pradera', ' Gustavo A. Madero', 7500, 19.322665, -99.156373, 'Monte de Las Cruces 42, La Pradera, Gustavo A. Madero, 07500 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (202, 9, 'Eusebio Jáuregui 264', ' Ampliación San Pedro Xalpa', ' Azcapotzalco', 2719, 19.343566, -99.206353, 'Eusebio Jáuregui 264, Ampliación San Pedro Xalpa, Azcapotzalco, 02719 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (203, 9, 'Primavera', ' Tepalcates', ' Iztapalapa', 9210, 19.454565, -99.107363, 'Primavera, Tepalcates, Iztapalapa, 09210 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (204, 9, 'Eje 3 Norte Av. Cuitláhuac 3325', ' Obrero Popular', ' Azcapotzalco', 2840, 19.359656, -99.176363, 'Eje 3 Norte Av. Cuitláhuac 3325, Obrero Popular, Azcapotzalco, 02840 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (205, 9, 'Batallón de Zacapoaxtla 8', ' Ejército de Oriente Indeco II ISSSTE', ' Ejercito de Oriente', 9230, 19.324655, -99.076373, 'Batallón de Zacapoaxtla 8, Ejército de Oriente Indeco II ISSSTE, Ejercito de Oriente, 09230 Iztapalapa, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (206, 9, 'Bosque de Tabachines 212', ' Bosques de Las Lomas', ' Cuajimalpa', 5120, 19.375556, -99.206382, 'Bosque de Tabachines 212, Bosques de Las Lomas, Cuajimalpa, 05120 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (207, 9, 'Primavera MZ3 LTSN', ' 2da Ampliación Santiago Acahualtepec', ' Iztapalapa', 9609, 19.464656, -99.226372, 'Primavera MZ3 LTSN, 2da Ampliación Santiago Acahualtepec, Iztapalapa, 09609 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (208, 9, 'Cerro de La Juvencia 49', ' Campestre Churubusco', ' Coyoacán', 4200, 19.452566, -99.106383, 'Cerro de La Juvencia 49, Campestre Churubusco, Coyoacán, 04200 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (209, 9, 'Santa Fe 453', ' Lomas de Santa Fe', ' Cuajimalpa', 1219, 19.429566, -99.237373, 'Santa Fe 453, Lomas de Santa Fe, Cuajimalpa, 01219 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (210, 9, 'Camino de La Amistad a 3', ' Campestre Aragón', ' Gustavo A. Madero', 7530, 19.428556, -99.256373, 'Camino de La Amistad a 3, Campestre Aragón, Gustavo A. Madero, 07530 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (211, 9, 'Constitución de Apatzingán', ' Tepalcates', ' Iztapalapa', 9210, 19.388566, -99.126372, 'Constitución de Apatzingán, Tepalcates, Iztapalapa, 09210 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (212, 9, 'Avenida Tamaulipas 1240', ' Piru Xocomecatla', ' Álvaro Obregón', 1530, 19.434565, -99.137373, 'Avenida Tamaulipas 1240, Piru Xocomecatla, Álvaro Obregón, 01530 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (213, 9, 'Zanja 22', ' San Mateo Tlaltenango', ' Cuajimalpa', 5600, 19.329555, -99.166353, 'Zanja 22, San Mateo Tlaltenango, Cuajimalpa, 05600 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (214, 9, 'Concepción Beistegui 1465', ' Del Valle', ' Benito Juarez', 3020, 19.349655, -99.036363, 'Concepción Beistegui 1465, Del Valle, Benito Juarez, 03020 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (215, 9, 'Plan de Ayala', ' Hank González', ' Iztapalapa', 9700, 19.345666, -99.007353, 'Plan de Ayala, Hank González, Iztapalapa, 09700 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (216, 9, 'Avenida Universidad 1499', ' Axotla', ' Álvaro Obregón', 1030, 19.437556, -99.006383, 'Avenida Universidad 1499, Axotla, Álvaro Obregón, 01030 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (217, 9, 'Benito Juárez 7', ' Del Carmen', ' Coyoacán', 4100, 19.435565, -99.067363, 'Benito Juárez 7, Del Carmen, Coyoacán, 04100 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (218, 9, 'Jacarandas', ' San Jerónimo Lídice', ' Magdalena Contreras', 10200, 19.365566, -99.176363, 'Jacarandas, San Jerónimo Lídice, Magdalena Contreras, 10200 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (219, 9, 'Corina 53', ' Del Carmen', ' Coyoacán', 4100, 19.365566, -99.176363, 'Corina 53, Del Carmen, Coyoacán, 04100 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (220, 9, 'Corina 25', ' Del Carmen', ' Coyoacán', 4100, 19.338555, -99.227382, 'Corina 25, Del Carmen, Coyoacán, 04100 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (221, 9, 'Minerva 803', ' Florida', ' Benito Juarez', 1030, 19.338555, -99.227382, 'Minerva 803, Florida, Benito Juarez, 01030 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (222, 9, 'Allende 18', ' Norte', ' Álvaro Obregón', 1410, 19.389656, -99.267383, 'Allende 18, Norte, Álvaro Obregón, 01410 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (223, 9, 'Plutarco Elías Calles', ' Chinampac de Juárez', ' Iztapalapa', 9208, 19.389656, -99.267383, 'Plutarco Elías Calles, Chinampac de Juárez, Iztapalapa, 09208 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (224, 9, 'Avenida Carlos Lazo', ' Reserva Ecológica Torres de Potrero', ' Álvaro Obregón', 1848, 19.389656, -99.267383, 'Avenida Carlos Lazo, Reserva Ecológica Torres de Potrero, Álvaro Obregón, 01848 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (225, 9, 'Calle 71', ' Santa Cruz Meyehualco', ' Iztapalapa', 9290, 19.472566, -99.227353, 'Calle 71, Santa Cruz Meyehualco, Iztapalapa, 09290 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (226, 9, '1ra Hidalgo', ' Zona Urbana Ejidal San Andrés Tomatlan', ' Iztapalapa', 9870, 19.472566, -99.227353, '1ra Hidalgo, Zona Urbana Ejidal San Andrés Tomatlan, Iztapalapa, 09870 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (227, 9, 'Francisco J. Serrano 104', ' Lomas de Santa Fe', ' Desarrolo Urbano Santa Fe', 5348, 19.386666, -99.117352, 'Francisco J. Serrano 104, Lomas de Santa Fe, Desarrolo Urbano Santa Fe, 05348 Cuajimalpa de Morelos, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (228, 9, 'Cofre de Perote 325', ' Lomas de Chapultepec', ' Miguel Hidalgo', 11000, 19.386666, -99.117352, 'Cofre de Perote 325, Lomas de Chapultepec, Miguel Hidalgo, 11000 Mexico City, State of Mexico, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (229, 9, 'Cruz Gálvez', ' Nueva Santa María', ' Azcapotzalco', 2800, 19.326656, -99.157372, 'Cruz Gálvez, Nueva Santa María, Azcapotzalco, 02800 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (230, 9, 'Insurgentes Norte 1020', ' Tlacamaca', ' Gustavo A. Madero', 7380, 19.326656, -99.157372, 'Insurgentes Norte 1020, Tlacamaca, Gustavo A. Madero, 07380 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (231, 9, 'Avenida de las Torres', ' Los Padres', ' Magdalena Contreras', 10340, 19.326656, -99.157372, 'Avenida de las Torres, Los Padres, Magdalena Contreras, 10340 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (232, 9, 'Eje 2 Poniente Gabriel Mancera 1270', ' Del Valle', ' Benito Juarez', 3100, 19.379656, -99.107352, 'Eje 2 Poniente Gabriel Mancera 1270, Del Valle, Benito Juarez, 03100 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (233, 9, 'Calle 10 41', ' Heron Proal', ' Álvaro Obregón', 1640, 19.379656, -99.107352, 'Calle 10 41, Heron Proal, Álvaro Obregón, 01640 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (234, 9, 'Vía Express Tapo', ' Aeropuerto Int de La Ciudad de México', ' Venustiano Carranza', 15620, 19.362556, -99.136362, 'Vía Express Tapo, Aeropuerto Int de La Ciudad de México, Venustiano Carranza, 15620 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (235, 9, 'Isabel la Católica 116', ' Centro', ' Cuauhtémoc', 6000, 19.362556, -99.136362, 'Isabel la Católica 116, Centro, Cuauhtémoc, 06000 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (236, 9, 'Maíz 263', ' Valle del Sur', ' Iztapalapa', 9819, 19.336666, -99.237363, 'Maíz 263, Valle del Sur, Iztapalapa, 09819 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (237, 9, 'Villa Pozos', ' Desarrollo Urbano Quetzalcoatl', ' Iztapalapa', 9700, 19.358656, -99.056353, 'Villa Pozos, Desarrollo Urbano Quetzalcoatl, Iztapalapa, 09700 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (238, 9, 'Circuito', ' Olivar de Los Padres', ' Álvaro Obregón', 1780, 19.337665, -99.066352, 'Circuito, Olivar de Los Padres, Álvaro Obregón, 01780 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (239, 9, 'Carlos David Anderson MZ 1 LT B', ' Culhuacan', ' Iztapalapa', 9800, 19.436665, -99.036353, 'Carlos David Anderson MZ 1 LT B, Culhuacan, Iztapalapa, 09800 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (240, 9, 'Calle Naranjo 267', ' Santa María La Ribera', ' Cuauhtémoc', 11320, 19.436665, -99.036353, 'Calle Naranjo 267, Santa María La Ribera, Cuauhtémoc, 11320 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (241, 9, 'España 77', ' Cerro de La Estrella', ' Iztapalapa', 9860, 19.449656, -99.266363, 'España 77, Cerro de La Estrella, Iztapalapa, 09860 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (242, 9, 'Vía Express Tapo', ' Aeropuerto Int de La Ciudad de México', ' Venustiano Carranza', 15620, 19.449656, -99.266363, 'Vía Express Tapo, Aeropuerto Int de La Ciudad de México, Venustiano Carranza, 15620 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (243, 9, 'Manuel Acuña', ' Palmitas', ' Iztapalapa', 9670, 19.326556, -99.277362, 'Manuel Acuña, Palmitas, Iztapalapa, 09670 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (244, 9, 'Avenida Tlahuac 220', ' Zona Urbana Ejidal Los Reyes Culhuacan', ' Iztapalapa', 9820, 19.478665, -99.166352, 'Avenida Tlahuac 220, Zona Urbana Ejidal Los Reyes Culhuacan, Iztapalapa, 09820 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (245, 9, 'Orion 112', ' Prado Churubusco', ' Coyoacán', 4230, 19.478665, -99.166352, 'Orion 112, Prado Churubusco, Coyoacán, 04230 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (246, 9, 'Cascada 420', ' Jardines del Pedregal', ' Álvaro Obregón', 1900, 19.478665, -99.166352, 'Cascada 420, Jardines del Pedregal, Álvaro Obregón, 01900 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (247, 9, 'Amores 923', ' Del Valle', ' Benito Juarez', 3100, 19.478665, -99.166352, 'Amores 923, Del Valle, Benito Juarez, 03100 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (248, 9, 'Miguel Laurent 17', ' Del Valle', ' Benito Juarez', 3100, 19.355666, -99.106352, 'Miguel Laurent 17, Del Valle, Benito Juarez, 03100 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (249, 9, 'Eje 1 Poniente', ' Guerrero', ' Cuauhtémoc', 6300, 19.437556, -99.167353, 'Eje 1 Poniente, Guerrero, Cuauhtémoc, 06300 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (250, 9, 'General Vicente Guerrero 28', ' 15 de Agosto', ' Gustavo A. Madero', 7050, 19.437556, -99.167353, 'General Vicente Guerrero 28, 15 de Agosto, Gustavo A. Madero, 07050 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (251, 9, 'R. Figueroa 5', ' Álvaro Obregón', ' Iztapalapa', 9230, 19.437556, -99.167353, 'R. Figueroa 5, Álvaro Obregón, Iztapalapa, 09230 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (252, 9, 'Cadereyta MZ C LT26', ' Lomas de Becerra', ' Álvaro Obregón', 1279, 19.464566, -99.226383, 'Cadereyta MZ C LT26, Lomas de Becerra, Álvaro Obregón, 01279 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (253, 9, 'Minerva 803', ' Florida', ' Benito Juarez', 1030, 19.464566, -99.226383, 'Minerva 803, Florida, Benito Juarez, 01030 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (254, 9, 'Eje 5 Sur (Prol. Marcelino Buendía)', ' Cabeza de Juárez VI', ' Iztapalapa', 9225, 19.464566, -99.226383, 'Eje 5 Sur (Prol. Marcelino Buendía), Cabeza de Juárez VI, Iztapalapa, 09225 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (255, 9, 'Profra. Aurora Reza 20', ' Los Reyes', ' Coyoacán', 4330, 19.452666, -99.077353, 'Profra. Aurora Reza 20, Los Reyes, Coyoacán, 04330 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (256, 9, 'Constitución de Apatzingán', ' Tepalcates', ' Iztapalapa', 9210, 19.452666, -99.077353, 'Constitución de Apatzingán, Tepalcates, Iztapalapa, 09210 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (257, 9, 'Calle Dinamarca', ' Juárez', ' Cuauhtémoc', 6600, 19.333555, -99.017352, 'Calle Dinamarca, Juárez, Cuauhtémoc, 06600 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (258, 9, 'Sur 129 8', ' Minerva', ' Iztapalapa', 9810, 19.333555, -99.017352, 'Sur 129 8, Minerva, Iztapalapa, 09810 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (259, 9, '2', ' Olivar de Los Padres', ' Álvaro Obregón', 1780, 19.333555, -99.017352, '2, Olivar de Los Padres, Álvaro Obregón, 01780 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (260, 9, 'Bahía de San Hipólito', ' Anáhuac', ' Miguel Hidalgo', 11320, 19.445665, -99.116363, 'Bahía de San Hipólito, Anáhuac, Miguel Hidalgo, 11320 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (261, 9, 'Cerrada de Popocatépetl 36', ' Xoco', ' Benito Juarez', 3330, 19.322666, -99.027372, 'Cerrada de Popocatépetl 36, Xoco, Benito Juarez, 03330 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (262, 9, 'Calzada Legaria 585', ' Lomas de Sotelo', ' Irrigación', 11200, 19.322666, -99.027372, 'Calzada Legaria 585, Lomas de Sotelo, Irrigación, 11200 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (263, 9, 'Avenida las Flores', ' Flor de María', ' Álvaro Obregón', 1760, 19.373656, -99.166372, 'Avenida las Flores, Flor de María, Álvaro Obregón, 01760 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (264, 9, '20 de Noviembre', ' Palmitas', ' Iztapalapa', 9670, 19.388565, -99.246373, '20 de Noviembre, Palmitas, Iztapalapa, 09670 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (265, 9, 'Tlalmiminolpan', ' San Bartolo Ameyalco', ' Álvaro Obregón', 1800, 19.388565, -99.246373, 'Tlalmiminolpan, San Bartolo Ameyalco, Álvaro Obregón, 01800 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (266, 9, 'Alpes 650A', ' Lomas de Chapultepec', ' Miguel Hidalgo', 11000, 19.369566, -99.256382, 'Alpes 650A, Lomas de Chapultepec, Miguel Hidalgo, 11000 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (267, 9, 'Avenida Paseo de Los Jardines 100', ' Paseos de Taxqueña', ' Coyoacán', 4250, 19.369566, -99.256382, 'Avenida Paseo de Los Jardines 100, Paseos de Taxqueña, Coyoacán, 04250 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (268, 9, 'Rómulo Valdez Romero 144', ' Presidentes Ejidales', ' Coyoacán', 4470, 19.376565, -99.106383, 'Rómulo Valdez Romero 144, Presidentes Ejidales, Coyoacán, 04470 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (269, 9, 'Bélgica 815', ' Portales', ' Benito Juarez', 3300, 19.376565, -99.106383, 'Bélgica 815, Portales, Benito Juarez, 03300 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (270, 9, 'Avenida Paseo de Los Jardines 74', ' Paseos de Taxqueña', ' Coyoacán', 4250, 19.376565, -99.106383, 'Avenida Paseo de Los Jardines 74, Paseos de Taxqueña, Coyoacán, 04250 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (271, 9, 'Herminio Chavarría', ' Zona Urbana Ejidal Santa María Aztahuacan', ' Iztapalapa', 9570, 19.469555, -99.226362, 'Herminio Chavarría, Zona Urbana Ejidal Santa María Aztahuacan, Iztapalapa, 09570 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (272, 9, 'Francisco I. Madero', ' San Bartolo Ameyalco', ' Álvaro Obregón', 1800, 19.469555, -99.226362, 'Francisco I. Madero, San Bartolo Ameyalco, Álvaro Obregón, 01800 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (273, 9, 'Eje 6 Sur (Av. Michoacán)', ' Chinampac de Juárez', ' Iztapalapa', 9208, 19.359566, -99.167382, 'Eje 6 Sur (Av. Michoacán), Chinampac de Juárez, Iztapalapa, 09208 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (274, 9, 'Peñón', ' Morelos', ' Cuauhtémoc', 6200, 19.479565, -99.216362, 'Peñón, Morelos, Cuauhtémoc, 06200 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (275, 9, 'Avenida Telecomunicaciones', ' Chinampac de Juárez', ' Iztapalapa', 9208, 19.479565, -99.216362, 'Avenida Telecomunicaciones, Chinampac de Juárez, Iztapalapa, 09208 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (276, 9, 'Coquimbo 756', ' Lindavista', ' Gustavo A. Madero', 7300, 19.384656, -99.106353, 'Coquimbo 756, Lindavista, Gustavo A. Madero, 07300 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (277, 9, 'Fray Servando Teresa de Mier 356', ' Centro', ' Cuauhtémoc', 6090, 19.384656, -99.106353, 'Fray Servando Teresa de Mier 356, Centro, Cuauhtémoc, 06090 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (278, 9, '19 70B', ' San Miguel Amantla', ' Azcapotzalco', 2600, 19.373556, -99.206363, '19 70B, San Miguel Amantla, Azcapotzalco, 02600 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (279, 9, 'Madrid MZ55 LT82', ' Cerro de La Estrella', ' Iztapalapa', 9860, 19.373556, -99.206363, 'Madrid MZ55 LT82, Cerro de La Estrella, Iztapalapa, 09860 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (280, 9, 'Monte de Las Cruces 42', ' La Pradera', ' Gustavo A. Madero', 7500, 19.374665, -99.056353, 'Monte de Las Cruces 42, La Pradera, Gustavo A. Madero, 07500 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (281, 9, '508 199', ' San Juan de Aragón 4a Sección', ' Gustavo A. Madero', 7979, 19.354656, -99.137373, '508 199, San Juan de Aragón 4a Sección, Gustavo A. Madero, 07979 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (282, 9, 'Poniente 58 3909', ' Obrero Popular', ' Azcapotzalco', 2840, 19.354656, -99.137373, 'Poniente 58 3909, Obrero Popular, Azcapotzalco, 02840 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (283, 9, 'Xochitlán Norte 52', ' El Arenal 4a Sección', ' Venustiano Carranza', 15640, 19.484666, -99.006363, 'Xochitlán Norte 52, El Arenal 4a Sección, Venustiano Carranza, 15640 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (284, 9, 'Vía Tapo (Av. 602)', ' San Juan de Aragón 3a Sección', ' Gustavo A. Madero', 7970, 19.484666, -99.006363, 'Vía Tapo (Av. 602), San Juan de Aragón 3a Sección, Gustavo A. Madero, 07970 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (285, 9, 'Jesús Gaona 21', ' Moctezuma 1a Sección', ' Venustiano Carranza', 15500, 19.386565, -99.066353, 'Jesús Gaona 21, Moctezuma 1a Sección, Venustiano Carranza, 15500 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (286, 9, 'Puerto Obregón', ' Ampliación Piloto Adolfo López Mateos', ' Álvaro Obregón', 1298, 19.386565, -99.066353, 'Puerto Obregón, Ampliación Piloto Adolfo López Mateos, Álvaro Obregón, 01298 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (287, 9, 'San Borja 627', ' Del Valle', ' Benito Juarez', 3100, 19.348565, -99.207373, 'San Borja 627, Del Valle, Benito Juarez, 03100 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (288, 9, 'Cerro Dulce MZ4 LT17', ' Los Cedros Santa Lucía', ' Álvaro Obregón', 1870, 19.366656, -99.207352, 'Cerro Dulce MZ4 LT17, Los Cedros Santa Lucía, Álvaro Obregón, 01870 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (289, 9, 'Wisconsin 103', ' Ampliación Nápoles', ' Benito Juarez', 3810, 19.366656, -99.207352, 'Wisconsin 103, Ampliación Nápoles, Benito Juarez, 03810 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (290, 9, '5 de Mayo', ' Zona Urbana Ejidal Los Reyes Culhuacan', ' Iztapalapa', 9840, 19.472665, -99.277352, '5 de Mayo, Zona Urbana Ejidal Los Reyes Culhuacan, Iztapalapa, 09840 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (291, 9, 'Antonio Caso 49-53', ' Tabacalera', ' Cuauhtémoc', 6030, 19.329665, -99.247363, 'Antonio Caso 49-53, Tabacalera, Cuauhtémoc, 06030 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (292, 9, 'Moras 1260', ' Florida', ' Álvaro Obregón', 1030, 19.477556, -99.067352, 'Moras 1260, Florida, Álvaro Obregón, 01030 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (293, 9, '2 217', ' Granjas San Antonio', ' Iztapalapa', 9070, 19.326555, -99.227362, '2 217, Granjas San Antonio, Iztapalapa, 09070 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (294, 9, 'Río Madeira', ' Nueva Argentina (Argentina Poniente)', ' Miguel Hidalgo', 11230, 19.427556, -99.246363, 'Río Madeira, Nueva Argentina (Argentina Poniente), Miguel Hidalgo, 11230 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (295, 9, 'Alpes 650A', ' Lomas de Chapultepec', ' Miguel Hidalgo', 11000, 19.467566, -99.176353, 'Alpes 650A, Lomas de Chapultepec, Miguel Hidalgo, 11000 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (296, 9, 'Carlos David Anderson MZ 1 LT B', ' Culhuacan', ' Iztapalapa', 9800, 19.369666, -99.107352, 'Carlos David Anderson MZ 1 LT B, Culhuacan, Iztapalapa, 09800 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (297, 9, 'San Miguel', ' Tetelpan', ' Álvaro Obregón', 1700, 19.477666, -99.207382, 'San Miguel, Tetelpan, Álvaro Obregón, 01700 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (298, 9, 'Avenida Plan de San Luis 545', ' Hogar y Seguridad', ' Azcapotzalco', 2820, 19.477666, -99.207382, 'Avenida Plan de San Luis 545, Hogar y Seguridad, Azcapotzalco, 02820 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (299, 9, '1a. Cerrada C. 4 27', ' Granjas San Antonio', ' Iztapalapa', 9070, 19.363656, -99.076372, '1a. Cerrada C. 4 27, Granjas San Antonio, Iztapalapa, 09070 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (300, 9, 'Prolongación Río Churubusco', ' Aeropuerto Int de La Ciudad de México', ' Venustiano Carranza', 15620, 19.336555, -99.156372, 'Prolongación Río Churubusco, Aeropuerto Int de La Ciudad de México, Venustiano Carranza, 15620 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (301, 9, 'Eje 1 Oriente (Av. Canal de Miramontes) 2340', ' Avante', ' Coyoacán', 4460, 19.447665, -99.256372, 'Eje 1 Oriente (Av. Canal de Miramontes) 2340, Avante, Coyoacán, 04460 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (302, 9, 'Regina', ' Centro', ' Cuauhtémoc', 6000, 19.373666, -99.166373, 'Regina, Centro, Cuauhtémoc, 06000 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (303, 9, 'Darwin 61', ' Anzures', ' Miguel Hidalgo', 11590, 19.457565, -99.276382, 'Darwin 61, Anzures, Miguel Hidalgo, 11590 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (304, 9, 'San Diego', ' San Bartolo Ameyalco', ' Álvaro Obregón', 1800, 19.325556, -99.236383, 'San Diego, San Bartolo Ameyalco, Álvaro Obregón, 01800 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (305, 9, '1 MZ5 LT6', ' Xalpa', ' Iztapalapa', 9640, 19.322666, -99.067363, '1 MZ5 LT6, Xalpa, Iztapalapa, 09640 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (306, 9, 'Fernando Montes de Oca', ' Guadalupe del Moral', ' Iztapalapa', 9300, 19.375665, -99.036353, 'Fernando Montes de Oca, Guadalupe del Moral, Iztapalapa, 09300 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (307, 9, 'Iznal MZ6 LT66', ' Xalpa', ' Iztapalapa', 9640, 19.476655, -99.037363, 'Iznal MZ6 LT66, Xalpa, Iztapalapa, 09640 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (308, 9, 'Canadá Los Helechos 435', ' San Mateo Tlaltenango', ' Cuajimalpa', 5600, 19.423666, -99.246353, 'Canadá Los Helechos 435, San Mateo Tlaltenango, Cuajimalpa, 05600 Mexico City, State of Mexico, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (309, 9, 'SIN NOMBRE No. 370 19', ' Narciso Bassols', ' Gustavo A. Madero', 7980, 19.485565, -99.016353, 'SIN NOMBRE No. 370 19, Narciso Bassols, Gustavo A. Madero, 07980 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (310, 9, 'Horacio 1603', ' Polanco', ' Miguel Hidalgo', 11550, 19.425566, -99.256373, 'Horacio 1603, Polanco, Miguel Hidalgo, 11550 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (311, 9, 'Sur 69 103', ' Banjidal', ' Prado', 9480, 19.323566, -99.177353, 'Sur 69 103, Banjidal, Prado, 09480 Iztapalapa, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (312, 9, 'Minas', ' Lomas de La Estancia', ' Iztapalapa', 9640, 19.474656, -99.157372, 'Minas, Lomas de La Estancia, Iztapalapa, 09640 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (313, 9, '1a 5 de Mayo', ' Palmitas', ' Iztapalapa', 9670, 19.468666, -99.147383, '1a 5 de Mayo, Palmitas, Iztapalapa, 09670 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (314, 9, 'Eje 5 Norte (Calz. San Juan de Aragón) 214', ' Constitución de La República', ' Gustavo A. Madero', 7469, 19.422656, -99.117373, 'Eje 5 Norte (Calz. San Juan de Aragón) 214, Constitución de La República, Gustavo A. Madero, 07469 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (315, 9, 'Zaragoza 4', ' Santa Lucía Reacomodo', ' Álvaro Obregón', 1509, 19.446566, -99.146383, 'Zaragoza 4, Santa Lucía Reacomodo, Álvaro Obregón, 01509 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (316, 9, 'Poniente 58 3909', ' Obrero Popular', ' Azcapotzalco', 2840, 19.454565, -99.076373, 'Poniente 58 3909, Obrero Popular, Azcapotzalco, 02840 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (317, 9, 'Año de Juárez 253', ' Granjas San Antonio', ' Iztapalapa', 9070, 19.477556, -99.066372, 'Año de Juárez 253, Granjas San Antonio, Iztapalapa, 09070 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (318, 9, 'Guillermo Prieto 121', ' San Rafael', ' Cuauhtémoc', 6740, 19.329565, -99.156363, 'Guillermo Prieto 121, San Rafael, Cuauhtémoc, 06740 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (319, 9, 'Pirul 13', ' Santa María Insurgentes', ' Cuauhtémoc', 6430, 19.466555, -99.256383, 'Pirul 13, Santa María Insurgentes, Cuauhtémoc, 06430 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (320, 9, 'Eje Central Lázaro Cárdenas 15', ' Nueva Vallejo', ' Gustavo A. Madero', 7750, 19.388655, -99.146383, 'Eje Central Lázaro Cárdenas 15, Nueva Vallejo, Gustavo A. Madero, 07750 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (321, 9, 'Benito Juárez 58', ' Zacatepec', ' Iztapalapa', 9560, 19.437565, -99.046372, 'Benito Juárez 58, Zacatepec, Iztapalapa, 09560 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (322, 9, 'Cascada 512', ' Banjidal', ' Iztapalapa', 9450, 19.428555, -99.147382, 'Cascada 512, Banjidal, Iztapalapa, 09450 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (323, 9, 'Calle 20 25', ' Olivar del Conde 1a. Sección', ' Álvaro Obregón', 1400, 19.449666, -99.066372, 'Calle 20 25, Olivar del Conde 1a. Sección, Álvaro Obregón, 01400 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (324, 9, 'Callao 738', ' Lindavista', ' Gustavo A. Madero', 7300, 19.365656, -99.047382, 'Callao 738, Lindavista, Gustavo A. Madero, 07300 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (325, 9, 'Avenida Montevideo 178-181', ' Lindavista', ' Gustavo A. Madero', 7300, 19.365656, -99.047382, 'Avenida Montevideo 178-181, Lindavista, Gustavo A. Madero, 07300 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (326, 9, 'Allende 18', ' Norte', ' Álvaro Obregón', 1410, 19.365656, -99.047382, 'Allende 18, Norte, Álvaro Obregón, 01410 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (327, 9, 'Calzada de la Virgen Mz 9 Lt 14', ' Carmen Serdán', ' Coyoacán', 4910, 19.365656, -99.047382, 'Calzada de la Virgen Mz 9 Lt 14, Carmen Serdán, Coyoacán, 04910 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (328, 9, 'Satélite 115', ' Lomas de La Estancia', ' Iztapalapa', 9640, 19.365656, -99.047382, 'Satélite 115, Lomas de La Estancia, Iztapalapa, 09640 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (329, 9, 'San Francisco', ' Corpus Cristy', ' Álvaro Obregón', 1530, 19.327666, -99.237383, 'San Francisco, Corpus Cristy, Álvaro Obregón, 01530 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (330, 9, 'Pedro Aguirre Cerda', ' 2a. Ampliación Presidentes', ' Álvaro Obregón', 1299, 19.327666, -99.237383, 'Pedro Aguirre Cerda, 2a. Ampliación Presidentes, Álvaro Obregón, 01299 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (331, 9, 'Jumil 69-79', ' 35B', ' Coyoacán', 4369, 19.327666, -99.237383, 'Jumil 69-79, 35B, Coyoacán, 04369 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (332, 9, 'Emilio Elizondo', ' Ejército de Agua Prieta', ' Iztapalapa', 9578, 19.369556, -99.057353, 'Emilio Elizondo, Ejército de Agua Prieta, Iztapalapa, 09578 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (333, 9, 'Isabel la Católica 158', ' Centro', ' Cuauhtémoc', 6000, 19.353655, -99.157363, 'Isabel la Católica 158, Centro, Cuauhtémoc, 06000 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (334, 9, 'Torres de Ixtapantongo 380', ' Olivar de Los Padres', ' Oliviar de los Padres', 1780, 19.467555, -99.027353, 'Torres de Ixtapantongo 380, Olivar de Los Padres, Oliviar de los Padres, 01780 Álvaro Obregón, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (335, 9, 'Caracol 128', ' Caracol', ' Venustiano Carranza', 15630, 19.347665, -99.136383, 'Caracol 128, Caracol, Venustiano Carranza, 15630 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (336, 9, 'Villa Gatón MZ70B LT11', ' Desarrollo Urbano Quetzalcoatl', ' Iztapalapa', 9700, 19.347665, -99.136383, 'Villa Gatón MZ70B LT11, Desarrollo Urbano Quetzalcoatl, Iztapalapa, 09700 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (337, 9, 'Manzanas 56', ' Tlacoquemecatl del Valle', ' Benito Juarez', 3200, 19.447655, -99.257373, 'Manzanas 56, Tlacoquemecatl del Valle, Benito Juarez, 03200 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (338, 9, 'Serenata 105', ' Colinas del Sur', ' Álvaro Obregón', 1430, 19.337656, -99.207373, 'Serenata 105, Colinas del Sur, Álvaro Obregón, 01430 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (339, 9, 'Privada Sidral', ' Santa María La Ribera', ' Cuauhtémoc', 6400, 19.337656, -99.207373, 'Privada Sidral, Santa María La Ribera, Cuauhtémoc, 06400 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (340, 9, 'Cedros', ' Ejido San Mateo', ' Álvaro Obregón', 1580, 19.334565, -99.026353, 'Cedros, Ejido San Mateo, Álvaro Obregón, 01580 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (341, 9, '1a. Cerrada Amapola MZ5 LT5', ' Xalpa', ' Iztapalapa', 9640, 19.334565, -99.026353, '1a. Cerrada Amapola MZ5 LT5, Xalpa, Iztapalapa, 09640 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (342, 9, 'Adolfo López Mateos 70', ' Adolfo López Mateos', ' Venustiano Carranza', 15670, 19.334565, -99.026353, 'Adolfo López Mateos 70, Adolfo López Mateos, Venustiano Carranza, 15670 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (343, 9, 'San Francisco', ' San Bartolo Ameyalco', ' Álvaro Obregón', 1800, 19.363565, -99.267373, 'San Francisco, San Bartolo Ameyalco, Álvaro Obregón, 01800 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (344, 9, 'Avenida Ing. Eduardo Molina 4427', ' La Joya', ' Gustavo A. Madero', 7890, 19.363565, -99.267373, 'Avenida Ing. Eduardo Molina 4427, La Joya, Gustavo A. Madero, 07890 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (345, 9, 'Cofre de Perote 325', ' Lomas de Chapultepec', ' Miguel Hidalgo', 11000, 19.387655, -99.117383, 'Cofre de Perote 325, Lomas de Chapultepec, Miguel Hidalgo, 11000 Mexico City, State of Mexico, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (346, 9, 'Interior Avenida Río Churubusco 69', ' Del Carmen', ' Coyoacán', 4100, 19.387655, -99.117383, 'Interior Avenida Río Churubusco 69, Del Carmen, Coyoacán, 04100 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (347, 9, 'López Cotilla 1143', ' Del Valle', ' Benito Juarez', 3100, 19.387655, -99.117383, 'López Cotilla 1143, Del Valle, Benito Juarez, 03100 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (348, 9, '2a. Cerrada de Minas', ' La Joya', ' Álvaro Obregón', 1280, 19.387655, -99.117383, '2a. Cerrada de Minas, La Joya, Álvaro Obregón, 01280 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (349, 9, 'Reyna Xochitl', ' El Paraíso', ' Iztapalapa', 9230, 19.335556, -99.127373, 'Reyna Xochitl, El Paraíso, Iztapalapa, 09230 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (350, 9, 'Del IMSS', ' Magdalena de Las Salinas', ' Gustavo A. Madero', 7760, 19.335556, -99.127373, 'Del IMSS, Magdalena de Las Salinas, Gustavo A. Madero, 07760 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (351, 9, 'Antonio Caso 49-53', ' Tabacalera', ' Cuauhtémoc', 6030, 19.335556, -99.127373, 'Antonio Caso 49-53, Tabacalera, Cuauhtémoc, 06030 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (352, 9, 'Del Parque 23A', ' Avante', ' Coyoacán', 4460, 19.384556, -99.106352, 'Del Parque 23A, Avante, Coyoacán, 04460 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (353, 9, 'Estampado', ' 20 de Noviembre', ' Venustiano Carranza', 15300, 19.384556, -99.106352, 'Estampado, 20 de Noviembre, Venustiano Carranza, 15300 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (354, 9, 'Conscripto 311', ' Lomas de Sotelo', ' Miguel Hidalgo', 11200, 19.384556, -99.106352, 'Conscripto 311, Lomas de Sotelo, Miguel Hidalgo, 11200 Naucalpan, State of Mexico, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (355, 9, 'Doctor Gabino Fraga MZ3 LT39', ' Tlacuitlapa Ampliación 2o. Reacomodo', ' Álvaro Obregón', 1650, 19.384556, -99.106352, 'Doctor Gabino Fraga MZ3 LT39, Tlacuitlapa Ampliación 2o. Reacomodo, Álvaro Obregón, 01650 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (356, 9, 'Lomas Quebradas 27', ' San Jerónimo Lídice', ' Magdalena Contreras', 10010, 19.467565, -99.147372, 'Lomas Quebradas 27, San Jerónimo Lídice, Magdalena Contreras, 10010 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (357, 9, 'Avenida De Los Maestros', ' Plutarco Elías Calles', ' Miguel Hidalgo', 11350, 19.467565, -99.147372, 'Avenida De Los Maestros, Plutarco Elías Calles, Miguel Hidalgo, 11350 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (358, 9, '2', ' Olivar de Los Padres', ' Álvaro Obregón', 1780, 19.339556, -99.076352, '2, Olivar de Los Padres, Álvaro Obregón, 01780 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (359, 9, 'Avenida Rubén M. Campos', ' Villa de Cortes', ' Benito Juarez', 3530, 19.339556, -99.076352, 'Avenida Rubén M. Campos, Villa de Cortes, Benito Juarez, 03530 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (360, 9, 'Hierro 28', ' Maza', ' Cuauhtémoc', 6240, 19.339556, -99.076352, 'Hierro 28, Maza, Cuauhtémoc, 06240 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (361, 9, 'Cda. Montes Celestes 110', ' Lomas de Chapultepec', ' Miguel Hidalgo', 11000, 19.343556, -99.216353, 'Cda. Montes Celestes 110, Lomas de Chapultepec, Miguel Hidalgo, 11000 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (362, 9, 'Eje 1 Oriente F.C. Hidalgo 2301', ' La Joyita', ' Gustavo A. Madero', 7850, 19.343556, -99.216353, 'Eje 1 Oriente F.C. Hidalgo 2301, La Joyita, Gustavo A. Madero, 07850 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (363, 9, 'Avenida De Los Maestros 159', ' Santo Tomas', ' Miguel Hidalgo', 11340, 19.343556, -99.216353, 'Avenida De Los Maestros 159, Santo Tomas, Miguel Hidalgo, 11340 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (364, 9, 'Eje 1 Oriente F.C. Hidalgo 14', ' La Joyita', ' Gustavo A. Madero', 7860, 19.373656, -99.137363, 'Eje 1 Oriente F.C. Hidalgo 14, La Joyita, Gustavo A. Madero, 07860 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (365, 9, 'Avenida Tlahuac 89', ' Santa Isabel Industrial', ' Iztapalapa', 9820, 19.373656, -99.137363, 'Avenida Tlahuac 89, Santa Isabel Industrial, Iztapalapa, 09820 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (366, 9, 'Pedro Aguirre Cerda', ' 2a. Ampliación Presidentes', ' Álvaro Obregón', 1299, 19.422565, -99.127353, 'Pedro Aguirre Cerda, 2a. Ampliación Presidentes, Álvaro Obregón, 01299 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (367, 9, 'Miguel Laurent 1164', ' Letrán Valle', ' Benito Juarez', 3650, 19.422565, -99.127353, 'Miguel Laurent 1164, Letrán Valle, Benito Juarez, 03650 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (368, 9, '2', ' Zenón Delgado', ' Álvaro Obregón', 1220, 19.489666, -99.157352, '2, Zenón Delgado, Álvaro Obregón, 01220 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (369, 9, 'Calle de Balderas', ' Centro', ' Cuauhtémoc', 6000, 19.489666, -99.157352, 'Calle de Balderas, Centro, Cuauhtémoc, 06000 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (370, 9, 'Anaxágoras 715', ' Narvarte', ' Benito Juarez', 3000, 19.489666, -99.157352, 'Anaxágoras 715, Narvarte, Benito Juarez, 03000 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (371, 9, 'Caniles MZ46 LT68', ' Cerro de La Estrella', ' Iztapalapa', 9860, 19.489666, -99.157352, 'Caniles MZ46 LT68, Cerro de La Estrella, Iztapalapa, 09860 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (372, 9, 'Avenida Centenario', ' Bosques Tarango', ' Álvaro Obregón', 1580, 19.436555, -99.236352, 'Avenida Centenario, Bosques Tarango, Álvaro Obregón, 01580 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (373, 9, 'Minas', ' Lomas de La Estancia', ' Iztapalapa', 9640, 19.436555, -99.236352, 'Minas, Lomas de La Estancia, Iztapalapa, 09640 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (374, 9, 'Paseo Girasoles 7', ' Lomas de Vista Hermosa', ' Cuajimalpa', 5100, 19.357656, -99.016362, 'Paseo Girasoles 7, Lomas de Vista Hermosa, Cuajimalpa, 05100 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (375, 9, 'Calle La Presa', ' (P .i.) Garcimarrero 090100001291-B', ' Álvaro Obregón', 1510, 19.357656, -99.016362, 'Calle La Presa, (P .i.) Garcimarrero 090100001291-B, Álvaro Obregón, 01510 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (376, 9, 'Avenida Tlahuac', ' San Andrés Tomatlan', ' Iztapalapa', 9870, 19.369655, -99.157362, 'Avenida Tlahuac, San Andrés Tomatlan, Iztapalapa, 09870 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (377, 9, 'Calle La Presa', ' (P .i.) Garcimarrero 090100001291-B', ' Álvaro Obregón', 1510, 19.369655, -99.157362, 'Calle La Presa, (P .i.) Garcimarrero 090100001291-B, Álvaro Obregón, 01510 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (378, 9, 'Monte de Las Cruces 42', ' La Pradera', ' Gustavo A. Madero', 7500, 19.376556, -99.106363, 'Monte de Las Cruces 42, La Pradera, Gustavo A. Madero, 07500 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (379, 9, '2a. Cerrada C. 4 4', ' Granjas San Antonio', ' Iztapalapa', 9070, 19.376556, -99.106363, '2a. Cerrada C. 4 4, Granjas San Antonio, Iztapalapa, 09070 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (380, 9, 'Avenida Universidad 1046', ' Xoco', ' Benito Juarez', 3340, 19.376556, -99.106363, 'Avenida Universidad 1046, Xoco, Benito Juarez, 03340 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (381, 9, 'Loma del Parque 134', ' Lomas de Vista Hermosa', ' Cuajimalpa', 5100, 19.466555, -99.056353, 'Loma del Parque 134, Lomas de Vista Hermosa, Cuajimalpa, 05100 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (382, 9, 'Plomo 21', ' Valle Gómez', ' Cuauhtémoc', 6240, 19.466555, -99.056353, 'Plomo 21, Valle Gómez, Cuauhtémoc, 06240 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (383, 9, 'Manuel Bonilla', ' Zona Urbana Ejidal Santa Martha Acatitla Sur', ' Iztapalapa', 9530, 19.466555, -99.056353, 'Manuel Bonilla, Zona Urbana Ejidal Santa Martha Acatitla Sur, Iztapalapa, 09530 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (384, 9, 'Eje 2 Poniente Gabriel Mancera 1314', ' Del Valle', ' Benito Juarez', 3100, 19.378566, -99.007383, 'Eje 2 Poniente Gabriel Mancera 1314, Del Valle, Benito Juarez, 03100 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (385, 9, 'Eje 4 Norte (Calz. Azcapotzalco La Villa)', ' San Andrés de Las Salinas', ' Azcapotzalco', 2300, 19.378566, -99.007383, 'Eje 4 Norte (Calz. Azcapotzalco La Villa), San Andrés de Las Salinas, Azcapotzalco, 02300 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (386, 9, '2a. Cerrada C. 4 4', ' Granjas San Antonio', ' Iztapalapa', 9070, 19.333565, -99.047363, '2a. Cerrada C. 4 4, Granjas San Antonio, Iztapalapa, 09070 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (387, 9, 'Sierra Vertientes 335', ' Lomas de Chapultepec', ' Miguel Hidalgo', 11000, 19.333565, -99.047363, 'Sierra Vertientes 335, Lomas de Chapultepec, Miguel Hidalgo, 11000 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (388, 9, 'Joyas 88', ' La Estrella', ' Gustavo A. Madero', 7810, 19.455565, -99.106383, 'Joyas 88, La Estrella, Gustavo A. Madero, 07810 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (389, 9, 'General Juan Cabral', ' Militar 1 K Lomas de Sotelo', ' Miguel Hidalgo', 11200, 19.455565, -99.106383, 'General Juan Cabral, Militar 1 K Lomas de Sotelo, Miguel Hidalgo, 11200 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (390, 9, 'Norte 11 4630', ' Defensores de La República', ' Gustavo A. Madero', 7780, 19.446656, -99.276382, 'Norte 11 4630, Defensores de La República, Gustavo A. Madero, 07780 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (391, 9, 'Rodríguez Puebla', ' Centro', ' Cuauhtémoc', 6000, 19.342665, -99.166372, 'Rodríguez Puebla, Centro, Cuauhtémoc, 06000 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (392, 9, 'Yurécuaro 110-112', ' Janitzio', ' Venustiano Carranza', 15200, 19.342665, -99.166372, 'Yurécuaro 110-112, Janitzio, Venustiano Carranza, 15200 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (393, 9, 'Cda. de Tiro Al Pichón 29A', ' Lomas de Bezares', ' Miguel Hidalgo', 11910, 19.346555, -99.067372, 'Cda. de Tiro Al Pichón 29A, Lomas de Bezares, Miguel Hidalgo, 11910 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (394, 9, 'Aretinos', ' Isidro Fabela', ' Álvaro Obregón', 1170, 19.346555, -99.067372, 'Aretinos, Isidro Fabela, Álvaro Obregón, 01170 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (395, 9, 'Eje 1 Oriente (Av. Canal de Miramontes) 2273', ' Avante', ' Coyoacán', 4460, 19.385656, -99.127362, 'Eje 1 Oriente (Av. Canal de Miramontes) 2273, Avante, Coyoacán, 04460 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (396, 9, 'Calzada Ings. Militares', ' San Lorenzo Tlaltenango', ' Miguel Hidalgo', 11210, 19.337656, -99.266353, 'Calzada Ings. Militares, San Lorenzo Tlaltenango, Miguel Hidalgo, 11210 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (397, 9, 'Circuito Interior Avenida Río Churubusco 1198', ' Portales', ' Benito Juarez', 3300, 19.483656, -99.016372, 'Circuito Interior Avenida Río Churubusco 1198, Portales, Benito Juarez, 03300 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (398, 9, 'Copa de Oro 69', ' Ciudad Jardín', ' Coyoacán', 4370, 19.483656, -99.016372, 'Copa de Oro 69, Ciudad Jardín, Coyoacán, 04370 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (399, 9, 'Martin Mendalde 613', ' Del Valle', ' Benito Juarez', 3100, 19.388566, -99.177353, 'Martin Mendalde 613, Del Valle, Benito Juarez, 03100 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (400, 9, 'Muitles', ' San Bartolo Ameyalco', ' Álvaro Obregón', 1800, 19.484565, -99.036362, 'Muitles, San Bartolo Ameyalco, Álvaro Obregón, 01800 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (401, 9, 'Carretera Federal 15 de Cuota', ' Lomas de Santa Fe', ' Cuajimalpa', 1219, 19.343556, -99.266352, 'Carretera Federal 15 de Cuota, Lomas de Santa Fe, Cuajimalpa, 01219 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (402, 9, 'Abedul MZ245 LT20', ' 2da Ampliación Santiago Acahualtepec', ' Iztapalapa', 9609, 19.476566, -99.267373, 'Abedul MZ245 LT20, 2da Ampliación Santiago Acahualtepec, Iztapalapa, 09609 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (403, 9, 'Agrario 11', ' San Simon Culhuacan', ' Iztapalapa', 9870, 19.476566, -99.267373, 'Agrario 11, San Simon Culhuacan, Iztapalapa, 09870 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (404, 9, 'Salvador Allende', ' Presidentes', ' Álvaro Obregón', 1299, 19.427556, -99.116353, 'Salvador Allende, Presidentes, Álvaro Obregón, 01299 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (405, 9, 'Tejamanil 198', ' Santo Domingo (Pgal de Sto Domingo)', ' Coyoacán', 4369, 19.336565, -99.056372, 'Tejamanil 198, Santo Domingo (Pgal de Sto Domingo), Coyoacán, 04369 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (406, 9, 'Prado Sur 285', ' Lomas de Chapultepec', ' Miguel Hidalgo', 11000, 19.457555, -99.216373, 'Prado Sur 285, Lomas de Chapultepec, Miguel Hidalgo, 11000 Miguel Hidalgo, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (407, 9, 'Malintzin 46', ' Aragón La Villa(Aragón)', ' Gustavo A. Madero', 7000, 19.457555, -99.216373, 'Malintzin 46, Aragón La Villa(Aragón), Gustavo A. Madero, 07000 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (408, 9, 'Ruiz Cortines', ' Pensador Mexicano', ' Venustiano Carranza', 15510, 19.485566, -99.167372, 'Ruiz Cortines, Pensador Mexicano, Venustiano Carranza, 15510 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (409, 9, 'Lomas de Sotelo 1130', ' Loma Hermosa', ' Miguel Hidalgo', 11200, 19.352665, -99.037373, 'Lomas de Sotelo 1130, Loma Hermosa, Miguel Hidalgo, 11200 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (410, 9, 'Calle Tarango', ' San Clemente Norte', ' Álvaro Obregón', 1740, 19.352665, -99.037373, 'Calle Tarango, San Clemente Norte, Álvaro Obregón, 01740 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (411, 9, 'General Emiliano Zapata', ' Portales', ' Benito Juarez', 3300, 19.488556, -99.077352, 'General Emiliano Zapata, Portales, Benito Juarez, 03300 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (412, 9, 'Maíz MZ18 LT17', ' Xalpa', ' Iztapalapa', 9640, 19.364666, -99.036362, 'Maíz MZ18 LT17, Xalpa, Iztapalapa, 09640 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (413, 9, 'Caniles MZ46 LT68', ' Cerro de La Estrella', ' Iztapalapa', 9860, 19.325665, -99.217363, 'Caniles MZ46 LT68, Cerro de La Estrella, Iztapalapa, 09860 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (414, 9, 'Autopista México-Marquesa', ' Zedec Santa Fe', ' Álvaro Obregón', 1219, 19.325665, -99.217363, 'Autopista México-Marquesa, Zedec Santa Fe, Álvaro Obregón, 01219 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (415, 9, 'Ret. Cerro del Hombre 69', ' Romero de Terreros', ' Coyoacán', 4310, 19.477666, -99.256362, 'Ret. Cerro del Hombre 69, Romero de Terreros, Coyoacán, 04310 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (416, 9, 'Tolteca 73', ' Industrial', ' Gustavo A. Madero', 7800, 19.479555, -99.247383, 'Tolteca 73, Industrial, Gustavo A. Madero, 07800 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (417, 9, 'Corregidora 135', ' San Jerónimo Lídice', ' Magdalena Contreras', 10200, 19.446665, -99.226382, 'Corregidora 135, San Jerónimo Lídice, Magdalena Contreras, 10200 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (418, 9, 'Chichen Itza 301', ' Letrán Valle', ' Benito Juarez', 3600, 19.489656, -99.137373, 'Chichen Itza 301, Letrán Valle, Benito Juarez, 03600 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (419, 9, 'Avenida Ing. Eduardo Molina 4429', ' La Joya', ' Gustavo A. Madero', 7890, 19.376566, -99.177363, 'Avenida Ing. Eduardo Molina 4429, La Joya, Gustavo A. Madero, 07890 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (420, 9, 'Zempoala 24', ' Hermosillo', ' Coyoacán', 4240, 19.424555, -99.246353, 'Zempoala 24, Hermosillo, Coyoacán, 04240 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (421, 9, 'Cuitláhuac MZ11 LT8', ' Zona Urbana Ejidal Los Reyes Culhuacan', ' Iztapalapa', 9840, 19.367665, -99.216372, 'Cuitláhuac MZ11 LT8, Zona Urbana Ejidal Los Reyes Culhuacan, Iztapalapa, 09840 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (422, 9, 'Calle 21 323', ' Pro Hogar', ' Azcapotzalco', 2600, 19.349566, -99.037383, 'Calle 21 323, Pro Hogar, Azcapotzalco, 02600 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (423, 9, 'Nueva York 264', ' Del Valle', ' Benito Juarez', 3810, 19.359555, -99.267352, 'Nueva York 264, Del Valle, Benito Juarez, 03810 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (424, 9, '1519 56', ' San Juan de Aragón 6a Sección', ' Gustavo A. Madero', 7918, 19.437665, -99.046382, '1519 56, San Juan de Aragón 6a Sección, Gustavo A. Madero, 07918 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (425, 9, 'Pino', ' Del Cedromilpa', ' Álvaro Obregón', 1580, 19.367556, -99.246373, 'Pino, Del Cedromilpa, Álvaro Obregón, 01580 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (426, 9, 'Josafat F. Márquez', ' Colonial Iztapalapa', ' Iztapalapa', 9270, 19.453555, -99.157352, 'Josafat F. Márquez, Colonial Iztapalapa, Iztapalapa, 09270 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (427, 9, '4 de Rivera Cambas 65', ' Jardín Balbuena', ' Venustiano Carranza', 15900, 19.373655, -99.156373, '4 de Rivera Cambas 65, Jardín Balbuena, Venustiano Carranza, 15900 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (428, 9, '631 241', ' San Juan de Aragón 4a Sección', ' Gustavo A. Madero', 7979, 19.368656, -99.167383, '631 241, San Juan de Aragón 4a Sección, Gustavo A. Madero, 07979 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (429, 9, 'Plutarco Elías Calles', ' Ampliación San Miguel', ' Iztapalapa', 9240, 19.342566, -99.077363, 'Plutarco Elías Calles, Ampliación San Miguel, Iztapalapa, 09240 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (430, 9, 'San Francisco', ' San Bartolo Ameyalco', ' Álvaro Obregón', 1800, 19.355556, -99.216353, 'San Francisco, San Bartolo Ameyalco, Álvaro Obregón, 01800 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (431, 9, '1a. Privada Vicente Guerrero', ' Culhuacan', ' Iztapalapa', 9800, 19.437556, -99.016363, '1a. Privada Vicente Guerrero, Culhuacan, Iztapalapa, 09800 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (432, 9, 'Iturbe 32', ' San Mateo Tlaltenango', ' Cuajimalpa', 5600, 19.477656, -99.007372, 'Iturbe 32, San Mateo Tlaltenango, Cuajimalpa, 05600 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (433, 9, 'Hierro 28', ' Maza', ' Cuauhtémoc', 6240, 19.487566, -99.136362, 'Hierro 28, Maza, Cuauhtémoc, 06240 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (434, 9, 'Pelícano 75', ' Granjas Modernas', ' Gustavo A. Madero', 7460, 19.488666, -99.217383, 'Pelícano 75, Granjas Modernas, Gustavo A. Madero, 07460 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (435, 9, 'Insurgentes Norte 1725', ' Tepeyac Insurgentes', ' Gustavo A. Madero', 7020, 19.374555, -99.257373, 'Insurgentes Norte 1725, Tepeyac Insurgentes, Gustavo A. Madero, 07020 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (436, 9, 'Providencia 343', ' San Miguel Amantla', ' Azcapotzalco', 2700, 19.434555, -99.177382, 'Providencia 343, San Miguel Amantla, Azcapotzalco, 02700 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (437, 9, 'Wake 204', ' Libertad', ' Azcapotzalco', 2050, 19.363655, -99.047363, 'Wake 204, Libertad, Azcapotzalco, 02050 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (438, 9, 'Avenida Santa Cruz Meyehualco 181', ' Santa Cruz Meyehualco', ' Iztapalapa', 9290, 19.324565, -99.146382, 'Avenida Santa Cruz Meyehualco 181, Santa Cruz Meyehualco, Iztapalapa, 09290 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (439, 9, 'Marcos N. Méndez MZ40 LT20', ' Zona Urbana Ejidal Santa Martha Acatitla Sur', ' Iztapalapa', 9530, 19.386666, -99.266373, 'Marcos N. Méndez MZ40 LT20, Zona Urbana Ejidal Santa Martha Acatitla Sur, Iztapalapa, 09530 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (440, 9, 'Norte 1', ' Cuchilla del Tesoro', ' Gustavo A. Madero', 7900, 19.438556, -99.257383, 'Norte 1, Cuchilla del Tesoro, Gustavo A. Madero, 07900 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (441, 9, '3a San Francisco', ' San Bartolo Ameyalco', ' Álvaro Obregón', 1800, 19.345665, -99.277353, '3a San Francisco, San Bartolo Ameyalco, Álvaro Obregón, 01800 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (442, 9, 'Avenida 608 29', ' San Juan de Aragón 3a Sección', ' Gustavo A. Madero', 7970, 19.345655, -99.256372, 'Avenida 608 29, San Juan de Aragón 3a Sección, Gustavo A. Madero, 07970 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (443, 9, 'Parroquia 830', ' Del Valle', ' Benito Juarez', 3100, 19.473566, -99.036372, 'Parroquia 830, Del Valle, Benito Juarez, 03100 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (445, 9, 'Miguel Allende', ' El Parque', ' Venustiano Carranza', 15290, 19.488566, -99.067383, 'Miguel Allende, El Parque, Venustiano Carranza, 15290 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (446, 9, 'Plaza del Loreto 37', ' Doctor Alfonso Ortiz Tirado', ' Iztapalapa', 9020, 19.488566, -99.067383, 'Plaza del Loreto 37, Doctor Alfonso Ortiz Tirado, Iztapalapa, 09020 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (444, 9, 'Modesto Domínguez', ' Ejército de Agua Prieta', ' Iztapalapa', 9578, 19.488566, -99.067383, 'Modesto Domínguez, Ejército de Agua Prieta, Iztapalapa, 09578 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (447, 9, 'Avenida Tlahuac 190', ' Santa Isabel Industrial', ' Iztapalapa', 9820, 19.488566, -99.067383, 'Avenida Tlahuac 190, Santa Isabel Industrial, Iztapalapa, 09820 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (448, 9, 'Sierra Madre Oriental 49', ' La Pradera', ' Gustavo A. Madero', 7500, 19.452565, -99.067362, 'Sierra Madre Oriental 49, La Pradera, Gustavo A. Madero, 07500 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (449, 9, 'Miguel Laurent 1164', ' Letrán Valle', ' Benito Juarez', 3650, 19.452565, -99.067362, 'Miguel Laurent 1164, Letrán Valle, Benito Juarez, 03650 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (450, 9, 'Xiutetelco MZC5 LT26', ' El Arenal 4a Sección', ' Venustiano Carranza', 15640, 19.327665, -99.276363, 'Xiutetelco MZC5 LT26, El Arenal 4a Sección, Venustiano Carranza, 15640 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (451, 9, 'Avenida Tamaulipas 257', ' Casa La Salle', ' Álvaro Obregón', 1357, 19.327665, -99.276363, 'Avenida Tamaulipas 257, Casa La Salle, Álvaro Obregón, 01357 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (452, 9, 'Miguel Negrete 34', ' Niños Heroes de Chapultepec', ' Benito Juarez', 3440, 19.327665, -99.276363, 'Miguel Negrete 34, Niños Heroes de Chapultepec, Benito Juarez, 03440 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (453, 9, 'San Esteban 48 A', ' Santo Tomas', ' Azcapotzalco', 2020, 19.327665, -99.276363, 'San Esteban 48 A, Santo Tomas, Azcapotzalco, 02020 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (454, 9, 'Ret.68 61', ' Avante', ' Coyoacán', 4460, 19.343565, -99.136383, 'Ret.68 61, Avante, Coyoacán, 04460 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (455, 9, 'Transmisiones Militares 15', ' Residencial Lomas de Sotelo', ' Fraccionamiento Lomas de Sotelo', 53390, 19.343565, -99.136383, 'Transmisiones Militares 15, Residencial Lomas de Sotelo, Fraccionamiento Lomas de Sotelo, 53390 Naucalpan, State of Mexico, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (456, 9, 'Amacuzac 42', ' San Andrés Tetepilco', ' Iztapalapa', 9440, 19.343565, -99.136383, 'Amacuzac 42, San Andrés Tetepilco, Iztapalapa, 09440 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (457, 9, 'Las Fuentes 297', ' Jardines del Pedregal', ' Álvaro Obregón', 1900, 19.442655, -99.276353, 'Las Fuentes 297, Jardines del Pedregal, Álvaro Obregón, 01900 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (458, 9, 'Sonora', ' Aeropuerto Int de La Ciudad de México', ' Venustiano Carranza', 15620, 19.442655, -99.276353, 'Sonora, Aeropuerto Int de La Ciudad de México, Venustiano Carranza, 15620 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (459, 9, 'Hermenegildo Galeana 26A', ' Guadalupe del Moral', ' Iztapalapa', 9300, 19.486555, -99.247383, 'Hermenegildo Galeana 26A, Guadalupe del Moral, Iztapalapa, 09300 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (460, 9, 'Avenida Bernardo Quintana A.', ' La Loma', ' Álvaro Obregón', 1260, 19.486555, -99.247383, 'Avenida Bernardo Quintana A., La Loma, Álvaro Obregón, 01260 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (461, 9, '481 84', ' San Juan de Aragón 7 Sección', ' Gustavo A. Madero', 7910, 19.486555, -99.247383, '481 84, San Juan de Aragón 7 Sección, Gustavo A. Madero, 07910 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (462, 9, 'Xochitlán Norte 59', ' El Arenal 4a Sección', ' Venustiano Carranza', 15640, 19.478566, -99.167363, 'Xochitlán Norte 59, El Arenal 4a Sección, Venustiano Carranza, 15640 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (463, 9, 'José Loreto Fabela 140', ' San Juan de Aragón 4a Sección', ' Gustavo A. Madero', 7979, 19.478566, -99.167363, 'José Loreto Fabela 140, San Juan de Aragón 4a Sección, Gustavo A. Madero, 07979 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (464, 9, 'Paseo de Las Palmas 805', ' Lomas de Chapultepec', ' Miguel Hidalgo', 11000, 19.466665, -99.007353, 'Paseo de Las Palmas 805, Lomas de Chapultepec, Miguel Hidalgo, 11000 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (465, 9, 'D García Ramos', ' Lomas de Santa Fe', ' Cuajimalpa', 1219, 19.356565, -99.007363, 'D García Ramos, Lomas de Santa Fe, Cuajimalpa, 01219 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (466, 9, 'Ceylan 679', ' Las Salinas', ' Azcapotzalco', 2360, 19.356565, -99.007363, 'Ceylan 679, Las Salinas, Azcapotzalco, 02360 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (467, 9, 'Dalias', ' Lomas de Vista Hermosa', ' Cuajimalpa', 5100, 19.356565, -99.007363, 'Dalias, Lomas de Vista Hermosa, Cuajimalpa, 05100 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (468, 9, 'Meztli MZA1 LT48', ' El Arenal 4a Sección', ' Venustiano Carranza', 15640, 19.334566, -99.267363, 'Meztli MZA1 LT48, El Arenal 4a Sección, Venustiano Carranza, 15640 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (469, 9, 'Enrique Añorve 107', ' Ampliación San Pedro Xalpa', ' Azcapotzalco', 2719, 19.334566, -99.267363, 'Enrique Añorve 107, Ampliación San Pedro Xalpa, Azcapotzalco, 02719 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (470, 9, 'Vencedora 48', ' Industrial', ' Gustavo A. Madero', 7800, 19.334566, -99.267363, 'Vencedora 48, Industrial, Gustavo A. Madero, 07800 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (471, 9, 'Propiedad (Polar)', ' Lomas de La Estancia', ' Iztapalapa', 9640, 19.344666, -99.207352, 'Propiedad (Polar), Lomas de La Estancia, Iztapalapa, 09640 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (472, 9, 'Loma Linda 270', ' Lomas de Vista Hermosa', ' Cuajimalpa', 5100, 19.434555, -99.147362, 'Loma Linda 270, Lomas de Vista Hermosa, Cuajimalpa, 05100 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (473, 9, 'Privada Felipe Angeles 5-8', ' Ampliación El Triunfo', ' Iztapalapa', 9438, 19.434555, -99.147362, 'Privada Felipe Angeles 5-8, Ampliación El Triunfo, Iztapalapa, 09438 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (474, 9, 'Benemérito de Las Americas MZ15 LT4', ' Nueva Díaz Ordaz', ' Coyoacán', 4390, 19.434555, -99.147362, 'Benemérito de Las Americas MZ15 LT4, Nueva Díaz Ordaz, Coyoacán, 04390 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (475, 9, 'Jilotepec MZ3 LT7', ' 2da Ampliación Santiago Acahualtepec', ' Iztapalapa', 9609, 19.375556, -99.216362, 'Jilotepec MZ3 LT7, 2da Ampliación Santiago Acahualtepec, Iztapalapa, 09609 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (476, 9, 'Xiutetelco MZC5 LT30', ' El Arenal 4a Sección', ' Venustiano Carranza', 15640, 19.375556, -99.216362, 'Xiutetelco MZC5 LT30, El Arenal 4a Sección, Venustiano Carranza, 15640 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (477, 9, '1a de Cipreces MZ207 LT105', ' 2da Ampliación Santiago Acahualtepec', ' Iztapalapa', 9609, 19.375556, -99.216362, '1a de Cipreces MZ207 LT105, 2da Ampliación Santiago Acahualtepec, Iztapalapa, 09609 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (478, 9, 'Calle Heroes', ' Guerrero', ' Cuauhtémoc', 6300, 19.375556, -99.216362, 'Calle Heroes, Guerrero, Cuauhtémoc, 06300 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (479, 9, 'Abasolo 26', ' Progreso Tizapan', ' Álvaro Obregón', 54200, 19.434565, -99.127353, 'Abasolo 26, Progreso Tizapan, Álvaro Obregón, 54200 Polotitlán, State of Mexico, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (480, 9, 'Guardiola 90', ' Doctor Alfonso Ortiz Tirado', ' Iztapalapa', 9020, 19.469556, -99.246353, 'Guardiola 90, Doctor Alfonso Ortiz Tirado, Iztapalapa, 09020 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (481, 9, 'Calle Canarias 73', ' San Simon Ticumac', ' Benito Juarez', 3660, 19.469556, -99.246353, 'Calle Canarias 73, San Simon Ticumac, Benito Juarez, 03660 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (482, 9, 'San Bernabé 896', ' San Jerónimo Lídice', ' Magdalena Contreras', 10200, 19.469556, -99.246353, 'San Bernabé 896, San Jerónimo Lídice, Magdalena Contreras, 10200 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (483, 9, 'Filipinas 314', ' Portales', ' Benito Juarez', 3300, 19.379655, -99.057382, 'Filipinas 314, Portales, Benito Juarez, 03300 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (484, 9, 'Poniente 116 649 B', ' Industrial Vallejo', ' Azcapotzalco', 2300, 19.379655, -99.057382, 'Poniente 116 649 B, Industrial Vallejo, Azcapotzalco, 02300 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (485, 9, 'Valentín Gómez Farias', ' Campamento 2 de Octubre', ' Iztacalco', 8930, 19.433566, -99.066382, 'Valentín Gómez Farias, Campamento 2 de Octubre, Iztacalco, 08930 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (486, 9, '1 Mercedes Abrego', ' Ctm VI Culhuacan', ' Coyoacán', 4480, 19.433566, -99.066382, '1 Mercedes Abrego, Ctm VI Culhuacan, Coyoacán, 04480 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (487, 9, 'Campo 3 Brazos', ' San Pedro Xalpa', ' Azcapotzalco', 2710, 19.433566, -99.066382, 'Campo 3 Brazos, San Pedro Xalpa, Azcapotzalco, 02710 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (488, 9, 'Ignacio Allende', ' Consejo Agrarista Mexicano', ' Iztapalapa', 9760, 19.362656, -99.167353, 'Ignacio Allende, Consejo Agrarista Mexicano, Iztapalapa, 09760 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (489, 9, 'Albino Terreros 26-28', ' Presidentes Ejidales', ' Coyoacán', 4470, 19.362656, -99.167353, 'Albino Terreros 26-28, Presidentes Ejidales, Coyoacán, 04470 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (490, 9, 'Sándalo 27', ' Santa María Insurgentes', ' Cuauhtémoc', 6430, 19.362656, -99.167353, 'Sándalo 27, Santa María Insurgentes, Cuauhtémoc, 06430 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (491, 9, 'San Felipe 229', ' Xoco', ' Benito Juarez', 3330, 19.344565, -99.206373, 'San Felipe 229, Xoco, Benito Juarez, 03330 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (492, 9, 'Paseo de Las Palmas 805', ' Lomas de Chapultepec', ' Miguel Hidalgo', 11000, 19.344565, -99.206373, 'Paseo de Las Palmas 805, Lomas de Chapultepec, Miguel Hidalgo, 11000 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (493, 9, 'Avenida División del Norte 1611', ' Residencial Emperadores', ' Santa Cruz Atoyac', 3310, 19.333656, -99.217353, 'Avenida División del Norte 1611, Residencial Emperadores, Santa Cruz Atoyac, 03310 Benito Juárez, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (494, 9, 'De Las Presas MZ6 LT1A', ' Presa Sección Hornos', ' Álvaro Obregón', 1270, 19.333656, -99.217353, 'De Las Presas MZ6 LT1A, Presa Sección Hornos, Álvaro Obregón, 01270 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (495, 9, 'Hoja de Árbol', ' Infonavit Iztacalco', ' Iztacalco', 8900, 19.333656, -99.217353, 'Hoja de Árbol, Infonavit Iztacalco, Iztacalco, 08900 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (496, 9, 'Prolongación Misterios 133', ' Santa Isabel Tola', ' Gustavo A. Madero', 7010, 19.357566, -99.167383, 'Prolongación Misterios 133, Santa Isabel Tola, Gustavo A. Madero, 07010 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (497, 9, 'Mendelssohn 70', ' Vallejo', ' Gustavo A. Madero', 7870, 19.357566, -99.167383, 'Mendelssohn 70, Vallejo, Gustavo A. Madero, 07870 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (498, 9, 'Nicolás San Juan 1527', ' Del Valle', ' Benito Juarez', 3100, 19.357566, -99.167383, 'Nicolás San Juan 1527, Del Valle, Benito Juarez, 03100 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (499, 9, 'Jiquilpan 139', ' Janitzio', ' Venustiano Carranza', 15200, 19.444656, -99.007382, 'Jiquilpan 139, Janitzio, Venustiano Carranza, 15200 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (500, 9, 'Calzada de La Ronda 133', ' Ex Hipódromo de Peralvillo', ' Cuauhtémoc', 6250, 19.334666, -99.227373, 'Calzada de La Ronda 133, Ex Hipódromo de Peralvillo, Cuauhtémoc, 06250 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (501, 9, '631 238', ' San Juan de Aragón 4a Sección', ' Gustavo A. Madero', 7979, 19.339656, -99.067382, '631 238, San Juan de Aragón 4a Sección, Gustavo A. Madero, 07979 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (502, 9, 'Nicolás San Juan 1527', ' Del Valle', ' Benito Juarez', 3100, 19.339656, -99.067382, 'Nicolás San Juan 1527, Del Valle, Benito Juarez, 03100 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (503, 9, 'San Jerónimo', ' Centro', ' Cuauhtémoc', 6000, 19.336566, -99.176373, 'San Jerónimo, Centro, Cuauhtémoc, 06000 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (504, 9, 'Abasolo 26', ' Progreso Tizapan', ' Álvaro Obregón', 54200, 19.336566, -99.176373, 'Abasolo 26, Progreso Tizapan, Álvaro Obregón, 54200 Polotitlán, State of Mexico, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (505, 9, 'Morelos', ' Pueblo Santa Fe', ' Álvaro Obregón', 1210, 19.336566, -99.176373, 'Morelos, Pueblo Santa Fe, Álvaro Obregón, 01210 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (506, 9, 'Rosales', ' Zedec Santa Fe', ' Álvaro Obregón', 1219, 19.472555, -99.257372, 'Rosales, Zedec Santa Fe, Álvaro Obregón, 01219 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (507, 9, 'Transmisiones Militares 15', ' Residencial Lomas de Sotelo', ' Fraccionamiento Lomas de Sotelo', 53390, 19.427566, -99.107372, 'Transmisiones Militares 15, Residencial Lomas de Sotelo, Fraccionamiento Lomas de Sotelo, 53390 Naucalpan, State of Mexico, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (508, 9, '5 de Mayo 16A', ' San Francisco Culhuacan', ' Coyoacán', 4260, 19.438655, -99.007362, '5 de Mayo 16A, San Francisco Culhuacan, Coyoacán, 04260 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (509, 9, 'Juan B. Alberti', ' Integración Latinoamericana', ' Coyoacán', 4350, 19.438655, -99.007362, 'Juan B. Alberti, Integración Latinoamericana, Coyoacán, 04350 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (510, 9, 'Jaime Henrich', ' Los Gamitos', ' Álvaro Obregón', 1230, 19.428665, -99.257363, 'Jaime Henrich, Los Gamitos, Álvaro Obregón, 01230 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (511, 9, 'Bosques de Palmitos', ' Lomas de Bezares', ' Miguel Hidalgo', 11910, 19.362656, -99.106383, 'Bosques de Palmitos, Lomas de Bezares, Miguel Hidalgo, 11910 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (512, 9, 'Misioneros 9', ' Centro', ' Cuauhtémoc', 6000, 19.362656, -99.106383, 'Misioneros 9, Centro, Cuauhtémoc, 06000 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (513, 9, 'Planeta', ' Lomas de La Estancia', ' Iztapalapa', 9640, 19.362656, -99.106383, 'Planeta, Lomas de La Estancia, Iztapalapa, 09640 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (514, 9, 'Estampado', ' 20 de Noviembre', ' Venustiano Carranza', 15300, 19.489666, -99.136353, 'Estampado, 20 de Noviembre, Venustiano Carranza, 15300 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (515, 9, 'Filósofos 17', ' Nueva Rosita', ' Iztapalapa', 9420, 19.489666, -99.136353, 'Filósofos 17, Nueva Rosita, Iztapalapa, 09420 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (516, 9, 'Eje 3 Norte Calzada San Isidro', ' Providencia', ' Azcapotzalco', 2440, 19.449566, -99.057363, 'Eje 3 Norte Calzada San Isidro, Providencia, Azcapotzalco, 02440 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (517, 9, 'Esther Zuno', ' Consejo Agrarista Mexicano', ' Iztapalapa', 9760, 19.375666, -99.046373, 'Esther Zuno, Consejo Agrarista Mexicano, Iztapalapa, 09760 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (518, 9, 'Maíz 263', ' Valle del Sur', ' Iztapalapa', 9819, 19.327666, -99.067382, 'Maíz 263, Valle del Sur, Iztapalapa, 09819 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (519, 9, 'Mata Obscura', ' Jalalpa Tepito 2a. Ampliación', ' Álvaro Obregón', 1296, 19.456665, -99.026362, 'Mata Obscura, Jalalpa Tepito 2a. Ampliación, Álvaro Obregón, 01296 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (520, 9, 'Avenida Torres Ixtapaltongo', ' San José del Olivar', ' Álvaro Obregón', 1848, 19.463565, -99.057372, 'Avenida Torres Ixtapaltongo, San José del Olivar, Álvaro Obregón, 01848 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (521, 9, 'Avenida 608 279', ' San Juan de Aragón 4a Sección', ' Gustavo A. Madero', 7979, 19.468655, -99.137372, 'Avenida 608 279, San Juan de Aragón 4a Sección, Gustavo A. Madero, 07979 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (522, 9, 'Cruz del Sur 62', ' Prado Churubusco', ' Coyoacán', 4230, 19.468655, -99.137372, 'Cruz del Sur 62, Prado Churubusco, Coyoacán, 04230 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (523, 9, 'Cerrada Condor', ' Águilas Sección Hornos', ' Álvaro Obregón', 1048, 19.372565, -99.167362, 'Cerrada Condor, Águilas Sección Hornos, Álvaro Obregón, 01048 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (524, 9, 'Mártires Irlandeses 22', ' Parque San Andrés', ' Coyoacán', 4040, 19.442655, -99.036352, 'Mártires Irlandeses 22, Parque San Andrés, Coyoacán, 04040 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (525, 9, 'Coacota', ' Zenón Delgado', ' Álvaro Obregón', 1220, 19.466565, -99.267383, 'Coacota, Zenón Delgado, Álvaro Obregón, 01220 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (526, 9, 'General Vicente Guerrero 30', ' 15 de Agosto', ' Gustavo A. Madero', 7050, 19.475566, -99.177353, 'General Vicente Guerrero 30, 15 de Agosto, Gustavo A. Madero, 07050 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (527, 9, 'Bandera', ' Lomas De santa Fe', ' Álvaro Obregón', 1219, 19.475566, -99.177353, 'Bandera, Lomas De santa Fe, Álvaro Obregón, 01219 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (528, 9, 'Anaxágoras 715', ' Narvarte', ' Benito Juarez', 3000, 19.359566, -99.226373, 'Anaxágoras 715, Narvarte, Benito Juarez, 03000 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (529, 9, 'Eje 4 Sur (Xola) 1302', ' Esperanza', ' Benito Juarez', 3020, 19.457666, -99.166382, 'Eje 4 Sur (Xola) 1302, Esperanza, Benito Juarez, 03020 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (530, 9, 'Creta', ' Lomas de Axomiatla', ' Álvaro Obregón', 1820, 19.465566, -99.236362, 'Creta, Lomas de Axomiatla, Álvaro Obregón, 01820 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (531, 9, 'Maíz 358', ' Valle del Sur', ' Iztapalapa', 9819, 19.323565, -99.226382, 'Maíz 358, Valle del Sur, Iztapalapa, 09819 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (532, 9, 'Autopista México-Marquesa', ' Zedec Santa Fe', ' Álvaro Obregón', 1219, 19.429555, -99.077372, 'Autopista México-Marquesa, Zedec Santa Fe, Álvaro Obregón, 01219 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (533, 9, 'Bosque de Canelos 95', ' Bosques de Las Lomas', ' Cuajimalpa', 5120, 19.366665, -99.206373, 'Bosque de Canelos 95, Bosques de Las Lomas, Cuajimalpa, 05120 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (534, 9, 'Ruiz Cortines', ' Pensador Mexicano', ' Venustiano Carranza', 15510, 19.476566, -99.236382, 'Ruiz Cortines, Pensador Mexicano, Venustiano Carranza, 15510 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (535, 9, 'Doctor Alfonso Caso Andrade', ' Pilares Águilas', ' Álvaro Obregón', 1710, 19.476566, -99.026352, 'Doctor Alfonso Caso Andrade, Pilares Águilas, Álvaro Obregón, 01710 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (536, 9, 'Loma Chica LB', ' Lomas de Tarango', ' Álvaro Obregón', 1620, 19.325566, -99.146383, 'Loma Chica LB, Lomas de Tarango, Álvaro Obregón, 01620 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (537, 9, 'Canadá Los Helechos 434', ' San Mateo Tlaltenango', ' Cuajimalpa', 5600, 19.453556, -99.236363, 'Canadá Los Helechos 434, San Mateo Tlaltenango, Cuajimalpa, 05600 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (538, 9, 'Calle 20 25', ' Olivar del Conde 1a. Sección', ' Álvaro Obregón', 1400, 19.345566, -99.277362, 'Calle 20 25, Olivar del Conde 1a. Sección, Álvaro Obregón, 01400 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (539, 9, 'San Luis 27', ' Corpus Cristy', ' Álvaro Obregón', 1530, 19.436556, -99.066373, 'San Luis 27, Corpus Cristy, Álvaro Obregón, 01530 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (540, 9, 'San Miguel', ' Tetelpan', ' Álvaro Obregón', 1700, 19.463655, -99.037362, 'San Miguel, Tetelpan, Álvaro Obregón, 01700 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (541, 9, 'Avenida Bordo Xochiaca', ' Aeropuerto Int de La Ciudad de México', ' Venustiano Carranza', 15620, 19.369665, -99.076353, 'Avenida Bordo Xochiaca, Aeropuerto Int de La Ciudad de México, Venustiano Carranza, 15620 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (542, 9, 'Raúl Zárate Machuca', ' Cuevitas', ' Álvaro Obregón', 1220, 19.358665, -99.026382, 'Raúl Zárate Machuca, Cuevitas, Álvaro Obregón, 01220 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (543, 9, 'Sur 22 129', ' Agrícola Oriental', ' Iztacalco', 8500, 19.382665, -99.167382, 'Sur 22 129, Agrícola Oriental, Iztacalco, 08500 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (544, 9, 'Paseo Capulines 24', ' Paseos de Taxqueña', ' Coyoacán', 4250, 19.334665, -99.036382, 'Paseo Capulines 24, Paseos de Taxqueña, Coyoacán, 04250 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (545, 9, 'Vizcaínas 8-10', ' Doctor Alfonso Ortiz Tirado', ' Iztapalapa', 9020, 19.436656, -99.206362, 'Vizcaínas 8-10, Doctor Alfonso Ortiz Tirado, Iztapalapa, 09020 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (546, 9, 'Vía Express Tapo *(VISUAL)', ' Aeropuerto Int de La Ciudad de México', ' Venustiano Carranza', 15620, 19.332665, -99.227372, 'Vía Express Tapo *(VISUAL), Aeropuerto Int de La Ciudad de México, Venustiano Carranza, 15620 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (547, 9, 'Pisco 545', ' Churubusco Tepeyac', ' Gustavo A. Madero', 7730, 19.475566, -99.257353, 'Pisco 545, Churubusco Tepeyac, Gustavo A. Madero, 07730 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (548, 9, 'Plan de Agua Prieta 66', ' Plutarco Elías Calles', ' Miguel Hidalgo', 11340, 19.372555, -99.127372, 'Plan de Agua Prieta 66, Plutarco Elías Calles, Miguel Hidalgo, 11340 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (549, 9, 'Artes 22', ' Santa Catarina', ' Coyoacán', 4010, 19.484555, -99.107373, 'Artes 22, Santa Catarina, Coyoacán, 04010 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (550, 9, 'Rumania 609', ' Portales', ' Benito Juarez', 3300, 19.382556, -99.016362, 'Rumania 609, Portales, Benito Juarez, 03300 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (551, 9, 'San Bartolo-Naucalpan 182 a', ' Nueva Argentina (Argentina Poniente)', ' Argentina Poniente', 11230, 19.463666, -99.137363, 'San Bartolo-Naucalpan 182 a, Nueva Argentina (Argentina Poniente), Argentina Poniente, 11230 Miguel Hidalgo, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (552, 9, 'Río Nilo', ' Puente Blanco', ' Iztapalapa', 9770, 19.439566, -99.006372, 'Río Nilo, Puente Blanco, Iztapalapa, 09770 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (553, 9, 'Gregorio A. Tello 4', ' Constitución de 1917', ' Iztapalapa', 9260, 19.349665, -99.267372, 'Gregorio A. Tello 4, Constitución de 1917, Iztapalapa, 09260 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (554, 9, 'Campo 3 Brazos 11', ' San Antonio', ' Azcapotzalco', 2760, 19.336655, -99.166353, 'Campo 3 Brazos 11, San Antonio, Azcapotzalco, 02760 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (555, 9, 'Norte 11-A 4719', ' Defensores de La República', ' Gustavo A. Madero', 7780, 19.457566, -99.136353, 'Norte 11-A 4719, Defensores de La República, Gustavo A. Madero, 07780 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (556, 9, 'San Esteban 85', ' Santo Tomas', ' Azcapotzalco', 2020, 19.457566, -99.136353, 'San Esteban 85, Santo Tomas, Azcapotzalco, 02020 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (557, 9, 'Roble', ' Garcimarreronorte', ' Álvaro Obregón', 1510, 19.457566, -99.136353, 'Roble, Garcimarreronorte, Álvaro Obregón, 01510 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (558, 9, 'Pedro A. Chapa', ' Colonial Iztapalapa', ' Iztapalapa', 9270, 19.435656, -99.037383, 'Pedro A. Chapa, Colonial Iztapalapa, Iztapalapa, 09270 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (559, 9, 'Zapata', ' La Magdalena Culhuacan', ' Coyoacán', 4260, 19.435656, -99.037383, 'Zapata, La Magdalena Culhuacan, Coyoacán, 04260 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (560, 9, 'Ceylan 585', ' Industrial Vallejo', ' Gustavo A. Madero', 7729, 19.439566, -99.166372, 'Ceylan 585, Industrial Vallejo, Gustavo A. Madero, 07729 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (561, 9, 'Calle Ignacio Zaragoza MZ127 LT1003', ' Zona Urbana Ejidal Santa Martha Acatitla Norte', ' Iztapalapa', 9140, 19.439566, -99.166372, 'Calle Ignacio Zaragoza MZ127 LT1003, Zona Urbana Ejidal Santa Martha Acatitla Norte, Iztapalapa, 09140 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (562, 9, 'Año de Juárez 198', ' Granjas San Antonio', ' Iztapalapa', 9070, 19.428555, -99.237363, 'Año de Juárez 198, Granjas San Antonio, Iztapalapa, 09070 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (563, 9, 'Camino Viejo a Mixcoac 3525', ' San Bartolo Ameyalco', ' Álvaro Obregón', 1800, 19.428555, -99.237363, 'Camino Viejo a Mixcoac 3525, San Bartolo Ameyalco, Álvaro Obregón, 01800 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (564, 9, 'Eje 2 Norte (Manuel González) 115', ' Ex Hipódromo de Peralvillo', ' Cuauhtémoc', 6250, 19.345566, -99.126363, 'Eje 2 Norte (Manuel González) 115, Ex Hipódromo de Peralvillo, Cuauhtémoc, 06250 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (565, 9, 'Matamoros', ' Morelos', ' Cuauhtémoc', 6200, 19.345566, -99.126363, 'Matamoros, Morelos, Cuauhtémoc, 06200 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (566, 9, 'Paseo de la Reforma 24', ' Tabacalera', ' Cuauhtémoc', 6000, 19.436565, -99.247383, 'Paseo de la Reforma 24, Tabacalera, Cuauhtémoc, 06000 Mexico City, MX, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (567, 9, 'Herreros 53', ' Morelos', ' Venustiano Carranza', 15940, 19.436565, -99.247383, 'Herreros 53, Morelos, Venustiano Carranza, 15940 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (568, 9, 'Horticultura 236', ' 20 de Noviembre', ' Venustiano Carranza', 15300, 19.436565, -99.247383, 'Horticultura 236, 20 de Noviembre, Venustiano Carranza, 15300 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (569, 9, 'Agua 160', ' Jardines del Pedregal', ' Álvaro Obregón', 1900, 19.377556, -99.217353, 'Agua 160, Jardines del Pedregal, Álvaro Obregón, 01900 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (570, 9, 'La Joya', ' Bosques Tarango', ' Álvaro Obregón', 1580, 19.377556, -99.217353, 'La Joya, Bosques Tarango, Álvaro Obregón, 01580 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (571, 9, 'Manuel P. Romero 30', ' Zona Urbana Ejidal Santa Martha Acatitla Norte', ' Iztapalapa', 9140, 19.373556, -99.047353, 'Manuel P. Romero 30, Zona Urbana Ejidal Santa Martha Acatitla Norte, Iztapalapa, 09140 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (572, 9, 'Morelos 44', ' Ampliación Zona Urbana Ejidal Santa María Aztahuacan', ' Iztapalapa', 9570, 19.373556, -99.047353, 'Morelos 44, Ampliación Zona Urbana Ejidal Santa María Aztahuacan, Iztapalapa, 09570 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (573, 9, 'Colipa', ' 2a. Ampliación Jalalpa El Grande', ' Álvaro Obregón', 1296, 19.373556, -99.047353, 'Colipa, 2a. Ampliación Jalalpa El Grande, Álvaro Obregón, 01296 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (574, 9, 'Reyna Xochitl', ' El Paraíso', ' Iztapalapa', 9230, 19.428655, -99.027362, 'Reyna Xochitl, El Paraíso, Iztapalapa, 09230 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (575, 9, 'Mariquita Sánchez', ' Ctm VI Culhuacan', ' Coyoacán', 4480, 19.428655, -99.027362, 'Mariquita Sánchez, Ctm VI Culhuacan, Coyoacán, 04480 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (576, 9, 'San Francisco 1838-1856', ' Actipan', ' Benito Juarez', 3240, 19.428655, -99.027362, 'San Francisco 1838-1856, Actipan, Benito Juarez, 03240 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (577, 9, 'Pennsylvania 280', ' Ciudad de Los Deportes', ' Benito Juarez', 3810, 19.428655, -99.027362, 'Pennsylvania 280, Ciudad de Los Deportes, Benito Juarez, 03810 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (578, 9, 'Río Nilo', ' Puente Blanco', ' Iztapalapa', 9770, 19.389655, -99.057382, 'Río Nilo, Puente Blanco, Iztapalapa, 09770 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (579, 9, 'Emperadores 235', ' Residencial Emperadores', ' Santa Cruz Atoyac', 3320, 19.389655, -99.057382, 'Emperadores 235, Residencial Emperadores, Santa Cruz Atoyac, 03320 Benito Juárez, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (580, 9, 'Carretera Federal Mexico - Toluca', ' Palo Alto(Granjas)', ' Cuajimalpa', 5110, 19.435566, -99.177372, 'Carretera Federal Mexico - Toluca, Palo Alto(Granjas), Cuajimalpa, 05110 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (581, 9, 'Sur 69 476', ' Banjidal', ' Iztapalapa', 9450, 19.435566, -99.177372, 'Sur 69 476, Banjidal, Iztapalapa, 09450 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (582, 9, 'Calle 63 125', ' Santa Cruz Meyehualco', ' Iztapalapa', 9290, 19.435566, -99.177372, 'Calle 63 125, Santa Cruz Meyehualco, Iztapalapa, 09290 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (583, 9, 'Pensylvania 241', ' Nápoles', ' Benito Juarez', 3810, 19.429556, -99.166383, 'Pensylvania 241, Nápoles, Benito Juarez, 03810 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (584, 9, '21 de Marzo MZ6 LT3', ' Ampliación Candelaria', ' Coyoacán', 4389, 19.429556, -99.166383, '21 de Marzo MZ6 LT3, Ampliación Candelaria, Coyoacán, 04389 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (585, 9, 'Don Luis 69', ' Nativitas', ' Benito Juarez', 3500, 19.457655, -99.036352, 'Don Luis 69, Nativitas, Benito Juarez, 03500 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (586, 9, 'Eje 10 Sur (Canoa) 77', ' Progreso Tizapan', ' Álvaro Obregón', 1080, 19.457655, -99.036352, 'Eje 10 Sur (Canoa) 77, Progreso Tizapan, Álvaro Obregón, 01080 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (587, 9, 'Anfora 44B', ' Industrial', ' Gustavo A. Madero', 7800, 19.432565, -99.166363, 'Anfora 44B, Industrial, Gustavo A. Madero, 07800 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (588, 9, 'Fray Servando Teresa de Mier 356', ' Centro', ' Cuauhtémoc', 6090, 19.432565, -99.166363, 'Fray Servando Teresa de Mier 356, Centro, Cuauhtémoc, 06090 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (589, 9, 'Copa de Oro 69', ' Ciudad Jardín', ' Coyoacán', 4370, 19.432556, -99.236373, 'Copa de Oro 69, Ciudad Jardín, Coyoacán, 04370 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (590, 9, 'F.f. C.c. de Cuernavaca 318', ' Polanco', ' Miguel Hidalgo', 11550, 19.432556, -99.236373, 'F.f. C.c. de Cuernavaca 318, Polanco, Miguel Hidalgo, 11550 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (591, 9, 'Benito Juárez', ' Progresista', ' Iztapalapa', 9240, 19.432556, -99.236373, 'Benito Juárez, Progresista, Iztapalapa, 09240 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (592, 9, 'Pirules', ' Solidaridad', ' Iztapalapa', 9160, 19.482555, -99.067373, 'Pirules, Solidaridad, Iztapalapa, 09160 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (593, 9, 'Calle Tarango', ' San Clemente Norte', ' Álvaro Obregón', 1740, 19.458555, -99.127372, 'Calle Tarango, San Clemente Norte, Álvaro Obregón, 01740 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (594, 9, 'Anillo Periférico 2773', ' San Jerónimo Lídice', ' Magdalena Contreras', 10200, 19.458555, -99.127372, 'Anillo Periférico 2773, San Jerónimo Lídice, Magdalena Contreras, 10200 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (595, 9, 'Norte 15-A 4918', ' Magdalena de Las Salinas', ' Azcapotzalco', 7760, 19.458555, -99.127372, 'Norte 15-A 4918, Magdalena de Las Salinas, Azcapotzalco, 07760 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (596, 9, 'José María Morelos y Pavón', ' Torres de Potrero', ' Álvaro Obregón', 1840, 19.388566, -99.056372, 'José María Morelos y Pavón, Torres de Potrero, Álvaro Obregón, 01840 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (597, 9, 'Gobernación', ' Zona Urbana Ejidal Estrella Culhuacan', ' Iztapalapa', 9800, 19.388566, -99.056372, 'Gobernación, Zona Urbana Ejidal Estrella Culhuacan, Iztapalapa, 09800 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (598, 9, 'Repúblicas 205', ' Portales', ' Benito Juarez', 3300, 19.388566, -99.056372, 'Repúblicas 205, Portales, Benito Juarez, 03300 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (599, 9, 'Orion 6', ' Prado Churubusco', ' Coyoacán', 4230, 19.355655, -99.147362, 'Orion 6, Prado Churubusco, Coyoacán, 04230 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (600, 9, 'Ricardo Flores Magón 392', ' Santa María La Ribera', ' Cuauhtémoc', 6400, 19.355655, -99.147362, 'Ricardo Flores Magón 392, Santa María La Ribera, Cuauhtémoc, 06400 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (601, 9, 'Eje 1 Poniente (Av. Cuauhtémoc) 808', ' Narvarte', ' Benito Juarez', 3020, 19.483655, -99.227363, 'Eje 1 Poniente (Av. Cuauhtémoc) 808, Narvarte, Benito Juarez, 03020 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (602, 9, 'Retorno 204', ' Modelo', ' Iztapalapa', 9089, 19.483655, -99.227363, 'Retorno 204, Modelo, Iztapalapa, 09089 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (603, 9, 'Norte 75 15', ' Popotla', ' Miguel Hidalgo', 11400, 19.469565, -99.166373, 'Norte 75 15, Popotla, Miguel Hidalgo, 11400 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (604, 9, 'Oriente 2', ' Cuchilla del Tesoro', ' Gustavo A. Madero', 7900, 19.469565, -99.166373, 'Oriente 2, Cuchilla del Tesoro, Gustavo A. Madero, 07900 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (605, 9, 'Rosales', ' Zedec Santa Fe', ' Álvaro Obregón', 1219, 19.369666, -99.067373, 'Rosales, Zedec Santa Fe, Álvaro Obregón, 01219 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (606, 9, 'Gómez Farias 331', ' Zedec Santa Fe', ' Álvaro Obregón', 1219, 19.482655, -99.117383, 'Gómez Farias 331, Zedec Santa Fe, Álvaro Obregón, 01219 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (607, 9, 'Privada Corina 37', ' Del Carmen', ' Coyoacán', 4100, 19.482655, -99.117383, 'Privada Corina 37, Del Carmen, Coyoacán, 04100 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (608, 9, 'Coxcox 75', ' El Arenal 3a Sección', ' Venustiano Carranza', 15660, 19.482655, -99.117383, 'Coxcox 75, El Arenal 3a Sección, Venustiano Carranza, 15660 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (609, 9, 'Laguna de Términos 395', ' Anáhuac', ' Miguel Hidalgo', 11320, 19.372655, -99.206383, 'Laguna de Términos 395, Anáhuac, Miguel Hidalgo, 11320 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (610, 9, '3ER. Anillo de Circunvalación 270C', ' Granjas San Antonio', ' Iztapalapa', 9000, 19.372655, -99.206383, '3ER. Anillo de Circunvalación 270C, Granjas San Antonio, Iztapalapa, 09000 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (611, 9, 'Minerva 803', ' Axotla', ' Álvaro Obregón', 1030, 19.478655, -99.037383, 'Minerva 803, Axotla, Álvaro Obregón, 01030 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (612, 9, 'Desierto de Los Leones 5720', ' Cedros', ' Álvaro Obregón', 1729, 19.478655, -99.037383, 'Desierto de Los Leones 5720, Cedros, Álvaro Obregón, 01729 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (613, 9, 'Avestruz', ' Golondrinas', ' Álvaro Obregón', 1270, 19.333666, -99.217383, 'Avestruz, Golondrinas, Álvaro Obregón, 01270 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (614, 9, 'Santa Lucía', ' Buenavista', ' Iztapalapa', 9700, 19.438656, -99.177362, 'Santa Lucía, Buenavista, Iztapalapa, 09700 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (615, 9, 'Francisco T. Contreras MZ4 LT9', ' Álvaro Obregón', ' Iztapalapa', 9230, 19.354656, -99.066353, 'Francisco T. Contreras MZ4 LT9, Álvaro Obregón, Iztapalapa, 09230 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (616, 9, 'Donizetti 29', ' Vallejo', ' Gustavo A. Madero', 7870, 19.354656, -99.066353, 'Donizetti 29, Vallejo, Gustavo A. Madero, 07870 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (617, 9, 'Avenida Ing. Eduardo Molina 4427', ' La Joya', ' Gustavo A. Madero', 7890, 19.463555, -99.017352, 'Avenida Ing. Eduardo Molina 4427, La Joya, Gustavo A. Madero, 07890 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (618, 9, 'Flor de Nube', ' Torres de Potrero', ' Álvaro Obregón', 1840, 19.454555, -99.126362, 'Flor de Nube, Torres de Potrero, Álvaro Obregón, 01840 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (619, 9, 'Avenida Ing. Eduardo Molina', ' El Parque', ' Venustiano Carranza', 15960, 19.325565, -99.047363, 'Avenida Ing. Eduardo Molina, El Parque, Venustiano Carranza, 15960 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (620, 9, 'Camino Campestre a 157', ' Campestre Aragón', ' Gustavo A. Madero', 7530, 19.369555, -99.237362, 'Camino Campestre a 157, Campestre Aragón, Gustavo A. Madero, 07530 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (621, 9, 'General Vicente Guerrero 196', ' Martin Carrera', ' Gustavo A. Madero', 7070, 19.388665, -99.057363, 'General Vicente Guerrero 196, Martin Carrera, Gustavo A. Madero, 07070 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (622, 9, 'República del Salvador 44', ' Centro', ' Cuauhtémoc', 6000, 19.388665, -99.057363, 'República del Salvador 44, Centro, Cuauhtémoc, 06000 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (623, 9, 'Bahía de Descanso 16', ' Verónica Anzures', ' Miguel Hidalgo', 11300, 19.489566, -99.217372, 'Bahía de Descanso 16, Verónica Anzures, Miguel Hidalgo, 11300 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (624, 9, 'Emiliano Zapata MZ40 LT439', ' Zona Urbana Ejidal Santa María Aztahuacan', ' Iztapalapa', 9570, 19.337565, -99.067353, 'Emiliano Zapata MZ40 LT439, Zona Urbana Ejidal Santa María Aztahuacan, Iztapalapa, 09570 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (625, 9, 'Bogotá 649', ' Lindavista', ' Gustavo A. Madero', 7300, 19.337565, -99.067353, 'Bogotá 649, Lindavista, Gustavo A. Madero, 07300 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (626, 9, 'Osa Menor 92', ' Prado Churubusco', ' Coyoacán', 4230, 19.386565, -99.036382, 'Osa Menor 92, Prado Churubusco, Coyoacán, 04230 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (627, 9, 'Holbein', ' Ciudad de Los Deportes', ' Benito Juarez', 3710, 19.386565, -99.036382, 'Holbein, Ciudad de Los Deportes, Benito Juarez, 03710 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (628, 9, 'Tajín 763', ' Letrán Valle', ' Benito Juarez', 3650, 19.445666, -99.056383, 'Tajín 763, Letrán Valle, Benito Juarez, 03650 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (629, 9, 'Callejón Benito Juárez 5', ' Norte', ' Álvaro Obregón', 1410, 19.362555, -99.037372, 'Callejón Benito Juárez 5, Norte, Álvaro Obregón, 01410 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (630, 9, 'Batalla de Celaya', ' Militar 1 K Lomas de Sotelo', ' Miguel Hidalgo', 11200, 19.454556, -99.237373, 'Batalla de Celaya, Militar 1 K Lomas de Sotelo, Miguel Hidalgo, 11200 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (631, 9, 'Duraznos', ' Las Cruces', ' Magdalena Contreras', 10330, 19.454556, -99.237373, 'Duraznos, Las Cruces, Magdalena Contreras, 10330 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (632, 9, 'Arroz 226', ' Santa Isabel Industrial', ' Iztapalapa', 9820, 19.338655, -99.167382, 'Arroz 226, Santa Isabel Industrial, Iztapalapa, 09820 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (633, 9, 'Pedro Monte', ' 2a. Ampliación Presidentes', ' Álvaro Obregón', 1299, 19.452655, -99.027362, 'Pedro Monte, 2a. Ampliación Presidentes, Álvaro Obregón, 01299 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (634, 9, 'Ezequiel Montes 134', ' Tabacalera', ' Cuauhtémoc', 6030, 19.452655, -99.027362, 'Ezequiel Montes 134, Tabacalera, Cuauhtémoc, 06030 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (635, 9, 'Avenida Ing. Eduardo Molina 3736', ' La Joya', ' Gustavo A. Madero', 7890, 19.326666, -99.216362, 'Avenida Ing. Eduardo Molina 3736, La Joya, Gustavo A. Madero, 07890 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (636, 9, 'Lomas del Angel 13', ' Lomas de Tarango', ' Álvaro Obregón', 1620, 19.325565, -99.217363, 'Lomas del Angel 13, Lomas de Tarango, Álvaro Obregón, 01620 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (637, 9, 'Doctor José María Vertiz 12', ' Doctores', ' Cuauhtémoc', 6720, 19.337665, -99.176363, 'Doctor José María Vertiz 12, Doctores, Cuauhtémoc, 06720 Cuauhtemoc, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (638, 9, 'Nogales', ' Lomas de Capula', ' Álvaro Obregón', 1520, 19.467656, -99.227352, 'Nogales, Lomas de Capula, Álvaro Obregón, 01520 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (639, 9, '3 Pioquinto Roldán MZ3 LT52', ' U Habitacional Vicente Guerrero I II ÌII IV V VI VII', ' Iztapalapa', 9200, 19.342666, -99.116373, '3 Pioquinto Roldán MZ3 LT52, U Habitacional Vicente Guerrero I II ÌII IV V VI VII, Iztapalapa, 09200 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (640, 9, 'Mar Marmara 379', ' Popotla', ' Miguel Hidalgo', 11400, 19.357656, -99.276353, 'Mar Marmara 379, Popotla, Miguel Hidalgo, 11400 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (641, 9, 'Violeta', ' Tlacoyaque', ' Álvaro Obregón', 1859, 19.483555, -99.146372, 'Violeta, Tlacoyaque, Álvaro Obregón, 01859 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (642, 9, 'Xoconoxtle 13', ' Infonavit Iztacalco', ' Iztacalco', 8900, 19.346655, -99.206372, 'Xoconoxtle 13, Infonavit Iztacalco, Iztacalco, 08900 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (643, 9, '16 de Septiembre', ' Culhuacan', ' Iztapalapa', 9800, 19.446556, -99.067372, '16 de Septiembre, Culhuacan, Iztapalapa, 09800 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (644, 9, 'Secretaría de Marina 435', ' Lomas de Vista Hermosa', ' Cuajimalpa', 5100, 19.444665, -99.207362, 'Secretaría de Marina 435, Lomas de Vista Hermosa, Cuajimalpa, 05100 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (645, 9, 'Calzada de la Naranja 867', ' Ampliación San Pedro Xalpa', ' San Isidro', 2710, 19.458556, -99.007352, 'Calzada de la Naranja 867, Ampliación San Pedro Xalpa, San Isidro, 02710 Azcapotzalco, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (646, 9, 'Avenida Insurgentes Norte', ' Tlacamaca', ' Gustavo A. Madero', 7380, 19.378666, -99.056383, 'Avenida Insurgentes Norte, Tlacamaca, Gustavo A. Madero, 07380 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (647, 9, 'Lomas del Angel 13', ' Lomas de Tarango', ' Álvaro Obregón', 1620, 19.462665, -99.227352, 'Lomas del Angel 13, Lomas de Tarango, Álvaro Obregón, 01620 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (648, 9, 'Batallón de Zacapoaxtla 8', ' Ejército de Oriente Indeco II ISSSTE', ' Ejercito de Oriente', 9230, 19.348566, -99.007382, 'Batallón de Zacapoaxtla 8, Ejército de Oriente Indeco II ISSSTE, Ejercito de Oriente, 09230 Iztapalapa, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (649, 9, 'Campo Colomo 24', ' San Antonio', ' Azcapotzalco', 2760, 19.352566, -99.077383, 'Campo Colomo 24, San Antonio, Azcapotzalco, 02760 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (650, 9, 'Río Lerma 100', ' Cuauhtémoc', ' Nueva Cobertura', 6500, 19.423665, -99.276372, 'Río Lerma 100, Cuauhtémoc, Nueva Cobertura, 06500 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (651, 9, 'Pedro A. Chapa', ' Colonial Iztapalapa', ' Iztapalapa', 9270, 19.444556, -99.117373, 'Pedro A. Chapa, Colonial Iztapalapa, Iztapalapa, 09270 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (652, 9, 'Avenida Tamaulipas 307', ' Lomas de Santa Fe', ' Cuajimalpa', 5600, 19.346656, -99.047352, 'Avenida Tamaulipas 307, Lomas de Santa Fe, Cuajimalpa, 05600 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (653, 9, 'Al Manantial', ' San Mateo Tlaltenango', ' Cuajimalpa', 5600, 19.347656, -99.046372, 'Al Manantial, San Mateo Tlaltenango, Cuajimalpa, 05600 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (654, 9, '604 315', ' Narciso Bassols', ' Gustavo A. Madero', 7980, 19.335566, -99.236362, '604 315, Narciso Bassols, Gustavo A. Madero, 07980 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (655, 9, 'Avenida Panteón', ' San Juan Cerro', ' Iztapalapa', 9858, 19.444666, -99.226362, 'Avenida Panteón, San Juan Cerro, Iztapalapa, 09858 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (656, 9, 'Donceles 36', ' Centro', ' Cuauhtémoc', 6010, 19.377566, -99.056352, 'Donceles 36, Centro, Cuauhtémoc, 06010 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (657, 9, 'Calle Nautla', ' Casa Blanca', ' Iztapalapa', 9860, 19.358565, -99.016383, 'Calle Nautla, Casa Blanca, Iztapalapa, 09860 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (658, 9, 'Sur 103 1110', ' El Parque', ' Venustiano Carranza', 15970, 19.424665, -99.026363, 'Sur 103 1110, El Parque, Venustiano Carranza, 15970 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (659, 9, 'Miguel Laurent 514', ' Del Valle', ' Benito Juarez', 3100, 19.443565, -99.027382, 'Miguel Laurent 514, Del Valle, Benito Juarez, 03100 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (660, 9, 'Avenida 608 23', ' San Juan de Aragón 3a Sección', ' Gustavo A. Madero', 7970, 19.462556, -99.207373, 'Avenida 608 23, San Juan de Aragón 3a Sección, Gustavo A. Madero, 07970 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (661, 9, 'Del Rosal', ' Los Angeles', ' Iztapalapa', 9830, 19.484555, -99.106373, 'Del Rosal, Los Angeles, Iztapalapa, 09830 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (662, 9, 'Calle Justo Sierra MZ20 LT8', ' Santa Cruz Meyehualco', ' Iztapalapa', 9730, 19.484555, -99.106373, 'Calle Justo Sierra MZ20 LT8, Santa Cruz Meyehualco, Iztapalapa, 09730 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (663, 9, 'Marcos López Jiménez MZ126 LT16', ' Zona Urbana Ejidal Santa Martha Acatitla Norte', ' Iztapalapa', 9140, 19.484555, -99.106373, 'Marcos López Jiménez MZ126 LT16, Zona Urbana Ejidal Santa Martha Acatitla Norte, Iztapalapa, 09140 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (664, 9, 'Javier Barros Sierra 225', ' Zedec Santa Fe', ' Álvaro Obregón', 1219, 19.484555, -99.106373, 'Javier Barros Sierra 225, Zedec Santa Fe, Álvaro Obregón, 01219 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (665, 9, 'Jose Antonio Alzate 70', ' Santa María La Ribera', ' Cuauhtémoc', 6400, 19.483556, -99.007382, 'Jose Antonio Alzate 70, Santa María La Ribera, Cuauhtémoc, 06400 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (666, 9, 'Frontera 36', ' Roma Norte', ' Cuauhtémoc', 6700, 19.483556, -99.007382, 'Frontera 36, Roma Norte, Cuauhtémoc, 06700 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (667, 9, 'Loma de Vista Hermosa 118', ' Lomas de Vista Hermosa', ' Cuajimalpa', 5100, 19.475655, -99.156353, 'Loma de Vista Hermosa 118, Lomas de Vista Hermosa, Cuajimalpa, 05100 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (668, 9, 'Villa Fruela MZ70B LT19', ' Lomas de Santa Cruz', ' Iztapalapa', 9700, 19.475655, -99.156353, 'Villa Fruela MZ70B LT19, Lomas de Santa Cruz, Iztapalapa, 09700 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (669, 9, 'Mina de Zinc', ' Tlacuitlapa Ampliación 2o. Reacomodo', ' Álvaro Obregón', 1650, 19.428566, -99.157362, 'Mina de Zinc, Tlacuitlapa Ampliación 2o. Reacomodo, Álvaro Obregón, 01650 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (670, 9, 'Herminio Chavarría', ' Zona Urbana Ejidal Santa María Aztahuacan', ' Iztapalapa', 9570, 19.428566, -99.157362, 'Herminio Chavarría, Zona Urbana Ejidal Santa María Aztahuacan, Iztapalapa, 09570 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (671, 9, 'Eje 3 Poniente (Av. Coyoacán) 739', ' Del Valle', ' Benito Juarez', 3100, 19.342565, -99.236353, 'Eje 3 Poniente (Av. Coyoacán) 739, Del Valle, Benito Juarez, 03100 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (672, 9, 'Cerrada de Popocatépetl 36', ' Xoco', ' Benito Juarez', 3330, 19.342565, -99.236353, 'Cerrada de Popocatépetl 36, Xoco, Benito Juarez, 03330 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (673, 9, 'Árbol de Fuego 17', ' Valle del Sur', ' Iztapalapa', 9819, 19.487556, -99.157373, 'Árbol de Fuego 17, Valle del Sur, Iztapalapa, 09819 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (674, 9, 'Ave María 18', ' Santa Catarina', ' Coyoacán', 4010, 19.487556, -99.157373, 'Ave María 18, Santa Catarina, Coyoacán, 04010 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (675, 9, 'Doctor Mora 1', ' Centro', ' Cuauhtémoc', 6050, 19.487556, -99.157373, 'Doctor Mora 1, Centro, Cuauhtémoc, 06050 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (676, 9, 'Carlos David Anderson MZ 1 LT B', ' Culhuacan', ' Iztapalapa', 9800, 19.323555, -99.147373, 'Carlos David Anderson MZ 1 LT B, Culhuacan, Iztapalapa, 09800 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (677, 9, 'Plutarco Elías Calles', ' Chinampac de Juárez', ' Iztapalapa', 9208, 19.323555, -99.147373, 'Plutarco Elías Calles, Chinampac de Juárez, Iztapalapa, 09208 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (678, 9, 'Rancho San Francisco', ' San Bartolo Ameyalco', ' Álvaro Obregón', 1800, 19.323555, -99.147373, 'Rancho San Francisco, San Bartolo Ameyalco, Álvaro Obregón, 01800 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (679, 9, 'Lauro Aguirre 57', ' Agricultura', ' Miguel Hidalgo', 11360, 19.342656, -99.177373, 'Lauro Aguirre 57, Agricultura, Miguel Hidalgo, 11360 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (680, 9, 'Donizetti 29', ' Vallejo', ' Gustavo A. Madero', 7870, 19.342656, -99.177373, 'Donizetti 29, Vallejo, Gustavo A. Madero, 07870 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (681, 9, 'Cruz Gálvez 13', ' Hogar y Seguridad', ' Azcapotzalco', 2820, 19.362656, -99.027372, 'Cruz Gálvez 13, Hogar y Seguridad, Azcapotzalco, 02820 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (682, 9, 'Bernardo Quintana a', ' Zedec Santa Fe', ' Álvaro Obregón', 1219, 19.362656, -99.027372, 'Bernardo Quintana a, Zedec Santa Fe, Álvaro Obregón, 01219 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (683, 9, 'San Diego', ' San Bartolo Ameyalco', ' Álvaro Obregón', 1800, 19.362656, -99.027372, 'San Diego, San Bartolo Ameyalco, Álvaro Obregón, 01800 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (684, 9, 'Donizetti 316', ' Vallejo', ' Gustavo A. Madero', 7870, 19.468566, -99.176352, 'Donizetti 316, Vallejo, Gustavo A. Madero, 07870 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (685, 9, 'Avenida Tamaulipas 172', ' Santa Lucía Reacomodo', ' Álvaro Obregón', 1509, 19.468566, -99.176352, 'Avenida Tamaulipas 172, Santa Lucía Reacomodo, Álvaro Obregón, 01509 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (686, 9, 'Paseo de la Reforma SNS', ' Tabacalera', ' Cuauhtémoc', 6030, 19.468566, -99.176352, 'Paseo de la Reforma SNS, Tabacalera, Cuauhtémoc, 06030 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (687, 9, 'José Cardel 10A', ' Ampliación San Pedro Xalpa', ' Azcapotzalco', 2719, 19.336655, -99.177383, 'José Cardel 10A, Ampliación San Pedro Xalpa, Azcapotzalco, 02719 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (688, 9, 'Eje 2 Norte (Eulalia Guzmán) 143', ' Atlampa', ' Cuauhtémoc', 6450, 19.334656, -99.146382, 'Eje 2 Norte (Eulalia Guzmán) 143, Atlampa, Cuauhtémoc, 06450 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (689, 9, 'Floricultura 270', ' 20 de Noviembre', ' Venustiano Carranza', 15300, 19.334656, -99.146382, 'Floricultura 270, 20 de Noviembre, Venustiano Carranza, 15300 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (690, 9, 'Álvaro Obregón', ' Lomas de Santa Cruz', ' Iztapalapa', 9709, 19.342665, -99.247362, 'Álvaro Obregón, Lomas de Santa Cruz, Iztapalapa, 09709 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (691, 9, 'Avenida Rio San Joaquin', ' Panteón Francés', ' Miguel Hidalgo', 11470, 19.365665, -99.227363, 'Avenida Rio San Joaquin, Panteón Francés, Miguel Hidalgo, 11470 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (692, 9, 'Maíz 283', ' Valle del Sur', ' Iztapalapa', 9819, 19.365665, -99.227363, 'Maíz 283, Valle del Sur, Iztapalapa, 09819 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (693, 9, 'Cumbres de Maltrata 145', ' Narvarte', ' Benito Juarez', 3020, 19.365665, -99.227363, 'Cumbres de Maltrata 145, Narvarte, Benito Juarez, 03020 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (694, 9, 'Eje 1 Oriente (Av. Canal de Miramontes) 1680', ' Campestre Churubusco', ' Coyoacán', 4200, 19.455566, -99.146382, 'Eje 1 Oriente (Av. Canal de Miramontes) 1680, Campestre Churubusco, Coyoacán, 04200 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (695, 9, 'Eje 4 Norte (Talismán) 279', ' Aragón Inguarán', ' Gustavo A. Madero', 7820, 19.455566, -99.146382, 'Eje 4 Norte (Talismán) 279, Aragón Inguarán, Gustavo A. Madero, 07820 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (696, 9, '17', ' San Simon Ticumac', ' Benito Juarez', 3660, 19.345655, -99.017383, '17, San Simon Ticumac, Benito Juarez, 03660 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (697, 9, 'Ezequiel Montes 132', ' Tabacalera', ' Cuauhtémoc', 6030, 19.345655, -99.017383, 'Ezequiel Montes 132, Tabacalera, Cuauhtémoc, 06030 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (698, 9, 'Coxcox MZA2 LT10', ' El Arenal 4a Sección', ' Venustiano Carranza', 15640, 19.349655, -99.266362, 'Coxcox MZA2 LT10, El Arenal 4a Sección, Venustiano Carranza, 15640 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (699, 9, 'Circuito Interior Avenida Río Mixcoac', ' Florida', ' Álvaro Obregón', 3240, 19.373556, -99.057372, 'Circuito Interior Avenida Río Mixcoac, Florida, Álvaro Obregón, 03240 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (700, 9, 'Calle 7 216', ' Molino de Rosas', ' Álvaro Obregón', 1470, 19.373556, -99.057372, 'Calle 7 216, Molino de Rosas, Álvaro Obregón, 01470 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (701, 9, 'Avenida Tamaulipas MZ5 LT22', ' Ejido San Mateo', ' Álvaro Obregón', 1580, 19.373556, -99.057372, 'Avenida Tamaulipas MZ5 LT22, Ejido San Mateo, Álvaro Obregón, 01580 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (702, 9, 'Calle Fresas', ' Tlacoquemecatl del Valle', ' Benito Juarez', 3200, 19.426566, -99.107382, 'Calle Fresas, Tlacoquemecatl del Valle, Benito Juarez, 03200 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (703, 9, 'Oyamel MZ9 LT7', ' (P .i.) Garcimarrero 090100001291-B', ' Álvaro Obregón', 1510, 19.426566, -99.107382, 'Oyamel MZ9 LT7, (P .i.) Garcimarrero 090100001291-B, Álvaro Obregón, 01510 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (704, 9, 'Tlalmiminolpan', ' San Bartolo Ameyalco', ' Álvaro Obregón', 1800, 19.352655, -99.156363, 'Tlalmiminolpan, San Bartolo Ameyalco, Álvaro Obregón, 01800 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (705, 9, 'Batalla de Celaya', ' Militar 1 K Lomas de Sotelo', ' Miguel Hidalgo', 11200, 19.352655, -99.156363, 'Batalla de Celaya, Militar 1 K Lomas de Sotelo, Miguel Hidalgo, 11200 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (706, 9, 'Paseo de los Laureles 129', ' Bosques de Las Lomas', ' Cuajimalpa', 5120, 19.355556, -99.007353, 'Paseo de los Laureles 129, Bosques de Las Lomas, Cuajimalpa, 05120 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (707, 9, 'José Loreto Fabela 19A', ' Campestre Aragón', ' Gustavo A. Madero', 7530, 19.355556, -99.007353, 'José Loreto Fabela 19A, Campestre Aragón, Gustavo A. Madero, 07530 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (708, 9, 'Atexzimal (Encinos)', ' San Bartolo Ameyalco', ' Álvaro Obregón', 1800, 19.355556, -99.007353, 'Atexzimal (Encinos), San Bartolo Ameyalco, Álvaro Obregón, 01800 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (709, 9, 'Anillo Periférico Canal de Garay MZ11LT34', ' Lomas de San Lorenzo', ' Iztapalapa', 9780, 19.379555, -99.166363, 'Anillo Periférico Canal de Garay MZ11LT34, Lomas de San Lorenzo, Iztapalapa, 09780 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (710, 9, 'Florida 85', ' Centro', ' Cuauhtémoc', 6000, 19.379555, -99.166363, 'Florida 85, Centro, Cuauhtémoc, 06000 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (711, 9, 'La Joya', ' Bosques Tarango', ' Álvaro Obregón', 1580, 19.465655, -99.126362, 'La Joya, Bosques Tarango, Álvaro Obregón, 01580 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (712, 9, 'SIN NOMBRE No. 458 36', ' Narciso Bassols', ' Gustavo A. Madero', 7980, 19.442556, -99.267382, 'SIN NOMBRE No. 458 36, Narciso Bassols, Gustavo A. Madero, 07980 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (713, 9, 'Presidente Plutarco Elías Calles 1102', ' San Andrés Tetepilco', ' Iztapalapa', 9440, 19.442556, -99.267382, 'Presidente Plutarco Elías Calles 1102, San Andrés Tetepilco, Iztapalapa, 09440 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (714, 9, 'Andador 7-C', ' Norte', ' Álvaro Obregón', 1410, 19.433555, -99.267383, 'Andador 7-C, Norte, Álvaro Obregón, 01410 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (715, 9, '8 170', ' Granjas San Antonio', ' Iztapalapa', 9070, 19.433555, -99.267383, '8 170, Granjas San Antonio, Iztapalapa, 09070 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (716, 9, 'Lomas del Angel 13', ' Lomas de Tarango', ' Álvaro Obregón', 1620, 19.433555, -99.267383, 'Lomas del Angel 13, Lomas de Tarango, Álvaro Obregón, 01620 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (717, 9, 'Paseo de Los Jardines 191', ' Paseos de Taxqueña', ' Coyoacán', 4250, 19.454666, -99.026373, 'Paseo de Los Jardines 191, Paseos de Taxqueña, Coyoacán, 04250 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (718, 9, 'Eje 2 Poniente Florencia 20', ' Juárez', ' Cuauhtémoc', 6600, 19.454666, -99.026373, 'Eje 2 Poniente Florencia 20, Juárez, Cuauhtémoc, 06600 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (719, 9, 'Avenida Francisco Sosa 69', ' Santa Catarina', ' Coyoacán', 4100, 19.454666, -99.026373, 'Avenida Francisco Sosa 69, Santa Catarina, Coyoacán, 04100 Metro Coyoacán, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (720, 9, 'Sur 129 125-126', ' Santa Isabel Industrial', ' Iztapalapa', 9820, 19.373656, -99.076352, 'Sur 129 125-126, Santa Isabel Industrial, Iztapalapa, 09820 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (721, 9, 'Bahía de Ballenas 64', ' Verónica Anzures', ' Miguel Hidalgo', 11300, 19.373656, -99.076352, 'Bahía de Ballenas 64, Verónica Anzures, Miguel Hidalgo, 11300 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (722, 9, 'Mixtecas 154(MZ80 LT5)', ' Ajusco', ' Coyoacán', 4300, 19.472656, -99.026372, 'Mixtecas 154(MZ80 LT5), Ajusco, Coyoacán, 04300 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (723, 9, '508 193', ' San Juan de Aragón 4a Sección', ' Gustavo A. Madero', 7979, 19.472656, -99.026372, '508 193, San Juan de Aragón 4a Sección, Gustavo A. Madero, 07979 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (724, 9, 'General Ildefonso Vázquez 3', ' Militar 1 K Lomas de Sotelo', ' Miguel Hidalgo', 11200, 19.469655, -99.166382, 'General Ildefonso Vázquez 3, Militar 1 K Lomas de Sotelo, Miguel Hidalgo, 11200 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (725, 9, 'Centeno 44', ' Granjas Esmeralda', ' Benito Juarez', 9810, 19.362555, -99.006373, 'Centeno 44, Granjas Esmeralda, Benito Juarez, 09810 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (726, 9, 'Yacatecutli MZ14 LT1', ' 1ra Ampliación Santiago Acahualtepec', ' Iztapalapa', 9608, 19.433565, -99.267353, 'Yacatecutli MZ14 LT1, 1ra Ampliación Santiago Acahualtepec, Iztapalapa, 09608 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (727, 9, 'Chabacano 30', ' San Mateo Tlaltenango', ' Cuajimalpa', 5600, 19.433565, -99.267353, 'Chabacano 30, San Mateo Tlaltenango, Cuajimalpa, 05600 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (728, 9, 'Moctezuma', ' Zona Urbana Ejidal Los Reyes Culhuacan', ' Iztapalapa', 9840, 19.458555, -99.066382, 'Moctezuma, Zona Urbana Ejidal Los Reyes Culhuacan, Iztapalapa, 09840 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (729, 9, 'Jacobo Watt', ' Culhuacan', ' Iztapalapa', 9800, 19.335556, -99.106363, 'Jacobo Watt, Culhuacan, Iztapalapa, 09800 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (730, 9, 'Calle Francisco Pimentel 99', ' San Rafael', ' Cuauhtémoc', 6470, 19.335556, -99.106363, 'Calle Francisco Pimentel 99, San Rafael, Cuauhtémoc, 06470 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (731, 9, 'Avenida Hidalgo', ' San Miguel', ' Iztapalapa', 9360, 19.482665, -99.067373, 'Avenida Hidalgo, San Miguel, Iztapalapa, 09360 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (732, 9, 'República de Ecuador 47', ' Centro', ' Cuauhtémoc', 6020, 19.386565, -99.257383, 'República de Ecuador 47, Centro, Cuauhtémoc, 06020 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (733, 9, 'Mar de La Sonda', ' Popotla', ' Miguel Hidalgo', 11400, 19.487665, -99.007362, 'Mar de La Sonda, Popotla, Miguel Hidalgo, 11400 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (734, 9, 'Mixtecas 154(MZ80 LT5)', ' Ajusco', ' Coyoacán', 4300, 19.329555, -99.017352, 'Mixtecas 154(MZ80 LT5), Ajusco, Coyoacán, 04300 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (735, 9, '11 1630', ' Aguilera', ' Azcapotzalco', 2900, 19.329555, -99.017352, '11 1630, Aguilera, Azcapotzalco, 02900 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (736, 9, 'Ingeniería 23', ' Copilco El Alto', ' Coyoacán', 4360, 19.478656, -99.006372, 'Ingeniería 23, Copilco El Alto, Coyoacán, 04360 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (737, 9, '1a. Privada Prolongación San Diego', ' San Bartolo Ameyalco', ' Álvaro Obregón', 1800, 19.442656, -99.046362, '1a. Privada Prolongación San Diego, San Bartolo Ameyalco, Álvaro Obregón, 01800 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (738, 9, 'Al Manantial', ' San Mateo Tlaltenango', ' Cuajimalpa', 5600, 19.376556, -99.127373, 'Al Manantial, San Mateo Tlaltenango, Cuajimalpa, 05600 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (739, 9, 'Al Olivo 22', ' Jardines de La Palma(Huizachito)', ' Cuajimalpa', 5100, 19.336665, -99.246373, 'Al Olivo 22, Jardines de La Palma(Huizachito), Cuajimalpa, 05100 Cuajimalpa de Morelos, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (740, 9, 'Lago Chalco', ' Anáhuac', ' Miguel Hidalgo', 11320, 19.326556, -99.117383, 'Lago Chalco, Anáhuac, Miguel Hidalgo, 11320 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (741, 9, 'Minas', ' Lomas de La Estancia', ' Iztapalapa', 9640, 19.439655, -99.046362, 'Minas, Lomas de La Estancia, Iztapalapa, 09640 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (742, 9, 'Lázaro Cárdenas MZ100 LT1263', ' Ampliación Zona Urbana Ejidal Santa María Aztahuacan', ' Iztapalapa', 9570, 19.439655, -99.046362, 'Lázaro Cárdenas MZ100 LT1263, Ampliación Zona Urbana Ejidal Santa María Aztahuacan, Iztapalapa, 09570 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (743, 9, 'F. C. Industrial', ' Moctezuma 2a Sección', ' Venustiano Carranza', 15530, 19.432555, -99.256353, 'F. C. Industrial, Moctezuma 2a Sección, Venustiano Carranza, 15530 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (744, 9, '28', ' Porvenir', ' Azcapotzalco', 2940, 19.348565, -99.017383, '28, Porvenir, Azcapotzalco, 02940 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (745, 9, 'Eje 1 Oriente (Av. Canal de Miramontes) 2131', ' El Centinela', ' Coyoacán', 4450, 19.453556, -99.166352, 'Eje 1 Oriente (Av. Canal de Miramontes) 2131, El Centinela, Coyoacán, 04450 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (746, 9, 'Bruselas 10', ' Juárez', ' Cuauhtémoc', 6600, 19.367656, -99.136373, 'Bruselas 10, Juárez, Cuauhtémoc, 06600 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (747, 9, 'Calle de La Loma', ' Lomas de San Angel Inn', ' Álvaro Obregón', 1790, 19.369666, -99.206353, 'Calle de La Loma, Lomas de San Angel Inn, Álvaro Obregón, 01790 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (748, 9, '2 de Noviembre', ' Palmitas', ' Iztapalapa', 9670, 19.468655, -99.056383, '2 de Noviembre, Palmitas, Iztapalapa, 09670 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (749, 9, 'Desierto de Los Leones 5720', ' Cedros', ' Álvaro Obregón', 1729, 19.366556, -99.056362, 'Desierto de Los Leones 5720, Cedros, Álvaro Obregón, 01729 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (750, 9, 'Eje 2 Poniente Florencia 20', ' Juárez', ' Cuauhtémoc', 6600, 19.469556, -99.167382, 'Eje 2 Poniente Florencia 20, Juárez, Cuauhtémoc, 06600 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (751, 9, 'Ejido Tepepan LB', ' San Francisco Culhuacan(Ejidos de Culhuacan)', ' Coyoacán', 4470, 19.389656, -99.007362, 'Ejido Tepepan LB, San Francisco Culhuacan(Ejidos de Culhuacan), Coyoacán, 04470 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (752, 9, 'Santo Tomas 12', ' Centro', ' Cuauhtémoc', 6000, 19.339565, -99.267372, 'Santo Tomas 12, Centro, Cuauhtémoc, 06000 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (753, 9, 'Camino de La Amistad 290', ' Campestre Aragón', ' Gustavo A. Madero', 7530, 19.379665, -99.157362, 'Camino de La Amistad 290, Campestre Aragón, Gustavo A. Madero, 07530 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (754, 9, 'General López de Santa Anna 127-129', ' Martin Carrera', ' Gustavo A. Madero', 7070, 19.423656, -99.037363, 'General López de Santa Anna 127-129, Martin Carrera, Gustavo A. Madero, 07070 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (755, 9, 'Jacaranda', ' San Clemente Norte', ' Álvaro Obregón', 1740, 19.453666, -99.016363, 'Jacaranda, San Clemente Norte, Álvaro Obregón, 01740 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (756, 9, 'Secretaría de Marina 491', ' Lomas de Vista Hermosa', ' Cuajimalpa', 5100, 19.324665, -99.107373, 'Secretaría de Marina 491, Lomas de Vista Hermosa, Cuajimalpa, 05100 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (757, 9, 'Calle Fco Cesar M.', ' Fuentes de Zaragoza', ' Iztapalapa', 9150, 19.324665, -99.107373, 'Calle Fco Cesar M., Fuentes de Zaragoza, Iztapalapa, 09150 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (758, 9, 'Anillo de Circunvalación', ' Zona Urbana Ejidal Santa María Aztahuacan', ' Iztapalapa', 9570, 19.324665, -99.107373, 'Anillo de Circunvalación, Zona Urbana Ejidal Santa María Aztahuacan, Iztapalapa, 09570 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (759, 9, 'Borregos', ' Lomas de Los Angeles Tetelpan', ' Álvaro Obregón', 1790, 19.475666, -99.246352, 'Borregos, Lomas de Los Angeles Tetelpan, Álvaro Obregón, 01790 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (760, 9, 'Calle 65 8', ' Santa Cruz Meyehualco', ' Iztapalapa', 9290, 19.475666, -99.246352, 'Calle 65 8, Santa Cruz Meyehualco, Iztapalapa, 09290 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (761, 9, 'Autopista México-Marquesa', ' Zedec Santa Fe', ' Álvaro Obregón', 1219, 19.424555, -99.246383, 'Autopista México-Marquesa, Zedec Santa Fe, Álvaro Obregón, 01219 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (762, 9, 'Avenida Centenario', ' Bosques Tarango', ' Álvaro Obregón', 1580, 19.424555, -99.246383, 'Avenida Centenario, Bosques Tarango, Álvaro Obregón, 01580 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (763, 9, 'Calzada 22 de Septiembre de 1914', ' San Juan Tlihuaca', ' Azcapotzalco', 2400, 19.366666, -99.266383, 'Calzada 22 de Septiembre de 1914, San Juan Tlihuaca, Azcapotzalco, 02400 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (764, 9, 'Cocoteros 150', ' Nueva Santa María', ' Azcapotzalco', 2800, 19.366666, -99.266383, 'Cocoteros 150, Nueva Santa María, Azcapotzalco, 02800 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (765, 9, 'Otilio Montaño', ' Las Peñas', ' Iztapalapa', 9700, 19.464665, -99.236352, 'Otilio Montaño, Las Peñas, Iztapalapa, 09700 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (766, 9, 'Avenida de las Minas', ' Xalpa', ' Iztapalapa', 9640, 19.434565, -99.166362, 'Avenida de las Minas, Xalpa, Iztapalapa, 09640 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (767, 9, 'Mar de La Sonda 16', ' Popotla', ' Miguel Hidalgo', 11400, 19.434565, -99.166362, 'Mar de La Sonda 16, Popotla, Miguel Hidalgo, 11400 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (768, 9, 'Poniente 16', ' Cuchilla del Tesoro', ' Gustavo A. Madero', 7900, 19.322656, -99.217353, 'Poniente 16, Cuchilla del Tesoro, Gustavo A. Madero, 07900 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (769, 9, '2a. Cerrada San Joaquín', ' San Joaquín', ' Miguel Hidalgo', 11260, 19.322656, -99.217353, '2a. Cerrada San Joaquín, San Joaquín, Miguel Hidalgo, 11260 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (770, 9, 'And. León Guzmán', ' Campamento 2 de Octubre', ' Iztacalco', 8930, 19.322656, -99.217353, 'And. León Guzmán, Campamento 2 de Octubre, Iztacalco, 08930 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (771, 9, 'Presidente Masaryk 547', ' Polanco', ' Miguel Hidalgo', 11550, 19.322656, -99.217353, 'Presidente Masaryk 547, Polanco, Miguel Hidalgo, 11550 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (772, 9, 'Avenida de las Minas', ' Xalpa', ' Iztapalapa', 9640, 19.478656, -99.177363, 'Avenida de las Minas, Xalpa, Iztapalapa, 09640 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (773, 9, 'Eje Central Lázaro Cárdenas 878', ' Niños Heroes de Chapultepec', ' Niños Héroes', 3440, 19.478656, -99.177363, 'Eje Central Lázaro Cárdenas 878, Niños Heroes de Chapultepec, Niños Héroes, 03440 Benito Juárez, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (774, 9, 'Censos 10', ' El Retoño', ' Iztapalapa', 9440, 19.369555, -99.126362, 'Censos 10, El Retoño, Iztapalapa, 09440 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (775, 9, 'Eje 4 Norte (Av. 510)', ' San Juan de Aragón 4a Sección', ' Gustavo A. Madero', 7979, 19.369555, -99.126362, 'Eje 4 Norte (Av. 510), San Juan de Aragón 4a Sección, Gustavo A. Madero, 07979 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (776, 9, '12 21(MZ28 LT15)', ' Olivar del Conde 1a. Sección', ' Álvaro Obregón', 1400, 19.369555, -99.126362, '12 21(MZ28 LT15), Olivar del Conde 1a. Sección, Álvaro Obregón, 01400 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (777, 9, 'Los Gipaetos', ' Lomas de Las Águilas', ' Álvaro Obregón', 1759, 19.468556, -99.006363, 'Los Gipaetos, Lomas de Las Águilas, Álvaro Obregón, 01759 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (778, 9, 'Roldán 124-126', ' Centro', ' Cuauhtémoc', 6000, 19.468556, -99.006363, 'Roldán 124-126, Centro, Cuauhtémoc, 06000 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (779, 9, '1517 89', ' San Juan de Aragón 6a Sección', ' Gustavo A. Madero', 7918, 19.468556, -99.006363, '1517 89, San Juan de Aragón 6a Sección, Gustavo A. Madero, 07918 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (780, 9, 'Del Recuerdo', ' El Mirador', ' Álvaro Obregón', 1708, 19.385655, -99.257352, 'Del Recuerdo, El Mirador, Álvaro Obregón, 01708 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (781, 9, 'Herminio Chavarría', ' Zona Urbana Ejidal Santa María Aztahuacan', ' Iztapalapa', 9570, 19.385655, -99.257352, 'Herminio Chavarría, Zona Urbana Ejidal Santa María Aztahuacan, Iztapalapa, 09570 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (782, 9, 'Calle de Balderas', ' Centro', ' Cuauhtémoc', 6000, 19.325665, -99.237373, 'Calle de Balderas, Centro, Cuauhtémoc, 06000 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (783, 9, 'N. Álvarez 2', ' Zacatepec', ' Iztapalapa', 9560, 19.325665, -99.237373, 'N. Álvarez 2, Zacatepec, Iztapalapa, 09560 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (784, 9, 'General Ildefonso Vázquez 3', ' Militar 1 K Lomas de Sotelo', ' Miguel Hidalgo', 11200, 19.329556, -99.247352, 'General Ildefonso Vázquez 3, Militar 1 K Lomas de Sotelo, Miguel Hidalgo, 11200 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (785, 9, 'Norte 11 4626', ' Defensores de La República', ' Gustavo A. Madero', 7780, 19.329556, -99.247352, 'Norte 11 4626, Defensores de La República, Gustavo A. Madero, 07780 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (786, 9, 'Cerro Tlapacoyan 11', ' Copilco Universidad', ' Coyoacán', 4360, 19.329556, -99.247352, 'Cerro Tlapacoyan 11, Copilco Universidad, Coyoacán, 04360 Coyoacan, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (787, 9, 'Avenida Tamaulipas MZ5 LT22', ' Ejido San Mateo', ' Álvaro Obregón', 1580, 19.329556, -99.247352, 'Avenida Tamaulipas MZ5 LT22, Ejido San Mateo, Álvaro Obregón, 01580 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (788, 9, 'Allende 62', ' Centro', ' Cuauhtémoc', 6000, 19.456666, -99.077352, 'Allende 62, Centro, Cuauhtémoc, 06000 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (789, 9, 'Calle 71 16', ' Santa Cruz Meyehualco', ' Iztapalapa', 9290, 19.456666, -99.077352, 'Calle 71 16, Santa Cruz Meyehualco, Iztapalapa, 09290 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (790, 9, '3a. Cerrada de Tiro Al Pichón 17', ' Lomas de Bezares', ' Miguel Hidalgo', 11910, 19.343665, -99.167352, '3a. Cerrada de Tiro Al Pichón 17, Lomas de Bezares, Miguel Hidalgo, 11910 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (791, 9, 'Insurgentes Centro 62', ' Tabacalera', ' Cuauhtémoc', 6030, 19.343665, -99.167352, 'Insurgentes Centro 62, Tabacalera, Cuauhtémoc, 06030 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (792, 9, 'Sur 69-A', ' Banjidal', ' Iztapalapa', 9450, 19.344666, -99.277352, 'Sur 69-A, Banjidal, Iztapalapa, 09450 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (793, 9, 'Rea MZ5 LT46', ' Sideral', ' Iztapalapa', 9320, 19.344666, -99.277352, 'Rea MZ5 LT46, Sideral, Iztapalapa, 09320 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (794, 9, 'SIN NOMBRE No. 41 4', ' San Francisco Culhuacan', ' Coyoacán', 4260, 19.343566, -99.167363, 'SIN NOMBRE No. 41 4, San Francisco Culhuacan, Coyoacán, 04260 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (795, 9, 'Miranda 45', ' Aragón La Villa(Aragón)', ' Gustavo A. Madero', 7000, 19.343566, -99.167363, 'Miranda 45, Aragón La Villa(Aragón), Gustavo A. Madero, 07000 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (796, 9, 'Calle 23 MZ6 LT20', ' Olivar del Conde 2a. Sección', ' Álvaro Obregón', 1408, 19.384566, -99.217363, 'Calle 23 MZ6 LT20, Olivar del Conde 2a. Sección, Álvaro Obregón, 01408 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (797, 9, 'Autopista México-Marquesa', ' Zedec Santa Fe', ' Álvaro Obregón', 1219, 19.384566, -99.217363, 'Autopista México-Marquesa, Zedec Santa Fe, Álvaro Obregón, 01219 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (798, 9, 'Africa 10', ' La Concepción', ' Coyoacán', 4020, 19.384566, -99.217363, 'Africa 10, La Concepción, Coyoacán, 04020 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (799, 9, 'Providencia', ' San Jerónimo Lídice', ' Magdalena Contreras', 10200, 19.438565, -99.137362, 'Providencia, San Jerónimo Lídice, Magdalena Contreras, 10200 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (800, 9, 'Reims', ' Fraccionamiento Villa Verdun', ' Álvaro Obregón', 1820, 19.349565, -99.017353, 'Reims, Fraccionamiento Villa Verdun, Álvaro Obregón, 01820 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (801, 9, 'Granados 135', ' Ex Hipódromo de Peralvillo', ' Cuauhtémoc', 6250, 19.344566, -99.277372, 'Granados 135, Ex Hipódromo de Peralvillo, Cuauhtémoc, 06250 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (802, 9, 'Avenida 608 279', ' San Juan de Aragón 4a Sección', ' Gustavo A. Madero', 7979, 19.344566, -99.277372, 'Avenida 608 279, San Juan de Aragón 4a Sección, Gustavo A. Madero, 07979 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (803, 9, 'Calle Ignacio Zaragoza', ' Juan Escutia', ' Iztapalapa', 9100, 19.344566, -99.277372, 'Calle Ignacio Zaragoza, Juan Escutia, Iztapalapa, 09100 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (804, 9, '1 Mercedes Abrego', ' Ctm VI Culhuacan', ' Coyoacán', 4480, 19.449656, -99.157382, '1 Mercedes Abrego, Ctm VI Culhuacan, Coyoacán, 04480 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (805, 9, 'Independencia 55', ' Ampliación El Triunfo', ' Iztapalapa', 9438, 19.434555, -99.117383, 'Independencia 55, Ampliación El Triunfo, Iztapalapa, 09438 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (806, 9, 'Francisco Villa', ' Zona Urbana Ejidal Santa María Aztahuacan', ' Iztapalapa', 9570, 19.434555, -99.117383, 'Francisco Villa, Zona Urbana Ejidal Santa María Aztahuacan, Iztapalapa, 09570 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (807, 9, 'Cerrada de Popocatépetl 36', ' Xoco', ' Benito Juarez', 3330, 19.474656, -99.007363, 'Cerrada de Popocatépetl 36, Xoco, Benito Juarez, 03330 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (808, 9, 'Avenida Telecomunicaciones', ' Cabeza de Juárez VI', ' Iztapalapa', 9225, 19.474656, -99.007363, 'Avenida Telecomunicaciones, Cabeza de Juárez VI, Iztapalapa, 09225 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (809, 9, 'Avenida Carlos Lazo', ' Reserva Ecológica Torres de Potrero', ' Álvaro Obregón', 1848, 19.382566, -99.247372, 'Avenida Carlos Lazo, Reserva Ecológica Torres de Potrero, Álvaro Obregón, 01848 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (810, 9, 'Avenida Vasco de Quiroga', ' Zedec Santa Fe', ' Álvaro Obregón', 1219, 19.469656, -99.007353, 'Avenida Vasco de Quiroga, Zedec Santa Fe, Álvaro Obregón, 01219 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (811, 9, 'Pilares 1013', ' Letrán Valle', ' Benito Juarez', 3650, 19.462666, -99.016373, 'Pilares 1013, Letrán Valle, Benito Juarez, 03650 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (812, 9, 'Allende 177', ' Guerrero', ' Cuauhtémoc', 6300, 19.373565, -99.236373, 'Allende 177, Guerrero, Cuauhtémoc, 06300 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (813, 9, 'Camino Real de Tetelpan 141', ' Lomas de Los Angeles Tetelpan', ' Álvaro Obregón', 1799, 19.373565, -99.236373, 'Camino Real de Tetelpan 141, Lomas de Los Angeles Tetelpan, Álvaro Obregón, 01799 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (814, 9, 'Villa Figueroa', ' Desarrollo Urbano Quetzalcoatl', ' Iztapalapa', 9700, 19.373565, -99.236373, 'Villa Figueroa, Desarrollo Urbano Quetzalcoatl, Iztapalapa, 09700 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (815, 9, 'Tigre 50', ' Del Valle', ' Benito Juarez', 3100, 19.354665, -99.117363, 'Tigre 50, Del Valle, Benito Juarez, 03100 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (816, 9, 'Guerrerenses', ' Arturo Martínez', ' Álvaro Obregón', 1200, 19.354665, -99.117363, 'Guerrerenses, Arturo Martínez, Álvaro Obregón, 01200 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (817, 9, 'Rumania 507', ' Portales', ' Benito Juarez', 3300, 19.455656, -99.116373, 'Rumania 507, Portales, Benito Juarez, 03300 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (818, 9, 'Avenida Tlahuac 105', ' Santa Isabel Industrial', ' Iztapalapa', 9820, 19.455656, -99.116373, 'Avenida Tlahuac 105, Santa Isabel Industrial, Iztapalapa, 09820 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (819, 9, 'Estampado', ' 20 de Noviembre', ' Venustiano Carranza', 15300, 19.455655, -99.037372, 'Estampado, 20 de Noviembre, Venustiano Carranza, 15300 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (820, 9, 'Prolongación Río Churubusco', ' Aeropuerto Int de La Ciudad de México', ' Venustiano Carranza', 15620, 19.477556, -99.057383, 'Prolongación Río Churubusco, Aeropuerto Int de La Ciudad de México, Venustiano Carranza, 15620 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (821, 9, 'Guillermo Larrazábal', ' Campamento 2 de Octubre', ' Iztacalco', 8930, 19.477556, -99.057383, 'Guillermo Larrazábal, Campamento 2 de Octubre, Iztacalco, 08930 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (822, 9, 'Calle Miguel Hidalgo', ' Chinampac de Juárez', ' Iztapalapa', 9208, 19.347565, -99.106363, 'Calle Miguel Hidalgo, Chinampac de Juárez, Iztapalapa, 09208 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (823, 9, '2a. Cerrada MZ18 LT18', ' Xalpa', ' Iztapalapa', 9640, 19.387666, -99.137382, '2a. Cerrada MZ18 LT18, Xalpa, Iztapalapa, 09640 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (824, 9, 'Jose Ma. Morels', ' Culhuacan', ' Iztapalapa', 9800, 19.387666, -99.137382, 'Jose Ma. Morels, Culhuacan, Iztapalapa, 09800 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (825, 9, 'De las Torres', ' Buenavista', ' Iztapalapa', 9700, 19.338665, -99.036382, 'De las Torres, Buenavista, Iztapalapa, 09700 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (826, 9, 'Censos 16', ' El Retoño', ' Iztapalapa', 9440, 19.338665, -99.036382, 'Censos 16, El Retoño, Iztapalapa, 09440 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (827, 9, 'General G. Hernández 9', ' Doctores', ' Cuauhtémoc', 6720, 19.382665, -99.106353, 'General G. Hernández 9, Doctores, Cuauhtémoc, 06720 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (828, 9, 'Avenida Torres Ixtapaltongo', ' San José del Olivar', ' Álvaro Obregón', 1848, 19.325555, -99.157382, 'Avenida Torres Ixtapaltongo, San José del Olivar, Álvaro Obregón, 01848 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (829, 9, 'Calle Tarango', ' San Clemente Norte', ' Álvaro Obregón', 1740, 19.355656, -99.206372, 'Calle Tarango, San Clemente Norte, Álvaro Obregón, 01740 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (830, 9, '3 A. Hernández MZ3 LT28', ' U Habitacional Vicente Guerrero I II ÌII IV V VI VII', ' Iztapalapa', 9200, 19.447666, -99.027372, '3 A. Hernández MZ3 LT28, U Habitacional Vicente Guerrero I II ÌII IV V VI VII, Iztapalapa, 09200 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (831, 9, 'Río Nilo', ' Puente Blanco', ' Iztapalapa', 9770, 19.453655, -99.246352, 'Río Nilo, Puente Blanco, Iztapalapa, 09770 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (832, 9, 'Escocia 44', ' Parque San Andrés', ' Coyoacán', 4040, 19.453655, -99.246352, 'Escocia 44, Parque San Andrés, Coyoacán, 04040 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (833, 9, 'Avenida Pacífico 281', ' La Concepción', ' Coyoacán', 4020, 19.349566, -99.066372, 'Avenida Pacífico 281, La Concepción, Coyoacán, 04020 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (834, 9, '20 de Agosto 31', ' San Diego Churubusco', ' Iztapalapa', 9800, 19.462556, -99.007363, '20 de Agosto 31, San Diego Churubusco, Iztapalapa, 09800 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (835, 9, 'Año de Juárez 216', ' Granjas San Antonio', ' Iztapalapa', 9070, 19.432655, -99.247353, 'Año de Juárez 216, Granjas San Antonio, Iztapalapa, 09070 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (836, 9, 'San Lorenzo 131', ' Tlacoquemecatl del Valle', ' Benito Juarez', 3100, 19.438566, -99.147362, 'San Lorenzo 131, Tlacoquemecatl del Valle, Benito Juarez, 03100 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (837, 9, 'Monte de Las Cruces 42', ' La Pradera', ' Gustavo A. Madero', 7500, 19.364666, -99.146373, 'Monte de Las Cruces 42, La Pradera, Gustavo A. Madero, 07500 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (838, 9, 'Ojo de Agua 2a', ' 2a. Ampliación Presidentes', ' Álvaro Obregón', 1299, 19.437655, -99.066373, 'Ojo de Agua 2a, 2a. Ampliación Presidentes, Álvaro Obregón, 01299 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (839, 9, 'Topógrafos 15', ' Nueva Rosita', ' Iztapalapa', 9420, 19.374565, -99.277372, 'Topógrafos 15, Nueva Rosita, Iztapalapa, 09420 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (840, 9, 'San Pedro', ' San José del Olivar', ' Álvaro Obregón', 1770, 19.424666, -99.246372, 'San Pedro, San José del Olivar, Álvaro Obregón, 01770 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (841, 9, 'Avenida Pacífico 281', ' La Concepción', ' Coyoacán', 4020, 19.453665, -99.037373, 'Avenida Pacífico 281, La Concepción, Coyoacán, 04020 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (842, 9, 'Interior Avenida Río Churubusco 37A', ' Del Carmen', ' Coyoacán', 4100, 19.476656, -99.276352, 'Interior Avenida Río Churubusco 37A, Del Carmen, Coyoacán, 04100 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (843, 9, 'Avenida Aztecas 322(MZ91 LT8)', ' Ajusco', ' Coyoacán', 4300, 19.424556, -99.217382, 'Avenida Aztecas 322(MZ91 LT8), Ajusco, Coyoacán, 04300 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (844, 9, 'Privada Santa Cruz', ' San Simon Ticumac', ' Benito Juarez', 3660, 19.325566, -99.236352, 'Privada Santa Cruz, San Simon Ticumac, Benito Juarez, 03660 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (845, 9, 'Autopista México-Marquesa', ' Zedec Santa Fe', ' Álvaro Obregón', 1219, 19.424656, -99.056372, 'Autopista México-Marquesa, Zedec Santa Fe, Álvaro Obregón, 01219 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (846, 9, 'Isabel la Católica 116', ' Centro', ' Cuauhtémoc', 6800, 19.424656, -99.056372, 'Isabel la Católica 116, Centro, Cuauhtémoc, 06800 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (847, 9, 'Maíz MZ265 LT32', ' Xalpa', ' Iztapalapa', 9640, 19.424656, -99.056372, 'Maíz MZ265 LT32, Xalpa, Iztapalapa, 09640 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (848, 9, 'Eje 8 Sur (Calz. Ermita Iztapalapa) CFAMSA', ' Granjas San Antonio', ' Iztapalapa', 9070, 19.438566, -99.246373, 'Eje 8 Sur (Calz. Ermita Iztapalapa) CFAMSA, Granjas San Antonio, Iztapalapa, 09070 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (849, 9, 'Villa Hermosa', ' Buenavista', ' Iztapalapa', 9700, 19.447655, -99.116363, 'Villa Hermosa, Buenavista, Iztapalapa, 09700 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (850, 9, 'Cocoteros 140', ' Nueva Santa María', ' Azcapotzalco', 2800, 19.356655, -99.137372, 'Cocoteros 140, Nueva Santa María, Azcapotzalco, 02800 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (851, 9, 'Paseo de los Arquitectos', ' Lomas de Santa Fe', ' Cuajimalpa', 1219, 19.356655, -99.137372, 'Paseo de los Arquitectos, Lomas de Santa Fe, Cuajimalpa, 01219 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (852, 9, 'Clavelitos 28', ' El Retoño', ' Iztapalapa', 9440, 19.469666, -99.246362, 'Clavelitos 28, El Retoño, Iztapalapa, 09440 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (853, 9, 'Estrella de Belén', ' Industrias Militares de Sedena', ' Álvaro Obregón', 1219, 19.469666, -99.246362, 'Estrella de Belén, Industrias Militares de Sedena, Álvaro Obregón, 01219 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (854, 9, 'Paseo de los Laureles 444', ' Bosques de Las Lomas', ' Cuajimalpa', 5100, 19.469666, -99.246362, 'Paseo de los Laureles 444, Bosques de Las Lomas, Cuajimalpa, 05100 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (855, 9, 'Mendelssohn 70', ' Vallejo', ' Gustavo A. Madero', 7870, 19.462565, -99.127352, 'Mendelssohn 70, Vallejo, Gustavo A. Madero, 07870 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (856, 9, '10', ' Olivar del Conde 1a. Sección', ' Álvaro Obregón', 1400, 19.462565, -99.127352, '10, Olivar del Conde 1a. Sección, Álvaro Obregón, 01400 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (857, 9, 'Anillo Periférico (Blvd. Adolfo Ruiz Cortines) 3376', ' Jardines del Pedregal', ' Álvaro Obregón', 1900, 19.323565, -99.217363, 'Anillo Periférico (Blvd. Adolfo Ruiz Cortines) 3376, Jardines del Pedregal, Álvaro Obregón, 01900 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (858, 9, 'Paseo de La Troje', ' La Loma', ' Álvaro Obregón', 1260, 19.323565, -99.217363, 'Paseo de La Troje, La Loma, Álvaro Obregón, 01260 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (859, 9, 'Loma Tlapexco 162', ' Lomas de Vista Hermosa', ' Cuajimalpa', 5100, 19.323565, -99.217363, 'Loma Tlapexco 162, Lomas de Vista Hermosa, Cuajimalpa, 05100 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (860, 9, 'Agustín Romero Ibáñez 144', ' Presidentes Ejidales', ' Coyoacán', 4470, 19.323565, -99.217363, 'Agustín Romero Ibáñez 144, Presidentes Ejidales, Coyoacán, 04470 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (861, 9, 'Nicolás Bravo', ' Pueblo Santa Fe', ' Álvaro Obregón', 1210, 19.367566, -99.067363, 'Nicolás Bravo, Pueblo Santa Fe, Álvaro Obregón, 01210 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (862, 9, 'Ejido de Los Reyes 100', ' San Francisco Culhuacan(Ejidos de Culhuacan)', ' Coyoacán', 4470, 19.367566, -99.067363, 'Ejido de Los Reyes 100, San Francisco Culhuacan(Ejidos de Culhuacan), Coyoacán, 04470 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (863, 9, 'Progreso', ' Lomas de San Lorenzo', ' Iztapalapa', 9780, 19.367566, -99.067363, 'Progreso, Lomas de San Lorenzo, Iztapalapa, 09780 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (864, 9, 'Prado Sur 285', ' Lomas de Chapultepec', ' Miguel Hidalgo', 11000, 19.458665, -99.117352, 'Prado Sur 285, Lomas de Chapultepec, Miguel Hidalgo, 11000 Miguel Hidalgo, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (865, 9, 'Ings. Grabadores 43', ' Jardínes de Churubusco', ' Iztapalapa', 9410, 19.458665, -99.117352, 'Ings. Grabadores 43, Jardínes de Churubusco, Iztapalapa, 09410 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (866, 9, 'Eje 2 Norte (Manuel González) 142', ' Tlatelolco', ' Cuauhtémoc', 6250, 19.458665, -99.117352, 'Eje 2 Norte (Manuel González) 142, Tlatelolco, Cuauhtémoc, 06250 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (867, 9, 'Manuel Acuña 15(MZ3 LT4)', ' Palmitas', ' Iztapalapa', 9730, 19.458665, -99.117352, 'Manuel Acuña 15(MZ3 LT4), Palmitas, Iztapalapa, 09730 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (868, 9, 'Cerrada Pino', ' San Andrés Tomatlan', ' Iztapalapa', 9870, 19.443655, -99.117362, 'Cerrada Pino, San Andrés Tomatlan, Iztapalapa, 09870 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (869, 9, 'Avenida Santa Lucía 3B', ' Unidad Popular Emiliano Zapata', ' Álvaro Obregón', 1400, 19.443655, -99.117362, 'Avenida Santa Lucía 3B, Unidad Popular Emiliano Zapata, Álvaro Obregón, 01400 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (870, 9, 'Gómez Farias 331', ' Zedec Santa Fe', ' Álvaro Obregón', 1219, 19.324655, -99.257373, 'Gómez Farias 331, Zedec Santa Fe, Álvaro Obregón, 01219 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (871, 9, 'Clave 293', ' Vallejo', ' Gustavo A. Madero', 7870, 19.324655, -99.257373, 'Clave 293, Vallejo, Gustavo A. Madero, 07870 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (872, 9, 'Ricardo Monges López 19', ' Educación', ' Coyoacán', 4400, 19.324655, -99.257373, 'Ricardo Monges López 19, Educación, Coyoacán, 04400 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (873, 9, 'Berlín 80', ' Del Carmen', ' Coyoacán', 4100, 19.483566, -99.116383, 'Berlín 80, Del Carmen, Coyoacán, 04100 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (874, 9, 'Paso de Los Libres', ' La Palmita', ' Álvaro Obregón', 1260, 19.483566, -99.116383, 'Paso de Los Libres, La Palmita, Álvaro Obregón, 01260 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (875, 9, 'Donizetti 33-35', ' Vallejo', ' Gustavo A. Madero', 7870, 19.447566, -99.107362, 'Donizetti 33-35, Vallejo, Gustavo A. Madero, 07870 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (876, 9, 'Potrero Hondo', ' Lomas de La Estancia', ' Iztapalapa', 9640, 19.465666, -99.127352, 'Potrero Hondo, Lomas de La Estancia, Iztapalapa, 09640 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (877, 9, 'Flor de Nubes', ' Torres de Potrero', ' Álvaro Obregón', 1840, 19.465666, -99.127352, 'Flor de Nubes, Torres de Potrero, Álvaro Obregón, 01840 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (878, 9, 'Avenida del Bosque', ' Parque Tarango', ' Álvaro Obregón', 1580, 19.465666, -99.127352, 'Avenida del Bosque, Parque Tarango, Álvaro Obregón, 01580 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (879, 9, 'Coquimbo 699', ' Lindavista', ' Gustavo A. Madero', 7300, 19.446656, -99.026373, 'Coquimbo 699, Lindavista, Gustavo A. Madero, 07300 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (880, 9, 'Hortensia', ' Los Angeles', ' Iztapalapa', 9830, 19.434566, -99.036352, 'Hortensia, Los Angeles, Iztapalapa, 09830 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (881, 9, 'Lemus', ' Xalpa', ' Iztapalapa', 9640, 19.434566, -99.036352, 'Lemus, Xalpa, Iztapalapa, 09640 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (882, 9, 'Moctezuma 14', ' Villa Coyoacán', ' Coyoacán', 4000, 19.436556, -99.156383, 'Moctezuma 14, Villa Coyoacán, Coyoacán, 04000 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (883, 9, 'Gavilán 185', ' Gavilán', ' Iztapalapa', 9369, 19.486566, -99.207362, 'Gavilán 185, Gavilán, Iztapalapa, 09369 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (884, 9, 'Calzada Ings. Militares', ' San Lorenzo Tlaltenango', ' Miguel Hidalgo', 11219, 19.486566, -99.207362, 'Calzada Ings. Militares, San Lorenzo Tlaltenango, Miguel Hidalgo, 11219 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (885, 9, 'De La Santísima 19', ' Centro', ' Cuauhtémoc', 6000, 19.486566, -99.207362, 'De La Santísima 19, Centro, Cuauhtémoc, 06000 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (886, 9, 'Violeta', ' Tlacoyaque', ' Álvaro Obregón', 1859, 19.363666, -99.137372, 'Violeta, Tlacoyaque, Álvaro Obregón, 01859 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (887, 9, '613 121', ' San Juan de Aragón 4a Sección', ' Gustavo A. Madero', 7979, 19.363666, -99.137372, '613 121, San Juan de Aragón 4a Sección, Gustavo A. Madero, 07979 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (888, 9, 'Lago Chalco', ' Anáhuac', ' Miguel Hidalgo', 11320, 19.363666, -99.137372, 'Lago Chalco, Anáhuac, Miguel Hidalgo, 11320 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (889, 9, 'Amores 854', ' Del Valle', ' Benito Juarez', 3100, 19.347555, -99.216352, 'Amores 854, Del Valle, Benito Juarez, 03100 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (890, 9, 'Jesús Gaona 39', ' Moctezuma 1a Sección', ' Venustiano Carranza', 15500, 19.347555, -99.216352, 'Jesús Gaona 39, Moctezuma 1a Sección, Venustiano Carranza, 15500 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (891, 9, 'Mayorazgo de Orduña 33', ' Xoco', ' Benito Juarez', 3330, 19.347555, -99.216352, 'Mayorazgo de Orduña 33, Xoco, Benito Juarez, 03330 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (892, 9, 'Oriente 1', ' Cuchilla del Tesoro', ' Gustavo A. Madero', 7900, 19.473655, -99.266382, 'Oriente 1, Cuchilla del Tesoro, Gustavo A. Madero, 07900 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (893, 9, 'Calzada de la Virgen', ' Presidentes Ejidales', ' Coyoacán', 4470, 19.473655, -99.266382, 'Calzada de la Virgen, Presidentes Ejidales, Coyoacán, 04470 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (894, 9, 'Chichimecas 154(MZ81 LT9)', ' Ajusco', ' Coyoacán', 4300, 19.475655, -99.026352, 'Chichimecas 154(MZ81 LT9), Ajusco, Coyoacán, 04300 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (895, 9, 'Calzada Ings. Militares 18', ' Periodista', ' Miguel Hidalgo', 11200, 19.448666, -99.267373, 'Calzada Ings. Militares 18, Periodista, Miguel Hidalgo, 11200 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (896, 9, 'Presidente Masaryk 526', ' Polanco', ' Miguel Hidalgo', 11550, 19.448666, -99.267373, 'Presidente Masaryk 526, Polanco, Miguel Hidalgo, 11550 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (897, 9, 'Tapicería 38', ' Penitenciaria', ' Venustiano Carranza', 15350, 19.382555, -99.127362, 'Tapicería 38, Penitenciaria, Venustiano Carranza, 15350 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (898, 9, 'Volcán Pico de Orizaba 70', ' La Pradera', ' Gustavo A. Madero', 7500, 19.382555, -99.127362, 'Volcán Pico de Orizaba 70, La Pradera, Gustavo A. Madero, 07500 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (899, 9, 'Bandera', ' Industrias Militares de Sedena', ' Álvaro Obregón', 1219, 19.382555, -99.127362, 'Bandera, Industrias Militares de Sedena, Álvaro Obregón, 01219 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (900, 9, '49 34', ' Avante', ' Coyoacán', 4460, 19.362555, -99.107383, '49 34, Avante, Coyoacán, 04460 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (901, 9, 'Loma de la Palma 133', ' Lomas de Vista Hermosa', ' Cuajimalpa', 5100, 19.362555, -99.107383, 'Loma de la Palma 133, Lomas de Vista Hermosa, Cuajimalpa, 05100 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (902, 9, 'Ajusco 29', ' Jardines del Pedregal', ' Álvaro Obregón', 1900, 19.362555, -99.107383, 'Ajusco 29, Jardines del Pedregal, Álvaro Obregón, 01900 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (903, 9, 'Minas', ' Lomas de La Estancia', ' Iztapalapa', 9640, 19.327566, -99.156383, 'Minas, Lomas de La Estancia, Iztapalapa, 09640 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (904, 9, 'Emiliano Zapata', ' Miguel Hidalgo', ' Venustiano Carranza', 15470, 19.327566, -99.156383, 'Emiliano Zapata, Miguel Hidalgo, Venustiano Carranza, 15470 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (905, 9, 'Avenida Vasco de Quiroga', ' Lomas de Santa Fe', ' Cuajimalpa', 1219, 19.327566, -99.156383, 'Avenida Vasco de Quiroga, Lomas de Santa Fe, Cuajimalpa, 01219 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (906, 9, 'Cda. González Ortega', ' Morelos', ' Cuauhtémoc', 6200, 19.344565, -99.037352, 'Cda. González Ortega, Morelos, Cuauhtémoc, 06200 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (907, 9, 'Pirules', ' Solidaridad', ' Iztapalapa', 9160, 19.344565, -99.037352, 'Pirules, Solidaridad, Iztapalapa, 09160 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (908, 9, 'San Borja 1310', ' Vertiz Narvarte', ' Benito Juarez', 3600, 19.484555, -99.036353, 'San Borja 1310, Vertiz Narvarte, Benito Juarez, 03600 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (909, 9, '3a. Cerrada 5 de Mayo', ' San Francisco Culhuacan', ' Coyoacán', 4260, 19.463655, -99.026372, '3a. Cerrada 5 de Mayo, San Francisco Culhuacan, Coyoacán, 04260 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (910, 9, 'Al Manantial', ' San Mateo Tlaltenango', ' Cuajimalpa', 5600, 19.463655, -99.026372, 'Al Manantial, San Mateo Tlaltenango, Cuajimalpa, 05600 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (911, 9, 'José Loreto Fabela 192', ' Campestre Aragón', ' Gustavo A. Madero', 7530, 19.452555, -99.007363, 'José Loreto Fabela 192, Campestre Aragón, Gustavo A. Madero, 07530 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (912, 9, 'Ojapan', ' Zenón Delgado', ' Álvaro Obregón', 1220, 19.452555, -99.007363, 'Ojapan, Zenón Delgado, Álvaro Obregón, 01220 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (913, 9, 'Cicalco 321', ' Santo Domingo (Pgal de Sto Domingo)', ' Coyoacán', 4369, 19.444656, -99.266363, 'Cicalco 321, Santo Domingo (Pgal de Sto Domingo), Coyoacán, 04369 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (914, 9, '10', ' Olivar del Conde 1a. Sección', ' Álvaro Obregón', 1400, 19.444656, -99.266363, '10, Olivar del Conde 1a. Sección, Álvaro Obregón, 01400 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (915, 9, 'Vernet 8', ' San Antonio', ' Azcapotzalco', 2760, 19.373666, -99.246373, 'Vernet 8, San Antonio, Azcapotzalco, 02760 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (916, 9, 'Plan de Agua Prieta 66', ' Plutarco Elías Calles', ' Miguel Hidalgo', 11340, 19.364566, -99.216352, 'Plan de Agua Prieta 66, Plutarco Elías Calles, Miguel Hidalgo, 11340 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (917, 9, 'Yácatas 418', ' Narvarte', ' Benito Juarez', 3020, 19.364566, -99.216352, 'Yácatas 418, Narvarte, Benito Juarez, 03020 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (918, 9, 'Avenida Venustiano Carranza', ' Progresista', ' Iztapalapa', 9240, 19.385555, -99.117363, 'Avenida Venustiano Carranza, Progresista, Iztapalapa, 09240 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (919, 9, 'Javier Barros Sierra 225', ' Zedec Santa Fe', ' Álvaro Obregón', 1219, 19.385555, -99.117363, 'Javier Barros Sierra 225, Zedec Santa Fe, Álvaro Obregón, 01219 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (920, 9, 'Antigua Vía a La Venta MZ7 LT6', ' Arturo Martínez', ' Álvaro Obregón', 1200, 19.336566, -99.157362, 'Antigua Vía a La Venta MZ7 LT6, Arturo Martínez, Álvaro Obregón, 01200 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (921, 9, 'Eje 4 Norte (Talismán) 284', ' Granjas Modernas', ' Gustavo A. Madero', 7460, 19.336566, -99.157362, 'Eje 4 Norte (Talismán) 284, Granjas Modernas, Gustavo A. Madero, 07460 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (922, 9, 'Norte 76 3808', ' La Joya', ' Gustavo A. Madero', 7890, 19.354556, -99.216382, 'Norte 76 3808, La Joya, Gustavo A. Madero, 07890 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (923, 9, 'Circuito Interior Avenida Río Churubusco', ' Modelo', ' Iztapalapa', 9089, 19.332665, -99.257382, 'Circuito Interior Avenida Río Churubusco, Modelo, Iztapalapa, 09089 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (924, 9, 'Impresores 74', ' 20 de Noviembre', ' 20 de Novienbre', 15300, 19.459566, -99.006382, 'Impresores 74, 20 de Noviembre, 20 de Novienbre, 15300 Venustiano Carranza, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (925, 9, 'Raúl Zárate Machuca', ' Cuevitas', ' Álvaro Obregón', 1220, 19.375655, -99.207372, 'Raúl Zárate Machuca, Cuevitas, Álvaro Obregón, 01220 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (926, 9, 'Yácatas 418', ' Narvarte', ' Benito Juarez', 3020, 19.375655, -99.207372, 'Yácatas 418, Narvarte, Benito Juarez, 03020 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (927, 9, 'Calle 7', ' Lomas de Sotelo', ' Miguel Hidalgo', 11200, 19.334566, -99.027372, 'Calle 7, Lomas de Sotelo, Miguel Hidalgo, 11200 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (928, 9, 'Eje 1 Pte. (Guerrero) 198', ' Colonia Buenavista', ' Cuauhtémoc', 6350, 19.339655, -99.146363, 'Eje 1 Pte. (Guerrero) 198, Colonia Buenavista, Cuauhtémoc, 06350 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (929, 9, '10', ' 2da Ampliación Santiago Acahualtepec', ' Iztapalapa', 9609, 19.323655, -99.137373, '10, 2da Ampliación Santiago Acahualtepec, Iztapalapa, 09609 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (930, 9, 'Calle 23 MZ6 LT22', ' Olivar del Conde 2a. Sección', ' Álvaro Obregón', 1408, 19.334565, -99.116372, 'Calle 23 MZ6 LT22, Olivar del Conde 2a. Sección, Álvaro Obregón, 01408 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (931, 9, 'Imperial 73', ' Industrial', ' Gustavo A. Madero', 7800, 19.376666, -99.226382, 'Imperial 73, Industrial, Gustavo A. Madero, 07800 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (932, 9, '11 1608', ' Pro Hogar', ' Azcapotzalco', 2600, 19.376666, -99.226382, '11 1608, Pro Hogar, Azcapotzalco, 02600 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (933, 9, 'Santa Fe Milpa Alta 5', ' Merced Gómez', ' Álvaro Obregón', 1600, 19.379666, -99.106352, 'Santa Fe Milpa Alta 5, Merced Gómez, Álvaro Obregón, 01600 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (934, 9, 'Playa Mirador 436', ' Militar Marte', ' Iztacalco', 8830, 19.449555, -99.016362, 'Playa Mirador 436, Militar Marte, Iztacalco, 08830 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (935, 9, 'Ricardo Flores Magón 392', ' Santa María La Ribera', ' Cuauhtémoc', 6400, 19.327665, -99.236382, 'Ricardo Flores Magón 392, Santa María La Ribera, Cuauhtémoc, 06400 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (936, 9, 'Chocolin', ' San Juan Cerro', ' Iztapalapa', 9858, 19.345656, -99.156353, 'Chocolin, San Juan Cerro, Iztapalapa, 09858 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (937, 9, 'Cjon. Las Flores 15', ' Los Reyes', ' Coyoacán', 4330, 19.482665, -99.046352, 'Cjon. Las Flores 15, Los Reyes, Coyoacán, 04330 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (938, 9, 'Saúco', ' San Bartolo Ameyalco', ' Álvaro Obregón', 1800, 19.376556, -99.226373, 'Saúco, San Bartolo Ameyalco, Álvaro Obregón, 01800 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (939, 9, 'Talavera 4', ' Centro', ' Cuauhtémoc', 6000, 19.472665, -99.166353, 'Talavera 4, Centro, Cuauhtémoc, 06000 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (940, 9, 'General Martin Carrera 139', ' Martin Carrera', ' Gustavo A. Madero', 7070, 19.384556, -99.216352, 'General Martin Carrera 139, Martin Carrera, Gustavo A. Madero, 07070 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (941, 9, 'Desierto de Los Leones', ' San Bartolo Ameyalco', ' Álvaro Obregón', 1800, 19.359556, -99.177362, 'Desierto de Los Leones, San Bartolo Ameyalco, Álvaro Obregón, 01800 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (942, 9, 'Calzada Ings. Militares', ' San Lorenzo Tlaltenango', ' Miguel Hidalgo', 11219, 19.345665, -99.177352, 'Calzada Ings. Militares, San Lorenzo Tlaltenango, Miguel Hidalgo, 11219 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (943, 9, 'Playa Chac Mool 20', ' Santiago Sur', ' Iztacalco', 8800, 19.325565, -99.076352, 'Playa Chac Mool 20, Santiago Sur, Iztacalco, 08800 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (944, 9, 'Pasaje San Pablo 63', ' Centro', ' Cuauhtémoc', 6000, 19.423655, -99.217373, 'Pasaje San Pablo 63, Centro, Cuauhtémoc, 06000 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (945, 9, 'Radio 20', ' Valle Gómez', ' Cuauhtémoc', 6240, 19.444555, -99.156382, 'Radio 20, Valle Gómez, Cuauhtémoc, 06240 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (946, 9, 'Fray Bartolomé de Las Casas', ' Morelos', ' Cuauhtémoc', 6200, 19.444555, -99.156382, 'Fray Bartolomé de Las Casas, Morelos, Cuauhtémoc, 06200 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (947, 9, 'Paseo de la Reforma 155', ' Guerrero', ' Cuauhtémoc', 6500, 19.444555, -99.156382, 'Paseo de la Reforma 155, Guerrero, Cuauhtémoc, 06500 Cuauhtémoc, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (948, 9, 'Sanctorum 5', ' Lomas de Sotelo', ' Miguel Hidalgo', 11200, 19.457556, -99.236352, 'Sanctorum 5, Lomas de Sotelo, Miguel Hidalgo, 11200 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (949, 9, 'Norte 13 4908', ' Magdalena de Las Salinas', ' Gustavo A. Madero', 7770, 19.457556, -99.236352, 'Norte 13 4908, Magdalena de Las Salinas, Gustavo A. Madero, 07770 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (950, 9, 'Campo Colomo 24', ' San Antonio', ' Azcapotzalco', 2760, 19.364656, -99.116383, 'Campo Colomo 24, San Antonio, Azcapotzalco, 02760 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (951, 9, 'Avenida 3 179-181', ' Educación', ' Coyoacán', 4400, 19.325665, -99.207363, 'Avenida 3 179-181, Educación, Coyoacán, 04400 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (952, 9, 'Gardenia', ' Arcos de Centenario', ' Álvaro Obregón', 1618, 19.325665, -99.207363, 'Gardenia, Arcos de Centenario, Álvaro Obregón, 01618 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (953, 9, 'Cda. Portales 21', ' Sta Cruz Atoyac', ' Benito Juarez', 3310, 19.325665, -99.207363, 'Cda. Portales 21, Sta Cruz Atoyac, Benito Juarez, 03310 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (954, 9, 'Paseo de la Reforma', ' Zedec Santa Fe', ' Álvaro Obregón', 1219, 19.325665, -99.207363, 'Paseo de la Reforma, Zedec Santa Fe, Álvaro Obregón, 01219 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (955, 9, 'Minerva 803', ' Florida', ' Benito Juarez', 1030, 19.478665, -99.137383, 'Minerva 803, Florida, Benito Juarez, 01030 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (956, 9, 'Eje 2 Norte (Manuel González) 408', ' Tlatelolco', ' Cuauhtémoc', 6900, 19.478665, -99.137383, 'Eje 2 Norte (Manuel González) 408, Tlatelolco, Cuauhtémoc, 06900 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (957, 9, 'Ignacio Zaragoza 13', ' Zacatepec', ' Iztapalapa', 9560, 19.478665, -99.137383, 'Ignacio Zaragoza 13, Zacatepec, Iztapalapa, 09560 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (958, 9, 'San Francisco', ' Corpus Cristy', ' Álvaro Obregón', 1530, 19.473655, -99.276372, 'San Francisco, Corpus Cristy, Álvaro Obregón, 01530 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (959, 9, 'San Bernabé', ' Progreso', ' Álvaro Obregón', 1080, 19.473655, -99.276372, 'San Bernabé, Progreso, Álvaro Obregón, 01080 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (960, 9, 'Desierto de Los Leones 5720', ' Cedros', ' Álvaro Obregón', 1729, 19.447655, -99.007372, 'Desierto de Los Leones 5720, Cedros, Álvaro Obregón, 01729 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (961, 9, 'Rumania 308', ' Portales', ' Benito Juarez', 3300, 19.447655, -99.007372, 'Rumania 308, Portales, Benito Juarez, 03300 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (962, 9, 'Bosque de Huizaches 3', ' Bosques de Las Lomas', ' Cuajimalpa', 11000, 19.447655, -99.007372, 'Bosque de Huizaches 3, Bosques de Las Lomas, Cuajimalpa, 11000 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (963, 9, 'Eje 2 Oriente Av. H. Congreso de la Unión 5719A', ' Granjas Modernas', ' Gustavo A. Madero', 7460, 19.362565, -99.247362, 'Eje 2 Oriente Av. H. Congreso de la Unión 5719A, Granjas Modernas, Gustavo A. Madero, 07460 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (964, 9, 'Juchique', ' Jalalpa Tepito 2a. Ampliación', ' Álvaro Obregón', 1296, 19.362565, -99.247362, 'Juchique, Jalalpa Tepito 2a. Ampliación, Álvaro Obregón, 01296 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (965, 9, 'Ruiz Cortines', ' Pensador Mexicano', ' Venustiano Carranza', 15510, 19.362565, -99.247362, 'Ruiz Cortines, Pensador Mexicano, Venustiano Carranza, 15510 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (966, 9, 'Río Danubio', ' Cuauhtémoc', ' Nueva Cobertura', 6500, 19.483565, -99.037352, 'Río Danubio, Cuauhtémoc, Nueva Cobertura, 06500 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (967, 9, 'Francisco I. Madero 43', ' Centro', ' Cuauhtémoc', 6000, 19.483565, -99.037352, 'Francisco I. Madero 43, Centro, Cuauhtémoc, 06000 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (968, 9, 'Niños Heroes', ' Palmitas', ' Iztapalapa', 9670, 19.426556, -99.167352, 'Niños Heroes, Palmitas, Iztapalapa, 09670 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (969, 9, 'Alberto S. Díaz', ' Ejército de Agua Prieta', ' Iztapalapa', 9578, 19.425565, -99.227353, 'Alberto S. Díaz, Ejército de Agua Prieta, Iztapalapa, 09578 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (970, 9, 'Cjon. Maxtla 36', ' El Arenal 2a Sección', ' Venustiano Carranza', 15680, 19.425565, -99.227353, 'Cjon. Maxtla 36, El Arenal 2a Sección, Venustiano Carranza, 15680 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (971, 9, 'Canal Nacional', ' Ctm VII Culhuacan', ' Coyoacán', 4489, 19.377655, -99.117383, 'Canal Nacional, Ctm VII Culhuacan, Coyoacán, 04489 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (972, 9, 'Eje 1 Poniente', ' Guerrero', ' Cuauhtémoc', 6300, 19.377655, -99.117383, 'Eje 1 Poniente, Guerrero, Cuauhtémoc, 06300 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (973, 9, '3a. Cerrada de Minas', ' Arvide', ' Álvaro Obregón', 1280, 19.377655, -99.117383, '3a. Cerrada de Minas, Arvide, Álvaro Obregón, 01280 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (974, 9, 'Prolongación Río Churubusco', ' Aeropuerto Int de La Ciudad de México', ' Venustiano Carranza', 15620, 19.476655, -99.256363, 'Prolongación Río Churubusco, Aeropuerto Int de La Ciudad de México, Venustiano Carranza, 15620 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (975, 9, '2a. Cerrada Robles', ' San Bartolo Ameyalco', ' Álvaro Obregón', 1800, 19.476655, -99.256363, '2a. Cerrada Robles, San Bartolo Ameyalco, Álvaro Obregón, 01800 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (976, 9, 'Cerro 2 Conejos 60', ' Romero de Terreros', ' Coyoacán', 4310, 19.348665, -99.227373, 'Cerro 2 Conejos 60, Romero de Terreros, Coyoacán, 04310 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (977, 9, 'Norte 52 3815', ' Emiliano Zapata', ' Gustavo A. Madero', 7889, 19.348665, -99.227373, 'Norte 52 3815, Emiliano Zapata, Gustavo A. Madero, 07889 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (978, 9, 'Avenida Torres Ixtapaltongo', ' Olivar de Los Padres', ' Álvaro Obregón', 1780, 19.348665, -99.227373, 'Avenida Torres Ixtapaltongo, Olivar de Los Padres, Álvaro Obregón, 01780 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (979, 9, 'Historiadores 282', ' Ampliación El Triunfo', ' Iztapalapa', 9438, 19.348665, -99.227373, 'Historiadores 282, Ampliación El Triunfo, Iztapalapa, 09438 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (980, 9, 'Jose Ma. Morels', ' Culhuacan', ' Iztapalapa', 9800, 19.428666, -99.107382, 'Jose Ma. Morels, Culhuacan, Iztapalapa, 09800 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (981, 9, '1a. Privada Vicente Guerrero', ' Culhuacan', ' Iztapalapa', 9800, 19.385565, -99.256362, '1a. Privada Vicente Guerrero, Culhuacan, Iztapalapa, 09800 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (982, 9, 'Carretera Federal 15 de Cuota', ' Lomas de Santa Fe', ' Cuajimalpa', 1219, 19.385565, -99.256362, 'Carretera Federal 15 de Cuota, Lomas de Santa Fe, Cuajimalpa, 01219 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (983, 9, 'Río Nilo', ' Puente Blanco', ' Iztapalapa', 9770, 19.385565, -99.256362, 'Río Nilo, Puente Blanco, Iztapalapa, 09770 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (984, 9, 'Rómulo O''farril 14', ' Miguel Hidalgo', ' Álvaro Obregón', 1789, 19.378556, -99.226383, 'Rómulo O''farril 14, Miguel Hidalgo, Álvaro Obregón, 01789 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (985, 9, 'Yuncas', ' Tlacuitlapa Ampliación 2o. Reacomodo', ' Álvaro Obregón', 1650, 19.378556, -99.226383, 'Yuncas, Tlacuitlapa Ampliación 2o. Reacomodo, Álvaro Obregón, 01650 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (986, 9, 'Bandera', ' Lomas De santa Fe', ' Álvaro Obregón', 1219, 19.378556, -99.226383, 'Bandera, Lomas De santa Fe, Álvaro Obregón, 01219 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (987, 9, 'Calle 10 41', ' Heron Proal', ' Álvaro Obregón', 1640, 19.422655, -99.117352, 'Calle 10 41, Heron Proal, Álvaro Obregón, 01640 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (988, 9, 'SIN NOMBRE No. 370 18', ' Narciso Bassols', ' Gustavo A. Madero', 7980, 19.422655, -99.117352, 'SIN NOMBRE No. 370 18, Narciso Bassols, Gustavo A. Madero, 07980 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (989, 9, 'San Juan 2', ' Corpus Cristy', ' Álvaro Obregón', 1530, 19.422655, -99.117352, 'San Juan 2, Corpus Cristy, Álvaro Obregón, 01530 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (990, 9, '633 226', ' San Juan de Aragón 4a Sección', ' Gustavo A. Madero', 7979, 19.482656, -99.056353, '633 226, San Juan de Aragón 4a Sección, Gustavo A. Madero, 07979 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (991, 9, 'Minas', ' Lomas de La Estancia', ' Iztapalapa', 9640, 19.372666, -99.116352, 'Minas, Lomas de La Estancia, Iztapalapa, 09640 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (992, 9, 'Universidad', ' Ejército Constitucionalista I II y ÌII', ' Iztapalapa', 9220, 19.429566, -99.006383, 'Universidad, Ejército Constitucionalista I II y ÌII, Iztapalapa, 09220 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (993, 9, 'Calzada de La Ronda 105-109', ' Ex Hipódromo de Peralvillo', ' Cuauhtémoc', 6250, 19.472665, -99.026363, 'Calzada de La Ronda 105-109, Ex Hipódromo de Peralvillo, Cuauhtémoc, 06250 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (994, 9, 'Larín 35', ' Industrial', ' Gustavo A. Madero', 7800, 19.472665, -99.026363, 'Larín 35, Industrial, Gustavo A. Madero, 07800 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (995, 9, 'Eje 1 Poniente 982', ' Narvarte', ' Benito Juarez', 3020, 19.349665, -99.067352, 'Eje 1 Poniente 982, Narvarte, Benito Juarez, 03020 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (996, 9, 'N 75', ' La Concepción', ' Coyoacán', 4020, 19.349665, -99.067352, 'N 75, La Concepción, Coyoacán, 04020 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (997, 9, 'Calle Sufrajio Efectivo', ' San Miguel Amantla', ' Azcapotzalco', 2700, 19.349665, -99.067352, 'Calle Sufrajio Efectivo, San Miguel Amantla, Azcapotzalco, 02700 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (998, 9, '23 63', ' Santa Cruz Meyehualco', ' Iztapalapa', 9290, 19.324656, -99.106373, '23 63, Santa Cruz Meyehualco, Iztapalapa, 09290 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (999, 9, 'Norte 1', ' Cuchilla del Tesoro', ' Gustavo A. Madero', 7900, 19.324656, -99.106373, 'Norte 1, Cuchilla del Tesoro, Gustavo A. Madero, 07900 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1000, 9, 'Circunvalación 210', ' Janitzio', ' Venustiano Carranza', 15200, 19.336666, -99.166372, 'Circunvalación 210, Janitzio, Venustiano Carranza, 15200 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1001, 9, 'Sidar y Rovirosa', ' El Parque', ' Venustiano Carranza', 15960, 19.446665, -99.227352, 'Sidar y Rovirosa, El Parque, Venustiano Carranza, 15960 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1002, 9, 'Casma 637', ' Lindavista', ' Gustavo A. Madero', 7300, 19.446665, -99.227352, 'Casma 637, Lindavista, Gustavo A. Madero, 07300 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1003, 9, 'Muitles', ' San Bartolo Ameyalco', ' Álvaro Obregón', 1800, 19.383666, -99.126382, 'Muitles, San Bartolo Ameyalco, Álvaro Obregón, 01800 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1004, 9, '679 59', ' C. T. M. Aragón', ' Gustavo A. Madero', 7990, 19.472565, -99.226382, '679 59, C. T. M. Aragón, Gustavo A. Madero, 07990 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1005, 9, 'General Miguel Miramón 159', ' Martin Carrera', ' Gustavo A. Madero', 7070, 19.472565, -99.226382, 'General Miguel Miramón 159, Martin Carrera, Gustavo A. Madero, 07070 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1006, 9, 'Calle Libertad', ' Morelos', ' Cuauhtémoc', 6200, 19.472565, -99.226382, 'Calle Libertad, Morelos, Cuauhtémoc, 06200 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1007, 9, 'José Loreto Fabela 140', ' San Juan de Aragón 4a Sección', ' Gustavo A. Madero', 7979, 19.485566, -99.116363, 'José Loreto Fabela 140, San Juan de Aragón 4a Sección, Gustavo A. Madero, 07979 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1008, 9, 'Cruz Verde 26', ' Los Reyes', ' Coyoacán', 4330, 19.485566, -99.116363, 'Cruz Verde 26, Los Reyes, Coyoacán, 04330 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1009, 9, 'Centeno 66', ' Granjas Esmeralda', ' Iztapalapa', 9810, 19.465565, -99.207382, 'Centeno 66, Granjas Esmeralda, Iztapalapa, 09810 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1010, 9, 'Calle Aluminio 450', ' 2do Tramo 20 de Noviembre', ' Venustiano Carranza', 15300, 19.465565, -99.207382, 'Calle Aluminio 450, 2do Tramo 20 de Noviembre, Venustiano Carranza, 15300 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1011, 9, 'Paseo de Los Jardines 222', ' Paseos de Taxqueña', ' Paseos Taxqueña', 4250, 19.465565, -99.207382, 'Paseo de Los Jardines 222, Paseos de Taxqueña, Paseos Taxqueña, 04250 Coyoacán, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1012, 9, 'Avenida Carlos Lazo', ' Ejido San Mateo', ' Álvaro Obregón', 1580, 19.349565, -99.257363, 'Avenida Carlos Lazo, Ejido San Mateo, Álvaro Obregón, 01580 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1013, 9, 'Calle Fco Cesar M. MZ125 LT3', ' Zona Urbana Ejidal Santa Martha Acatitla Norte', ' Iztapalapa', 9140, 19.325655, -99.106362, 'Calle Fco Cesar M. MZ125 LT3, Zona Urbana Ejidal Santa Martha Acatitla Norte, Iztapalapa, 09140 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1014, 9, 'Hoja de Árbol', ' Infonavit Iztacalco', ' Iztacalco', 8900, 19.325655, -99.106362, 'Hoja de Árbol, Infonavit Iztacalco, Iztacalco, 08900 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1015, 9, 'Misioneros 20', ' Centro', ' Cuauhtémoc', 6000, 19.343656, -99.117353, 'Misioneros 20, Centro, Cuauhtémoc, 06000 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1016, 9, 'Avilés', ' Constitución de 1917', ' Iztapalapa', 9260, 19.479655, -99.017373, 'Avilés, Constitución de 1917, Iztapalapa, 09260 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1017, 9, 'Minas', ' Pilares Águilas', ' Álvaro Obregón', 1710, 19.467656, -99.067352, 'Minas, Pilares Águilas, Álvaro Obregón, 01710 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1018, 9, 'Plaza Gregorio Torres Quintero', ' Centro', ' Cuauhtémoc', 6000, 19.467656, -99.067352, 'Plaza Gregorio Torres Quintero, Centro, Cuauhtémoc, 06000 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1019, 9, 'Eje 8 Sur (Calz. Ermita Iztapalapa) 557', ' Granjas Esmeralda', ' Iztapalapa', 9810, 19.328555, -99.137372, 'Eje 8 Sur (Calz. Ermita Iztapalapa) 557, Granjas Esmeralda, Iztapalapa, 09810 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1020, 9, 'Balderas 68', ' Centro', ' Cuauhtémoc', 6050, 19.459656, -99.106372, 'Balderas 68, Centro, Cuauhtémoc, 06050 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1021, 9, 'San Juan de Los Lagos', ' Lomas de La Estancia', ' Iztapalapa', 9640, 19.459656, -99.106372, 'San Juan de Los Lagos, Lomas de La Estancia, Iztapalapa, 09640 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1022, 9, 'Eje 5 Sur (Prol. Marcelino Buendía)', ' Chinampac de Juárez', ' Iztapalapa', 9208, 19.452656, -99.137363, 'Eje 5 Sur (Prol. Marcelino Buendía), Chinampac de Juárez, Iztapalapa, 09208 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1023, 9, 'Asia 2', ' La Concepción', ' Coyoacán', 4020, 19.444556, -99.107352, 'Asia 2, La Concepción, Coyoacán, 04020 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1024, 9, 'Terbio 390', ' Cuchilla Pantitlan', ' Venustiano Carranza', 15610, 19.444556, -99.107352, 'Terbio 390, Cuchilla Pantitlan, Venustiano Carranza, 15610 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1025, 9, 'Tejamanil 141', ' Santo Domingo (Pgal de Sto Domingo)', ' Coyoacán', 4369, 19.364565, -99.127353, 'Tejamanil 141, Santo Domingo (Pgal de Sto Domingo), Coyoacán, 04369 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1026, 9, 'México - Toluca 2990', ' Lomas de Bezares', ' Miguel Hidalgo', 11910, 19.328555, -99.157352, 'México - Toluca 2990, Lomas de Bezares, Miguel Hidalgo, 11910 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1027, 9, 'Paseo de Las Trojes', ' Paseos de Taxqueña', ' Coyoacán', 4280, 19.369656, -99.047382, 'Paseo de Las Trojes, Paseos de Taxqueña, Coyoacán, 04280 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1028, 9, 'Sonora', ' Aeropuerto Int de La Ciudad de México', ' Venustiano Carranza', 15620, 19.424655, -99.257372, 'Sonora, Aeropuerto Int de La Ciudad de México, Venustiano Carranza, 15620 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1029, 9, 'Canadá Los Helechos 435-436', ' San Mateo Tlaltenango', ' Cuajimalpa', 5600, 19.444556, -99.046383, 'Canadá Los Helechos 435-436, San Mateo Tlaltenango, Cuajimalpa, 05600 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1030, 9, 'José Loreto Fabela 192', ' Campestre Aragón', ' Gustavo A. Madero', 7530, 19.457555, -99.226372, 'José Loreto Fabela 192, Campestre Aragón, Gustavo A. Madero, 07530 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1031, 9, 'Nueva York 264', ' Del Valle', ' Benito Juarez', 3810, 19.437565, -99.076363, 'Nueva York 264, Del Valle, Benito Juarez, 03810 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1032, 9, 'Ejido de Los Reyes 100', ' San Francisco Culhuacan(Ejidos de Culhuacan)', ' Coyoacán', 4470, 19.365665, -99.016372, 'Ejido de Los Reyes 100, San Francisco Culhuacan(Ejidos de Culhuacan), Coyoacán, 04470 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1033, 9, 'Paseo de la Reforma 325', ' Lomas Virreyes', ' Miguel Hidalgo', 6500, 19.472555, -99.256383, 'Paseo de la Reforma 325, Lomas Virreyes, Miguel Hidalgo, 06500 Mexico City (Distrito Federal), Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1034, 9, '10 30', ' Olivar del Conde 1a. Sección', ' Álvaro Obregón', 1400, 19.477655, -99.066352, '10 30, Olivar del Conde 1a. Sección, Álvaro Obregón, 01400 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1035, 9, 'Vicente Guerrero 9', ' Zacatepec', ' Iztapalapa', 9560, 19.439566, -99.006352, 'Vicente Guerrero 9, Zacatepec, Iztapalapa, 09560 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1036, 9, 'Cerro de Compostela 15', ' Campestre Churubusco', ' Coyoacán', 4200, 19.387566, -99.107383, 'Cerro de Compostela 15, Campestre Churubusco, Coyoacán, 04200 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1037, 9, 'Azueta', ' Centro', ' Cuauhtémoc', 6000, 19.366555, -99.006373, 'Azueta, Centro, Cuauhtémoc, 06000 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1038, 9, 'Al Olivo 22', ' Jardines de La Palma(Huizachito)', ' Cuajimalpa', 5100, 19.472555, -99.207352, 'Al Olivo 22, Jardines de La Palma(Huizachito), Cuajimalpa, 05100 Cuajimalpa de Morelos, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1039, 9, 'General Miguel Miramón 156BIS', ' Martin Carrera', ' Gustavo A. Madero', 7070, 19.466665, -99.277362, 'General Miguel Miramón 156BIS, Martin Carrera, Gustavo A. Madero, 07070 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1040, 9, 'Oriente 237 108', ' Agrícola Oriental', ' Iztacalco', 8500, 19.369091, -99.0768417, 'Oriente 237 108, Agrícola Oriental, Iztacalco, 08500 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1041, 9, 'Avenida Oceanía 130', ' Romero Rubio', ' Venustiano Carranza', 15400, 19.369091, -99.0768417, 'Avenida Oceanía 130, Romero Rubio, Venustiano Carranza, 15400 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1042, 9, 'Avenida del Bosque', ' Parque Tarango', ' Álvaro Obregón', 1580, 19.3368294, -99.0909366, 'Avenida del Bosque, Parque Tarango, Álvaro Obregón, 01580 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1043, 9, 'Calle Doctor Martínez del Río', ' Doctores', ' Cuauhtémoc', 6720, 19.3368294, -99.0909366, 'Calle Doctor Martínez del Río, Doctores, Cuauhtémoc, 06720 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1044, 9, 'Avenida Constituyentes 671', ' América', ' Miguel Hidalgo', 11820, 19.3368294, -99.0909366, 'Avenida Constituyentes 671, América, Miguel Hidalgo, 11820 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1045, 9, 'Nubes 121', ' Jardines del Pedregal', ' Álvaro Obregón', 1900, 19.3368294, -99.0909366, 'Nubes 121, Jardines del Pedregal, Álvaro Obregón, 01900 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1046, 9, 'Conscripto 311', ' Lomas de Sotelo', ' Miguel Hidalgo', 11200, 19.3724569, -99.1830019, 'Conscripto 311, Lomas de Sotelo, Miguel Hidalgo, 11200 Naucalpan, State of Mexico, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1047, 9, 'Bellini 47-48', ' Peralvillo', ' Cuauhtémoc', 6220, 19.3724569, -99.1830019, 'Bellini 47-48, Peralvillo, Cuauhtémoc, 06220 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1048, 9, 'F. C. Industrial', ' Vallejo', ' Gustavo A. Madero', 7870, 19.3430002, -99.1931543, 'F. C. Industrial, Vallejo, Gustavo A. Madero, 07870 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1049, 9, 'Las Torres', ' Xalpa', ' Iztapalapa', 9640, 19.3430002, -99.1931543, 'Las Torres, Xalpa, Iztapalapa, 09640 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1050, 9, 'Huitzilihuitl 22', ' La Preciosa', ' Azcapotzalco', 2460, 19.3752822, -99.0268074, 'Huitzilihuitl 22, La Preciosa, Azcapotzalco, 02460 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1051, 9, 'Avenida Revolucion 682', ' Nonoalco', ' Benito Juarez', 3700, 19.3752822, -99.0268074, 'Avenida Revolucion 682, Nonoalco, Benito Juarez, 03700 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1052, 9, 'Eje 10 Sur (Monserrat)', ' Conjunto Mariana', ' Coyoacán', 4330, 19.469201, -99.1679933, 'Eje 10 Sur (Monserrat), Conjunto Mariana, Coyoacán, 04330 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1053, 9, 'Eje 3 Sur (Añil) 217', ' Granjas México', ' Iztacalco', 8400, 19.4126233, -99.0821887, 'Eje 3 Sur (Añil) 217, Granjas México, Iztacalco, 08400 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1054, 9, 'Avenida de las Torres', ' 2da Ampliación Santiago Acahualtepec', ' Iztapalapa', 9609, 19.4126233, -99.0821887, 'Avenida de las Torres, 2da Ampliación Santiago Acahualtepec, Iztapalapa, 09609 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1055, 9, 'La Zanja 40', ' San Mateo Tlaltenango', ' Cuajimalpa', 5600, 19.4126233, -99.0821887, 'La Zanja 40, San Mateo Tlaltenango, Cuajimalpa, 05600 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1056, 9, 'Zempoala 62', ' Hermosillo', ' Coyoacán', 4240, 19.4575835, -99.2417843, 'Zempoala 62, Hermosillo, Coyoacán, 04240 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1057, 9, 'Niños Heroes de Chapultepec 102', ' Niños Heroes de Chapultepec', ' Benito Juarez', 3440, 19.4575835, -99.2417843, 'Niños Heroes de Chapultepec 102, Niños Heroes de Chapultepec, Benito Juarez, 03440 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1058, 9, 'Oriente 112 2307', ' Gabriel Ramos Millán', ' Iztacalco', 8730, 19.4575835, -99.2417843, 'Oriente 112 2307, Gabriel Ramos Millán, Iztacalco, 08730 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1059, 9, 'Marcelino Dávalos 13', ' Algarín', ' Cuauhtémoc', 6880, 19.3885214, -99.1856246, 'Marcelino Dávalos 13, Algarín, Cuauhtémoc, 06880 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1060, 9, 'Avenida Universidad 1495', ' Axotla', ' Álvaro Obregón', 1030, 19.3885214, -99.1856246, 'Avenida Universidad 1495, Axotla, Álvaro Obregón, 01030 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1061, 9, 'Ignacio Allende 10_1', ' Agrícola', ' Álvaro Obregón', 1050, 19.3885214, -99.1856246, 'Ignacio Allende 10_1, Agrícola, Álvaro Obregón, 01050 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1062, 9, 'Avenida Toluca 411', ' Olivar de Los Padres', ' Álvaro Obregón', 1780, 19.3885214, -99.1856246, 'Avenida Toluca 411, Olivar de Los Padres, Álvaro Obregón, 01780 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1063, 9, 'Hermenegildo Galeana 134', ' Guadalupe del Moral', ' Iztapalapa', 9300, 19.4210788, -99.043085, 'Hermenegildo Galeana 134, Guadalupe del Moral, Iztapalapa, 09300 Iztapalapa, Mexico, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1064, 9, '533 258', ' San Juan de Aragón 1a Sección', ' Gustavo A. Madero', 7969, 19.4210788, -99.043085, '533 258, San Juan de Aragón 1a Sección, Gustavo A. Madero, 07969 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1065, 9, 'Defensa Nacional', ' Xalpa', ' Iztapalapa', 9640, 19.4210788, -99.043085, 'Defensa Nacional, Xalpa, Iztapalapa, 09640 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1066, 9, 'Solón Argüello', ' Zona Urbana Ejidal Santa Martha Acatitla Sur', ' Iztapalapa', 9530, 19.4524633, -99.1995842, 'Solón Argüello, Zona Urbana Ejidal Santa Martha Acatitla Sur, Iztapalapa, 09530 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1067, 9, 'Calle José Ma. Parras 81', ' Juan Escutia', ' Iztapalapa', 9100, 19.3838398, -99.0581275, 'Calle José Ma. Parras 81, Juan Escutia, Iztapalapa, 09100 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1068, 9, 'Zapotecas 248', ' Ajusco', ' Coyoacán', 4300, 19.3838398, -99.0581275, 'Zapotecas 248, Ajusco, Coyoacán, 04300 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1069, 9, 'Eje 4 Oriente (Avenida Río Churubusco)', ' Granjas México', ' Iztacalco', 8400, 19.3838398, -99.0581275, 'Eje 4 Oriente (Avenida Río Churubusco), Granjas México, Iztacalco, 08400 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1070, 9, 'Campos Elíseos 71', ' Base 3', ' Miguel Hidalgo', 11580, 19.4206811, -99.101106, 'Campos Elíseos 71, Base 3, Miguel Hidalgo, 11580 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1071, 9, 'Eje 1 Poniente (Av. Cuahutemoc) 1090', ' Letrán Valle', ' Benito Juarez', 3650, 19.3377168, -99.2600586, 'Eje 1 Poniente (Av. Cuahutemoc) 1090, Letrán Valle, Benito Juarez, 03650 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1072, 9, 'Calle 3', ' Ampliación Jalalpa', ' Álvaro Obregón', 1296, 19.3377168, -99.2600586, 'Calle 3, Ampliación Jalalpa, Álvaro Obregón, 01296 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1073, 9, 'Alejandro Dumas 71', ' Polanco', ' Miguel Hidalgo', 11550, 19.3377168, -99.2600586, 'Alejandro Dumas 71, Polanco, Miguel Hidalgo, 11550 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1074, 9, 'Trabajo y Previsión Social 510', ' Federal', ' Venustiano Carranza', 15700, 19.4416414, -99.1573333, 'Trabajo y Previsión Social 510, Federal, Venustiano Carranza, 15700 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1075, 9, 'Del Carmen', ' Ixtlahuacan', ' Iztapalapa', 9690, 19.3227538, -99.0754373, 'Del Carmen, Ixtlahuacan, Iztapalapa, 09690 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1076, 9, 'Tasmania 362', ' Cosmopolita', ' Azcapotzalco', 2670, 19.3227538, -99.0754373, 'Tasmania 362, Cosmopolita, Azcapotzalco, 02670 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1077, 9, 'Colorines', ' Tenorios', ' Iztapalapa', 9680, 19.37568, -99.2460144, 'Colorines, Tenorios, Iztapalapa, 09680 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1078, 9, '5 de Mayo 14', ' La Martinica II', ' Álvaro Obregón', 1630, 19.37568, -99.2460144, '5 de Mayo 14, La Martinica II, Álvaro Obregón, 01630 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1079, 9, 'Calle 4', ' Pantitlan', ' Iztacalco', 8100, 19.3645012, -99.2345084, 'Calle 4, Pantitlan, Iztacalco, 08100 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1080, 9, 'Parque Vía Reforma 2035', ' Lomas de Chapultepec', ' Miguel Hidalgo', 11000, 19.3645012, -99.2345084, 'Parque Vía Reforma 2035, Lomas de Chapultepec, Miguel Hidalgo, 11000 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1081, 9, '2a. Cerrada Benito Juárez', ' Zona Urbana Ejidal Santa María Aztahuacan', ' Iztapalapa', 9570, 19.3645012, -99.2345084, '2a. Cerrada Benito Juárez, Zona Urbana Ejidal Santa María Aztahuacan, Iztapalapa, 09570 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1082, 9, 'Canal Nacional 2034', ' Valle del Sur', ' Iztapalapa', 9819, 19.4323597, -99.1250148, 'Canal Nacional 2034, Valle del Sur, Iztapalapa, 09819 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1083, 9, '2 A. Pérez MZ11 LT24', ' U Habitacional Vicente Guerrero I II ÌII IV V VI VII', ' Iztapalapa', 9200, 19.4323597, -99.1250148, '2 A. Pérez MZ11 LT24, U Habitacional Vicente Guerrero I II ÌII IV V VI VII, Iztapalapa, 09200 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1084, 9, 'Laureano Estudillo MZ166 LT40', ' Zona Urbana Ejidal Santa Martha Acatitla Norte', ' Iztapalapa', 9140, 19.4818894, -99.0019678, 'Laureano Estudillo MZ166 LT40, Zona Urbana Ejidal Santa Martha Acatitla Norte, Iztapalapa, 09140 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1085, 9, 'San Pedro 57(103)101', ' Del Carmen', ' Coyoacán', 4100, 19.4818894, -99.0019678, 'San Pedro 57(103)101, Del Carmen, Coyoacán, 04100 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1086, 9, 'Sagitario 154', ' Prado Churubusco', ' Coyoacán', 4230, 19.4818894, -99.0019678, 'Sagitario 154, Prado Churubusco, Coyoacán, 04230 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1087, 9, 'Serafín Olarte 85', ' Independencia', ' Benito Juarez', 3630, 19.4164992, -99.2632397, 'Serafín Olarte 85, Independencia, Benito Juarez, 03630 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1088, 9, 'Paseo del Río (Joaquín Gallo) 101', ' Chimalistac', ' Coyoacán', 4460, 19.4164992, -99.2632397, 'Paseo del Río (Joaquín Gallo) 101, Chimalistac, Coyoacán, 04460 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1089, 9, 'Eje 5 Norte Av. 412 MZ1 LT15', ' Ejidos San Juan de Aragón 2a Sección', ' Gustavo A. Madero', 7919, 19.3544035, -99.1932558, 'Eje 5 Norte Av. 412 MZ1 LT15, Ejidos San Juan de Aragón 2a Sección, Gustavo A. Madero, 07919 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1090, 9, 'Primer Retorno de Canal Nacional 41b', ' Ctm VII Culhuacan', ' Coyoacán', 4489, 19.3544035, -99.1932558, 'Primer Retorno de Canal Nacional 41b, Ctm VII Culhuacan, Coyoacán, 04489 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1091, 9, 'Díaz de León', ' Morelos', ' Cuauhtémoc', 6200, 19.3544035, -99.1932558, 'Díaz de León, Morelos, Cuauhtémoc, 06200 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1092, 9, 'Calle Cairo 46', ' San Miguel Amantla', ' Miguel Hidalgo', 2080, 19.3365846, -99.2545932, 'Calle Cairo 46, San Miguel Amantla, Miguel Hidalgo, 02080 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1093, 9, 'Melchor Ocampo 257', ' Verónica Anzures', ' Veronica Ansurez', 11300, 19.3365846, -99.2545932, 'Melchor Ocampo 257, Verónica Anzures, Veronica Ansurez, 11300 Miguel Hidalgo, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1094, 9, 'Anillo Periférico 2141', ' Ejército Constitucionalista', ' Iztapalapa', 9220, 19.3365846, -99.2545932, 'Anillo Periférico 2141, Ejército Constitucionalista, Iztapalapa, 09220 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1095, 9, 'Atlamaya', ' Flor de María', ' Álvaro Obregón', 1760, 19.3665309, -99.1943557, 'Atlamaya, Flor de María, Álvaro Obregón, 01760 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1096, 9, 'Río Salado', ' Puente Colorado', ' Álvaro Obregón', 1730, 19.3665309, -99.1943557, 'Río Salado, Puente Colorado, Álvaro Obregón, 01730 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1097, 9, 'EDISON 139', ' San Rafael', ' Cuauhtémoc', 6470, 19.4465475, -99.2734259, 'EDISON 139, San Rafael, Cuauhtémoc, 06470 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1098, 9, 'Luis Carracci', ' San Juan', ' Benito Juarez', 3730, 19.4465475, -99.2734259, 'Luis Carracci, San Juan, Benito Juarez, 03730 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1099, 9, 'Loma del Recuerdo 50', ' Lomas de Vista Hermosa', ' Cuajimalpa', 5100, 19.4465475, -99.2734259, 'Loma del Recuerdo 50, Lomas de Vista Hermosa, Cuajimalpa, 05100 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1100, 9, 'Oriente 182', ' Moctezuma 2a Sección', ' Venustiano Carranza', 15530, 19.4797577, -99.2489248, 'Oriente 182, Moctezuma 2a Sección, Venustiano Carranza, 15530 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1101, 9, 'Debussy 4419', ' Guadalupe Victoria', ' Gustavo A. Madero', 7790, 19.4797577, -99.2489248, 'Debussy 4419, Guadalupe Victoria, Gustavo A. Madero, 07790 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1102, 9, 'Avenida Carlos Lazo', ' Lomas de Santa Fe', ' Cuajimalpa', 1219, 19.4797577, -99.2489248, 'Avenida Carlos Lazo, Lomas de Santa Fe, Cuajimalpa, 01219 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1103, 9, 'Magdalena 727', ' Del Valle', ' Benito Juarez', 3100, 19.421293, -99.2464205, 'Magdalena 727, Del Valle, Benito Juarez, 03100 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1104, 9, 'Cabalgata 12', ' Colinas del Sur', ' Álvaro Obregón', 1430, 19.421293, -99.2464205, 'Cabalgata 12, Colinas del Sur, Álvaro Obregón, 01430 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1105, 9, 'Santa Balbina 96', ' Molino de Santo Domingo', ' Álvaro Obregón', 1130, 19.4672018, -99.1183819, 'Santa Balbina 96, Molino de Santo Domingo, Álvaro Obregón, 01130 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1106, 9, 'Misión', ' El Santuario', ' Iztapalapa', 9820, 19.4672018, -99.1183819, 'Misión, El Santuario, Iztapalapa, 09820 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1107, 9, 'Bertha 81', ' Nativitas', ' Benito Juarez', 3500, 19.4672018, -99.1183819, 'Bertha 81, Nativitas, Benito Juarez, 03500 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1108, 9, 'Niños Heroes 202', ' Doctores', ' Cuauhtémoc', 6720, 19.4672018, -99.1183819, 'Niños Heroes 202, Doctores, Cuauhtémoc, 06720 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1109, 9, 'Tlaloc 3', ' Ampliación El Triunfo', ' Iztapalapa', 9438, 19.4672018, -99.1183819, 'Tlaloc 3, Ampliación El Triunfo, Iztapalapa, 09438 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1110, 9, 'Avenida Telecomunicaciones', ' Unidad Habitacional Guelatao de Juárez II', ' Iztapalapa', 9208, 19.3835338, -99.1240842, 'Avenida Telecomunicaciones, Unidad Habitacional Guelatao de Juárez II, Iztapalapa, 09208 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1111, 9, 'Miguel M. Acosta MZ11 LT9', ' Álvaro Obregón', ' Iztapalapa', 9230, 19.3835338, -99.1240842, 'Miguel M. Acosta MZ11 LT9, Álvaro Obregón, Iztapalapa, 09230 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1112, 9, 'Calle Lago Zurich 210', ' Ampliación Granada', ' Miguel Hidalgo', 11529, 19.3835338, -99.1240842, 'Calle Lago Zurich 210, Ampliación Granada, Miguel Hidalgo, 11529 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1113, 9, 'Anillo Periférico', ' Chinampac de Juárez', ' Iztapalapa', 9208, 19.384105, -99.0194469, 'Anillo Periférico, Chinampac de Juárez, Iztapalapa, 09208 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1114, 9, 'Amatista 9', ' La Esmeralda 1a Sección', ' Gustavo A. Madero', 7549, 19.384105, -99.0194469, 'Amatista 9, La Esmeralda 1a Sección, Gustavo A. Madero, 07549 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1115, 9, '2a Cda del Refugio', ' San Bartolo Ameyalco', ' Álvaro Obregón', 1800, 19.384105, -99.0194469, '2a Cda del Refugio, San Bartolo Ameyalco, Álvaro Obregón, 01800 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1116, 9, 'Reforma 6', ' Lomas de San Lorenzo', ' Iztapalapa', 9780, 19.384105, -99.0194469, 'Reforma 6, Lomas de San Lorenzo, Iztapalapa, 09780 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1117, 9, 'Libra 94', ' Prado Churubusco', ' Coyoacán', 4230, 19.4106752, -99.0677892, 'Libra 94, Prado Churubusco, Coyoacán, 04230 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1118, 9, 'Sur 73-B', ' Sinatel', ' Iztapalapa', 9470, 19.4106752, -99.0677892, 'Sur 73-B, Sinatel, Iztapalapa, 09470 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1119, 9, 'Cda. Pincel 221', ' Santo Domingo (Pgal de Sto Domingo)', ' Coyoacán', 4369, 19.4106752, -99.0677892, 'Cda. Pincel 221, Santo Domingo (Pgal de Sto Domingo), Coyoacán, 04369 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1120, 9, 'Cedro 82', ' Santa María La Ribera', ' Cuauhtémoc', 6400, 19.3561374, -99.0043198, 'Cedro 82, Santa María La Ribera, Cuauhtémoc, 06400 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1121, 9, 'Norte 60-A 5415', ' Tablas de San Aguistin', ' Gustavo A. Madero', 7860, 19.4520145, -99.2223932, 'Norte 60-A 5415, Tablas de San Aguistin, Gustavo A. Madero, 07860 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1122, 9, 'Fernando Montes de Oca 135', ' Guadalupe del Moral', ' Iztapalapa', 6140, 19.4520145, -99.2223932, 'Fernando Montes de Oca 135, Guadalupe del Moral, Iztapalapa, 06140 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1123, 9, 'FARALLON 200', ' Jardines del Pedregal', ' Álvaro Obregón', 1900, 19.4520145, -99.2223932, 'FARALLON 200, Jardines del Pedregal, Álvaro Obregón, 01900 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1124, 9, 'Circuito Interior Avenida Río Churubusco 1644', ' Campestre Churubusco', ' Iztapalapa', 4200, 19.4520145, -99.2223932, 'Circuito Interior Avenida Río Churubusco 1644, Campestre Churubusco, Iztapalapa, 04200 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1125, 9, 'Ret. 707 11', ' El Centinela', ' Coyoacán', 4450, 19.4268519, -99.2033236, 'Ret. 707 11, El Centinela, Coyoacán, 04450 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1126, 9, 'San Francisco', ' San Bartolo Ameyalco', ' Álvaro Obregón', 1800, 19.4789927, -99.2752026, 'San Francisco, San Bartolo Ameyalco, Álvaro Obregón, 01800 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1127, 9, 'Avenida Aquiles Serdan', ' Tacuba', ' Miguel Hidalgo', 11410, 19.4789927, -99.2752026, 'Avenida Aquiles Serdan, Tacuba, Miguel Hidalgo, 11410 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1128, 9, 'Francisco Sarabia', ' Aeropuerto Int de La Ciudad de México', ' Venustiano Carranza', 15620, 19.3231924, -99.2673683, 'Francisco Sarabia, Aeropuerto Int de La Ciudad de México, Venustiano Carranza, 15620 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1129, 9, 'Rafael Sierra', ' San Juan', ' Iztapalapa', 9830, 19.3231924, -99.2673683, 'Rafael Sierra, San Juan, Iztapalapa, 09830 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1130, 9, 'Millet 13', ' Tlacoquemecatl del Valle', ' Benito Juarez', 3100, 19.3231924, -99.2673683, 'Millet 13, Tlacoquemecatl del Valle, Benito Juarez, 03100 BENITO JUAREZ, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1131, 9, 'Rosa Amarilla 77', ' El Alfalfar', ' Álvaro Obregón', 1470, 19.3263747, -99.0804289, 'Rosa Amarilla 77, El Alfalfar, Álvaro Obregón, 01470 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1132, 9, 'Ceylan 585', ' Industrial Vallejo', ' Gustavo A. Madero', 7729, 19.3263747, -99.0804289, 'Ceylan 585, Industrial Vallejo, Gustavo A. Madero, 07729 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1133, 9, 'De Los Buharros', ' Lomas de Las Águilas', ' Álvaro Obregón', 1759, 19.3263747, -99.0804289, 'De Los Buharros, Lomas de Las Águilas, Álvaro Obregón, 01759 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1134, 9, 'Aldama 75', ' Colonia Buenavista', ' Cuauhtémoc', 6350, 19.4505355, -99.0329326, 'Aldama 75, Colonia Buenavista, Cuauhtémoc, 06350 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1135, 9, 'Mixtecas 150', ' Ajusco', ' Coyoacán', 4300, 19.4505355, -99.0329326, 'Mixtecas 150, Ajusco, Coyoacán, 04300 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1136, 9, 'Ignacio Allende', ' Consejo Agrarista Mexicano', ' Iztapalapa', 9760, 19.441315, -99.0983141, 'Ignacio Allende, Consejo Agrarista Mexicano, Iztapalapa, 09760 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1137, 9, 'Fueguinos', ' Puerta Grande Ampliación', ' Álvaro Obregón', 1630, 19.441315, -99.0983141, 'Fueguinos, Puerta Grande Ampliación, Álvaro Obregón, 01630 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1138, 9, 'Calle Justo Sierra MZ20 LT8', ' Santa Cruz Meyehualco', ' Iztapalapa', 9730, 19.441315, -99.0983141, 'Calle Justo Sierra MZ20 LT8, Santa Cruz Meyehualco, Iztapalapa, 09730 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1139, 9, 'Francita 132', ' Petrolera', ' Azcapotzalco', 2480, 19.3877463, -99.1494144, 'Francita 132, Petrolera, Azcapotzalco, 02480 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1140, 9, 'Estela 144', ' Guadalupe Tepeyac', ' Gustavo A. Madero', 7840, 19.3689176, -99.1234581, 'Estela 144, Guadalupe Tepeyac, Gustavo A. Madero, 07840 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1141, 9, 'Cantera 8', ' Villa Gustavo a Madero', ' Gustavo A. Madero', 7050, 19.3689176, -99.1234581, 'Cantera 8, Villa Gustavo a Madero, Gustavo A. Madero, 07050 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1142, 9, '1a. Cerrada Legaria', ' Torre Blanca', ' Miguel Hidalgo', 11280, 19.3689176, -99.1234581, '1a. Cerrada Legaria, Torre Blanca, Miguel Hidalgo, 11280 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1143, 9, 'Coronado', ' El Paraíso', ' Iztapalapa', 9230, 19.4539932, -99.1470286, 'Coronado, El Paraíso, Iztapalapa, 09230 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1144, 9, 'Leopoldo Blakaller 15', ' Ampliación San Pedro Xalpa', ' Azcapotzalco', 2719, 19.4539932, -99.1470286, 'Leopoldo Blakaller 15, Ampliación San Pedro Xalpa, Azcapotzalco, 02719 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1145, 9, 'Calzada de la Naranja 195B', ' Santiago Ahuizotla', ' Azcapotzalco', 2750, 19.4310643, -99.2286539, 'Calzada de la Naranja 195B, Santiago Ahuizotla, Azcapotzalco, 02750 Mexico City, State of Mexico, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1146, 9, 'Oriente 172', ' Ampliación Sinatel', ' Iztapalapa', 9479, 19.4310643, -99.2286539, 'Oriente 172, Ampliación Sinatel, Iztapalapa, 09479 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1147, 9, 'Rodolfo Usigli 1221', ' Heroes de Churubusco', ' Rodolfo Usigli', 9090, 19.4357664, -99.2038989, 'Rodolfo Usigli 1221, Heroes de Churubusco, Rodolfo Usigli, 09090 Iztapalapa, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1148, 9, 'San Agustín', ' Buenavista', ' Iztapalapa', 9700, 19.4357664, -99.2038989, 'San Agustín, Buenavista, Iztapalapa, 09700 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1149, 9, 'Plan de Ayala', ' Plutarco Elías Calles', ' Miguel Hidalgo', 11350, 19.4422126, -99.052696, 'Plan de Ayala, Plutarco Elías Calles, Miguel Hidalgo, 11350 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1150, 9, 'Gustavo Díaz Ordaz', ' 2a. Ampliación Presidentes', ' Álvaro Obregón', 1299, 19.4422126, -99.052696, 'Gustavo Díaz Ordaz, 2a. Ampliación Presidentes, Álvaro Obregón, 01299 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1151, 9, 'Sur 114 20', ' Cove', ' Miguel Hidalgo', 1120, 19.4422126, -99.052696, 'Sur 114 20, Cove, Miguel Hidalgo, 01120 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1152, 9, 'Avenida Torres Ixtapaltongo', ' Olivar de Los Padres', ' Álvaro Obregón', 1780, 19.3541383, -99.2319365, 'Avenida Torres Ixtapaltongo, Olivar de Los Padres, Álvaro Obregón, 01780 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1153, 9, 'Avenida Fortuna 429', ' Churubusco Tepeyac', ' Gustavo A. Madero', 7730, 19.4682932, -99.1511234, 'Avenida Fortuna 429, Churubusco Tepeyac, Gustavo A. Madero, 07730 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1154, 9, 'Lucas Alamán 138', ' Obrera', ' Cuauhtémoc', 6800, 19.4682932, -99.1511234, 'Lucas Alamán 138, Obrera, Cuauhtémoc, 06800 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1155, 9, 'Avenida División del Norte 2420', ' Portales', ' Benito Juarez', 3300, 19.4682932, -99.1511234, 'Avenida División del Norte 2420, Portales, Benito Juarez, 03300 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1156, 9, 'Calle 5', ' San Miguel Amantla', ' Azcapotzalco', 2950, 19.3533733, -99.2582142, 'Calle 5, San Miguel Amantla, Azcapotzalco, 02950 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1157, 9, 'Yosemite 80', ' Nápoles', ' Benito Juarez', 3810, 19.3533733, -99.2582142, 'Yosemite 80, Nápoles, Benito Juarez, 03810 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1158, 9, 'Juan Aldama 800', ' Centro', ' Cuauhtémoc', 88780, 19.3533733, -99.2582142, 'Juan Aldama 800, Centro, Cuauhtémoc, 88780 Reynosa, Tamaulipas, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1159, 9, 'Camino de Los Viveros', ' Lomas Estrella 1RA. Sección', ' Iztapalapa', 9880, 19.3611251, -99.0658602, 'Camino de Los Viveros, Lomas Estrella 1RA. Sección, Iztapalapa, 09880 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1160, 9, 'Avenida Melchor Ocampo 272', ' Santa Catarina', ' Coyoacán', 4010, 19.3611251, -99.0658602, 'Avenida Melchor Ocampo 272, Santa Catarina, Coyoacán, 04010 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1161, 9, 'Eje 2 Oriente Heroica Escuela Naval Militar 480', ' San Francisco Culhuacan', ' Coyoacán', 4260, 19.4054019, -99.1971814, 'Eje 2 Oriente Heroica Escuela Naval Militar 480, San Francisco Culhuacan, Coyoacán, 04260 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1162, 9, 'Flor Silvestre MZ6 LT8', ' 2da Ampliación Santiago Acahualtepec', ' Iztapalapa', 9609, 19.4054019, -99.1971814, 'Flor Silvestre MZ6 LT8, 2da Ampliación Santiago Acahualtepec, Iztapalapa, 09609 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1163, 9, 'Plan de San Luis', ' Zona Urbana Ejidal Santa María Aztahuacan', ' Iztapalapa', 9570, 19.46864, -99.0578906, 'Plan de San Luis, Zona Urbana Ejidal Santa María Aztahuacan, Iztapalapa, 09570 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1164, 9, 'Calzada San Simon 92', ' San Simon Tolnahuac', ' Cuauhtémoc', 6920, 19.46864, -99.0578906, 'Calzada San Simon 92, San Simon Tolnahuac, Cuauhtémoc, 06920 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1165, 9, 'Bosque de Ciruelos 9', ' Bosques de Las Lomas', ' Miguel Hidalgo', 11700, 19.3515986, -99.1971984, 'Bosque de Ciruelos 9, Bosques de Las Lomas, Miguel Hidalgo, 11700 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1166, 9, 'Cuautla 66', ' Colonia Condesa', ' Cuauhtémoc', 6140, 19.3515986, -99.1971984, 'Cuautla 66, Colonia Condesa, Cuauhtémoc, 06140 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1167, 9, 'Vía Express Tapo *(VISUAL)', ' Aeropuerto Int de La Ciudad de México', ' Venustiano Carranza', 15620, 19.3397669, -99.0676538, 'Vía Express Tapo *(VISUAL), Aeropuerto Int de La Ciudad de México, Venustiano Carranza, 15620 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1168, 9, 'Prolongación Vicente Guerrero 4', ' San Mateo Tlaltenango', ' Cuajimalpa', 5600, 19.3397669, -99.0676538, 'Prolongación Vicente Guerrero 4, San Mateo Tlaltenango, Cuajimalpa, 05600 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1169, 9, 'Irolo', ' Del Carmen', ' Benito Juarez', 3540, 19.3397669, -99.0676538, 'Irolo, Del Carmen, Benito Juarez, 03540 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1170, 9, '3ER. Callejón Colón', ' San Miguel', ' Iztapalapa', 9360, 19.3397669, -99.0676538, '3ER. Callejón Colón, San Miguel, Iztapalapa, 09360 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1171, 9, 'Calzada México-Tacuba 870', ' Torre Blanca', ' Miguel Hidalgo', 11280, 19.37823, -99.0660125, 'Calzada México-Tacuba 870, Torre Blanca, Miguel Hidalgo, 11280 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1172, 9, 'Pino', ' Garcimarreronorte', ' Álvaro Obregón', 1510, 19.37823, -99.0660125, 'Pino, Garcimarreronorte, Álvaro Obregón, 01510 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1173, 9, 'De La Rosa MZ2 LT15A', ' Reforma Política', ' Iztapalapa', 9730, 19.37823, -99.0660125, 'De La Rosa MZ2 LT15A, Reforma Política, Iztapalapa, 09730 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1174, 9, 'Melchor Ocampo 68-79', ' El Triunfo', ' Iztapalapa', 9430, 19.4309113, -99.1230182, 'Melchor Ocampo 68-79, El Triunfo, Iztapalapa, 09430 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1175, 9, 'Procuraduría General de Justicia 247', ' Federal', ' Venustiano Carranza', 15700, 19.4309113, -99.1230182, 'Procuraduría General de Justicia 247, Federal, Venustiano Carranza, 15700 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1176, 9, 'Pedro Vélez', ' Insurgentes', ' Iztapalapa', 9750, 19.4817466, -99.2360482, 'Pedro Vélez, Insurgentes, Iztapalapa, 09750 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1177, 9, 'Cerrada de Capuchinas 83', ' San José Insurgentes', ' Benito Juarez', 3900, 19.4817466, -99.2360482, 'Cerrada de Capuchinas 83, San José Insurgentes, Benito Juarez, 03900 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1178, 9, 'Miguel Barragán 13', ' Martin Carrera', ' Gustavo A. Madero', 7070, 19.4817466, -99.2360482, 'Miguel Barragán 13, Martin Carrera, Gustavo A. Madero, 07070 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1179, 9, 'Presa la Amistad 13', ' Lomas de Sotelo', ' Miguel Hidalgo', 11200, 19.4860407, -99.2068262, 'Presa la Amistad 13, Lomas de Sotelo, Miguel Hidalgo, 11200 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1180, 9, 'Santa Teresita MZ30 LT17 Y LT19', ' Molino de Santo Domingo', ' Álvaro Obregón', 1130, 19.4860407, -99.2068262, 'Santa Teresita MZ30 LT17 Y LT19, Molino de Santo Domingo, Álvaro Obregón, 01130 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1181, 9, 'Leopoldo Auer 68', ' Vallejo Poniente', ' Gustavo A. Madero', 7790, 19.4860407, -99.2068262, 'Leopoldo Auer 68, Vallejo Poniente, Gustavo A. Madero, 07790 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1182, 9, 'Avenida de Los Compositores', ' Bosque de Chapultepec II', ' Miguel Hidalgo', 11100, 19.4860407, -99.2068262, 'Avenida de Los Compositores, Bosque de Chapultepec II, Miguel Hidalgo, 11100 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1183, 9, 'Cataratas', ' Los Alpes', ' Álvaro Obregón', 1710, 19.3730281, -99.0783646, 'Cataratas, Los Alpes, Álvaro Obregón, 01710 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1184, 9, 'Bosque de Canelos 85', ' Bosques de Las Lomas', ' Cuajimalpa', 5120, 19.3730281, -99.0783646, 'Bosque de Canelos 85, Bosques de Las Lomas, Cuajimalpa, 05120 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1185, 9, 'Díaz Soto y Gama MZ14 LT40', ' U Habitacional Vicente Guerrero I II ÌII IV V VI VII', ' Iztapalapa', 9200, 19.4575325, -99.2065724, 'Díaz Soto y Gama MZ14 LT40, U Habitacional Vicente Guerrero I II ÌII IV V VI VII, Iztapalapa, 09200 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1186, 9, 'Calle Miguel Hidalgo', ' Zona Urbana Ejidal Santa María Aztahuacan', ' Iztapalapa', 9570, 19.4678954, -99.2091443, 'Calle Miguel Hidalgo, Zona Urbana Ejidal Santa María Aztahuacan, Iztapalapa, 09570 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1187, 9, 'Lafayette 67', ' Cedros', ' Álvaro Obregón', 1870, 19.4678954, -99.2091443, 'Lafayette 67, Cedros, Álvaro Obregón, 01870 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1188, 9, 'Rivero 100', ' Barrio de Tepito', ' Cuauhtémoc', 6200, 19.4678954, -99.2091443, 'Rivero 100, Barrio de Tepito, Cuauhtémoc, 06200 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1189, 9, 'Detroit 14', ' Noche Buena', ' Benito Juarez', 3720, 19.3799843, -99.0020524, 'Detroit 14, Noche Buena, Benito Juarez, 03720 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1190, 9, 'Eje 2 Oriente Av. H. Congreso de la Unión 6413', ' Granjas Modernas', ' Gustavo A. Madero', 7460, 19.3799843, -99.0020524, 'Eje 2 Oriente Av. H. Congreso de la Unión 6413, Granjas Modernas, Gustavo A. Madero, 07460 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1191, 9, 'Granjas 39', ' Palo Alto(Granjas)', ' Palo Alto', 1000, 19.3799843, -99.0020524, 'Granjas 39, Palo Alto(Granjas), Palo Alto, 01000 Cuajimalpa de Morelos, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1192, 9, 'Avenida Tamaulipas MZ5 LT22', ' Ejido San Mateo', ' Álvaro Obregón', 1580, 19.3799843, -99.0020524, 'Avenida Tamaulipas MZ5 LT22, Ejido San Mateo, Álvaro Obregón, 01580 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1193, 9, 'Ejido Tlahuac 12', ' San Francisco Culhuacan(Ejidos de Culhuacan)', ' Coyoacán', 4470, 19.3413887, -99.0230341, 'Ejido Tlahuac 12, San Francisco Culhuacan(Ejidos de Culhuacan), Coyoacán, 04470 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1194, 9, 'Jesús Carranza 23', ' Morelos', ' Cuauhtémoc', 6200, 19.3413887, -99.0230341, 'Jesús Carranza 23, Morelos, Cuauhtémoc, 06200 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1195, 9, 'Carretera Federal 85', ' Colonia Buenavista', ' Cuauhtémoc', 6350, 19.3413887, -99.0230341, 'Carretera Federal 85, Colonia Buenavista, Cuauhtémoc, 06350 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1196, 9, 'De Colina', ' Águilas', ' Álvaro Obregón', 1710, 19.324549, -99.2614292, 'De Colina, Águilas, Álvaro Obregón, 01710 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1197, 9, 'Luis de La Rosa 8', ' Constitución de La República', ' Gustavo A. Madero', 7469, 19.4406622, -99.2575036, 'Luis de La Rosa 8, Constitución de La República, Gustavo A. Madero, 07469 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1198, 9, 'Galeana 352', ' Pueblo Santa Fe', ' Álvaro Obregón', 1210, 19.4406622, -99.2575036, 'Galeana 352, Pueblo Santa Fe, Álvaro Obregón, 01210 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1199, 9, 'Eje 8 Sur (Calz. Ermita Iztapalapa) 1334', ' San Pablo', ' Iztapalapa', 9000, 19.4406622, -99.2575036, 'Eje 8 Sur (Calz. Ermita Iztapalapa) 1334, San Pablo, Iztapalapa, 09000 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1200, 9, 'Avenida 1 35', ' Educación', ' Coyoacán', 4400, 19.4407132, -99.0154874, 'Avenida 1 35, Educación, Coyoacán, 04400 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1201, 9, 'Francisco Villa MZP LT13', ' Acuilotla', ' Álvaro Obregón', 1540, 19.4556456, -99.0126448, 'Francisco Villa MZP LT13, Acuilotla, Álvaro Obregón, 01540 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1202, 9, 'Alpes 324', ' Lomas de Chapultepec', ' Miguel Hidalgo', 11000, 19.4556456, -99.0126448, 'Alpes 324, Lomas de Chapultepec, Miguel Hidalgo, 11000 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1203, 9, 'Avenida Rio San Joaquin 36', ' Base 3', ' Granada Polanco', 11520, 19.4556456, -99.0126448, 'Avenida Rio San Joaquin 36, Base 3, Granada Polanco, 11520 Miguel Hidalgo, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1204, 9, 'Hojalatería 174', ' Emilio Carranza', ' Venustiano Carranza', 15230, 19.4507089, -99.2635442, 'Hojalatería 174, Emilio Carranza, Venustiano Carranza, 15230 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1205, 9, 'Ignacio Rayon', ' San Juan de Aragón', ' Gustavo A. Madero', 7950, 19.4507089, -99.2635442, 'Ignacio Rayon, San Juan de Aragón, Gustavo A. Madero, 07950 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1206, 9, 'Norte 45 660', ' Industrial Vallejo', ' Azcapotzalco', 2300, 19.4313295, -99.1899732, 'Norte 45 660, Industrial Vallejo, Azcapotzalco, 02300 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1207, 9, 'Sur 105', ' Heroes de Churubusco', ' Iztapalapa', 9090, 19.4313295, -99.1899732, 'Sur 105, Heroes de Churubusco, Iztapalapa, 09090 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1208, 9, 'Calle 4 5', ' San Pedro de Los Pinos', ' Álvaro Obregón', 1180, 19.4313295, -99.1899732, 'Calle 4 5, San Pedro de Los Pinos, Álvaro Obregón, 01180 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1209, 9, 'Calzada Legaria 662', ' Lomas de Sotelo', ' Miguel Hidalgo', 11200, 19.4313295, -99.1899732, 'Calzada Legaria 662, Lomas de Sotelo, Miguel Hidalgo, 11200 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1210, 9, 'Saratoga 302', ' Portales', ' Benito Juarez', 3300, 19.4313295, -99.1899732, 'Saratoga 302, Portales, Benito Juarez, 03300 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1211, 9, 'Limón 7', ' Centro', ' Venustiano Carranza', 15100, 19.4737296, -99.1898548, 'Limón 7, Centro, Venustiano Carranza, 15100 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1212, 9, 'Constitución de Apatzingán', ' Tepalcates', ' Iztapalapa', 9210, 19.4553702, -99.2660654, 'Constitución de Apatzingán, Tepalcates, Iztapalapa, 09210 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1213, 9, 'Coras 34', ' Ajusco', ' Coyoacán', 4300, 19.4553702, -99.2660654, 'Coras 34, Ajusco, Coyoacán, 04300 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1214, 9, 'Supervía Poniente', ' Parque Tarango', ' Álvaro Obregón', 1580, 19.4553702, -99.2660654, 'Supervía Poniente, Parque Tarango, Álvaro Obregón, 01580 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1215, 9, 'De Los Bosques 103', ' Lomas del Chamizal', ' Cuajimalpa', 5129, 19.4553702, -99.2660654, 'De Los Bosques 103, Lomas del Chamizal, Cuajimalpa, 05129 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1216, 9, 'Puerto México', ' Piloto Adolfo López Mateos', ' Álvaro Obregón', 1290, 19.4637441, -99.004286, 'Puerto México, Piloto Adolfo López Mateos, Álvaro Obregón, 01290 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1217, 9, 'Zaragoza 29', ' Centro de Azcapotzalco', ' Azcapotzalco', 2000, 19.3755372, -99.2028668, 'Zaragoza 29, Centro de Azcapotzalco, Azcapotzalco, 02000 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1218, 9, 'Torres Adalid 1165', ' Narvarte', ' Benito Juarez', 3100, 19.3755372, -99.2028668, 'Torres Adalid 1165, Narvarte, Benito Juarez, 03100 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1219, 9, 'Cda. And. 4 16', ' Granjas México', ' Iztacalco', 8400, 19.4053713, -99.0097175, 'Cda. And. 4 16, Granjas México, Iztacalco, 08400 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1220, 9, 'Moctezuma 243', ' Colonia Buenavista', ' Cuauhtémoc', 6300, 19.4053713, -99.0097175, 'Moctezuma 243, Colonia Buenavista, Cuauhtémoc, 06300 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1221, 9, 'México', ' Desarrollo Urbano El Piru', ' Álvaro Obregón', 1520, 19.4509843, -99.0101236, 'México, Desarrollo Urbano El Piru, Álvaro Obregón, 01520 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1222, 9, 'San Nicolás Tolentino 29', ' Presidentes de México', ' Iztapalapa', 9740, 19.4509843, -99.0101236, 'San Nicolás Tolentino 29, Presidentes de México, Iztapalapa, 09740 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1223, 9, 'Anillo Periférico 54', ' Constitución de 1917', ' Iztapalapa', 9260, 19.4272089, -99.1725788, 'Anillo Periférico 54, Constitución de 1917, Iztapalapa, 09260 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1224, 9, 'Juan de Dios Peza 85', ' Obrera', ' Cuauhtémoc', 6800, 19.4272089, -99.1725788, 'Juan de Dios Peza 85, Obrera, Cuauhtémoc, 06800 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1225, 9, 'Ventura G.Tena 25', ' Asturias', ' Cuauhtémoc', 6850, 19.4272089, -99.1725788, 'Ventura G.Tena 25, Asturias, Cuauhtémoc, 06850 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1226, 9, '49 45', ' Avante', ' Coyoacán', 4460, 19.350752, -99.0008003, '49 45, Avante, Coyoacán, 04460 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1227, 9, 'Rafael Heliodoro Valle 427', ' Lorenzo Boturini', ' Venustiano Carranza', 15820, 19.350752, -99.0008003, 'Rafael Heliodoro Valle 427, Lorenzo Boturini, Venustiano Carranza, 15820 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1228, 9, 'Avenida Tamaulipas 24', ' Universal Infonavit', ' Álvaro Obregón', 1357, 19.350752, -99.0008003, 'Avenida Tamaulipas 24, Universal Infonavit, Álvaro Obregón, 01357 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1229, 9, '2a. Cda. Zacatecas MZ378 LT10', ' Peñón de Los Baños', ' Venustiano Carranza', 15520, 19.350752, -99.0008003, '2a. Cda. Zacatecas MZ378 LT10, Peñón de Los Baños, Venustiano Carranza, 15520 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1230, 9, 'Poniente 116 576', ' Industrial Vallejo', ' Azcapotzalco', 2350, 19.4437426, -99.0001404, 'Poniente 116 576, Industrial Vallejo, Azcapotzalco, 02350 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1231, 9, '10 226', ' Porvenir', ' Azcapotzalco', 2940, 19.4437426, -99.0001404, '10 226, Porvenir, Azcapotzalco, 02940 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1232, 9, 'Gabriel Carmona LB', ' Canutillo', ' Álvaro Obregón', 1560, 19.4437426, -99.0001404, 'Gabriel Carmona LB, Canutillo, Álvaro Obregón, 01560 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1233, 9, 'Calle Del Golf 219', ' Country Club', ' Coyoacán', 4220, 19.3653273, -99.0287025, 'Calle Del Golf 219, Country Club, Coyoacán, 04220 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1234, 9, 'Avenida Batallones Rojos', ' Albarrada', ' Iztapalapa', 9200, 19.3653273, -99.0287025, 'Avenida Batallones Rojos, Albarrada, Iztapalapa, 09200 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1235, 9, '5 de Febrero', ' Algarín', ' Cuauhtémoc', 6880, 19.364236, -99.273189, '5 de Febrero, Algarín, Cuauhtémoc, 06880 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1236, 9, 'Piedra del Sol 82', ' Avante', ' Coyoacán', 4460, 19.364236, -99.273189, 'Piedra del Sol 82, Avante, Coyoacán, 04460 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1237, 9, 'Ricardo Flores Magón 164 A', ' Guerrero', ' Cuauhtémoc', 6300, 19.364236, -99.273189, 'Ricardo Flores Magón 164 A, Guerrero, Cuauhtémoc, 06300 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1238, 9, 'Auditorio Nacional', ' Bosque de Chapultepec I', ' Miguel Hidalgo', 11100, 19.4457519, -99.1122397, 'Auditorio Nacional, Bosque de Chapultepec I, Miguel Hidalgo, 11100 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1239, 9, 'Prolongación Canario 208', ' Tolteca', ' Álvaro Obregón', 1150, 19.4457519, -99.1122397, 'Prolongación Canario 208, Tolteca, Álvaro Obregón, 01150 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1240, 9, 'Miguel Olivares 53', ' Presidentes Ejidales', ' Coyoacán', 4470, 19.4845515, -99.2321057, 'Miguel Olivares 53, Presidentes Ejidales, Coyoacán, 04470 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1241, 9, 'Ricarte 474', ' Churubusco Tepeyac', ' Gustavo A. Madero', 7730, 19.3965741, -99.0346839, 'Ricarte 474, Churubusco Tepeyac, Gustavo A. Madero, 07730 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1242, 9, 'Centeotl 274', ' Santa Lucía', ' Idustrial San Antonio', 2760, 19.3965741, -99.0346839, 'Centeotl 274, Santa Lucía, Idustrial San Antonio, 02760 Azcapotzalco, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1243, 9, 'Fernando M. Villalpando 43', ' Guadalupe Inn', ' Álvaro Obregón', 1020, 19.3965741, -99.0346839, 'Fernando M. Villalpando 43, Guadalupe Inn, Álvaro Obregón, 01020 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1244, 9, 'Sierra Vertientes 1020', ' Bosques de Las Lomas', ' Miguel Hidalgo', 11000, 19.3965741, -99.0346839, 'Sierra Vertientes 1020, Bosques de Las Lomas, Miguel Hidalgo, 11000 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1245, 9, 'Mafafa 119', ' El Manto', ' Iztapalapa', 9830, 19.4406469, -99.0251576, 'Mafafa 119, El Manto, Iztapalapa, 09830 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1246, 9, 'Eje 4 Norte (Av. 510)', ' San Juan de Aragón 4a Sección', ' Gustavo A. Madero', 7979, 19.4406469, -99.0251576, 'Eje 4 Norte (Av. 510), San Juan de Aragón 4a Sección, Gustavo A. Madero, 07979 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1247, 9, 'Avenida Santiago', ' Moderna', ' Benito Juarez', 3510, 19.4406469, -99.0251576, 'Avenida Santiago, Moderna, Benito Juarez, 03510 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1248, 9, 'Ceylan 470', ' San Miguel Amantla', ' Miguel Hidalgo', 2520, 19.3646083, -99.1975621, 'Ceylan 470, San Miguel Amantla, Miguel Hidalgo, 02520 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1249, 9, 'Villa Oso MZ70B LT15', ' Desarrollo Urbano Quetzalcoatl', ' Iztapalapa', 9700, 19.3646083, -99.1975621, 'Villa Oso MZ70B LT15, Desarrollo Urbano Quetzalcoatl, Iztapalapa, 09700 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1250, 9, 'Árbol del Fuego 80', ' El Rosario Coyoacán', ' Coyoacán', 4380, 19.3646083, -99.1975621, 'Árbol del Fuego 80, El Rosario Coyoacán, Coyoacán, 04380 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1251, 9, 'Eje Central Lázaro Cárdenas 1157', ' Letrán Valle', ' Benito Juarez', 3650, 19.3646083, -99.1975621, 'Eje Central Lázaro Cárdenas 1157, Letrán Valle, Benito Juarez, 03650 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1252, 9, 'Desierto de Los Leones 5469', ' Cedros', ' Álvaro Obregón', 1870, 19.326339, -99.000335, 'Desierto de Los Leones 5469, Cedros, Álvaro Obregón, 01870 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1253, 9, '1a. Cerrada Francisco Villa', ' Tlacoyaque', ' Álvaro Obregón', 1859, 19.326339, -99.000335, '1a. Cerrada Francisco Villa, Tlacoyaque, Álvaro Obregón, 01859 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1254, 9, 'Avenida 608 251', ' San Juan de Aragón 4a Sección', ' Gustavo A. Madero', 7979, 19.3624153, -99.0695912, 'Avenida 608 251, San Juan de Aragón 4a Sección, Gustavo A. Madero, 07979 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1255, 9, 'Avenida Revolución 7', ' San Ángel', ' Álvaro Obregón', 1000, 19.3624153, -99.0695912, 'Avenida Revolución 7, San Ángel, Álvaro Obregón, 01000 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1256, 9, 'Cerro San Francisco 248', ' Campestre Churubusco', ' Coyoacán', 4200, 19.3624153, -99.0695912, 'Cerro San Francisco 248, Campestre Churubusco, Coyoacán, 04200 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1257, 9, 'Albéniz 4418', ' Guadalupe Victoria', ' Gustavo A. Madero', 7780, 19.3624153, -99.0695912, 'Albéniz 4418, Guadalupe Victoria, Gustavo A. Madero, 07780 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1258, 9, 'Sur 111-A 2317', ' Tlacotal Ramos Millán', ' Iztacalco', 8720, 19.3619359, -99.1821644, 'Sur 111-A 2317, Tlacotal Ramos Millán, Iztacalco, 08720 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1259, 9, 'Universidad', ' Las Americas', ' Iztapalapa', 9250, 19.3619359, -99.1821644, 'Universidad, Las Americas, Iztapalapa, 09250 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1260, 9, 'Villa del Rey MZ20 LT11', ' Desarrollo Urbano Quetzalcoatl', ' Iztapalapa', 9700, 19.3619359, -99.1821644, 'Villa del Rey MZ20 LT11, Desarrollo Urbano Quetzalcoatl, Iztapalapa, 09700 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1261, 9, 'Eje 5 Norte Av. 412 370', ' San Juan de Aragón 6a Sección', ' Gustavo A. Madero', 7918, 19.3619359, -99.1821644, 'Eje 5 Norte Av. 412 370, San Juan de Aragón 6a Sección, Gustavo A. Madero, 07918 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1262, 9, 'Prisciliano Sánchez 67', ' Juan Escutia', ' Iztapalapa', 9100, 19.4555283, -99.2643311, 'Prisciliano Sánchez 67, Juan Escutia, Iztapalapa, 09100 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1263, 9, '2a. Cerrada 11 de Abril', ' Escandón', ' Miguel Hidalgo', 11800, 19.4555283, -99.2643311, '2a. Cerrada 11 de Abril, Escandón, Miguel Hidalgo, 11800 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1264, 9, 'Prolongación Río Churubusco', ' Aeropuerto Int de La Ciudad de México', ' Venustiano Carranza', 15620, 19.4703076, -99.1558527, 'Prolongación Río Churubusco, Aeropuerto Int de La Ciudad de México, Venustiano Carranza, 15620 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1265, 9, '1 B (Omecihuatl)', ' Adolfo Ruiz Cortines', ' Coyoacán', 4630, 19.4703076, -99.1558527, '1 B (Omecihuatl), Adolfo Ruiz Cortines, Coyoacán, 04630 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1266, 9, 'Carlos Hank González', ' Zona Urbana Ejidal Santa María Tomatlan', ' Iztapalapa', 9870, 19.4703076, -99.1558527, 'Carlos Hank González, Zona Urbana Ejidal Santa María Tomatlan, Iztapalapa, 09870 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1267, 9, '1a. Cerrada Piedra Bengala', ' Molino de Rosas', ' Álvaro Obregón', 1470, 19.4862192, -99.0528398, '1a. Cerrada Piedra Bengala, Molino de Rosas, Álvaro Obregón, 01470 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1268, 9, 'Eje 1 Norte (Av. Hangares de Aviación Fuerza Aérea Mexicana) 41', ' Federal', ' Venustiano Carranza', 15700, 19.3967985, -99.0232794, 'Eje 1 Norte (Av. Hangares de Aviación Fuerza Aérea Mexicana) 41, Federal, Venustiano Carranza, 15700 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1269, 9, 'De La Paz 26', ' Chimalistac', ' Álvaro Obregón', 1070, 19.3967985, -99.0232794, 'De La Paz 26, Chimalistac, Álvaro Obregón, 01070 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1270, 9, 'Ejército Nacional 613', ' Base 3', ' Cuauhtémoc', 6000, 19.3967985, -99.0232794, 'Ejército Nacional 613, Base 3, Cuauhtémoc, 06000 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1271, 9, 'Villa Castin', ' Desarrollo Urbano Quetzalcoatl', ' Iztapalapa', 9700, 19.3506959, -99.0729585, 'Villa Castin, Desarrollo Urbano Quetzalcoatl, Iztapalapa, 09700 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1272, 9, 'Eusebio Jáuregui 59', ' Ampliación San Pedro Xalpa', ' Azcapotzalco', 2719, 19.3506959, -99.0729585, 'Eusebio Jáuregui 59, Ampliación San Pedro Xalpa, Azcapotzalco, 02719 Mexico City, State of Mexico, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1273, 9, 'Villaco', ' Desarrollo Urbano Quetzalcoatl', ' Iztapalapa', 9700, 19.3506959, -99.0729585, 'Villaco, Desarrollo Urbano Quetzalcoatl, Iztapalapa, 09700 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1274, 9, 'Jericó 6', ' Romero Rubio', ' Venustiano Carranza', 15400, 19.4170755, -99.0512323, 'Jericó 6, Romero Rubio, Venustiano Carranza, 15400 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1275, 9, 'Oriente 157', ' El Coyol', ' Gustavo A. Madero', 7420, 19.4170755, -99.0512323, 'Oriente 157, El Coyol, Gustavo A. Madero, 07420 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1276, 9, 'Debussy 4419', ' Guadalupe Victoria', ' Gustavo A. Madero', 7790, 19.4155098, -99.023694, 'Debussy 4419, Guadalupe Victoria, Gustavo A. Madero, 07790 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1277, 9, 'Avenida Carlos Lazo', ' Lomas de Santa Fe', ' Cuajimalpa', 1219, 19.4155098, -99.023694, 'Avenida Carlos Lazo, Lomas de Santa Fe, Cuajimalpa, 01219 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1278, 9, 'Magdalena 727', ' Del Valle', ' Benito Juarez', 3100, 19.323682, -99.2172832, 'Magdalena 727, Del Valle, Benito Juarez, 03100 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1279, 9, 'Cabalgata 12', ' Colinas del Sur', ' Álvaro Obregón', 1430, 19.323682, -99.2172832, 'Cabalgata 12, Colinas del Sur, Álvaro Obregón, 01430 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1280, 9, 'Reforma Urbana MZ22 LT17', ' Reforma Política', ' Iztapalapa', 9730, 19.4417536, -99.013017, 'Reforma Urbana MZ22 LT17, Reforma Política, Iztapalapa, 09730 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1281, 9, 'Obraje', ' Guerrero', ' Cuauhtémoc', 6300, 19.4105528, -99.1496175, 'Obraje, Guerrero, Cuauhtémoc, 06300 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1282, 9, 'UAM-I', ' Los Angeles', ' Iztapalapa', 9830, 19.4105528, -99.1496175, 'UAM-I, Los Angeles, Iztapalapa, 09830 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1283, 9, 'Plutarco Elías Calles', ' Chinampac de Juárez', ' Iztapalapa', 9208, 19.4326657, -99.0590581, 'Plutarco Elías Calles, Chinampac de Juárez, Iztapalapa, 09208 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1284, 9, '1 Sur 12-B 18', ' Agrícola Oriental', ' Iztacalco', 8500, 19.4326657, -99.0590581, '1 Sur 12-B 18, Agrícola Oriental, Iztacalco, 08500 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1285, 9, 'Oriente 255 465', ' Agrícola Oriental', ' Iztacalco', 8500, 19.4326657, -99.0590581, 'Oriente 255 465, Agrícola Oriental, Iztacalco, 08500 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1286, 9, 'Bosque de Alisos 45', ' Palo Alto(Granjas)', ' Cuajimalpa', 5210, 19.4326657, -99.0590581, 'Bosque de Alisos 45, Palo Alto(Granjas), Cuajimalpa, 05210 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1287, 9, 'Lucero', ' Doce de Diciembre', ' Iztapalapa', 9870, 19.3243552, -99.1830696, 'Lucero, Doce de Diciembre, Iztapalapa, 09870 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1288, 9, 'Napoleón', ' Moderna', ' Benito Juarez', 3510, 19.3243552, -99.1830696, 'Napoleón, Moderna, Benito Juarez, 03510 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1289, 9, 'Avenida Oceanía', ' Pensador Mexicano', ' Venustiano Carranza', 15510, 19.3243552, -99.1830696, 'Avenida Oceanía, Pensador Mexicano, Venustiano Carranza, 15510 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1290, 9, 'Cañada 281', ' Jardines del Pedregal', ' Álvaro Obregón', 1900, 19.3288431, -99.2322072, 'Cañada 281, Jardines del Pedregal, Álvaro Obregón, 01900 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1291, 9, 'Liga de Carreteras', ' 7 de Julio', ' Venustiano Carranza', 15390, 19.3288431, -99.2322072, 'Liga de Carreteras, 7 de Julio, Venustiano Carranza, 15390 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1292, 9, '5 de Febrero 14', ' Centro', ' Cuauhtémoc', 6000, 19.4182433, -99.1367916, '5 de Febrero 14, Centro, Cuauhtémoc, 06000 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1293, 9, 'Avenida 585 45', ' San Juan de Aragón 3a Sección', ' Gustavo A. Madero', 7970, 19.358106, -99.1436952, 'Avenida 585 45, San Juan de Aragón 3a Sección, Gustavo A. Madero, 07970 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1294, 9, 'Río Soto La Marina SN S ESC CARLOS SANDOVAL', ' Real del Moral', ' Iztapalapa', 9010, 19.358106, -99.1436952, 'Río Soto La Marina SN S ESC CARLOS SANDOVAL, Real del Moral, Iztapalapa, 09010 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1295, 9, 'Aguayo 58', ' Del Carmen', ' Coyoacán', 4100, 19.358106, -99.1436952, 'Aguayo 58, Del Carmen, Coyoacán, 04100 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1296, 9, 'Sur 159 1684', ' Ampliación Gabriel Ramos Millán', ' Iztacalco', 8020, 19.3717022, -99.2717677, 'Sur 159 1684, Ampliación Gabriel Ramos Millán, Iztacalco, 08020 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1297, 9, 'Oriente 65 a 2924', ' Ampliación Asturias', ' Cuauhtémoc', 6890, 19.3717022, -99.2717677, 'Oriente 65 a 2924, Ampliación Asturias, Cuauhtémoc, 06890 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1298, 9, 'Manuel Bonilla', ' Zona Urbana Ejidal Santa Martha Acatitla Sur', ' Iztapalapa', 9530, 19.3717022, -99.2717677, 'Manuel Bonilla, Zona Urbana Ejidal Santa Martha Acatitla Sur, Iztapalapa, 09530 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1299, 9, 'Privada Mercurio 8', ' Cuchilla Pantitlan', ' Venustiano Carranza', 15610, 19.408829, -99.1238135, 'Privada Mercurio 8, Cuchilla Pantitlan, Venustiano Carranza, 15610 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1300, 9, '5 de Mayo Manuel Gonzalez 286', ' Tlatelolco', ' Cuauhtémoc', 6900, 19.408829, -99.1238135, '5 de Mayo Manuel Gonzalez 286, Tlatelolco, Cuauhtémoc, 06900 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1301, 9, 'Tamagno 102 B', ' Peralvillo', ' Cuauhtémoc', 6220, 19.4021074, -99.2512091, 'Tamagno 102 B, Peralvillo, Cuauhtémoc, 06220 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1302, 9, 'San Diego', ' San Bartolo Ameyalco', ' Álvaro Obregón', 1800, 19.4021074, -99.2512091, 'San Diego, San Bartolo Ameyalco, Álvaro Obregón, 01800 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1303, 9, '3', ' Río Pánuco 76', ' Cuauhtémoc', 6500, 19.4021074, -99.2512091, '3, Río Pánuco 76, Cuauhtémoc, 06500 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1304, 9, 'Calle 11 de Abril', ' Escandón', ' Miguel Hidalgo', 11800, 19.4059425, -99.1823082, 'Calle 11 de Abril, Escandón, Miguel Hidalgo, 11800 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1305, 9, 'Avenida Central', ' Colonia Buenavista', ' Cuauhtémoc', 6350, 19.4059425, -99.1823082, 'Avenida Central, Colonia Buenavista, Cuauhtémoc, 06350 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1306, 9, 'Herminio Chavarría', ' Zona Urbana Ejidal Santa María Aztahuacan', ' Iztapalapa', 9570, 19.4059425, -99.1823082, 'Herminio Chavarría, Zona Urbana Ejidal Santa María Aztahuacan, Iztapalapa, 09570 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1307, 9, 'Pedro Moreno 10', ' Guerrero', ' Cuauhtémoc', 6300, 19.4059425, -99.1823082, 'Pedro Moreno 10, Guerrero, Cuauhtémoc, 06300 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1308, 9, 'Paseo de Los Tamarindos 109', ' Bosques de Las Lomas', ' Cuajimalpa', 5120, 19.3900769, -99.150675, 'Paseo de Los Tamarindos 109, Bosques de Las Lomas, Cuajimalpa, 05120 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1309, 9, 'Huitzitzilin 31', ' Santo Domingo (Pgal de Sto Domingo)', ' Coyoacán', 4369, 19.3900769, -99.150675, 'Huitzitzilin 31, Santo Domingo (Pgal de Sto Domingo), Coyoacán, 04369 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1310, 9, 'Desierto de Los Leones 5916', ' Cedros', ' Álvaro Obregón', 1870, 19.3900769, -99.150675, 'Desierto de Los Leones 5916, Cedros, Álvaro Obregón, 01870 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1311, 9, 'Ahuizotl 78', ' La Preciosa', ' Azcapotzalco', 2460, 19.426806, -99.0607417, 'Ahuizotl 78, La Preciosa, Azcapotzalco, 02460 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1312, 9, 'Oriente 184', ' Moctezuma 2a Sección', ' Venustiano Carranza', 15530, 19.426806, -99.0607417, 'Oriente 184, Moctezuma 2a Sección, Venustiano Carranza, 15530 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1313, 9, 'Avenida 602 118', ' San Juan de Aragón 3a Sección', ' Gustavo A. Madero', 7970, 19.4525092, -99.0649381, 'Avenida 602 118, San Juan de Aragón 3a Sección, Gustavo A. Madero, 07970 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1314, 9, 'Minas', ' Lomas de La Estancia', ' Iztapalapa', 9640, 19.4525092, -99.0649381, 'Minas, Lomas de La Estancia, Iztapalapa, 09640 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1315, 9, 'Zumarraga 101-127', ' Villa Gustavo a Madero', ' Gustavo A. Madero', 7050, 19.4525092, -99.0649381, 'Zumarraga 101-127, Villa Gustavo a Madero, Gustavo A. Madero, 07050 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1316, 9, 'Bahía de San Hipólito', ' Anáhuac', ' Miguel Hidalgo', 11320, 19.4366079, -99.230439, 'Bahía de San Hipólito, Anáhuac, Miguel Hidalgo, 11320 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1317, 9, '1er. Andador de Carlos Arruza', ' San Lorenzo Tlaltenango', ' Miguel Hidalgo', 11210, 19.4366079, -99.230439, '1er. Andador de Carlos Arruza, San Lorenzo Tlaltenango, Miguel Hidalgo, 11210 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1318, 9, 'Reforma Política', ' Los Reyes', ' Coyoacán', 4330, 19.4264082, -99.1187627, 'Reforma Política, Los Reyes, Coyoacán, 04330 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1319, 9, 'Eje 1 Oriente F.C. Hidalgo 2301', ' La Joyita', ' Gustavo A. Madero', 7850, 19.4473073, -99.0772901, 'Eje 1 Oriente F.C. Hidalgo 2301, La Joyita, Gustavo A. Madero, 07850 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1320, 9, 'Fortín Chimalistac 34', ' Oxtopulco Universidad', ' Coyoacán', 4360, 19.4473073, -99.0772901, 'Fortín Chimalistac 34, Oxtopulco Universidad, Coyoacán, 04360 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1321, 9, 'Crisantema', ' Tlatilco', ' Azcapotzalco', 2860, 19.4168715, -99.1876128, 'Crisantema, Tlatilco, Azcapotzalco, 02860 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1322, 9, 'Eugenio Sue 51', ' Polanco', ' Miguel Hidalgo', 11550, 19.4168715, -99.1876128, 'Eugenio Sue 51, Polanco, Miguel Hidalgo, 11550 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1323, 9, 'Havre 43', ' Juárez', ' Cuauhtémoc', 6600, 19.4168715, -99.1876128, 'Havre 43, Juárez, Cuauhtémoc, 06600 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1324, 9, 'Playa Pichilingue 156', ' Reforma Iztaccihuatl Sur', ' Iztacalco', 8840, 19.412557, -99.0918588, 'Playa Pichilingue 156, Reforma Iztaccihuatl Sur, Iztacalco, 08840 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1325, 9, 'Avenida Vasco de Quiroga', ' Zedec Santa Fe', ' Álvaro Obregón', 1219, 19.412557, -99.0918588, 'Avenida Vasco de Quiroga, Zedec Santa Fe, Álvaro Obregón, 01219 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1326, 9, 'Clavel 70-S', ' Ampliación Candelaria', ' Coyoacán', 4389, 19.412557, -99.0918588, 'Clavel 70-S, Ampliación Candelaria, Coyoacán, 04389 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1327, 9, 'Eje 4 Oriente (Avenida Río Churubusco)', ' Cuchilla Agrícola Oriental', ' Iztacalco', 8420, 19.4193296, -99.2769031, 'Eje 4 Oriente (Avenida Río Churubusco), Cuchilla Agrícola Oriental, Iztacalco, 08420 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1328, 9, 'Jose Antonio Torres Xocongo 647', ' Ampliación Asturias', ' Cuauhtémoc', 6860, 19.4193296, -99.2769031, 'Jose Antonio Torres Xocongo 647, Ampliación Asturias, Cuauhtémoc, 06860 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1329, 9, 'Prolongación Lerdo B', ' San Simon Tolnahuac', ' Cuauhtémoc', 6920, 19.385232, -99.1322823, 'Prolongación Lerdo B, San Simon Tolnahuac, Cuauhtémoc, 06920 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1330, 9, 'Maíz 169', ' Granjas Esmeralda', ' Iztapalapa', 9810, 19.385232, -99.1322823, 'Maíz 169, Granjas Esmeralda, Iztapalapa, 09810 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1331, 9, 'Eje 1 Oriente Av. Andrés Molina Enríquez 4349', ' Viaducto Piedad', ' Iztacalco', 8200, 19.361324, -99.0368498, 'Eje 1 Oriente Av. Andrés Molina Enríquez 4349, Viaducto Piedad, Iztacalco, 08200 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1332, 9, 'Plinio 108', ' Granada', ' Miguel Hidalgo', 11560, 19.3920964, -99.0480343, 'Plinio 108, Granada, Miguel Hidalgo, 11560 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1333, 9, 'Gorostiza 78', ' Morelos', ' Cuauhtémoc', 6200, 19.3920964, -99.0480343, 'Gorostiza 78, Morelos, Cuauhtémoc, 06200 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1334, 9, 'Eje Central Lázaro Cárdenas 13-A', ' Centro', ' Cuauhtémoc', 6000, 19.4785082, -99.2179177, 'Eje Central Lázaro Cárdenas 13-A, Centro, Cuauhtémoc, 06000 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1335, 9, 'San Bartolo-Naucalpan 182 a', ' Nueva Argentina (Argentina Poniente)', ' Argentina Poniente', 11230, 19.4785082, -99.2179177, 'San Bartolo-Naucalpan 182 a, Nueva Argentina (Argentina Poniente), Argentina Poniente, 11230 Miguel Hidalgo, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1336, 9, '1a. Cerrada Hidalgo', ' San Bartolo Ameyalco', ' Álvaro Obregón', 1800, 19.4785082, -99.2179177, '1a. Cerrada Hidalgo, San Bartolo Ameyalco, Álvaro Obregón, 01800 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1337, 9, 'Avenida Estrella', ' Estrella del Sur', ' Iztapalapa', 9820, 19.4074776, -99.0223826, 'Avenida Estrella, Estrella del Sur, Iztapalapa, 09820 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1338, 9, 'Rosario Aldama', ' Hank González', ' Iztapalapa', 9700, 19.3561119, -99.2639419, 'Rosario Aldama, Hank González, Iztapalapa, 09700 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1339, 9, 'Luis Buitimea MZ132 LT22', ' Zona Urbana Ejidal Santa Martha Acatitla Norte', ' Iztapalapa', 9140, 19.3561119, -99.2639419, 'Luis Buitimea MZ132 LT22, Zona Urbana Ejidal Santa Martha Acatitla Norte, Iztapalapa, 09140 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1340, 9, 'Navanco 5', ' Juventino Rosas', ' Iztacalco', 8700, 19.3561119, -99.2639419, 'Navanco 5, Juventino Rosas, Iztacalco, 08700 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1341, 9, 'Calle Alfredo Chavero 112', ' Obrera', ' Cuauhtémoc', 6800, 19.4236849, -99.068153, 'Calle Alfredo Chavero 112, Obrera, Cuauhtémoc, 06800 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1342, 9, 'Guty Cárdenas 8', ' Guadalupe Inn', ' Álvaro Obregón', 1020, 19.4236849, -99.068153, 'Guty Cárdenas 8, Guadalupe Inn, Álvaro Obregón, 01020 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1343, 9, 'Paseo Tetlalpa MZ5 LT5', ' 2da Ampliación Santiago Acahualtepec', ' Iztapalapa', 9609, 19.3227487, -99.1828073, 'Paseo Tetlalpa MZ5 LT5, 2da Ampliación Santiago Acahualtepec, Iztapalapa, 09609 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1344, 9, 'Francisco J. Clavijero 22', ' Esperanza', ' Cuauhtémoc', 6840, 19.3227487, -99.1828073, 'Francisco J. Clavijero 22, Esperanza, Cuauhtémoc, 06840 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1345, 9, 'Real del Monte 56', ' Ampliación El Triunfo', ' Iztapalapa', 9438, 19.4617195, -99.2142967, 'Real del Monte 56, Ampliación El Triunfo, Iztapalapa, 09438 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1346, 9, '1 Soledad', ' San Sebastián', ' Azcapotzalco', 2040, 19.4617195, -99.2142967, '1 Soledad, San Sebastián, Azcapotzalco, 02040 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1347, 9, '3a. Cerrada Boulevard Capri', ' Lomas Estrella 1RA. Sección', ' Iztapalapa', 9880, 19.4617195, -99.2142967, '3a. Cerrada Boulevard Capri, Lomas Estrella 1RA. Sección, Iztapalapa, 09880 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1348, 9, 'Cerro Capilla de San Miguel 85', ' Campestre Churubusco', ' Coyoacán', 4200, 19.3771029, -99.2304051, 'Cerro Capilla de San Miguel 85, Campestre Churubusco, Coyoacán, 04200 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1349, 9, 'Eje 3 Norte (Av. Cuitláhuac) 17', ' Guadalupe Victoria', ' Gustavo A. Madero', 7790, 19.3771029, -99.2304051, 'Eje 3 Norte (Av. Cuitláhuac) 17, Guadalupe Victoria, Gustavo A. Madero, 07790 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1350, 9, 'Avenida Sur 4', ' Cuchilla Agrícola Oriental', ' Iztacalco', 8420, 19.3771029, -99.2304051, 'Avenida Sur 4, Cuchilla Agrícola Oriental, Iztacalco, 08420 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1351, 9, 'Villa Atuel SN', ' Desarrollo Urbano Quetzalcoatl', ' Desarrollo Urbano', 9700, 19.3949013, -99.0440918, 'Villa Atuel SN, Desarrollo Urbano Quetzalcoatl, Desarrollo Urbano, 09700 Iztapalapa, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1352, 9, 'Madrid 8', ' Del Carmen', ' Coyoacán', 4100, 19.3949013, -99.0440918, 'Madrid 8, Del Carmen, Coyoacán, 04100 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1353, 9, 'Netzahualcóyotl', ' Estrella del Sur', ' Iztapalapa', 9820, 19.4258268, -99.160912, 'Netzahualcóyotl, Estrella del Sur, Iztapalapa, 09820 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1354, 9, 'Poniente 2', ' Cuchilla del Tesoro', ' Gustavo A. Madero', 7900, 19.4258268, -99.160912, 'Poniente 2, Cuchilla del Tesoro, Gustavo A. Madero, 07900 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1355, 9, 'Eje 3 Oriente (Francisco del Paso y Troncoso)', ' Kennedy', ' Venustiano Carranza', 15950, 19.4258268, -99.160912, 'Eje 3 Oriente (Francisco del Paso y Troncoso), Kennedy, Venustiano Carranza, 15950 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1356, 9, 'Antonio Solis 102', ' Obrera', ' Cuauhtémoc', 6800, 19.3962171, -99.0654288, 'Antonio Solis 102, Obrera, Cuauhtémoc, 06800 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1357, 9, 'Itzuco MZ7 LT7', ' Carlos Zapata Vela', ' Iztacalco', 8040, 19.3962171, -99.0654288, 'Itzuco MZ7 LT7, Carlos Zapata Vela, Iztacalco, 08040 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1358, 9, 'Lago Atitlán 88', ' Deportiva Pensil', ' Miguel Hidalgo', 11470, 19.3962171, -99.0654288, 'Lago Atitlán 88, Deportiva Pensil, Miguel Hidalgo, 11470 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1359, 9, 'Fausto Vega', ' Sede Delegacional', ' Álvaro Obregón', 1150, 19.3494617, -99.2742973, 'Fausto Vega, Sede Delegacional, Álvaro Obregón, 01150 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1360, 9, '8 MZ10A LT3', ' Olivar del Conde 1a. Sección', ' Álvaro Obregón', 1400, 19.3494617, -99.2742973, '8 MZ10A LT3, Olivar del Conde 1a. Sección, Álvaro Obregón, 01400 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1361, 9, 'Cda.de F.c. 96B', ' Ampliación Granada', ' Miguel Hidalgo', 11529, 19.4872085, -99.0151575, 'Cda.de F.c. 96B, Ampliación Granada, Miguel Hidalgo, 11529 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1362, 9, 'Calzada Legaria 608', ' Lomas de Sotelo', ' Miguel Hidalgo', 11200, 19.4872085, -99.0151575, 'Calzada Legaria 608, Lomas de Sotelo, Miguel Hidalgo, 11200 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1363, 9, 'Calle del Fresno', ' Santa María La Ribera', ' Cuauhtémoc', 6400, 19.4872085, -99.0151575, 'Calle del Fresno, Santa María La Ribera, Cuauhtémoc, 06400 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1364, 9, '1er And Benito Juárez (1ra Cda Benito Juárez)', ' Norte', ' Álvaro Obregón', 1410, 19.4872085, -99.0151575, '1er And Benito Juárez (1ra Cda Benito Juárez), Norte, Álvaro Obregón, 01410 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1365, 9, 'Avenida Rio San Joaquin 5805', ' Popo', ' Miguel Hidalgo', 11480, 19.378439, -99.09949, 'Avenida Rio San Joaquin 5805, Popo, Miguel Hidalgo, 11480 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1366, 9, 'Calle Prolongacion Calle 10 8', ' San Pedro de Los Pinos', ' Benito Juarez', 3800, 19.378439, -99.09949, 'Calle Prolongacion Calle 10 8, San Pedro de Los Pinos, Benito Juarez, 03800 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1367, 9, '4a. Cerrada 16', ' El Retoño', ' Iztapalapa', 9440, 19.4126386, -99.0373066, '4a. Cerrada 16, El Retoño, Iztapalapa, 09440 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1368, 9, 'Calle Cuauhtémoc', ' Los Reyes Culhuacan', ' Iztapalapa', 9840, 19.4126386, -99.0373066, 'Calle Cuauhtémoc, Los Reyes Culhuacan, Iztapalapa, 09840 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1369, 9, 'Circuito Interior Avenida Río Churubusco 1908', ' Gabriel Ramos Millán', ' Iztacalco', 8730, 19.4664114, -99.1270538, 'Circuito Interior Avenida Río Churubusco 1908, Gabriel Ramos Millán, Iztacalco, 08730 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1370, 9, 'Eje 4 Sur (Av. Plutarco Elías Calles) 765', ' Nueva Sta Anita', ' Iztacalco', 8210, 19.4664114, -99.1270538, 'Eje 4 Sur (Av. Plutarco Elías Calles) 765, Nueva Sta Anita, Iztacalco, 08210 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1371, 9, 'Gaviota 18', ' Tacubaya', ' Miguel Hidalgo', 11870, 19.4312836, -99.0473913, 'Gaviota 18, Tacubaya, Miguel Hidalgo, 11870 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1372, 9, 'Providencia 1522', ' Tlacoquemecatl del Valle', ' Benito Juarez', 3200, 19.4312836, -99.0473913, 'Providencia 1522, Tlacoquemecatl del Valle, Benito Juarez, 03200 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1373, 9, 'Prolongación Río Churubusco', ' Aeropuerto Int de La Ciudad de México', ' Venustiano Carranza', 15620, 19.355913, -99.0157243, 'Prolongación Río Churubusco, Aeropuerto Int de La Ciudad de México, Venustiano Carranza, 15620 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1374, 9, 'Víctor Hugo 151', ' Portales', ' Benito Juarez', 3300, 19.355913, -99.0157243, 'Víctor Hugo 151, Portales, Benito Juarez, 03300 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1375, 9, 'Oriente 184', ' Moctezuma 2a Sección', ' Venustiano Carranza', 15530, 19.355913, -99.0157243, 'Oriente 184, Moctezuma 2a Sección, Venustiano Carranza, 15530 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1376, 9, 'Sur 107 1314-1318', ' Aeronáutica Militar', ' Venustiano Carranza', 15970, 19.355913, -99.0157243, 'Sur 107 1314-1318, Aeronáutica Militar, Venustiano Carranza, 15970 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1377, 9, 'Doctor José María Vertiz 669', ' Narvarte', ' Benito Juarez', 3020, 19.355913, -99.0157243, 'Doctor José María Vertiz 669, Narvarte, Benito Juarez, 03020 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1378, 9, 'Pesado', ' Colonia Buenavista', ' Cuauhtémoc', 6350, 19.4369904, -99.2173001, 'Pesado, Colonia Buenavista, Cuauhtémoc, 06350 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1379, 9, 'Oriente 5', ' Cuchilla del Tesoro', ' Gustavo A. Madero', 7900, 19.4369904, -99.2173001, 'Oriente 5, Cuchilla del Tesoro, Gustavo A. Madero, 07900 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1380, 9, 'Joaquín A. Pérez 16', ' San Miguel Chapultepec', ' Miguel Hidalgo', 11850, 19.4369904, -99.2173001, 'Joaquín A. Pérez 16, San Miguel Chapultepec, Miguel Hidalgo, 11850 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1381, 9, 'Eje 4 Norte (Pte. 128) 67', ' Nueva Vallejo', ' Gustavo A. Madero', 7750, 19.4799922, -99.0227803, 'Eje 4 Norte (Pte. 128) 67, Nueva Vallejo, Gustavo A. Madero, 07750 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1382, 9, 'Puente Nacional 100', ' Lomas de Las Águilas', ' Álvaro Obregón', 1730, 19.4799922, -99.0227803, 'Puente Nacional 100, Lomas de Las Águilas, Álvaro Obregón, 01730 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1383, 9, 'Oriente 172', ' Justo Sierra', ' Iztapalapa', 9460, 19.4799922, -99.0227803, 'Oriente 172, Justo Sierra, Iztapalapa, 09460 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1384, 9, 'Papalotl 80', ' Santo Domingo (Pgal de Sto Domingo)', ' Coyoacán', 4369, 19.3377372, -99.1078065, 'Papalotl 80, Santo Domingo (Pgal de Sto Domingo), Coyoacán, 04369 Pedregal de Santo Domingo, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1385, 9, 'Sur 109 2428', ' Tlazintla', ' Iztacalco', 8720, 19.3377372, -99.1078065, 'Sur 109 2428, Tlazintla, Iztacalco, 08720 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1386, 9, 'Salvador Díaz Mirón 374', ' Santo Tomas', ' Miguel Hidalgo', 11340, 19.3377372, -99.1078065, 'Salvador Díaz Mirón 374, Santo Tomas, Miguel Hidalgo, 11340 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1387, 9, 'Río Churubusco 2359', ' Puebla', ' Venustiano Carranza', 15020, 19.363114, -99.0529836, 'Río Churubusco 2359, Puebla, Venustiano Carranza, 15020 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1388, 9, '5a. Cerrada Morelos', ' San Antonio Culhuacan', ' Iztapalapa', 9800, 19.363114, -99.0529836, '5a. Cerrada Morelos, San Antonio Culhuacan, Iztapalapa, 09800 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1389, 9, 'Adolfo Prieto 1644', ' Del Valle', ' Benito Juarez', 3100, 19.363114, -99.0529836, 'Adolfo Prieto 1644, Del Valle, Benito Juarez, 03100 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1390, 9, 'Sur 16 509', ' Agrícola Oriental', ' Iztacalco', 8500, 19.363114, -99.0529836, 'Sur 16 509, Agrícola Oriental, Iztacalco, 08500 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1391, 9, 'Monrovia 1210A', ' Portales', ' Benito Juarez', 3300, 19.4394587, -99.0918504, 'Monrovia 1210A, Portales, Benito Juarez, 03300 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1392, 9, 'De Los Montes 16', ' Portales Oriente', ' Benito Juarez', 3570, 19.4394587, -99.0918504, 'De Los Montes 16, Portales Oriente, Benito Juarez, 03570 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1393, 9, 'Nardo 10', ' Los Angeles Apanoaya', ' Iztapalapa', 9710, 19.4394587, -99.0918504, 'Nardo 10, Los Angeles Apanoaya, Iztapalapa, 09710 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1394, 9, 'Calzada Ings. Militares', ' San Lorenzo Tlaltenango', ' Miguel Hidalgo', 11219, 19.4002103, -99.2720215, 'Calzada Ings. Militares, San Lorenzo Tlaltenango, Miguel Hidalgo, 11219 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1395, 9, 'Aerolito 6228', ' Tres Estrellas', ' Gustavo A. Madero', 7820, 19.4002103, -99.2720215, 'Aerolito 6228, Tres Estrellas, Gustavo A. Madero, 07820 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1396, 9, 'Defensa Nacional', ' Xalpa', ' Iztapalapa', 9640, 19.4002103, -99.2720215, 'Defensa Nacional, Xalpa, Iztapalapa, 09640 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1397, 9, 'Bosque de Encinos 286', ' Bosques de Las Lomas', ' Cuajimalpa', 11700, 19.4216398, -99.1531877, 'Bosque de Encinos 286, Bosques de Las Lomas, Cuajimalpa, 11700 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1398, 9, 'Altavista 192', ' San Angel Inn', ' Álvaro Obregón', 1060, 19.4216398, -99.1531877, 'Altavista 192, San Angel Inn, Álvaro Obregón, 01060 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1399, 9, 'Avenida del Bosque', ' Parque Tarango', ' Álvaro Obregón', 1580, 19.4796557, -99.178501, 'Avenida del Bosque, Parque Tarango, Álvaro Obregón, 01580 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1400, 9, 'Iztacalco', ' Pantitlan', ' Iztacalco', 8100, 19.4796557, -99.178501, 'Iztacalco, Pantitlan, Iztacalco, 08100 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1401, 9, 'Eucalipto', ' San Juan Cerro', ' Iztapalapa', 9858, 19.3345447, -99.232258, 'Eucalipto, San Juan Cerro, Iztapalapa, 09858 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1402, 9, 'SIN NOMBRE No. 314 12', ' Santo Domingo (Pgal de Sto Domingo)', ' Coyoacán', 4369, 19.3345447, -99.232258, 'SIN NOMBRE No. 314 12, Santo Domingo (Pgal de Sto Domingo), Coyoacán, 04369 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1403, 9, '27 123', ' Ignacio Zaragoza', ' Venustiano Carranza', 15000, 19.3345447, -99.232258, '27 123, Ignacio Zaragoza, Venustiano Carranza, 15000 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1404, 9, '2a. Privada Aztecas', ' La Asunción', ' Iztapalapa', 9000, 19.3592687, -99.0593965, '2a. Privada Aztecas, La Asunción, Iztapalapa, 09000 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1405, 9, '1a. Cerrada Camino Viejo a Mixcoac', ' San Bartolo Ameyalco', ' Álvaro Obregón', 1800, 19.3592687, -99.0593965, '1a. Cerrada Camino Viejo a Mixcoac, San Bartolo Ameyalco, Álvaro Obregón, 01800 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1406, 9, 'Jumil 153', ' Santo Domingo (Pgal de Sto Domingo)', ' Coyoacán', 4369, 19.3592687, -99.0593965, 'Jumil 153, Santo Domingo (Pgal de Sto Domingo), Coyoacán, 04369 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1407, 9, 'Avenida México 31', ' Hipódromo', ' Cuauhtémoc', 6100, 19.4738826, -99.0182624, 'Avenida México 31, Hipódromo, Cuauhtémoc, 06100 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1408, 9, 'Julio García 13', ' Zapotla', ' Iztacalco', 8610, 19.3765368, -99.2276725, 'Julio García 13, Zapotla, Iztacalco, 08610 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1409, 9, 'Jacobo Watt', ' Culhuacan', ' Iztapalapa', 9800, 19.3765368, -99.2276725, 'Jacobo Watt, Culhuacan, Iztapalapa, 09800 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1410, 9, 'Eje 2 Oriente Av. H. Congreso de la Unión 225-229', ' Merced Balbuena', ' Venustiano Carranza', 15810, 19.3765368, -99.2276725, 'Eje 2 Oriente Av. H. Congreso de la Unión 225-229, Merced Balbuena, Venustiano Carranza, 15810 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1411, 9, 'Grieg 40', ' Ex Hipódromo de Peralvillo', ' Cuauhtémoc', 6250, 19.3765368, -99.2276725, 'Grieg 40, Ex Hipódromo de Peralvillo, Cuauhtémoc, 06250 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1412, 9, 'Eje 1 Oriente (Av. Canal de Miramontes) 1630', ' Campestre Churubusco', ' Coyoacán', 4200, 19.378128, -99.2728168, 'Eje 1 Oriente (Av. Canal de Miramontes) 1630, Campestre Churubusco, Coyoacán, 04200 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1413, 9, 'Avenida Gran Canal', ' Gertrudis Sánchez 3a Sección', ' Gustavo A. Madero', 7839, 19.3921015, -99.2178923, 'Avenida Gran Canal, Gertrudis Sánchez 3a Sección, Gustavo A. Madero, 07839 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1414, 9, 'Ixtlahuaca', ' San Bartolo Ameyalco', ' Álvaro Obregón', 1800, 19.3921015, -99.2178923, 'Ixtlahuaca, San Bartolo Ameyalco, Álvaro Obregón, 01800 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1415, 9, 'Avenida Gran Canal 586A', ' 2do Tramo 20 de Noviembre', ' Venustiano Carranza', 15300, 19.3921015, -99.2178923, 'Avenida Gran Canal 586A, 2do Tramo 20 de Noviembre, Venustiano Carranza, 15300 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1416, 9, 'Circuito Interior Bicentenario (Avenida Instituto Técnico Industrial)', ' Agricultura', ' Miguel Hidalgo', 11360, 19.3599215, -99.177435, 'Circuito Interior Bicentenario (Avenida Instituto Técnico Industrial), Agricultura, Miguel Hidalgo, 11360 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1417, 9, 'Cerámica 266', ' 2do Tramo 20 de Noviembre', ' Venustiano Carranza', 15300, 19.3599215, -99.177435, 'Cerámica 266, 2do Tramo 20 de Noviembre, Venustiano Carranza, 15300 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1418, 9, 'Benito Juárez', ' El Tanque', ' Magdalena Contreras', 10320, 19.4629792, -99.0305638, 'Benito Juárez, El Tanque, Magdalena Contreras, 10320 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1419, 9, 'Avenida 601', ' San Juan de Aragón 3a Sección', ' Gustavo A. Madero', 7970, 19.4629792, -99.0305638, 'Avenida 601, San Juan de Aragón 3a Sección, Gustavo A. Madero, 07970 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1420, 9, 'Puerto Cozumel 174', ' Ampliación Casas Alemán', ' Gustavo A. Madero', 7580, 19.4629792, -99.0305638, 'Puerto Cozumel 174, Ampliación Casas Alemán, Gustavo A. Madero, 07580 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1421, 9, 'Eje 4 Sur (Av. Plutarco Elías Calles) 547-549', ' Santa Anita', ' Iztacalco', 8300, 19.4346342, -99.1984336, 'Eje 4 Sur (Av. Plutarco Elías Calles) 547-549, Santa Anita, Iztacalco, 08300 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1422, 9, 'Presidente Mazarik 321', ' Base 3', ' Polanco Chapultepec', 11560, 19.4346342, -99.1984336, 'Presidente Mazarik 321, Base 3, Polanco Chapultepec, 11560 Miguel Hidalgo, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1423, 9, 'Sastrería 32', ' Penitenciaria', ' Venustiano Carranza', 15350, 19.4573999, -99.2259127, 'Sastrería 32, Penitenciaria, Venustiano Carranza, 15350 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1424, 9, 'Prolongación Lerdo 340', ' Ex Hipódromo de Peralvillo', ' Cuauhtémoc', 6250, 19.4573999, -99.2259127, 'Prolongación Lerdo 340, Ex Hipódromo de Peralvillo, Cuauhtémoc, 06250 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1425, 9, 'Playa Miramar 389', ' Militar Marte', ' Iztacalco', 8830, 19.4779319, -99.152697, 'Playa Miramar 389, Militar Marte, Iztacalco, 08830 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1426, 9, 'Calle del Fresno', ' Santa María La Ribera', ' Cuauhtémoc', 6400, 19.4779319, -99.152697, 'Calle del Fresno, Santa María La Ribera, Cuauhtémoc, 06400 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1427, 9, 'Zapotecas 314', ' Ajusco', ' Coyoacán', 4300, 19.3734055, -99.1725957, 'Zapotecas 314, Ajusco, Coyoacán, 04300 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1428, 9, 'De Los Virreyes 1315', ' Lomas de Chapultepec', ' Miguel Hidalgo', 11000, 19.3734055, -99.1725957, 'De Los Virreyes 1315, Lomas de Chapultepec, Miguel Hidalgo, 11000 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1429, 9, 'Sur 6 6', ' Cuchilla Agrícola Oriental', ' Iztacalco', 8420, 19.440856, -99.0586351, 'Sur 6 6, Cuchilla Agrícola Oriental, Iztacalco, 08420 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1430, 9, 'Viaducto Río Piedad 279', ' La Cruz Coyuya', ' Iztacalco', 8320, 19.440856, -99.0586351, 'Viaducto Río Piedad 279, La Cruz Coyuya, Iztacalco, 08320 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1431, 9, 'México-contreras 579', ' San Jerónimo Lídice', ' Magdalena Contreras', 10200, 19.440856, -99.0586351, 'México-contreras 579, San Jerónimo Lídice, Magdalena Contreras, 10200 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1432, 9, 'Avenida Carlos Lazo', ' Parque Tarango', ' Álvaro Obregón', 1580, 19.440856, -99.0586351, 'Avenida Carlos Lazo, Parque Tarango, Álvaro Obregón, 01580 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1433, 9, 'Plan de Ayala', ' Zona Urbana Ejidal Santa María Aztahuacan', ' Iztapalapa', 9570, 19.370927, -99.2355575, 'Plan de Ayala, Zona Urbana Ejidal Santa María Aztahuacan, Iztapalapa, 09570 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1434, 9, 'SIN NOMBRE No. 570 LB', ' Las Águilas Ampliación 2o. Parque', ' Álvaro Obregón', 1750, 19.4781155, -99.1685686, 'SIN NOMBRE No. 570 LB, Las Águilas Ampliación 2o. Parque, Álvaro Obregón, 01750 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1435, 9, 'Villa San Pedro MZ16 LT2', ' Desarrollo Urbano Quetzalcoatl', ' Iztapalapa', 9700, 19.4781155, -99.1685686, 'Villa San Pedro MZ16 LT2, Desarrollo Urbano Quetzalcoatl, Iztapalapa, 09700 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1436, 9, 'Avenida Universidad 1788', ' Oxtopulco Universidad', ' Coyoacán', 4360, 19.4781155, -99.1685686, 'Avenida Universidad 1788, Oxtopulco Universidad, Coyoacán, 04360 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1437, 9, 'Avenida de Los Compositores', ' Bosque de Chapultepec II', ' Miguel Hidalgo', 11100, 19.4793395, -99.1819698, 'Avenida de Los Compositores, Bosque de Chapultepec II, Miguel Hidalgo, 11100 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1438, 9, 'Calle Fco Cesar M.', ' Fuentes de Zaragoza', ' Iztapalapa', 9160, 19.4793395, -99.1819698, 'Calle Fco Cesar M., Fuentes de Zaragoza, Iztapalapa, 09160 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1439, 9, 'Oriente 157 3736', ' Salvador Díaz Mirón', ' Gustavo A. Madero', 7400, 19.4885294, -99.2063524, 'Oriente 157 3736, Salvador Díaz Mirón, Gustavo A. Madero, 07400 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1440, 9, 'Centeno 579', ' Granjas México', ' Iztacalco', 8400, 19.4885294, -99.2063524, 'Centeno 579, Granjas México, Iztacalco, 08400 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1441, 9, 'Carretera Federal Mexico - Toluca 1725', ' Palo Alto(Granjas)', ' Cuajimalpa', 5110, 19.4885294, -99.2063524, 'Carretera Federal Mexico - Toluca 1725, Palo Alto(Granjas), Cuajimalpa, 05110 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1442, 9, 'San Miguel 49', ' San Lucas', ' Coyoacán', 4030, 19.4721283, -99.0822225, 'San Miguel 49, San Lucas, Coyoacán, 04030 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1443, 9, 'Avenida 517 213', ' San Juan de Aragón 1a Sección', ' Gustavo A. Madero', 7969, 19.4721283, -99.0822225, 'Avenida 517 213, San Juan de Aragón 1a Sección, Gustavo A. Madero, 07969 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1444, 9, 'Avenida 543 47', ' San Juan de Aragón 2a Sección', ' Gustavo A. Madero', 7969, 19.4442831, -99.2624952, 'Avenida 543 47, San Juan de Aragón 2a Sección, Gustavo A. Madero, 07969 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1445, 9, 'Miguel Alemán', ' Presidentes de México', ' Iztapalapa', 9740, 19.4442831, -99.2624952, 'Miguel Alemán, Presidentes de México, Iztapalapa, 09740 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1446, 9, 'Santa Fe 170', ' Lomas De santa Fe', ' Álvaro Obregón', 1210, 19.4442831, -99.2624952, 'Santa Fe 170, Lomas De santa Fe, Álvaro Obregón, 01210 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1447, 9, 'Magnolia', ' Tlacoyaque', ' Álvaro Obregón', 1859, 19.4442831, -99.2624952, 'Magnolia, Tlacoyaque, Álvaro Obregón, 01859 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1448, 9, 'Avenida San Jeronimo 630', ' Jardines del Pedregal', ' Álvaro Obregón', 1090, 19.3484571, -99.0796336, 'Avenida San Jeronimo 630, Jardines del Pedregal, Álvaro Obregón, 01090 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1449, 9, 'Aquiles', ' Lomas de Axomiatla', ' Álvaro Obregón', 1820, 19.3484571, -99.0796336, 'Aquiles, Lomas de Axomiatla, Álvaro Obregón, 01820 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1450, 9, '2da. Cerrada de La Era', ' San Bartolo Ameyalco', ' Álvaro Obregón', 1800, 19.3484571, -99.0796336, '2da. Cerrada de La Era, San Bartolo Ameyalco, Álvaro Obregón, 01800 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1451, 9, 'Cuauhtémoc 35', ' Del Carmen', ' Coyoacán', 4100, 19.3653477, -99.1536784, 'Cuauhtémoc 35, Del Carmen, Coyoacán, 04100 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1452, 9, 'Miguel Laurent 1164', ' Letrán Valle', ' Benito Juarez', 3650, 19.3653477, -99.1536784, 'Miguel Laurent 1164, Letrán Valle, Benito Juarez, 03650 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1453, 9, 'Francisco Flores', ' Ejército de Agua Prieta', ' Iztapalapa', 9530, 19.3543015, -99.1228321, 'Francisco Flores, Ejército de Agua Prieta, Iztapalapa, 09530 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1454, 9, 'Cráter 161', ' Jardines del Pedregal', ' Álvaro Obregón', 1900, 19.3543015, -99.1228321, 'Cráter 161, Jardines del Pedregal, Álvaro Obregón, 01900 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1455, 9, 'Avenida Acuario', ' Bosque de Chapultepec I', ' Miguel Hidalgo', 11100, 19.395345, -99.1286528, 'Avenida Acuario, Bosque de Chapultepec I, Miguel Hidalgo, 11100 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1456, 9, 'Avenida 521 131', ' San Juan de Aragón 1a Sección', ' Gustavo A. Madero', 7969, 19.395345, -99.1286528, 'Avenida 521 131, San Juan de Aragón 1a Sección, Gustavo A. Madero, 07969 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1457, 9, 'Calle 1', ' Pantitlan', ' Iztacalco', 8100, 19.395345, -99.1286528, 'Calle 1, Pantitlan, Iztacalco, 08100 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1458, 9, 'San Francisco 429', ' Granjas Estrella', ' Iztapalapa', 9880, 19.395345, -99.1286528, 'San Francisco 429, Granjas Estrella, Iztapalapa, 09880 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1459, 9, 'Omega 219', ' Romero de Terreros', ' Coyoacán', 4310, 19.4514535, -99.1122905, 'Omega 219, Romero de Terreros, Coyoacán, 04310 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1460, 9, 'Eje 1 Oriente F.C. Hidalgo 2301', ' La Joyita', ' Gustavo A. Madero', 7850, 19.4696498, -99.1451843, 'Eje 1 Oriente F.C. Hidalgo 2301, La Joyita, Gustavo A. Madero, 07850 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1461, 9, 'Higura 35', ' La Concepción', ' Coyoacán', 4000, 19.4696498, -99.1451843, 'Higura 35, La Concepción, Coyoacán, 04000 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1462, 9, '1a. Privada José Loreto Fabela 35', ' San Juan de Aragón', ' Gustavo A. Madero', 7950, 19.4696498, -99.1451843, '1a. Privada José Loreto Fabela 35, San Juan de Aragón, Gustavo A. Madero, 07950 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1463, 9, 'México - Toluca 2990', ' Lomas de Bezares', ' Miguel Hidalgo', 11910, 19.4696498, -99.1451843, 'México - Toluca 2990, Lomas de Bezares, Miguel Hidalgo, 11910 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1464, 9, 'Américo Vespucio', ' Lomas de Capula', ' Álvaro Obregón', 1270, 19.3611761, -99.1010721, 'Américo Vespucio, Lomas de Capula, Álvaro Obregón, 01270 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1465, 9, 'Sierra Amatepec 251', ' Lomas de Chapultepec', ' Miguel Hidalgo', 11000, 19.3611761, -99.1010721, 'Sierra Amatepec 251, Lomas de Chapultepec, Miguel Hidalgo, 11000 Mexico City, State of Mexico, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1466, 9, 'Avenida del Panteón 96', ' Los Reyes', ' Coyoacán', 4330, 19.3513028, -99.048415, 'Avenida del Panteón 96, Los Reyes, Coyoacán, 04330 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1467, 9, 'Avenida Centenario', ' Lomas de Tarango', ' Álvaro Obregón', 1620, 19.3426228, -99.0989232, 'Avenida Centenario, Lomas de Tarango, Álvaro Obregón, 01620 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1468, 9, 'Bosque de Zapotes 117', ' Bosques de Las Lomas', ' Miguel Hidalgo', 11700, 19.3426228, -99.0989232, 'Bosque de Zapotes 117, Bosques de Las Lomas, Miguel Hidalgo, 11700 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1469, 9, 'Refinería Azcapotzalco 3', ' Petrolera Taxqueña', ' Coyoacán', 4410, 19.3426228, -99.0989232, 'Refinería Azcapotzalco 3, Petrolera Taxqueña, Coyoacán, 04410 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1470, 9, 'Huecampool', ' Xalpa', ' Iztapalapa', 9640, 19.3412357, -99.1946264, 'Huecampool, Xalpa, Iztapalapa, 09640 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1471, 9, 'Poniente 116 571', ' Industrial Vallejo', ' Azcapotzalco', 2300, 19.3990577, -99.1415802, 'Poniente 116 571, Industrial Vallejo, Azcapotzalco, 02300 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1472, 9, 'Salvador Díaz Mirón 55', ' Santa María La Ribera', ' Cuauhtémoc', 6400, 19.3990577, -99.1415802, 'Salvador Díaz Mirón 55, Santa María La Ribera, Cuauhtémoc, 06400 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1473, 9, 'Guillermo Prieto 147', ' Magdalena Mixiuhca', ' Venustiano Carranza', 15860, 19.3990577, -99.1415802, 'Guillermo Prieto 147, Magdalena Mixiuhca, Venustiano Carranza, 15860 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1474, 9, 'Rosales', ' Zedec Santa Fe', ' Álvaro Obregón', 1219, 19.4844903, -99.1344058, 'Rosales, Zedec Santa Fe, Álvaro Obregón, 01219 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1475, 9, 'Gavilán 185', ' Gavilán', ' Iztapalapa', 9369, 19.4844903, -99.1344058, 'Gavilán 185, Gavilán, Iztapalapa, 09369 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1476, 9, 'Oriente 170 88', ' Moctezuma 2a Sección', ' Venustiano Carranza', 15530, 19.368581, -99.0019509, 'Oriente 170 88, Moctezuma 2a Sección, Venustiano Carranza, 15530 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1477, 9, '2a. Cda. Av. 679', ' C. T. M. Aragón', ' Gustavo A. Madero', 7990, 19.3969107, -99.1561911, '2a. Cda. Av. 679, C. T. M. Aragón, Gustavo A. Madero, 07990 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1478, 9, 'San Esteban 85', ' Santo Tomas', ' Azcapotzalco', 2020, 19.3969107, -99.1561911, 'San Esteban 85, Santo Tomas, Azcapotzalco, 02020 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1479, 9, 'Avenida 613 22', ' San Juan de Aragón 5a Sección', ' Gustavo A. Madero', 7970, 19.3969107, -99.1561911, 'Avenida 613 22, San Juan de Aragón 5a Sección, Gustavo A. Madero, 07970 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1480, 9, '205 de Av. Río Churubusco', ' Modelo', ' Iztapalapa', 9089, 19.3969107, -99.1561911, '205 de Av. Río Churubusco, Modelo, Iztapalapa, 09089 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1481, 9, 'Francisco Morazán 842', ' Villa de Aragón', ' Gustavo A. Madero', 7570, 19.4409835, -99.1466648, 'Francisco Morazán 842, Villa de Aragón, Gustavo A. Madero, 07570 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1482, 9, 'Patabam 3904', ' Del Gas', ' Azcapotzalco', 2950, 19.4409835, -99.1466648, 'Patabam 3904, Del Gas, Azcapotzalco, 02950 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1483, 9, 'Puente Zacate', ' Ampliación Gabriel Ramos Millán', ' Iztacalco', 8020, 19.4444922, -99.0187447, 'Puente Zacate, Ampliación Gabriel Ramos Millán, Iztacalco, 08020 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1484, 9, 'Desierto de Los Leones 5096', ' Cedros', ' Álvaro Obregón', 1870, 19.4444922, -99.0187447, 'Desierto de Los Leones 5096, Cedros, Álvaro Obregón, 01870 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1485, 9, 'Camino a Santa Fe 17(MZ36 LT5(MZ36C LT5))', ' Lomas de Becerra', ' Álvaro Obregón', 1279, 19.3301843, -99.2711501, 'Camino a Santa Fe 17(MZ36 LT5(MZ36C LT5)), Lomas de Becerra, Álvaro Obregón, 01279 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1486, 9, 'Rif 920', ' Sta Cruz Atoyac', ' Benito Juarez', 3310, 19.3301843, -99.2711501, 'Rif 920, Sta Cruz Atoyac, Benito Juarez, 03310 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1487, 9, 'Alsacia 36', ' San Andrés Tetepilco', ' Iztapalapa', 9440, 19.3500125, -99.044684, 'Alsacia 36, San Andrés Tetepilco, Iztapalapa, 09440 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1488, 9, 'Sur 14-A 18', ' Agrícola Oriental', ' Iztacalco', 8500, 19.3500125, -99.044684, 'Sur 14-A 18, Agrícola Oriental, Iztacalco, 08500 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1489, 9, 'Ferrocarril de Cuernavaca 415', ' San Jerónimo Lídice', ' Magdalena Contreras', 10200, 19.3860888, -99.1139403, 'Ferrocarril de Cuernavaca 415, San Jerónimo Lídice, Magdalena Contreras, 10200 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1490, 9, 'Monte Blanco 745', ' Lomas de Chapultepec', ' Miguel Hidalgo', 11000, 19.3860888, -99.1139403, 'Monte Blanco 745, Lomas de Chapultepec, Miguel Hidalgo, 11000 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1491, 9, 'Eje 3 Norte Calzada San Isidro', ' Ampliación Petrolera', ' Azcapotzalco', 2470, 19.3860888, -99.1139403, 'Eje 3 Norte Calzada San Isidro, Ampliación Petrolera, Azcapotzalco, 02470 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1492, 9, 'Loma de la Palma 133', ' Lomas de Vista Hermosa', ' Cuajimalpa', 5100, 19.3543474, -99.265414, 'Loma de la Palma 133, Lomas de Vista Hermosa, Cuajimalpa, 05100 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1493, 9, 'Bosque de Olivos 291', ' Bosques de Las Lomas', ' Miguel Hidalgo', 11700, 19.3543474, -99.265414, 'Bosque de Olivos 291, Bosques de Las Lomas, Miguel Hidalgo, 11700 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1494, 9, 'Anillo Periférico 2141', ' Ejército Constitucionalista', ' Iztapalapa', 9220, 19.3543474, -99.265414, 'Anillo Periférico 2141, Ejército Constitucionalista, Iztapalapa, 09220 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1495, 9, 'Paseo de Los Ahuehuetes Norte 1139', ' Bosques de Las Lomas', ' Miguel Hidalgo', 5120, 19.4474603, -99.1829258, 'Paseo de Los Ahuehuetes Norte 1139, Bosques de Las Lomas, Miguel Hidalgo, 05120 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1496, 9, '6 de Marzo', ' Revolución', ' Venustiano Carranza', 15460, 19.4474603, -99.1829258, '6 de Marzo, Revolución, Venustiano Carranza, 15460 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1497, 9, 'Bondojito 25', ' Michoacana', ' Venustiano Carranza', 15250, 19.4474603, -99.1829258, 'Bondojito 25, Michoacana, Venustiano Carranza, 15250 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1498, 9, 'Privada Galio 11', ' Cuchilla Pantitlan', ' Venustiano Carranza', 15610, 19.3380381, -99.1492198, 'Privada Galio 11, Cuchilla Pantitlan, Venustiano Carranza, 15610 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1499, 9, 'Doctor J. Navarro 30', ' Doctores', ' Cuauhtémoc', 6720, 19.3380381, -99.1492198, 'Doctor J. Navarro 30, Doctores, Cuauhtémoc, 06720 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1500, 9, 'Eje 4 Oriente (Avenida Río Churubusco) 578', ' Cuchilla Pantitlan', ' Venustiano Carranza', 15610, 19.3687289, -99.2149566, 'Eje 4 Oriente (Avenida Río Churubusco) 578, Cuchilla Pantitlan, Venustiano Carranza, 15610 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1501, 9, '2a. Cerrada Calle 10 204', ' Granjas San Antonio', ' Iztapalapa', 9070, 19.3644043, -99.0567146, '2a. Cerrada Calle 10 204, Granjas San Antonio, Iztapalapa, 09070 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1502, 9, 'Youita', ' Santa Lucía', ' Álvaro Obregón', 1580, 19.3644043, -99.0567146, 'Youita, Santa Lucía, Álvaro Obregón, 01580 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1503, 9, 'Eje 5 Sur (Prol. Marcelino Buendía)', ' Cabeza de Juárez VI', ' Iztapalapa', 9225, 19.3959927, -99.0768333, 'Eje 5 Sur (Prol. Marcelino Buendía), Cabeza de Juárez VI, Iztapalapa, 09225 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1504, 9, 'Canal de Tezontle 916', ' Paseos de Churubusco', ' Iztapalapa', 9030, 19.3959927, -99.0768333, 'Canal de Tezontle 916, Paseos de Churubusco, Iztapalapa, 09030 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1505, 9, 'Reforma Religiosa MZ41 LTSN', ' Reforma Política', ' Iztapalapa', 9730, 19.3959927, -99.0768333, 'Reforma Religiosa MZ41 LTSN, Reforma Política, Iztapalapa, 09730 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1506, 9, 'Cerro Creston 139', ' Campestre Churubusco', ' Coyoacán', 4200, 19.3870986, -99.2012339, 'Cerro Creston 139, Campestre Churubusco, Coyoacán, 04200 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1507, 9, 'Avenida Tamaulipas 307', ' Lomas de Santa Fe', ' Cuajimalpa', 5600, 19.3870986, -99.2012339, 'Avenida Tamaulipas 307, Lomas de Santa Fe, Cuajimalpa, 05600 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1508, 9, 'Calle Marsella 19', ' Juárez', ' Cuauhtémoc', 6600, 19.3870986, -99.2012339, 'Calle Marsella 19, Juárez, Cuauhtémoc, 06600 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1509, 9, 'José María Mendivil 124', ' Daniel Garza', ' Miguel Hidalgo', 11830, 19.4041933, -99.1388982, 'José María Mendivil 124, Daniel Garza, Miguel Hidalgo, 11830 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1510, 9, 'José María Morelos 116', ' San Miguel Amantla', ' Azcapotzalco', 2700, 19.4041933, -99.1388982, 'José María Morelos 116, San Miguel Amantla, Azcapotzalco, 02700 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1511, 9, 'José Antonio Torres 842', ' Viaducto Piedad', ' Iztacalco', 8200, 19.3954062, -99.2263526, 'José Antonio Torres 842, Viaducto Piedad, Iztacalco, 08200 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1512, 9, 'Prolongación Canario', ' Tolteca', ' Álvaro Obregón', 1150, 19.3954062, -99.2263526, 'Prolongación Canario, Tolteca, Álvaro Obregón, 01150 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1513, 9, 'Atlixaco 126', ' Santa Apolonia', ' Azcapotzalco', 2780, 19.3954062, -99.2263526, 'Atlixaco 126, Santa Apolonia, Azcapotzalco, 02780 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1514, 9, 'Wagner 50', ' Ex Hipódromo de Peralvillo', ' Cuauhtémoc', 6250, 19.3954062, -99.2263526, 'Wagner 50, Ex Hipódromo de Peralvillo, Cuauhtémoc, 06250 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1515, 9, 'Eucalipto', ' Tenorios', ' Iztapalapa', 9680, 19.42165, -99.2156757, 'Eucalipto, Tenorios, Iztapalapa, 09680 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1516, 9, 'Comisión Nacional Agraria 40', ' Federal', ' Venustiano Carranza', 15700, 19.42165, -99.2156757, 'Comisión Nacional Agraria 40, Federal, Venustiano Carranza, 15700 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1517, 9, 'Lechuzas', ' Alcantarilla', ' Álvaro Obregón', 1729, 19.42165, -99.2156757, 'Lechuzas, Alcantarilla, Álvaro Obregón, 01729 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1518, 9, 'Calle 5', ' Porvenir', ' Azcapotzalco', 2940, 19.4855409, -99.1944234, 'Calle 5, Porvenir, Azcapotzalco, 02940 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1519, 9, 'Fresnos 101', ' Palo Alto(Granjas)', ' Cuajimalpa', 5110, 19.4855409, -99.1944234, 'Fresnos 101, Palo Alto(Granjas), Cuajimalpa, 05110 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1520, 9, 'Oriente 217-B 19', ' Cuchilla Agrícola Oriental', ' Iztacalco', 8420, 19.4855409, -99.1944234, 'Oriente 217-B 19, Cuchilla Agrícola Oriental, Iztacalco, 08420 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1521, 9, 'Beta 91', ' Romero de Terreros', ' Coyoacán', 4310, 19.476453, -99.2404645, 'Beta 91, Romero de Terreros, Coyoacán, 04310 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1522, 9, 'Oriente 259 28', ' Agrícola Oriental', ' Iztacalco', 8500, 19.476453, -99.2404645, 'Oriente 259 28, Agrícola Oriental, Iztacalco, 08500 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1523, 9, 'Rodríguez Saro 424', ' Del Valle', ' Benito Juarez', 3100, 19.476453, -99.2404645, 'Rodríguez Saro 424, Del Valle, Benito Juarez, 03100 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1524, 9, 'Belisario Domínguez 1', ' Zacatepec', ' Iztapalapa', 9560, 19.476453, -99.2404645, 'Belisario Domínguez 1, Zacatepec, Iztapalapa, 09560 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1525, 9, 'Francisco J. Clavijero', ' Esperanza', ' Cuauhtémoc', 6840, 19.355607, -99.081681, 'Francisco J. Clavijero, Esperanza, Cuauhtémoc, 06840 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1526, 9, 'Sur 8 139', ' Agrícola Oriental', ' Iztacalco', 8500, 19.355607, -99.081681, 'Sur 8 139, Agrícola Oriental, Iztacalco, 08500 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1527, 9, 'Creta', ' Lomas de Axomiatla', ' Álvaro Obregón', 1820, 19.355607, -99.081681, 'Creta, Lomas de Axomiatla, Álvaro Obregón, 01820 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1528, 9, 'Calzada Ignacio Zaragoza 790', ' Aviación Civil', ' Venustiano Carranza', 15740, 19.4188961, -99.2548301, 'Calzada Ignacio Zaragoza 790, Aviación Civil, Venustiano Carranza, 15740 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1529, 9, 'Siporex 3', ' Alce Blanco', ' Industrial Alce Blanco', 53370, 19.4005367, -99.0538127, 'Siporex 3, Alce Blanco, Industrial Alce Blanco, 53370 Naucalpan, State of Mexico, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1530, 9, 'Eje 4 Sur (Xola) 1806', ' Narvarte', ' Benito Juarez', 3020, 19.4005367, -99.0538127, 'Eje 4 Sur (Xola) 1806, Narvarte, Benito Juarez, 03020 Mexico City, MX, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1531, 9, 'Ruiz Cortines', ' Pensador Mexicano', ' Venustiano Carranza', 15510, 19.4005367, -99.0538127, 'Ruiz Cortines, Pensador Mexicano, Venustiano Carranza, 15510 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1532, 9, 'Tejocotes 164', ' Tlacoquemecatl del Valle', ' Benito Juarez', 3200, 19.4005367, -99.0538127, 'Tejocotes 164, Tlacoquemecatl del Valle, Benito Juarez, 03200 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1533, 9, '506 (Eje 3 Norte)', ' San Juan de Aragón 1a Sección', ' Gustavo A. Madero', 7969, 19.4297996, -99.2425288, '506 (Eje 3 Norte), San Juan de Aragón 1a Sección, Gustavo A. Madero, 07969 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1534, 9, 'Canal Nacional 110-210', ' La Magdalena Culhuacan', ' Coyoacán', 4260, 19.4297996, -99.2425288, 'Canal Nacional 110-210, La Magdalena Culhuacan, Coyoacán, 04260 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1535, 9, 'Luis de La Rosa', ' Jardín Balbuena', ' Venustiano Carranza', 15900, 19.4297996, -99.2425288, 'Luis de La Rosa, Jardín Balbuena, Venustiano Carranza, 15900 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1536, 9, 'Cayetano Andrade 6', ' Santa Martha Acatitla', ' Iztapalapa', 9510, 19.3415927, -99.1638816, 'Cayetano Andrade 6, Santa Martha Acatitla, Iztapalapa, 09510 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1537, 9, '1', ' Olivar de Los Padres', ' Álvaro Obregón', 1780, 19.3415927, -99.1638816, '1, Olivar de Los Padres, Álvaro Obregón, 01780 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1538, 9, 'Canadá Los Helechos 447', ' San Mateo Tlaltenango', ' Cuajimalpa', 5600, 19.3415927, -99.1638816, 'Canadá Los Helechos 447, San Mateo Tlaltenango, Cuajimalpa, 05600 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1539, 9, 'Calle Chinameca', ' Zenón Delgado', ' Álvaro Obregón', 1220, 19.3923157, -99.1439998, 'Calle Chinameca, Zenón Delgado, Álvaro Obregón, 01220 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1540, 9, 'Cordilleras 158', ' Águilas', ' Álvaro Obregón', 1710, 19.4350422, -99.2029006, 'Cordilleras 158, Águilas, Álvaro Obregón, 01710 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1541, 9, 'Pastores MZ8 LTSN', ' Ampliación Ricardo Flores Magón', ' Iztapalapa', 9828, 19.3585854, -99.0311221, 'Pastores MZ8 LTSN, Ampliación Ricardo Flores Magón, Iztapalapa, 09828 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1542, 9, 'Bernardo Quintana 400', ' La Loma', ' Loma Santa Fé', 1219, 19.3585854, -99.0311221, 'Bernardo Quintana 400, La Loma, Loma Santa Fé, 01219 Alvaro Obregón, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1543, 9, 'Moliere 328', ' Polanco', ' Miguel Hidalgo', 11520, 19.3585854, -99.0311221, 'Moliere 328, Polanco, Miguel Hidalgo, 11520 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1544, 9, 'Barreteros 13', ' Azteca', ' Venustiano Carranza', 15320, 19.370621, -99.0242862, 'Barreteros 13, Azteca, Venustiano Carranza, 15320 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1545, 9, 'Sierra Vertientes 1125', ' Lomas de Chapultepec', ' Miguel Hidalgo', 11000, 19.4648763, -99.0097513, 'Sierra Vertientes 1125, Lomas de Chapultepec, Miguel Hidalgo, 11000 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1546, 9, 'Tratados de Sabinas (And 3)', ' Zona Urbana Ejidal Santa María Aztahuacan', ' Iztapalapa', 9570, 19.4648763, -99.0097513, 'Tratados de Sabinas (And 3), Zona Urbana Ejidal Santa María Aztahuacan, Iztapalapa, 09570 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1547, 9, 'Cjon. Juárez', ' Sta Cruz Atoyac', ' Benito Juarez', 3310, 19.4648763, -99.0097513, 'Cjon. Juárez, Sta Cruz Atoyac, Benito Juarez, 03310 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1548, 9, 'José Santos Chocano', ' Balcones de Ceguayo', ' Álvaro Obregón', 1540, 19.3462845, -99.0766387, 'José Santos Chocano, Balcones de Ceguayo, Álvaro Obregón, 01540 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1549, 9, 'Loma Linda 130', ' Lomas de Vista Hermosa', ' Cuajimalpa', 5100, 19.3462845, -99.0766387, 'Loma Linda 130, Lomas de Vista Hermosa, Cuajimalpa, 05100 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1550, 9, 'Avenida de las Torres MZ22 LT218', ' Zona Urbana Ejidal Santa María Aztahuacan', ' Iztapalapa', 9570, 19.4486894, -99.0889569, 'Avenida de las Torres MZ22 LT218, Zona Urbana Ejidal Santa María Aztahuacan, Iztapalapa, 09570 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1551, 9, 'Tecoyotitla 97-147', ' Agrícola', ' Álvaro Obregón', 1050, 19.4486894, -99.0889569, 'Tecoyotitla 97-147, Agrícola, Álvaro Obregón, 01050 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1552, 9, 'Avenida Guelatao', ' Ejército de Agua Prieta', ' Iztapalapa', 9578, 19.4486894, -99.0889569, 'Avenida Guelatao, Ejército de Agua Prieta, Iztapalapa, 09578 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1553, 9, 'República de Perú 131', ' Centro', ' Cuauhtémoc', 6010, 19.4486894, -99.0889569, 'República de Perú 131, Centro, Cuauhtémoc, 06010 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1554, 9, 'Antonio Rodríguez', ' San Simon Ticumac', ' Benito Juarez', 3660, 19.3750578, -99.0382119, 'Antonio Rodríguez, San Simon Ticumac, Benito Juarez, 03660 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1555, 9, 'Mayas 59', ' Los Reyes', ' Coyoacán', 4330, 19.3750578, -99.0382119, 'Mayas 59, Los Reyes, Coyoacán, 04330 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1556, 9, 'Mimosas', ' Santa María Insurgentes', ' Cuauhtémoc', 6430, 19.3750578, -99.0382119, 'Mimosas, Santa María Insurgentes, Cuauhtémoc, 06430 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1557, 9, 'Norte 88 6215', ' Gertrudis Sánchez 2a Sección', ' Gustavo A. Madero', 7839, 19.3750578, -99.0382119, 'Norte 88 6215, Gertrudis Sánchez 2a Sección, Gustavo A. Madero, 07839 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1558, 9, 'Loma de Vista Hermosa 71', ' Lomas de Vista Hermosa', ' Cuajimalpa', 5100, 19.3397261, -99.0949299, 'Loma de Vista Hermosa 71, Lomas de Vista Hermosa, Cuajimalpa, 05100 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1559, 9, 'Tungsteno', ' San Juan Cerro', ' Iztapalapa', 9858, 19.3397261, -99.0949299, 'Tungsteno, San Juan Cerro, Iztapalapa, 09858 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1560, 9, 'Iztaccihuatl', ' Moctezuma 2a Sección', ' Venustiano Carranza', 15530, 19.4657637, -99.1788733, 'Iztaccihuatl, Moctezuma 2a Sección, Venustiano Carranza, 15530 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1561, 9, 'Cuahutémoc 1154', ' Letrán Valle', ' Benito Juarez', 3310, 19.4657637, -99.1788733, 'Cuahutémoc 1154, Letrán Valle, Benito Juarez, 03310 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1562, 9, 'Avenida Tlahuac', ' Culhuacan', ' Iztapalapa', 9800, 19.371029, -99.0287532, 'Avenida Tlahuac, Culhuacan, Iztapalapa, 09800 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1563, 9, 'Henry Ford 25', ' Guadalupe Tepeyac', ' Gustavo A. Madero', 7840, 19.428443, -99.2484679, 'Henry Ford 25, Guadalupe Tepeyac, Gustavo A. Madero, 07840 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1564, 9, 'Olivo 78', ' Florida', ' Álvaro Obregón', 1030, 19.3944169, -99.2640349, 'Olivo 78, Florida, Álvaro Obregón, 01030 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1565, 9, 'Playa Mocambo 469', ' Militar Marte', ' Iztacalco', 8830, 19.3944169, -99.2640349, 'Playa Mocambo 469, Militar Marte, Iztacalco, 08830 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1566, 9, 'Av. Cuauhtémoc 462', ' Del Valle', ' Benito Juarez', 3000, 19.402138, -99.161445, 'Av. Cuauhtémoc 462, Del Valle, Benito Juarez, 03000 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1567, 9, 'Secretaría del Trabajo', ' Cuatro Árboles', ' Venustiano Carranza', 15730, 19.402138, -99.161445, 'Secretaría del Trabajo, Cuatro Árboles, Venustiano Carranza, 15730 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1568, 9, 'EJE 3 Oriente (AV. Ingeniero EDUARDO MOLINA) 7224A', ' Constitución de La República', ' Gustavo A. Madero', 7469, 19.4235982, -99.2300752, 'EJE 3 Oriente (AV. Ingeniero EDUARDO MOLINA) 7224A, Constitución de La República, Gustavo A. Madero, 07469 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1569, 9, '3a. Cerrada Carril', ' 2da Ampliación Barrio San Miguel (San Felipe Terremotes)', ' Iztapalapa', 9360, 19.4235982, -99.2300752, '3a. Cerrada Carril, 2da Ampliación Barrio San Miguel (San Felipe Terremotes), Iztapalapa, 09360 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1570, 9, 'Sur 16-B 58', ' Agrícola Oriental', ' Iztacalco', 8500, 19.3953348, -99.0661648, 'Sur 16-B 58, Agrícola Oriental, Iztacalco, 08500 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1571, 9, 'Lago Alberto 319', ' Ampliación Granada', ' Miguel Hidalgo', 11520, 19.3417253, -99.1445413, 'Lago Alberto 319, Ampliación Granada, Miguel Hidalgo, 11520 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1572, 9, 'Avenida Ing. Eduardo Molina 421', ' 20 de Noviembre', ' Venustiano Carranza', 15300, 19.3417253, -99.1445413, 'Avenida Ing. Eduardo Molina 421, 20 de Noviembre, Venustiano Carranza, 15300 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1573, 9, 'Licenciado Luis Cabrera', ' Jacarandas', ' Iztapalapa', 9280, 19.3417253, -99.1445413, 'Licenciado Luis Cabrera, Jacarandas, Iztapalapa, 09280 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1574, 9, 'Neptuno 44', ' San Simon Tolnahuac', ' Cuauhtémoc', 6920, 19.4620459, -99.2733159, 'Neptuno 44, San Simon Tolnahuac, Cuauhtémoc, 06920 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1575, 9, '2a. 539 4', ' San Juan de Aragón 2a Sección', ' Gustavo A. Madero', 7969, 19.4620459, -99.2733159, '2a. 539 4, San Juan de Aragón 2a Sección, Gustavo A. Madero, 07969 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1576, 9, 'Naranjos 146', ' Petrolera', ' Azcapotzalco', 2480, 19.4620459, -99.2733159, 'Naranjos 146, Petrolera, Azcapotzalco, 02480 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1577, 9, 'Ribera de San Cosme 157', ' Santa María La Ribera', ' Cuauhtémoc', 6400, 19.4713582, -99.2158703, 'Ribera de San Cosme 157, Santa María La Ribera, Cuauhtémoc, 06400 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1578, 9, 'Bahía Santa Barbara 414', ' Anáhuac', ' Miguel Hidalgo', 11320, 19.4713582, -99.2158703, 'Bahía Santa Barbara 414, Anáhuac, Miguel Hidalgo, 11320 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1579, 9, 'Pto. Catania 35', ' Ejidos San Juan de Aragón 1a Sección', ' Gustavo A. Madero', 7940, 19.4239501, -99.0294724, 'Pto. Catania 35, Ejidos San Juan de Aragón 1a Sección, Gustavo A. Madero, 07940 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1580, 9, 'Primero de Mayo 5', ' Tacubaya', ' Miguel Hidalgo', 11870, 19.4239501, -99.0294724, 'Primero de Mayo 5, Tacubaya, Miguel Hidalgo, 11870 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1581, 9, 'Medina 20', ' Pantitlan', ' Iztacalco', 8100, 19.4239501, -99.0294724, 'Medina 20, Pantitlan, Iztacalco, 08100 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1582, 9, '1 MZ22LT25B', ' La Martinica', ' Álvaro Obregón', 1690, 19.4746323, -99.0368667, '1 MZ22LT25B, La Martinica, Álvaro Obregón, 01690 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1583, 9, 'Labradores 7', ' Morelos', ' Cuauhtémoc', 15270, 19.4748771, -99.1504381, 'Labradores 7, Morelos, Cuauhtémoc, 15270 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1584, 9, 'Tlaxcala 1', ' Progreso', ' Álvaro Obregón', 1090, 19.4748771, -99.1504381, 'Tlaxcala 1, Progreso, Álvaro Obregón, 01090 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1585, 9, 'Pedro Calderon de la Barca 305', ' Polanco', ' Miguel Hidalgo', 11550, 19.4748771, -99.1504381, 'Pedro Calderon de la Barca 305, Polanco, Miguel Hidalgo, 11550 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1586, 9, 'Leo', ' San José del Olivar', ' Álvaro Obregón', 1770, 19.4056926, -99.1761068, 'Leo, San José del Olivar, Álvaro Obregón, 01770 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1587, 9, 'Eje Central Lázaro Cárdenas 866', ' Niños Heroes de Chapultepec', ' Benito Juarez', 3440, 19.4056926, -99.1761068, 'Eje Central Lázaro Cárdenas 866, Niños Heroes de Chapultepec, Benito Juarez, 03440 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1588, 9, 'Estenógrafo 20', ' Magdalena Atlazolpa', ' Iztapalapa', 9410, 19.4692571, -99.0958352, 'Estenógrafo 20, Magdalena Atlazolpa, Iztapalapa, 09410 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1589, 9, 'Licenciado Ignacio Ramos 219', ' Constitución de 1917', ' Iztapalapa', 9260, 19.4692571, -99.0958352, 'Licenciado Ignacio Ramos 219, Constitución de 1917, Iztapalapa, 09260 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1590, 9, 'Carlos Fernández', ' Del Valle', ' Benito Juarez', 3100, 19.4688593, -99.1538561, 'Carlos Fernández, Del Valle, Benito Juarez, 03100 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1591, 9, '2 Sur 12-B 50', ' Agrícola Oriental', ' Iztacalco', 8500, 19.4688593, -99.1538561, '2 Sur 12-B 50, Agrícola Oriental, Iztacalco, 08500 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1592, 9, 'Norte 45 829', ' Industrial Vallejo', ' Azcapotzalco', 2330, 19.4860764, -99.0096921, 'Norte 45 829, Industrial Vallejo, Azcapotzalco, 02330 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1593, 9, 'Hortensias 78', ' Ciudad Jardín', ' Coyoacán', 4370, 19.4860764, -99.0096921, 'Hortensias 78, Ciudad Jardín, Coyoacán, 04370 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1594, 9, 'Cda. Doctor José Ignacio Bartolache', ' Del Valle', ' Benito Juarez', 3100, 19.4860764, -99.0096921, 'Cda. Doctor José Ignacio Bartolache, Del Valle, Benito Juarez, 03100 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1595, 9, 'Emilio Balli', ' Chinampac de Juárez', ' Iztapalapa', 9208, 19.46634, -99.2440939, 'Emilio Balli, Chinampac de Juárez, Iztapalapa, 09208 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1596, 9, 'Enrique Rébsamen 617', ' Narvarte', ' Benito Juarez', 3020, 19.46634, -99.2440939, 'Enrique Rébsamen 617, Narvarte, Benito Juarez, 03020 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1597, 9, 'Calle Diamante 7', ' La Estrella', ' Gustavo A. Madero', 7810, 19.46634, -99.2440939, 'Calle Diamante 7, La Estrella, Gustavo A. Madero, 07810 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1598, 9, 'De Fresno', ' Pueblo Santa Fe', ' Álvaro Obregón', 1210, 19.46634, -99.2440939, 'De Fresno, Pueblo Santa Fe, Álvaro Obregón, 01210 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1599, 9, 'Alpes 964', ' Lomas de Chapultepec', ' Miguel Hidalgo', 11000, 19.3693205, -99.2352952, 'Alpes 964, Lomas de Chapultepec, Miguel Hidalgo, 11000 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1600, 9, 'Balboa 802', ' Portales', ' Benito Juarez', 3300, 19.3693205, -99.2352952, 'Balboa 802, Portales, Benito Juarez, 03300 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1601, 9, 'Picos VI B And 4', ' Los Picos VI B', ' Iztapalapa', 9420, 19.3413428, -99.1576802, 'Picos VI B And 4, Los Picos VI B, Iztapalapa, 09420 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1602, 9, 'Jorge Enciso 1810', ' Mexicaltzingo', ' Iztapalapa', 9060, 19.3413428, -99.1576802, 'Jorge Enciso 1810, Mexicaltzingo, Iztapalapa, 09060 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1603, 9, 'Oriente 172 143', ' Moctezuma 2a Sección', ' Venustiano Carranza', 15530, 19.3413428, -99.1576802, 'Oriente 172 143, Moctezuma 2a Sección, Venustiano Carranza, 15530 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1604, 9, '5 C. del Valle MZ23 LT32', ' U Habitacional Vicente Guerrero I II ÌII IV V VI VII', ' Iztapalapa', 9200, 19.438199, -99.2755833, '5 C. del Valle MZ23 LT32, U Habitacional Vicente Guerrero I II ÌII IV V VI VII, Iztapalapa, 09200 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1605, 9, 'Doctor José María Vertiz 262', ' Doctores', ' Cuauhtémoc', 6720, 19.438199, -99.2755833, 'Doctor José María Vertiz 262, Doctores, Cuauhtémoc, 06720 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1606, 9, 'Necaxa 130', ' Portales', ' Benito Juarez', 3300, 19.438199, -99.2755833, 'Necaxa 130, Portales, Benito Juarez, 03300 Mexico City, Federal District, Mexico');
INSERT INTO `ct_direccion_inmueble` VALUES (1607, 9, 'Cuitláhuac 2506-b', ' Clavería', ' Laveria', 2090, 19.3723906, -99.1926721, 'Cuitláhuac 2506-b, Clavería, Laveria, 02090 Azcapotzalco, Federal District, Mexico');


-- -----------------------------------------------------
-- Volcado `inmovitek`.`ct_foto_inmueble`
-- -----------------------------------------------------

INSERT INTO `ct_foto_inmueble` VALUES (1, 1, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (2, 2, 'foto5.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (3, 3, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (4, 4, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (5, 5, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (6, 6, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (7, 7, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (8, 8, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (9, 9, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (10, 10, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (11, 11, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (12, 12, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (13, 13, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (14, 14, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (15, 15, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (16, 16, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (17, 17, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (18, 18, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (19, 19, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (20, 20, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (21, 21, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (22, 22, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (23, 23, 'foto10.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (24, 24, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (25, 25, 'foto5.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (26, 26, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (27, 27, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (28, 28, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (29, 29, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (30, 30, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (31, 31, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (32, 32, 'foto10.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (33, 33, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (34, 34, 'foto6.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (35, 35, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (36, 36, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (37, 37, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (38, 38, 'foto6.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (39, 39, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (40, 40, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (41, 41, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (42, 42, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (43, 43, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (44, 44, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (45, 45, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (46, 46, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (47, 47, 'foto10.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (48, 48, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (49, 49, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (50, 50, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (51, 51, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (52, 52, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (53, 53, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (54, 54, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (55, 55, 'foto10.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (56, 56, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (57, 57, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (58, 58, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (59, 59, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (60, 60, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (61, 61, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (62, 62, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (63, 63, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (64, 64, 'foto6.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (65, 65, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (66, 66, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (67, 67, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (68, 68, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (69, 69, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (70, 70, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (71, 71, 'foto6.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (72, 72, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (73, 73, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (74, 74, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (75, 75, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (76, 76, 'foto5.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (77, 77, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (78, 78, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (79, 79, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (80, 80, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (81, 81, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (82, 82, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (83, 83, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (84, 84, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (85, 85, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (86, 86, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (87, 87, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (88, 88, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (89, 89, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (90, 90, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (91, 91, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (92, 92, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (93, 93, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (94, 94, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (95, 95, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (96, 96, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (97, 97, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (98, 98, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (99, 99, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (100, 100, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (101, 101, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (102, 102, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (103, 103, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (104, 104, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (105, 105, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (106, 106, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (107, 107, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (108, 108, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (109, 109, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (110, 110, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (111, 111, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (112, 112, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (113, 113, 'foto10.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (114, 114, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (115, 115, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (116, 116, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (117, 117, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (118, 118, 'foto10.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (119, 119, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (120, 120, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (121, 121, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (122, 122, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (123, 123, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (124, 124, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (125, 125, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (126, 126, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (127, 127, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (128, 128, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (129, 129, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (130, 130, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (131, 131, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (132, 132, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (133, 133, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (134, 134, 'foto6.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (135, 135, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (136, 136, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (137, 137, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (138, 138, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (139, 139, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (140, 140, 'foto10.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (141, 141, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (142, 142, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (143, 143, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (144, 144, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (145, 145, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (146, 146, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (147, 147, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (148, 148, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (149, 149, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (150, 150, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (151, 151, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (152, 152, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (153, 153, 'foto6.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (154, 154, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (155, 155, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (156, 156, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (157, 157, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (158, 158, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (159, 159, 'foto5.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (160, 160, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (161, 161, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (162, 162, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (163, 163, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (164, 164, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (165, 165, 'foto10.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (166, 166, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (167, 167, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (168, 168, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (169, 169, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (170, 170, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (171, 171, 'foto6.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (172, 172, 'foto6.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (173, 173, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (174, 174, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (175, 175, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (176, 176, 'foto10.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (177, 177, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (178, 178, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (179, 179, 'foto10.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (180, 180, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (181, 181, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (182, 182, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (183, 183, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (184, 184, 'foto10.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (185, 185, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (186, 186, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (187, 187, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (188, 188, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (189, 189, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (190, 190, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (191, 191, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (192, 192, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (193, 193, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (194, 194, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (195, 195, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (196, 196, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (197, 197, 'foto5.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (198, 198, 'foto6.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (199, 199, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (200, 200, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (201, 201, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (202, 202, 'foto6.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (203, 203, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (204, 204, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (205, 205, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (206, 206, 'foto6.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (207, 207, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (208, 208, 'foto6.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (209, 209, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (210, 210, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (211, 211, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (212, 212, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (213, 213, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (214, 214, 'foto10.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (215, 215, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (216, 216, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (217, 217, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (218, 218, 'foto5.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (219, 219, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (220, 220, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (221, 221, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (222, 222, 'foto5.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (223, 223, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (224, 224, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (225, 225, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (226, 226, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (227, 227, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (228, 228, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (229, 229, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (230, 230, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (231, 231, 'foto5.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (232, 232, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (233, 233, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (234, 234, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (235, 235, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (236, 236, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (237, 237, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (238, 238, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (239, 239, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (240, 240, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (241, 241, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (242, 242, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (243, 243, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (244, 244, 'foto5.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (245, 245, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (246, 246, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (247, 247, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (248, 248, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (249, 249, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (250, 250, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (251, 251, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (252, 252, 'foto5.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (253, 253, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (254, 254, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (255, 255, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (256, 256, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (257, 257, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (258, 258, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (259, 259, 'foto5.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (260, 260, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (261, 261, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (262, 262, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (263, 263, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (264, 264, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (265, 265, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (266, 266, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (267, 267, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (268, 268, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (269, 269, 'foto5.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (270, 270, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (271, 271, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (272, 272, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (273, 273, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (274, 274, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (275, 275, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (276, 276, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (277, 277, 'foto10.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (278, 278, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (279, 279, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (280, 280, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (281, 281, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (282, 282, 'foto5.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (283, 283, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (284, 284, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (285, 285, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (286, 286, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (287, 287, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (288, 288, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (289, 289, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (290, 290, 'foto6.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (291, 291, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (292, 292, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (293, 293, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (294, 294, 'foto10.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (295, 295, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (296, 296, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (297, 297, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (298, 298, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (299, 299, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (300, 300, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (301, 301, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (302, 302, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (303, 303, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (304, 304, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (305, 305, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (306, 306, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (307, 307, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (308, 308, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (309, 309, 'foto10.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (310, 310, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (311, 311, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (312, 312, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (313, 313, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (314, 314, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (315, 315, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (316, 316, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (317, 317, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (318, 318, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (319, 319, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (320, 320, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (321, 321, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (322, 322, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (323, 323, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (324, 324, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (325, 325, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (326, 326, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (327, 327, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (328, 328, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (329, 329, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (330, 330, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (331, 331, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (332, 332, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (333, 333, 'foto5.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (334, 334, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (335, 335, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (336, 336, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (337, 337, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (338, 338, 'foto6.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (339, 339, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (340, 340, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (341, 341, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (342, 342, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (343, 343, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (344, 344, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (345, 345, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (346, 346, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (347, 347, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (348, 348, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (349, 349, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (350, 350, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (351, 351, 'foto5.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (352, 352, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (353, 353, 'foto5.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (354, 354, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (355, 355, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (356, 356, 'foto6.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (357, 357, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (358, 358, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (359, 359, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (360, 360, 'foto10.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (361, 361, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (362, 362, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (363, 363, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (364, 364, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (365, 365, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (366, 366, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (367, 367, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (368, 368, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (369, 369, 'foto10.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (370, 370, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (371, 371, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (372, 372, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (373, 373, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (374, 374, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (375, 375, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (376, 376, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (377, 377, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (378, 378, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (379, 379, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (380, 380, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (381, 381, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (382, 382, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (383, 383, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (384, 384, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (385, 385, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (386, 386, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (387, 387, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (388, 388, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (389, 389, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (390, 390, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (391, 391, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (392, 392, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (393, 393, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (394, 394, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (395, 395, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (396, 396, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (397, 397, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (398, 398, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (399, 399, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (400, 400, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (401, 401, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (402, 402, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (403, 403, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (404, 404, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (405, 405, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (406, 406, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (407, 407, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (408, 408, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (409, 409, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (410, 410, 'foto10.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (411, 411, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (412, 412, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (413, 413, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (414, 414, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (415, 415, 'foto10.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (416, 416, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (417, 417, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (418, 418, 'foto10.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (419, 419, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (420, 420, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (421, 421, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (422, 422, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (423, 423, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (424, 424, 'foto6.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (425, 425, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (426, 426, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (427, 427, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (428, 428, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (429, 429, 'foto6.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (430, 430, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (431, 431, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (432, 432, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (433, 433, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (434, 434, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (435, 435, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (436, 436, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (437, 437, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (438, 438, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (439, 439, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (440, 440, 'foto10.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (441, 441, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (442, 442, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (443, 443, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (444, 445, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (445, 446, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (446, 444, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (447, 447, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (448, 448, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (449, 449, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (450, 450, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (451, 451, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (452, 452, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (453, 453, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (454, 454, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (455, 455, 'foto5.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (456, 456, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (457, 457, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (458, 458, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (459, 459, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (460, 460, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (461, 461, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (462, 462, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (463, 463, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (464, 464, 'foto5.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (465, 465, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (466, 466, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (467, 467, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (468, 468, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (469, 469, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (470, 470, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (471, 471, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (472, 472, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (473, 473, 'foto6.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (474, 474, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (475, 475, 'foto5.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (476, 476, 'foto6.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (477, 477, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (478, 478, 'foto6.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (479, 479, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (480, 480, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (481, 481, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (482, 482, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (483, 483, 'foto6.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (484, 484, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (485, 485, 'foto6.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (486, 486, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (487, 487, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (488, 488, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (489, 489, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (490, 490, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (491, 491, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (492, 492, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (493, 493, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (494, 494, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (495, 495, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (496, 496, 'foto5.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (497, 497, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (498, 498, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (499, 499, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (500, 500, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (501, 502, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (502, 501, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (503, 503, 'foto10.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (504, 504, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (505, 505, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (506, 506, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (507, 507, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (508, 508, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (509, 509, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (510, 510, 'foto5.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (511, 511, 'foto5.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (512, 512, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (513, 513, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (514, 514, 'foto10.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (515, 515, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (516, 516, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (517, 517, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (518, 518, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (519, 519, 'foto5.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (520, 520, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (521, 521, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (522, 522, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (523, 523, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (524, 524, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (525, 525, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (526, 526, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (527, 527, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (528, 528, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (529, 529, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (530, 530, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (531, 531, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (532, 532, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (533, 533, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (534, 534, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (535, 535, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (536, 536, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (537, 537, 'foto10.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (538, 538, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (539, 539, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (540, 540, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (541, 541, 'foto5.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (542, 542, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (543, 543, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (544, 544, 'foto10.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (545, 545, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (546, 546, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (547, 547, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (548, 548, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (549, 549, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (550, 550, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (551, 551, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (552, 552, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (553, 553, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (554, 554, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (555, 555, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (556, 556, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (557, 557, 'foto6.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (558, 558, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (559, 559, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (560, 560, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (561, 561, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (562, 562, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (563, 563, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (564, 564, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (565, 565, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (566, 566, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (567, 567, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (568, 568, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (569, 569, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (570, 570, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (571, 571, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (572, 572, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (573, 573, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (574, 574, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (575, 575, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (576, 576, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (577, 577, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (578, 578, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (579, 579, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (580, 580, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (581, 581, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (582, 582, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (583, 583, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (584, 584, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (585, 585, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (586, 586, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (587, 587, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (588, 588, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (589, 589, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (590, 590, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (591, 591, 'foto10.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (592, 592, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (593, 593, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (594, 594, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (595, 595, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (596, 596, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (597, 597, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (598, 598, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (599, 599, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (600, 600, 'foto10.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (601, 601, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (602, 602, 'foto5.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (603, 603, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (604, 604, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (605, 605, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (606, 606, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (607, 607, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (608, 608, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (609, 609, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (610, 610, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (611, 611, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (612, 612, 'foto6.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (613, 613, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (614, 614, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (615, 615, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (616, 616, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (617, 617, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (618, 618, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (619, 619, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (620, 620, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (621, 621, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (622, 622, 'foto5.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (623, 623, 'foto6.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (624, 624, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (625, 625, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (626, 626, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (627, 627, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (628, 628, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (629, 629, 'foto5.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (630, 630, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (631, 631, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (632, 632, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (633, 633, 'foto10.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (634, 634, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (635, 635, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (636, 636, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (637, 637, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (638, 638, 'foto5.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (639, 639, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (640, 640, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (641, 641, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (642, 642, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (643, 643, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (644, 644, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (645, 645, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (646, 646, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (647, 647, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (648, 648, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (649, 649, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (650, 650, 'foto6.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (651, 651, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (652, 652, 'foto10.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (653, 653, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (654, 654, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (655, 655, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (656, 656, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (657, 657, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (658, 658, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (659, 659, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (660, 660, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (661, 661, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (662, 662, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (663, 663, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (664, 664, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (665, 665, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (666, 666, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (667, 667, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (668, 668, 'foto6.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (669, 669, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (670, 670, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (671, 671, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (672, 672, 'foto10.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (673, 673, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (674, 674, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (675, 675, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (676, 676, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (677, 677, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (678, 678, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (679, 679, 'foto5.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (680, 680, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (681, 681, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (682, 682, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (683, 683, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (684, 684, 'foto6.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (685, 685, 'foto5.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (686, 686, 'foto10.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (687, 687, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (688, 688, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (689, 689, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (690, 690, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (691, 691, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (692, 692, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (693, 693, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (694, 694, 'foto5.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (695, 695, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (696, 696, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (697, 697, 'foto6.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (698, 698, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (699, 699, 'foto6.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (700, 700, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (701, 701, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (702, 702, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (703, 703, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (704, 704, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (705, 705, 'foto5.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (706, 706, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (707, 707, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (708, 708, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (709, 709, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (710, 710, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (711, 711, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (712, 712, 'foto6.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (713, 713, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (714, 714, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (715, 715, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (716, 716, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (717, 717, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (718, 718, 'foto5.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (719, 719, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (720, 720, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (721, 721, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (722, 722, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (723, 723, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (724, 724, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (725, 725, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (726, 726, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (727, 727, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (728, 728, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (729, 729, 'foto5.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (730, 730, 'foto5.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (731, 731, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (732, 732, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (733, 733, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (734, 734, 'foto5.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (735, 735, 'foto10.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (736, 736, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (737, 737, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (738, 738, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (739, 739, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (740, 740, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (741, 741, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (742, 742, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (743, 743, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (744, 744, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (745, 745, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (746, 746, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (747, 747, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (748, 748, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (749, 749, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (750, 750, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (751, 751, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (752, 752, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (753, 753, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (754, 754, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (755, 755, 'foto6.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (756, 756, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (757, 757, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (758, 758, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (759, 759, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (760, 760, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (761, 761, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (762, 762, 'foto5.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (763, 763, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (764, 764, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (765, 765, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (766, 766, 'foto6.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (767, 767, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (768, 768, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (769, 769, 'foto10.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (770, 770, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (771, 771, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (772, 772, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (773, 773, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (774, 774, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (775, 775, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (776, 776, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (777, 777, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (778, 778, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (779, 779, 'foto10.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (780, 780, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (781, 781, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (782, 782, 'foto6.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (783, 783, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (784, 784, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (785, 785, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (786, 786, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (787, 787, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (788, 788, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (789, 789, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (790, 790, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (791, 791, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (792, 792, 'foto5.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (793, 793, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (794, 794, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (795, 795, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (796, 796, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (797, 797, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (798, 798, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (799, 799, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (800, 800, 'foto6.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (801, 801, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (802, 802, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (803, 803, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (804, 804, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (805, 805, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (806, 806, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (807, 807, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (808, 808, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (809, 809, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (810, 810, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (811, 811, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (812, 812, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (813, 813, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (814, 814, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (815, 815, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (816, 816, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (817, 817, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (818, 818, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (819, 819, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (820, 820, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (821, 821, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (822, 822, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (823, 823, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (824, 824, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (825, 825, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (826, 826, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (827, 827, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (828, 828, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (829, 829, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (830, 830, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (831, 831, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (832, 832, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (833, 833, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (834, 834, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (835, 835, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (836, 836, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (837, 837, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (838, 838, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (839, 839, 'foto6.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (840, 840, 'foto10.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (841, 841, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (842, 842, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (843, 843, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (844, 844, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (845, 845, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (846, 846, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (847, 847, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (848, 848, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (849, 849, 'foto5.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (850, 850, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (851, 851, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (852, 852, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (853, 853, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (854, 854, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (855, 855, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (856, 856, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (857, 857, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (858, 858, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (859, 859, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (860, 860, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (861, 861, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (862, 862, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (863, 863, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (864, 864, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (865, 865, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (866, 866, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (867, 867, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (868, 868, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (869, 869, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (870, 870, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (871, 871, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (872, 872, 'foto6.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (873, 873, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (874, 874, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (875, 875, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (876, 876, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (877, 877, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (878, 878, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (879, 879, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (880, 880, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (881, 881, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (882, 882, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (883, 883, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (884, 884, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (885, 885, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (886, 886, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (887, 887, 'foto10.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (888, 888, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (889, 889, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (890, 890, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (891, 891, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (892, 892, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (893, 893, 'foto10.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (894, 894, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (895, 895, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (896, 896, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (897, 897, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (898, 898, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (899, 899, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (900, 900, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (901, 901, 'foto5.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (902, 902, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (903, 903, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (904, 904, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (905, 905, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (906, 906, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (907, 907, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (908, 908, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (909, 909, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (910, 910, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (911, 911, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (912, 912, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (913, 913, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (914, 914, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (915, 915, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (916, 916, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (917, 917, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (918, 918, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (919, 919, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (920, 920, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (921, 921, 'foto10.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (922, 922, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (923, 923, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (924, 924, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (925, 925, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (926, 926, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (927, 927, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (928, 928, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (929, 929, 'foto10.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (930, 930, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (931, 931, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (932, 932, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (933, 933, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (934, 934, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (935, 935, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (936, 936, 'foto6.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (937, 937, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (938, 938, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (939, 939, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (940, 940, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (941, 941, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (942, 942, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (943, 943, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (944, 944, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (945, 945, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (946, 946, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (947, 947, 'foto5.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (948, 948, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (949, 949, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (950, 950, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (951, 951, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (952, 952, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (953, 953, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (954, 954, 'foto6.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (955, 955, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (956, 956, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (957, 957, 'foto5.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (958, 958, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (959, 959, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (960, 960, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (961, 961, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (962, 962, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (963, 963, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (964, 964, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (965, 965, 'foto10.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (966, 966, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (967, 967, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (968, 968, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (969, 969, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (970, 970, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (971, 971, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (972, 972, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (973, 973, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (974, 974, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (975, 975, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (976, 976, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (977, 977, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (978, 978, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (979, 979, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (980, 980, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (981, 981, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (982, 982, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (983, 983, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (984, 984, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (985, 985, 'foto6.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (986, 986, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (987, 987, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (988, 988, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (989, 989, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (990, 990, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (991, 991, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (992, 992, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (993, 993, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (994, 994, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (995, 995, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (996, 996, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (997, 997, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (998, 998, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (999, 999, 'foto5.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1000, 1000, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1001, 1001, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1002, 1002, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1003, 1003, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1004, 1004, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1005, 1005, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1006, 1006, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1007, 1007, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1008, 1008, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1009, 1009, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1010, 1010, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1011, 1011, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1012, 1012, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1013, 1013, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1014, 1014, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1015, 1015, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1016, 1016, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1017, 1017, 'foto10.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1018, 1018, 'foto6.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1019, 1019, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1020, 1020, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1021, 1021, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1022, 1022, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1023, 1023, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1024, 1024, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1025, 1025, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1026, 1026, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1027, 1027, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1028, 1028, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1029, 1029, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1030, 1030, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1031, 1031, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1032, 1032, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1033, 1033, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1034, 1034, 'foto10.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1035, 1035, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1036, 1036, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1037, 1037, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1038, 1038, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1039, 1039, 'foto10.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1040, 1040, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1041, 1041, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1042, 1042, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1043, 1043, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1044, 1044, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1045, 1045, 'foto10.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1046, 1046, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1047, 1047, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1048, 1048, 'foto6.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1049, 1049, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1050, 1050, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1051, 1051, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1052, 1052, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1053, 1053, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1054, 1054, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1055, 1055, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1056, 1056, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1057, 1057, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1058, 1058, 'foto5.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1059, 1059, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1060, 1060, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1061, 1061, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1062, 1062, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1063, 1063, 'foto6.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1064, 1064, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1065, 1065, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1066, 1066, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1067, 1067, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1068, 1068, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1069, 1069, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1070, 1070, 'foto10.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1071, 1071, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1072, 1072, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1073, 1073, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1074, 1074, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1075, 1075, 'foto5.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1076, 1076, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1077, 1077, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1078, 1078, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1079, 1079, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1080, 1080, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1081, 1081, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1082, 1082, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1083, 1083, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1084, 1084, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1085, 1085, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1086, 1086, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1087, 1087, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1088, 1088, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1089, 1089, 'foto6.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1090, 1090, 'foto10.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1091, 1091, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1092, 1092, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1093, 1093, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1094, 1094, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1095, 1095, 'foto5.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1096, 1096, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1097, 1097, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1098, 1098, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1099, 1099, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1100, 1100, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1101, 1101, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1102, 1102, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1103, 1103, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1104, 1104, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1105, 1105, 'foto5.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1106, 1106, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1107, 1107, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1108, 1108, 'foto10.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1109, 1109, 'foto10.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1110, 1110, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1111, 1111, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1112, 1112, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1113, 1113, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1114, 1114, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1115, 1115, 'foto10.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1116, 1116, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1117, 1117, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1118, 1118, 'foto6.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1119, 1119, 'foto10.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1120, 1120, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1121, 1121, 'foto5.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1122, 1122, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1123, 1123, 'foto6.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1124, 1124, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1125, 1125, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1126, 1126, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1127, 1127, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1128, 1128, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1129, 1129, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1130, 1130, 'foto6.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1131, 1131, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1132, 1132, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1133, 1133, 'foto5.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1134, 1134, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1135, 1135, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1136, 1136, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1137, 1137, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1138, 1138, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1139, 1139, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1140, 1140, 'foto10.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1141, 1141, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1142, 1142, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1143, 1143, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1144, 1144, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1145, 1145, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1146, 1146, 'foto10.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1147, 1147, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1148, 1148, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1149, 1149, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1150, 1150, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1151, 1151, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1152, 1152, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1153, 1153, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1154, 1154, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1155, 1155, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1156, 1156, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1157, 1157, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1158, 1158, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1159, 1159, 'foto5.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1160, 1160, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1161, 1161, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1162, 1162, 'foto10.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1163, 1163, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1164, 1164, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1165, 1165, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1166, 1166, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1167, 1167, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1168, 1168, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1169, 1169, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1170, 1170, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1171, 1171, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1172, 1172, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1173, 1173, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1174, 1174, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1175, 1175, 'foto6.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1176, 1176, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1177, 1177, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1178, 1178, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1179, 1179, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1180, 1180, 'foto5.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1181, 1181, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1182, 1182, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1183, 1183, 'foto10.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1184, 1184, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1185, 1185, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1186, 1186, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1187, 1187, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1188, 1188, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1189, 1189, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1190, 1190, 'foto6.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1191, 1191, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1192, 1192, 'foto10.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1193, 1193, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1194, 1194, 'foto5.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1195, 1195, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1196, 1196, 'foto10.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1197, 1197, 'foto5.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1198, 1198, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1199, 1199, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1200, 1200, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1201, 1201, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1202, 1202, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1203, 1203, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1204, 1204, 'foto5.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1205, 1205, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1206, 1206, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1207, 1207, 'foto5.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1208, 1208, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1209, 1209, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1210, 1210, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1211, 1211, 'foto5.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1212, 1212, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1213, 1213, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1214, 1214, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1215, 1215, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1216, 1216, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1217, 1217, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1218, 1218, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1219, 1219, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1220, 1220, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1221, 1221, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1222, 1222, 'foto6.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1223, 1223, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1224, 1224, 'foto6.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1225, 1225, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1226, 1226, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1227, 1227, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1228, 1228, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1229, 1229, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1230, 1230, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1231, 1231, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1232, 1232, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1233, 1233, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1234, 1234, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1235, 1235, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1236, 1236, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1237, 1237, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1238, 1238, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1239, 1239, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1240, 1240, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1241, 1241, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1242, 1242, 'foto5.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1243, 1243, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1244, 1244, 'foto5.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1245, 1245, 'foto5.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1246, 1246, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1247, 1247, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1248, 1248, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1249, 1249, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1250, 1250, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1251, 1251, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1252, 1252, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1253, 1253, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1254, 1254, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1255, 1255, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1256, 1256, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1257, 1257, 'foto6.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1258, 1258, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1259, 1259, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1260, 1260, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1261, 1261, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1262, 1262, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1263, 1263, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1264, 1264, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1265, 1265, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1266, 1266, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1267, 1267, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1268, 1268, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1269, 1269, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1270, 1270, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1271, 1271, 'foto5.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1272, 1272, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1273, 1273, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1274, 1274, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1275, 1275, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1276, 1276, 'foto6.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1277, 1277, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1278, 1278, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1279, 1279, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1280, 1280, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1281, 1281, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1282, 1282, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1283, 1283, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1284, 1284, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1285, 1285, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1286, 1286, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1287, 1287, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1288, 1288, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1289, 1289, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1290, 1290, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1291, 1291, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1292, 1292, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1293, 1293, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1294, 1294, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1295, 1295, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1296, 1296, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1297, 1297, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1298, 1298, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1299, 1299, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1300, 1300, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1301, 1301, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1302, 1302, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1303, 1303, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1304, 1304, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1305, 1305, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1306, 1306, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1307, 1307, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1308, 1308, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1309, 1309, 'foto10.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1310, 1310, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1311, 1311, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1312, 1312, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1313, 1313, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1314, 1314, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1315, 1315, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1316, 1316, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1317, 1317, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1318, 1318, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1319, 1319, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1320, 1320, 'foto10.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1321, 1321, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1322, 1322, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1323, 1323, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1324, 1324, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1325, 1325, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1326, 1326, 'foto6.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1327, 1327, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1328, 1328, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1329, 1329, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1330, 1330, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1331, 1331, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1332, 1332, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1333, 1333, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1334, 1334, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1335, 1335, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1336, 1336, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1337, 1337, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1338, 1338, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1339, 1339, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1340, 1340, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1341, 1341, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1342, 1342, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1343, 1343, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1344, 1344, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1345, 1345, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1346, 1346, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1347, 1347, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1348, 1348, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1349, 1349, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1350, 1350, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1351, 1351, 'foto10.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1352, 1352, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1353, 1353, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1354, 1354, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1355, 1355, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1356, 1356, 'foto5.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1357, 1357, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1358, 1358, 'foto10.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1359, 1359, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1360, 1360, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1361, 1361, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1362, 1362, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1363, 1363, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1364, 1364, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1365, 1365, 'foto6.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1366, 1366, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1367, 1367, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1368, 1368, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1369, 1369, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1370, 1370, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1371, 1371, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1372, 1372, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1373, 1373, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1374, 1374, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1375, 1375, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1376, 1376, 'foto6.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1377, 1377, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1378, 1378, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1379, 1379, 'foto10.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1380, 1380, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1381, 1381, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1382, 1382, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1383, 1383, 'foto10.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1384, 1384, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1385, 1385, 'foto10.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1386, 1386, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1387, 1387, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1388, 1388, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1389, 1389, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1390, 1390, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1391, 1391, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1392, 1392, 'foto10.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1393, 1393, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1394, 1394, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1395, 1395, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1396, 1396, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1397, 1397, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1398, 1398, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1399, 1399, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1400, 1400, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1401, 1401, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1402, 1402, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1403, 1403, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1404, 1404, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1405, 1405, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1406, 1406, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1407, 1407, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1408, 1408, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1409, 1409, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1410, 1410, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1411, 1411, 'foto10.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1412, 1412, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1413, 1413, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1414, 1414, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1415, 1415, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1416, 1416, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1417, 1417, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1418, 1418, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1419, 1419, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1420, 1420, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1421, 1421, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1422, 1422, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1423, 1423, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1424, 1424, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1425, 1425, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1426, 1426, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1427, 1427, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1428, 1428, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1429, 1429, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1430, 1430, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1431, 1431, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1432, 1432, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1433, 1433, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1434, 1434, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1435, 1435, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1436, 1436, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1437, 1437, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1438, 1438, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1439, 1439, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1440, 1440, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1441, 1441, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1442, 1442, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1443, 1443, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1444, 1444, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1445, 1445, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1446, 1446, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1447, 1447, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1448, 1448, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1449, 1449, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1450, 1450, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1451, 1451, 'foto6.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1452, 1452, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1453, 1453, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1454, 1454, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1455, 1455, 'foto6.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1456, 1456, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1457, 1457, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1458, 1458, 'foto5.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1459, 1459, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1460, 1460, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1461, 1461, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1462, 1462, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1463, 1463, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1464, 1464, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1465, 1465, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1466, 1466, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1467, 1467, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1468, 1468, 'foto5.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1469, 1469, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1470, 1470, 'foto5.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1471, 1471, 'foto6.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1472, 1472, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1473, 1473, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1474, 1474, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1475, 1475, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1476, 1476, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1477, 1477, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1478, 1478, 'foto6.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1479, 1479, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1480, 1480, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1481, 1481, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1482, 1482, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1483, 1483, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1484, 1484, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1485, 1485, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1486, 1486, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1487, 1487, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1488, 1488, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1489, 1489, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1490, 1490, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1491, 1491, 'foto5.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1492, 1492, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1493, 1493, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1494, 1494, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1495, 1495, 'foto5.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1496, 1496, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1497, 1497, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1498, 1498, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1499, 1499, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1500, 1500, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1501, 1501, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1502, 1502, 'foto6.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1503, 1503, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1504, 1504, 'foto10.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1505, 1505, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1506, 1506, 'foto5.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1507, 1507, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1508, 1508, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1509, 1509, 'foto3.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1510, 1510, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1511, 1511, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1512, 1512, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1513, 1513, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1514, 1514, 'foto8.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1515, 1515, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1516, 1516, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1517, 1517, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1518, 1518, 'foto6.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1519, 1519, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1520, 1520, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1521, 1521, 'foto5.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1522, 1522, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1523, 1523, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1524, 1524, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1525, 1525, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1526, 1526, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1527, 1527, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1528, 1528, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1529, 1529, 'foto6.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1530, 1530, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1531, 1531, 'foto6.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1532, 1532, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1533, 1533, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1534, 1534, 'foto5.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1535, 1535, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1536, 1536, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1537, 1537, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1538, 1538, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1539, 1539, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1540, 1540, 'foto10.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1541, 1541, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1542, 1542, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1543, 1543, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1544, 1544, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1545, 1545, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1546, 1546, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1547, 1547, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1548, 1548, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1549, 1549, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1550, 1550, 'foto10.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1551, 1551, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1552, 1552, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1553, 1553, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1554, 1554, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1555, 1555, 'foto6.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1556, 1556, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1557, 1557, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1558, 1558, 'foto11.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1559, 1559, 'foto15.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1560, 1560, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1561, 1561, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1562, 1562, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1563, 1563, 'foto6.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1564, 1564, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1565, 1565, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1566, 1566, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1567, 1567, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1568, 1568, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1569, 1569, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1570, 1570, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1571, 1571, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1572, 1572, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1573, 1573, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1574, 1574, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1575, 1575, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1576, 1576, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1577, 1577, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1578, 1578, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1579, 1579, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1580, 1580, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1581, 1581, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1582, 1582, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1583, 1583, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1584, 1584, 'foto17.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1585, 1585, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1586, 1586, 'foto6.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1587, 1587, 'foto1.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1588, 1588, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1589, 1589, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1590, 1590, 'foto16.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1591, 1591, 'foto9.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1592, 1592, 'foto6.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1593, 1593, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1594, 1594, 'foto13.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1595, 1595, 'foto20.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1596, 1596, 'foto19.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1597, 1597, 'foto6.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1598, 1598, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1599, 1599, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1600, 1600, 'foto2.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1601, 1601, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1602, 1602, 'foto18.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1603, 1603, 'foto4.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1604, 1604, 'foto7.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1605, 1605, 'foto14.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1606, 1606, 'foto12.jpg');
INSERT INTO `ct_foto_inmueble` VALUES (1607, 1607, 'foto3.jpg');


-- -----------------------------------------------------
-- Volcado `inmovitek`.`ct_telefono_inmobiliaria`
-- -----------------------------------------------------

INSERT INTO `ct_telefono_inmobiliaria` VALUES (1, 1, '5525620720');


-- -----------------------------------------------------
-- Volcado `inmovitek`.`ct_limite_usuario`
-- -----------------------------------------------------

INSERT INTO `ct_limite_usuario` VALUES (1, 0, '2014-10-06');


