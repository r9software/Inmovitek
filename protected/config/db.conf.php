<?php

/**
 * Example Database connection settings and DB relationship mapping
 * $dbmap[Table A]['has_one'][Table B] = array('foreign_key'=> Table B's column that links to Table A );
 * $dbmap[Table B]['belongs_to'][Table A] = array('foreign_key'=> Table A's column where Table B links to );
 * */
//Mapeo de la base de datos al modelo ORM
//$dbmap[][][] = array('foreign_key'=>'','through'=>'');
//
//TABLA LICENCIA
$dbmap['licencia']['has_many']['inmobiliaria'] = array('foreign_key' => 'licencia');


//TABLA CT_INMOBILIARIA
$dbmap['inmobiliaria']['belongs_to']['licencia'] = array('foreign_key' => 'licencia');
$dbmap['inmobiliaria']['has_many']['usuario'] = array('foreign_key' => 'id_inmobiliaria');
$dbmap['inmobiliaria']['has_many']['cliente'] = array('foreign_key' => 'id_inmobiliaria');
//$dbmap['inmobiliaria']['has_many']['inmueble'] = array('foreign_key' => 'id_inmobiliaria');
$dbmap['inmobiliaria']['has_many']['viewInmobiliariaInmueble'] = array('foreign_key' => 'id_inmobiliaria');
$dbmap['inmobiliaria']['has_many']['telefonoInmobiliaria'] = array('foreign_key' => 'id_inmobiliaria');
$dbmap['inmobiliaria']['has_many']['inmobiliaria'] = array('foreign_key' => 'id_inmobiliaria', 'through' => 'inmobiliariaAmiga');
$dbmap['inmobiliaria']['has_many']['inmobiliaria'] = array('foreign_key' => 'id_inmobiliaria', 'through' => 'mensajeInmobiliaria');

//TABLA RL_INMOBILIARIA
$dbmap['inmobiliariaAmiga']['belongs_to']['inmobiliaria'] = array('foreign_key' => 'id_inmobiliaria_amiga');
$dbmap['inmobiliariaAmiga']['belongs_to']['inmobiliaria'] = array('foreign_key' => 'id_inmobiliaria');


//Tabla telefonoInmobiliaria
$dbmap['telefonoInmobiliaria']['belongs_to']['inmobiliaria'] = array('foreign_key' => 'id_inmobiliaria');

//TABLA CT_USUARIO
$dbmap['usuario']['belongs_to']['inmobiliaria'] = array('foreign_key' => 'id_inmobiliaria');
$dbmap['usuario']['has_many']['agendaUsuario'] = array('foreign_key' => 'id_usuario');
$dbmap['usuario']['has_one']['permisosUsuario'] = array('foreign_key' => 'id_usuario');
$dbmap['usuario']['has_many']['venta'] = array('foreign_key' => 'id_vendedor');
$dbmap['usuario']['has_one']['limiteUsuario'] = array('foreign_key' => 'id_usuario');
$dbmap['usuario']['has_many']['inmueble'] = array('foreign_key' => 'id_usuario');
$dbmap['usuario']['has_many']['viewInmobiliariaInmueble'] = array('foreign_key' => 'id_usuario');
$dbmap['usuario']['has_many']['usuario'] = array('foreign_key' => 'id_usuario', 'through' => 'mensajeUsuario');

//TABLA MENSAJE USUARIO
$dbmap['usuario']['has_many']['mensajeUsuario'] = array('foreign_key' => 'id_usuario_receptor');
$dbmap['usuario']['has_many']['mensajeUsuario'] = array('foreign_key' => 'id_usuario_emisor');
$dbmap['mensajeUsuario']['belongs_to']['usuario'] = array('foreign_key' => 'id_usuario');
$dbmap['inmobiliaria']['has_many']['mensajeInmobiliaria'] = array('foreign_key' => 'id_inmobiliaria_receptor');
$dbmap['inmobiliaria']['has_many']['mensajeInmobiliaria'] = array('foreign_key' => 'id_inmobiliaria_emisor');
$dbmap['mensajeInmobiliaria']['belongs_to']['inmobiliaria'] = array('foreign_key' => 'id_inmobiliaria');
// TABLA permisosUsuario
$dbmap['permisosUsuario']['belongs_to']['usuario'] = array('foreign_key' => 'id_usuario');

// TABLA LIMITE USUARIO
$dbmap['limiteUsuario']['belongs_to']['usuario'] = array('foreign_key' => 'id_usuario');

//TABLA AGENDA USUARIO
$dbmap['agendaUsuario']['belongs_to']['usuario'] = array('foreign_key' => 'id_usuario');

//TABLA CT_TIPO_INMUEBLE
$dbmap['tipoInmueble']['has_many']['inmueble'] = array('foreign_key' => 'id_tipo_inmueble');
$dbmap['tipoInmueble']['has_many']['viewInmobiliariaInmueble'] = array('foreign_key' => 'id_tipo_inmueble');
$dbmap['tipoInmueble']['has_many']['perfilCliente'] = array('foreign_key' => 'id_tipo_inmueble');

//TABLA CT_CLIENTE
$dbmap['cliente']['belongs_to']['usuario'] = array('foreign_key' => 'id_usuario');
$dbmap['cliente']['has_many']['inmueble'] = array('foreign_key' => 'id_propietario');
$dbmap['cliente']['has_many']['viewInmobiliariaInmueble'] = array('foreign_key' => 'id_propietario');
$dbmap['cliente']['has_many']['renta'] = array('foreign_key' => 'cliente_alquila');
$dbmap['cliente']['has_many']['inmuebleOfrecidoCliente'] = array('foreign_key' => 'id_cliente');
$dbmap['cliente']['has_many']['telefonoCliente'] = array('foreign_key' => 'id_cliente');
$dbmap['cliente']['has_many']['venta'] = array('foreign_key' => 'id_comprador');
$dbmap['cliente']['has_many']['perfilCliente'] = array('foreign_key' => 'id_cliente');

//Tabla telefonoCliente
$dbmap['telefonoCliente']['belongs_to']['cliente'] = array('foreign_key' => 'id_cliente');

//Tabla venta
$dbmap['venta']['belongs_to']['inmueble'] = array('foreign_key' => 'id_inmueble');
$dbmap['venta']['belongs_to']['viewINmobiliariaInmueble'] = array('foreign_key' => 'id_inmueble');
$dbmap['venta']['belongs_to']['usuario'] = array('foreign_key' => 'id_vendedor');
$dbmap['venta']['belongs_to']['cliente'] = array('foreign_key' => 'id_comprador');

//TABLA CT_INMUEBLE
$dbmap['inmueble']['belongs_to']['tipoInmueble'] = array('foreign_key' => 'id_tipo_inmueble');
$dbmap['inmueble']['belongs_to']['usuario'] = array('foreign_key' => 'id_usuario');
$dbmap['inmueble']['belongs_to']['cliente'] = array('foreign_key' => 'id_propietario');
$dbmap['inmueble']['has_many']['renta'] = array('foreign_key' => 'id_inmueble');
$dbmap['inmueble']['has_one']['direccionInmueble'] = array('foreign_key' => 'id_inmueble');
$dbmap['inmueble']['has_many']['fotoInmueble'] = array('foreign_key' => 'id_inmueble');
$dbmap['inmueble']['has_many']['inmueblePromocionado'] = array('foreign_key' => 'id_inmueble');
$dbmap['inmueble']['has_many']['inmuebleOfrecidoCliente'] = array('foreign_key' => 'id_inmueble');
$dbmap['inmueble']['has_many']['venta'] = array('foreign_key' => 'id_inmueble');
$dbmap['inmueble']['has_many']['visitaVirtual'] = array('foreign_key' => 'id_inmueble');

//TABLA view_inmobiliaria_inmueble
$dbmap['viewInmobiliariaInmueble']['belongs_to']['tipoInmueble'] = array('foreign_key' => 'id_tipo_inmueble');
$dbmap['viewInmobiliariaInmueble']['belongs_to']['usuario'] = array('foreign_key' => 'id_usuario');
$dbmap['viewInmobiliariaInmueble']['belongs_to']['cliente'] = array('foreign_key' => 'id_propietario');
$dbmap['viewInmobiliariaInmueble']['has_many']['renta'] = array('foreign_key' => 'id_inmueble');
$dbmap['viewInmobiliariaInmueble']['has_one']['direccionInmueble'] = array('foreign_key' => 'id_inmueble');
$dbmap['viewInmobiliariaInmueble']['has_many']['fotoInmueble'] = array('foreign_key' => 'id_inmueble');
$dbmap['viewInmobiliariaInmueble']['has_many']['inmueblePromocionado'] = array('foreign_key' => 'id_inmueble');
$dbmap['viewInmobiliariaInmueble']['has_many']['inmuebleOfrecidoCliente'] = array('foreign_key' => 'id_inmueble');
$dbmap['viewInmobiliariaInmueble']['has_many']['venta'] = array('foreign_key' => 'id_inmueble');
$dbmap['viewInmobiliariaInmueble']['has_many']['visitaVirtual'] = array('foreign_key' => 'id_inmueble');
$dbmap['viewInmobiliariaInmueble']['belongs_to']['inmobiliaria'] = array('foreign_key' => 'id_inmobiliaria');

//TABLA DIRECCION_INMUEBLE
$dbmap['direccionInmueble']['belongs_to']['estado'] = array('foreign_key' => 'id_estado');
$dbmap['direccionInmueble']['belongs_to']['inmueble'] = array('foreign_key' => 'id_inmueble');
$dbmap['direccionInmueble']['belongs_to']['viewInmobiliariaInmueble'] = array('foreign_key' => 'id_inmueble');

//TABLA CT_ESTADO
$dbmap['estado']['has_many']['perfilCliente'] = array('foreign_key' => 'id_estado_busca_inmueble');
$dbmap['estado']['has_many']['direccionInmueble'] = array('foreign_key' => 'id_estado');

//TABLA FOTO_INMUEBLE
$dbmap['fotoInmueble']['belongs_to']['inmueble'] = array('foreign_key' => 'id_inmueble');
$dbmap['fotoInmueble']['belongs_to']['viewInmobiliariaInmueble'] = array('foreign_key' => 'id_inmueble');

//Tabla visitaVirtual
$dbmap['visitaVirtual']['belongs_to']['inmueble'] = array('foreign_key' => 'id_inmueble');
$dbmap['visitaVirtual']['belongs_to']['viewInmobiliariaInmueble'] = array('foreign_key' => 'id_inmueble');

//Tabla inmueble promocionado
$dbmap['inmueblePromocionado']['belongs_to']['inmueble'] = array('foreign_key' => 'id_inmueble');
$dbmap['inmueblePromocionado']['belongs_to']['viewInmobiliariaInmueble'] = array('foreign_key' => 'id_inmueble');

//TABLA inmueble_ofrecido_cliente
$dbmap['inmuebleOfrecidoCliente']['belongs_to']['cliente'] = array('foreign_key' => 'id_cliente');
$dbmap['inmuebleOfrecidoCliente']['belongs_to']['inmueble'] = array('foreign_key' => 'id_inmueble');
$dbmap['inmuebleOfrecidoCliente']['belongs_to']['viewInmobiliariaInmueble'] = array('foreign_key' => 'id_inmueble');

//TABLA CT_RENTA
$dbmap['renta']['belongs_to']['inmueble'] = array('foreign_key' => 'id_inmueble');
$dbmap['renta']['belongs_to']['viewInmobiliariaInmueble'] = array('foreign_key' => 'id_inmueble');
$dbmap['renta']['belongs_to']['cliente'] = array('foreign_key' => 'id_cliente');
$dbmap['renta']['has_many']['pagoRenta'] = array('foreign_key' => 'id_renta');

//Tabla pago_renta
$dbmap['pagoRenta']['belongs_to']['renta'] = array('foreign_key' => 'id_renta');


//TABLA PERFIL_CLIENTE
$dbmap['perfilCliente']['belongs_to']['estado'] = array('foreign_key' => 'id_estado');
$dbmap['perfilCliente']['belongs_to']['tipoInmueble'] = array('foreign_key' => 'id_tipo_inmueble');
$dbmap['perfilCliente']['belongs_to']['cliente'] = array('foreign_key' => 'id_cliente');

//Configuración de la base de datos local
$dbconfig['dev'] = array('localhost', 'inmovitek', 'inmovi', 'cete8653', 'mysql', true);

//Configuración de la base de datos grupo-celula.com
$dbconfig['prod'] = array('localhost', 'grupoce_inmovitek', 'grupoce_inmo', 'cete8653', 'mysql', true);

//Configuración de la base de datos enginetec.com.mx
//$dbconfig['prod'] = array('localhost', 'enginetec_com_mx_inmovitek', 'engin_inmovi', 'cete8653', 'mysql', true);
?>