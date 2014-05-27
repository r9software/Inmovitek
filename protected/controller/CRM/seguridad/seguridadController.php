<?php
class SeguridadController{
	
	public static function validaSesion(){
		Doo::loadClass('token');
		$session = Doo::session(Doo::conf()->APP_NAME,"user");
		if($session -> get('IDusuario')==null || $session -> get('TKN')==null ){//Verificamos que este logueado
			$session -> destroy(); //No esta logueado, denegamos el acceso
			return FALSE;
		}else if(!( $session -> get('TKN') -> validaToken($session -> get('IDusuario') ) )){
			$session -> destroy(); //No paso la autenticación, posible intento de hackeo
			return FALSE;
		}else{
			return TRUE;
		}
	}
	
	
	public static function getUsuario(){
		Doo::loadModel('usuario');
		$session = Doo::session(Doo::conf()->APP_NAME,"user");
		$usuario = new usuario();
		$usuario->id_usuario = $session -> get('IDusuario');
		$usuario = Doo::db()->find($usuario,array('limit' => 1));
		return $usuario;
	}
	
	public static function getPermisos(){
		Doo::loadModel('usuario');
		$session = Doo::session(Doo::conf()->APP_NAME,"user");
		$permisos = new permisosUsuario(); 
		$permisos->id_usuario = $session -> get('IDusuario');
		$permisos = Doo::db()->find($permisos,array('limit' => 1));
		return $permisos; 
	}
}
?>