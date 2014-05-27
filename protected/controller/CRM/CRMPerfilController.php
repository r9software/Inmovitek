<?php

class CRMPerfilController extends DooController {

	public function index() {
		Doo::loadController('CRM/seguridad/seguridadController');

		if (!seguridadController::validaSesion()) {
			header('location:' . Doo::conf() -> APP_URL . 'CRM/?access=denied');
			exit ;
		}
		Doo::loadModel('usuario');
		Doo::loadModel('permisosUsuario');
		Doo::loadModel('inmobiliaria');
		Doo::loadModel('licencia');
		$session = Doo::session(Doo::conf() -> APP_NAME, "user");
		//Solicitamos los datos de usuario y sus permisos del usuario
		$this -> data['usuario'] = seguridadController::getUsuario($session);
		$this -> data['permisos'] = seguridadController::getPermisos($session);

		if ($this -> data['usuario'] == null || $this -> data['permisos'] == null) {
			echo '<h1>Ups. Algo salio mal.</h1><br>Un grupo de excentricos programadores trabaja en solucionar el problema.';
			exit ;
		}
		if ($this -> data['usuario'] -> id_inmobiliaria != null && $this -> data['usuario'] -> id_inmobiliaria != "") {
			$inmobiliaria = new inmobiliaria();
			$inmobiliaria -> id_inmobiliaria = $this -> data['usuario'] -> id_inmobiliaria;
			$inmobiliaria = $this -> db() -> find($inmobiliaria, array('limit' => 1));
			if ($inmobiliaria != null) {
				$this -> data['inmobiliaria'] = $inmobiliaria;
				$licencia = new licencia();
				$licencia -> licencia = $inmobiliaria -> licencia;
				$licencia = $this -> db() -> find($licencia, array('limit' => 1));
				$this -> data['licencia'] = $licencia;
			}
		}
		$this -> renderc('CRM/perfil/principal', $this -> data);
	}

	public function edit() {
		Doo::loadController('CRM/seguridad/seguridadController');
		if (!seguridadController::validaSesion()) {
			header('location:' . Doo::conf() -> APP_URL . 'CRM/?access=denied');
			exit ;
		}
		Doo::loadModel('usuario');
		Doo::loadModel('permisosUsuario');
		$session = Doo::session(Doo::conf() -> APP_NAME, "user");
		//Solicitamos los datos de usuario y sus permisos del usuario
		$this -> data['usuario'] = seguridadController::getUsuario($session);
		$this -> data['permisos'] = seguridadController::getPermisos($session);

		if ($this -> data['usuario'] == null || $this -> data['permisos'] == null) {
			echo '<h1>Ups. Algo salio mal.</h1><br>Un grupo de excentricos programadores trabaja en solucionar el problema.';
			exit ;
		}
		$this -> renderc('CRM/perfil/edit', $this -> data);
	}

	public function editAction() {
		Doo::loadModel('usuario');
		Doo::loadModel('permisosUsuario');
		Doo::loadController('CRM/seguridad/seguridadController');
		if (!seguridadController::validaSesion()) {
			header('location:' . Doo::conf() -> APP_URL . 'CRM/?access=denied');
			exit ;
		}
		$session = Doo::session(Doo::conf() -> APP_NAME, "user");
		//Solicitamos los datos de usuario y sus permisos del usuario
		$usuario = seguridadController::getUsuario();
		foreach ($_POST as $key => $value) {
			//echo $key .'=>'.$value;
			$this -> data[$key] = strip_tags(stripslashes($value));
		}
		$usuario -> nombres = $this -> data['nombre'];
		$usuario -> apellido_p = $this -> data['apaterno'];
		$usuario -> apellido_m = $this -> data['amaterno'];
		$array_replace = array(" ", "-", "_", "(", ")", "#");
		$usuario -> telefono_casa = str_replace($array_replace, "", strip_tags($this -> data['telfijo']));
		$usuario -> telefono_celular = str_replace($array_replace, "", strip_tags($this -> data['celular']));
		$usuario -> update();
		//Actualziamos el registro del ususario
		header('location:' . Doo::conf() -> APP_URL . 'CRM/perfil/edit?update=success');
	}

	public function changePass() {
		Doo::loadController('CRM/seguridad/seguridadController');
		if (!seguridadController::validaSesion()) {
			header('location:' . Doo::conf() -> APP_URL . 'CRM/?access=denied');
			exit ;
		}
		Doo::loadModel('usuario');
		Doo::loadModel('permisosUsuario');
		$session = Doo::session(Doo::conf() -> APP_NAME, "user");
		//Solicitamos los datos de usuario y sus permisos del usuario
		$this -> data['usuario'] = seguridadController::getUsuario($session);
		$this -> data['permisos'] = seguridadController::getPermisos($session);

		if ($this -> data['usuario'] == null || $this -> data['permisos'] == null) {
			echo '<h1>Ups. Algo salio mal.</h1><br>Un grupo de excentricos programadores trabaja en solucionar el problema.';
			exit ;
		}
		$this -> renderc('CRM/perfil/password', $this -> data);
	}

}
?>