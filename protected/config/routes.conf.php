<?php
 
 //Index
$route['*']['/'] = array('MainController', 'index');
//Perfil

/*
    $route['*']['/perfil'] = array('PerfilController', 'index');
    $route['post']['/perfil'] = array('PerfilController', 'subirFotos');
    $route['*']['/perfil/:nombreInmobiliaria'] = array('PerfilController', 'perfilIndividual');
    $route['*']['/perfil/:nombreInmobiliaria/mapa'] = array('PerfilController', 'verMapa');
    $route['*']['/perfil/:nombreInmobiliaria/inmuebles'] = array('PerfilController', 'listar');
    $route['*']['/perfil/:nombreInmobiliaria/inmueble/:idInmueble'] = array('PerfilController', 'verInmueble');
 */


$route['*']['root']['/:idenInmobiliaria'] = array('PerfilController', 'index');
$route['*']['root']['/:idenInmobiliaria/buscar'] = array('PerfilController', 'buscador');
$route['*']['root']['/:idenInmobiliaria/buscar/mapa'] = array('PerfilController', 'buscadorMapa');

//Perfil de Inmueble
$route['*']['/inmueble/:idInmueble'] = array('InmuebleController', 'verInmueble');

//Paginas del CRM
$route['*']['/CRM'] = array('CRM/CRMIndexController', 'login');
$route['post']['/CRM/ValidateLogin'] = array('CRM/CRMIndexController', 'ValidateLogin');
$route['*']['/CRM/logout'] = array('CRM/CRMIndexController', 'logout');
$route['*']['/CRM/home'] = array('CRM/CRMIndexController', 'home');

//genera licencia
$route['*']['/CRM/licencia'] = array('CRM/CRMIndexController', 'getLicencia');

//CRM - Perfil
$route['*']['/CRM/perfil'] = array('CRM/CRMPerfilController', 'index');
$route['post']['/CRM/perfil/edit'] = array('CRM/CRMPerfilController', 'editAction');
$route['*']['/CRM/perfil/edit'] = array('CRM/CRMPerfilController', 'edit');
$route['*']['/CRM/perfil/changePass'] = array('CRM/CRMPerfilController', 'changePass');

//CRM Inmobiliaria
$route['*']['/CRM/inmobiliaria'] = array('CRM/CRMInmobiliariaController', 'index');
$route['post']['/CRM/inmobiliaria/editar'] = array('CRM/CRMInmobiliariaController', 'actionEditar');
$route['*']['/CRM/inmobiliaria/editar'] = array('CRM/CRMInmobiliariaController', 'editar');
//CRM Usuarios

$route['post']['/CRM/inmobiliaria/usuarios/nuevo'] = array('CRM/CRMInmobiliariaController', 'registarNuevoUsuario');
$route['*']['/CRM/inmobiliaria/usuarios/nuevo'] = array('CRM/CRMInmobiliariaController', 'nuevoUsuario');
$route['*']['/CRM/inmobiliaria/usuarios/administrar'] = array('CRM/CRMInmobiliariaController', 'administrarUsuario');
$route['post']['/CRM/inmobiliaria/usuarios/administrar'] = array('CRM/CRMInmobiliariaController', 'cambiarPassword');
$route['*']['/CRM/inmobiliaria/usuarios/administrar/:idUsuario'] = array('CRM/CRMInmobiliariaController', 'usuarioExistente');
$route['post']['/CRM/inmobiliaria/usuarios/administrar/:idUsuario'] = array('CRM/CRMInmobiliariaController', 'actualizarUsuarioExistente');

//CRM Agenda
$route['*']['/CRM/agenda/index'] = array('CRM/CRMAgendaController', 'index');
$route['*']['/CRM/agenda/hoy'] = array('CRM/CRMAgendaController', 'agendaDia');
$route['*']['/CRM/agenda/anteriores'] = array('CRM/CRMAgendaController', 'agendaPasadas');
$route['post']['/CRM/agenda/nueva'] = array('CRM/CRMAgendaController', 'actionNuevaEntrada');
$route['*']['/CRM/agenda/nueva'] = array('CRM/CRMAgendaController', 'formNuevaEntrada');
$route['*']['/CRM/agenda/edit'] = array('CRM/CRMAgendaController', 'edit');
$route['post']['/CRM/agenda/edit'] = array('CRM/CRMAgendaController', 'actionEdit');
$route['*']['/CRM/agenda/delete'] = array('CRM/CRMAgendaController', 'delete');
$route['*']['/CRM/agenda/detalle'] = array('CRM/CRMAgendaController', 'detalle');

//Agenda - Conexion google
$route['*']['/CRM/agenda/google'] = array('CRM/CRMAgendaController', 'connectGoogleAccount');
$route['*']['/CRM/agenda/google/disconnect'] = array('CRM/CRMAgendaController', 'disconnectGoogleAccount');


//CRM Inmuebles
$route['*']['/CRM/inmuebles'] = array('CRM/CRMInmuebleController', 'index');
$route['*']['/CRM/inmueble/:idInmueble'] = array('CRM/CRMInmuebleController', 'verInmueble');
$route['*']['/CRM/inmueble/subirFotos/:idInmueble'] = array('CRM/CRMInmuebleController', 'subirFotos');
$route['*']['/CRM/inmueble/eliminar/:idInmueble'] = array('CRM/CRMInmuebleController', 'eliminar');
$route['post']['/CRM/inmueble/actualizar/:idInmueble'] = array('CRM/CRMInmuebleController', 'actionModificarInmueble');
$route['*']['/CRM/inmueble/actualizar/:idInmueble'] = array('CRM/CRMInmuebleController', 'modificarInmueble');


//Registro de nuevo Inmueble
$route['post']['/CRM/inmuebles/nuevo'] = array('CRM/CRMInmuebleController', 'actionNuevoInmueble');
$route['*']['/CRM/inmuebles/nuevo'] = array('CRM/CRMInmuebleController', 'formNuevoInmueble');

//listar inmuebles
$route['*']['/CRM/inmuebles/listar'] = array('CRM/CRMInmuebleController', 'listar');
$route['*']['/CRM/inmuebles/listar/vendidos'] = array('CRM/CRMInmuebleController', 'listarVendidosRentados');
$route['*']['/CRM/inmuebles/listar/rentados'] = array('CRM/CRMInmuebleController', 'listarVendidosRentados');

//CRM Clientes
$route['*']['/CRM/clientes'] = array('CRM/CRMClienteController', 'index');
$route['post']['/CRM/clientes/nuevo'] = array('CRM/CRMClienteController', 'actionNuevoCliente');
$route['*']['/CRM/clientes/nuevo'] = array('CRM/CRMClienteController', 'nuevoCliente');
$route['*']['/CRM/clientes/buscar'] = array('CRM/CRMClienteController', 'buscarCliente');
$route['*']['/CRM/clientes/listar'] = array('CRM/CRMClienteController', 'listarCliente');
$route['*']['/CRM/cliente/:idCliente'] = array('CRM/CRMClienteController', 'perfilCliente');
$route['*']['/CRM/cliente/:idCliente/busca'] = array('CRM/CRMClienteController', 'clienteBusca');
$route['post']['/CRM/cliente/:idCliente/busca'] = array('CRM/CRMClienteController', 'actionClienteBusca');

//CRM mensajes
$route['*']['/CRM/inmobiliaria/mensajes'] = array('CRM/CRMInmobiliariaMensajesController', 'index');
$route['post']['/CRM/inmobiliaria/mensajes'] = array('CRM/CRMInmobiliariaMensajesController', 'eliminarMensajes');
$route['*']['/CRM/inmobiliaria/mensajes/crear'] = array('CRM/CRMInmobiliariaMensajesController', 'crear');
$route['post']['/CRM/inmobiliaria/mensajes/crear'] = array('CRM/CRMInmobiliariaMensajesController', 'actionEnviarMensaje');
$route['*']['/CRM/inmobiliaria/mensajes/enviados'] = array('CRM/CRMInmobiliariaMensajesController', 'enviados');
$route['post']['/CRM/inmobiliaria/mensajes/enviados'] = array('CRM/CRMInmobiliariaMensajesController', 'eliminarMensajesEnviados');
$route['post']['/CRM/inmobiliaria/mensajes/detalle'] = array('CRM/CRMInmobiliariaMensajesController', 'detalleResponder');
$route['*']['/CRM/inmobiliaria/mensajes/detalle'] = array('CRM/CRMInmobiliariaMensajesController', 'detalle');
$route['*']['/CRM/inmobiliaria/mensajes/detalleE'] = array('CRM/CRMInmobiliariaMensajesController', 'detalleEnviados');
$route['*']['/CRM/inmobiliaria/mensajes/json/:busqueda'] = array('CRM/CRMInmobiliariaMensajesController', 'cargarJson');

//CRM mensajes
$route['*']['/CRM/usuario/mensajes'] = array('CRM/CRMUsuarioMensajesController', 'index');
$route['post']['/CRM/usuario/mensajes'] = array('CRM/CRMUsuarioMensajesController', 'eliminarMensajes');
$route['*']['/CRM/usuario/mensajes/crear'] = array('CRM/CRMUsuarioMensajesController', 'crear');
$route['post']['/CRM/usuario/mensajes/crear'] = array('CRM/CRMUsuarioMensajesController', 'actionEnviarMensaje');
$route['*']['/CRM/usuario/mensajes/enviados'] = array('CRM/CRMUsuarioMensajesController', 'enviados');
$route['post']['/CRM/usuario/mensajes/enviados'] = array('CRM/CRMUsuarioMensajesController', 'eliminarMensajesEnviados');
$route['post']['/CRM/usuario/mensajes/detalle'] = array('CRM/CRMUsuarioMensajesController', 'detalleResponder');
$route['*']['/CRM/usuario/mensajes/detalle'] = array('CRM/CRMUsuarioMensajesController', 'detalle');
$route['*']['/CRM/usuario/mensajes/detalleE'] = array('CRM/CRMUsuarioMensajesController', 'detalleEnviados');
$route['*']['/CRM/usuario/mensajes/json/:busqueda'] = array('CRM/CRMUsuarioMensajesController', 'cargarJson');





//Pagina de búsqueda
$route['*']['/buscar'] = array('BuscadorController', 'index');
$route['*']['/buscar/mapa'] = array('BuscadorController', 'buscaMapa');
//buscar Perfil
$route['*']['/buscar/perfil'] = array('BuscadorController', 'buscaPerfil');



//Pagina de registro
$route['*']['/CRM/registro'] = array('CRM/CRMIndexController', 'registro');
$route['post']['/CRM/action/registrar'] = array('CRM/CRMIndexController', 'registroAction');
$route['*']['/CRM/registro/inmobiliaria'] = array('CRM/CRMIndexController', 'registroInmobiliaria');
$route['*']['/CRM/action/registrar/inmobiliaria'] = array('CRM/CRMIndexController', 'registroInmobiliariaAction');


//Pagina de error
$route['*']['/error'] = array('ErrorController', 'index');

//Páginas de informacion
$route['*']['/acerca'] = array('InformacionController', 'acerca');
$route['*']['/experiencia'] = array('InformacionController', 'experiencia');
$route['*']['/mobile'] = array('InformacionController', 'mobile');
$route['*']['/contacto'] = array('InformacionController', 'contacto');


//API
$route['*']['/api/maps/markers.js'] = array('API/MarkersController', 'listadoInmuebles');
$route['*']['/api/maps/:identificador/markers.js'] = array('API/MarkersController', 'listadoInmueblesInmobiliaria');


/*
//---------- Delete if not needed ------------
$admin = array('admin'=>'1234');

//view the logs and profiles XML, filename = db.profile, log, trace.log, profile
$route['*']['/debug/:filename'] = array('MainController', 'debug', 'authName'=>'DooPHP Admin', 'auth'=>$admin, 'authFail'=>'Unauthorized!');

//show all urls in app
$route['*']['/allurl'] = array('MainController', 'allurl', 'authName'=>'DooPHP Admin', 'auth'=>$admin, 'authFail'=>'Unauthorized!');

//generate routes file. This replace the current routes.conf.php. Use with the sitemap tool.
$route['post']['/gen_sitemap'] = array('MainController', 'gen_sitemap', 'authName'=>'DooPHP Admin', 'auth'=>$admin, 'authFail'=>'Unauthorized!');

//generate routes & controllers. Use with the sitemap tool.
$route['post']['/gen_sitemap_controller'] = array('MainController', 'gen_sitemap_controller', 'authName'=>'DooPHP Admin', 'auth'=>$admin, 'authFail'=>'Unauthorized!');

//generate Controllers automatically
$route['*']['/gen_site'] = array('MainController', 'gen_site', 'authName'=>'DooPHP Admin', 'auth'=>$admin, 'authFail'=>'Unauthorized!');

//generate Models automatically
$route['*']['/gen_model'] = array('MainController', 'gen_model', 'authName'=>'DooPHP Admin', 'auth'=>$admin, 'authFail'=>'Unauthorized!');

*/
?>
