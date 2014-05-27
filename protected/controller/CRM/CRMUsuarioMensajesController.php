<?php

class CRMUsuarioMensajesController extends DooController {

    public function index() {
        Doo::loadController('CRM/seguridad/seguridadController');
        if (!seguridadController::validaSesion()) {
            header('location:' . Doo::conf()->APP_URL . 'CRM/?access=denied');
            exit;
        }
        Doo::loadModel('usuario');
        Doo::loadModel('permisosUsuario');
        Doo::loadModel('mensajeUsuario');
        Doo::loadModel('inmobiliaria');
		$this->data['tipo'] = "usuario";
        $session = Doo::session(Doo::conf()->APP_NAME, "user");
        //Solicitamos los datos de usuario y sus permisos del usuario
        $this->data['usuario'] = seguridadController::getUsuario($session);
        $this->data['permisos'] = seguridadController::getPermisos($session);

        if ($this->data['usuario'] == null || $this->data['permisos'] == null) {
            echo '<h1>Ups. Algo salio mal.</h1><br>Un grupo de excentricos programadores trabaja en solucionar el problema.';
            exit;
        }
        $mensajeInmobiliaria = new mensajeUsuario();
        $mensajeInmobiliaria->id_usuario_receptor = $this->data['usuario']->id_usuario;
        $mensajeInmobiliaria=$mensajeInmobiliaria->relate("usuario",array("where" => "status_receptor !=0"));
    	for($x=0;$x<count($mensajeInmobiliaria);$x++)
    	{
    		 $temp=$mensajeInmobiliaria[$x]->usuario->correo;
    		 $var=explode('@',$temp);
    		 $mensajeInmobiliaria[$x]->usuario->correo=$var[0]." @".$var[1];
    		 
    		 
    	}
        if ($mensajeInmobiliaria != null) {
            $this->data['mensajeInmobiliaria'] = $mensajeInmobiliaria;
            
        }

        $this->renderc('CRM/mensajes/mensajes', $this->data);
    }
    
    
    
    public function eliminarMensajes() {
        Doo::loadController('CRM/seguridad/seguridadController');
        if(!seguridadController::validaSesion()){
            header('location:' . Doo::conf() -> APP_URL . 'CRM/?access=denied');
            exit;
        }
        Doo::loadModel('usuario');
        Doo::loadModel('permisosUsuario');
        Doo::loadModel('mensajeUsuario');
        $this->data['tipo'] = "usuario";
        $session = Doo::session(Doo::conf()->APP_NAME,"user");
        //Solicitamos los datos de usuario y sus permisos del usuario
        $this->data['usuario'] = seguridadController::getUsuario($session);
        $this->data['permisos'] = seguridadController::getPermisos($session);

        if($this->data['usuario']==null || $this->data['permisos']==null){
            echo '<h1>Ups. Algo salio mal.</h1><br>Un grupo de excentricos programadores trabaja en solucionar el problema.';
            exit;
        }
        $valor="";
        foreach ($_POST as $key => $value) {
           if($key=='mensajes')
               $valor=$value;
        }
            $var=explode(" ",$valor);
            for($x=0;$x<count($var);$x++){
                $mensajeinmobiliaria = new mensajeUsuario();
                $mensajeinmobiliaria -> id_usuario_receptor= $this->data['usuario']->id_usuario;
                $entero=(int)$var[$x];
                        if(is_int($entero)){
                            $mensajeinmobiliaria = $this -> db() -> find($mensajeinmobiliaria,array("where" => "id_mensaje =".$var[$x]));
                            if ($mensajeinmobiliaria != null) {
                                $mensajeinmobiliaria[0]->status_receptor=0;
                                $mensajeinmobiliaria[0]->update();
                                $bandera=true;
                                }
                            else{
                               header('location:' . Doo::conf()->APP_URL . 'CRM/usuario/mensajes?delete=url');
                               
                            }
                        
                            }
                         else{
                             header('location:' . Doo::conf()->APP_URL . 'CRM/usuario/mensajes?delete=error');
                         }
                    }
                    if($bandera)
                       header('location:' . Doo::conf()->APP_URL . 'CRM/usuario/mensajes?delete=success');
            
           
                    
   }
   public function eliminarMensajesEnviados() {
        Doo::loadController('CRM/seguridad/seguridadController');
        if(!seguridadController::validaSesion()){
            header('location:' . Doo::conf() -> APP_URL . 'CRM/?access=denied');
            exit;
        }
        Doo::loadModel('usuario');
        Doo::loadModel('permisosUsuario');
        Doo::loadModel('mensajeUsuario');
        $this->data['tipo'] = "usuario";
        $session = Doo::session(Doo::conf()->APP_NAME,"user");
        //Solicitamos los datos de usuario y sus permisos del usuario
        $this->data['usuario'] = seguridadController::getUsuario($session);
        $this->data['permisos'] = seguridadController::getPermisos($session);

        if($this->data['usuario']==null || $this->data['permisos']==null){
            echo '<h1>Ups. Algo salio mal.</h1><br>Un grupo de excentricos programadores trabaja en solucionar el problema.';
            exit;
        }
        $valor="";
        foreach ($_POST as $key => $value) {
           if($key=='mensajes')
               $valor=$value;
        }
            $var=explode(" ",$valor);
            for($x=0;$x<count($var);$x++){
                $mensajeinmobiliaria = new mensajeUsuario();
                $mensajeinmobiliaria -> id_usuario_emisor= $this->data['usuario']->id_usuario;
                $entero=(int)$var[$x];
                        if(is_int($entero)){
                            $mensajeinmobiliaria = $this -> db() -> find($mensajeinmobiliaria,array("where" => "id_mensaje =".$var[$x]));
                            if ($mensajeinmobiliaria != null) {
                                $mensajeinmobiliaria[0]->status_emisor=0;
                                $mensajeinmobiliaria[0]->update();
                                $bandera=true;
                                }
                            else{
                               header('location:' . Doo::conf()->APP_URL . 'CRM/usuario/mensajes?delete=url');
                               
                            }
                        
                            }
                         else{
                             header('location:' . Doo::conf()->APP_URL . 'CRM/usuario/mensajes?delete=error');
                         }
                    }
                    if($bandera)
                       header('location:' . Doo::conf()->APP_URL . 'CRM/usuario/mensajes?delete=success');
            
           
                    
   }

    public function crear() {
        Doo::loadController('CRM/seguridad/seguridadController');
        if (!seguridadController::validaSesion()) {
            header('location:' . Doo::conf()->APP_URL . 'CRM/?access=denied');
            exit;
        }
        Doo::loadModel('usuario');
        Doo::loadModel('permisosUsuario');
        Doo::loadModel('mensajeUsuario');
        Doo::loadModel('inmobiliaria');

        $session = Doo::session(Doo::conf()->APP_NAME, "user");
        //Solicitamos los datos de usuario y sus permisos del usuario
        $this->data['usuario'] = seguridadController::getUsuario($session);
        $this->data['permisos'] = seguridadController::getPermisos($session);
        $this->data['tipo'] = "usuario";
        

        if ($this->data['usuario'] == null || $this->data['permisos'] == null) {
            echo '<h1>Ups. Algo salio mal.</h1><br>Un grupo de excentricos programadores trabaja en solucionar el problema.';
            exit;
        }
        $this->renderc('CRM/mensajes/mensajeNuevo', $this->data);
    }
public function cargarJson() {
        Doo::loadController('CRM/seguridad/seguridadController');
        if (!seguridadController::validaSesion()) {
            header('location:' . Doo::conf()->APP_URL . 'CRM/?access=denied');
            exit;
        }
        Doo::loadModel('usuario');
        Doo::loadModel('permisosUsuario');
        Doo::loadModel('mensajeUsuario');

        $session = Doo::session(Doo::conf()->APP_NAME, "user");
        //Solicitamos los datos de usuario y sus permisos del usuario
        $this->data['usuario'] = seguridadController::getUsuario($session);
        $this->data['permisos'] = seguridadController::getPermisos($session);
        $this->data['tipo'] = "usuario";

        if ($this->data['usuario'] == null || $this->data['permisos'] == null) {
            echo '<h1>Ups. Algo salio mal.</h1><br>Un grupo de excentricos programadores trabaja en solucionar el problema.';
            exit;
        }
         $busqueda = strip_tags(htmlentities($this->params['busqueda']));
         $usuario= new usuario();
         $usuario = $this -> db() ->  find($usuario,array("where" => "correo LIKE '%".$busqueda."%'"));
		    if ($usuario != null) {
		            $this->data['emailUsuario'] = $usuario;
		        }
		     
        $this->renderc('CRM/mensajes/jsonUsuario', $this->data);
    }
    public function actionEnviarMensaje() {
        Doo::loadModel('mensajeUsuario');

        Doo::autoload('DooDbExpression');

        Doo::loadController('CRM/seguridad/seguridadController');
        if (!seguridadController::validaSesion()) {
            header('location:' . Doo::conf()->APP_URL . 'CRM/?access=denied');
            exit;
        }
        Doo::loadModel('usuario');
        Doo::loadModel('permisosUsuario');
        Doo::loadModel('limiteUsuario');
        $this->data['tipo'] = "usuario";
        $session = Doo::session(Doo::conf()->APP_NAME, "user");
        //Solicitamos los datos de usuario y sus permisos del usuario
        $this->data['usuario'] = seguridadController::getUsuario($session);
        $this->data['permisos'] = seguridadController::getPermisos($session);

        if ($this->data['usuario'] == null || $this->data['permisos'] == null) {
            echo '<h1>Ups. Algo salio mal.</h1><br>Un grupo de excentricos programadores trabaja en solucionar el problema.';
            exit;
        }

        $bandera = false; //Valida si se recibieron todos los datos del formulario
        $datos = "";
        foreach ($_POST as $key => $value) {
            if ($key != 'mensaje' && ($value == null || $value == "")) {
                $bandera = true; // No se recibioern todos los datos
            }
            $this->data[$key] = stripslashes(strip_tags($value));
            $datos .= '&' . $key . '=' . $value;
        }
        if ($bandera) {
            $datos .= '&error=incompleto';
            //No se recibio completo el formulario, volvemos a solicitar los datos
            header('location:' . Doo::conf()->APP_URL . 'CRM/usuario/mensajes/crear?' . $datos);
            exit;
        } else {
			$usuario= new usuario();
			$usuario->correo=$this->data['nombre'];
			$usuario=$this -> db() -> find($usuario,array("where" => "correo='" . $this->data['nombre']."'"));
			

            $mensajeInmobiliaria = new mensajeUsuario();
            $mensajeInmobiliaria->asunto= $this->data['asunto'];
            $mensajeInmobiliaria->mensaje = $this->data['mensaje'];
            $mensajeInmobiliaria->fecha = new DooDbExpression('NOW()');
            $mensajeInmobiliaria->id_usuario_emisor= $this->data['usuario']->id_usuario;
            $mensajeInmobiliaria->leido=0;
            $mensajeInmobiliaria->id_usuario_receptor=  $usuario[0]->id_usuario;
            $mensajeInmobiliaria->status_emisor=1;
            $mensajeInmobiliaria->status_receptor=1;
            
            $mensajeInmobiliaria->insert();
            header('location:' . Doo::conf()->APP_URL . 'CRM/usuario/mensajes/crear?registro=success');
            
        }
    }
    public function detalleResponder() {
         Doo::loadModel('mensajeUsuario');

        Doo::autoload('DooDbExpression');

        Doo::loadController('CRM/seguridad/seguridadController');
        if (!seguridadController::validaSesion()) {
            header('location:' . Doo::conf()->APP_URL . 'CRM/?access=denied');
            exit;
        }
        Doo::loadModel('usuario');
        Doo::loadModel('permisosUsuario');
        Doo::loadModel('limiteUsuario');
        $this->data['tipo'] = "usuario";
        $session = Doo::session(Doo::conf()->APP_NAME, "user");
        //Solicitamos los datos de usuario y sus permisos del usuario
        $this->data['usuario'] = seguridadController::getUsuario($session);
        $this->data['permisos'] = seguridadController::getPermisos($session);

        if ($this->data['usuario'] == null || $this->data['permisos'] == null) {
            echo '<h1>Ups. Algo salio mal.</h1><br>Un grupo de excentricos programadores trabaja en solucionar el problema.';
            exit;
        }

        $bandera = false; //Valida si se recibieron todos los datos del formulario
        $datos = "";
        foreach ($_POST as $key => $value) {
            if ($key != 'mensaje' && ($value == null || $value == "")) {
                $bandera = true; // No se recibioern todos los datos
            }
            $this->data[$key] = stripslashes(strip_tags($value));
            $datos .= '&' . $key . '=' . $value;
        }
        if ($bandera) {
            $datos .= '&error=incompleto';
            //No se recibio completo el formulario, volvemos a solicitar los datos
            header('location:' . Doo::conf()->APP_URL . 'CRM/usuario/mensajes/crear?' . $datos);
            exit;
        } else {
			$usuario= new usuario();
			$usuario->correo=$this->data['nombre'];
			$usuario=$this -> db() -> find($usuario,array("where" => "correo='" . $this->data['nombre']."'"));
			$mensajeInmobiliaria = new mensajeUsuario();
            $mensajeInmobiliaria->asunto= $this->data['asunto'];
            $mensajeInmobiliaria->mensaje = $this->data['mensaje'];
            $mensajeInmobiliaria->fecha = new DooDbExpression('NOW()');
            $mensajeInmobiliaria->id_usuario_emisor= $this->data['usuario']->id_usuario;
            $mensajeInmobiliaria->leido=0;
            $mensajeInmobiliaria->id_usuario_receptor= $usuario[0]->id_usuario;
            $mensajeInmobiliaria->status_emisor=1;
            $mensajeInmobiliaria->status_receptor=1;
            
            $mensajeInmobiliaria->insert();
            header('location:' . Doo::conf()->APP_URL . 'CRM/usuario/mensajes/crear?registro=success');
        }
        
    }
    public function detalleEnviados() {
         Doo::autoload('DooDbExpression');

        Doo::loadController('CRM/seguridad/seguridadController');
        if(!seguridadController::validaSesion()){
            header('location:' . Doo::conf() -> APP_URL . 'CRM/?access=denied');
            exit;
        }
        Doo::loadModel('usuario');
        Doo::loadModel('permisosUsuario');
        Doo::loadModel('mensajeUsuario');
        $this->data['tipo'] = "usuario";
        $session = Doo::session(Doo::conf()->APP_NAME,"user");
        //Solicitamos los datos de usuario y sus permisos del usuario
        $this->data['usuario'] = seguridadController::getUsuario($session);
        $this->data['permisos'] = seguridadController::getPermisos($session);

        if($this->data['usuario']==null || $this->data['permisos']==null){
            echo '<h1>Ups. Algo salio mal.</h1><br>Un grupo de excentricos programadores trabaja en solucionar el problema.';
            exit;
        }
        	
        
        if(isset($_GET['id']))
            {
            
            $var=(int)$_GET['id'];
            $mensajeInmobiliaria = new mensajeUsuario();
	        $mensajeInmobiliaria=$this -> db() -> find($mensajeInmobiliaria,array("where" => "id_mensaje =".$var));
	        $temp=$mensajeInmobiliaria[0] -> id_usuario_receptor;
	        $usuarioInfo = new usuario();
			//$mensajeInmobiliaria -> id_usuario_receptor = $temp;
			$usuarioInfo->id_usuario=$temp;
	        $usuarioInfo=$this -> db() -> find($usuarioInfo);
            $this->data['mensajeInmobiliaria'] = $mensajeInmobiliaria;
            $this->data['usuarioInfo'] = $usuarioInfo;
            }
        else {
            header('location:' . Doo::conf()->APP_URL . 'CRM/usuario/mensajes?error=mensaje');
            }
        
        $this->renderc('CRM/mensajes/detalleEnviados',$this->data);

    }
    
    public function detalle() {
        Doo::autoload('DooDbExpression');

        Doo::loadController('CRM/seguridad/seguridadController');
        if(!seguridadController::validaSesion()){
            header('location:' . Doo::conf() -> APP_URL . 'CRM/?access=denied');
            exit;
        }
        Doo::loadModel('usuario');
        Doo::loadModel('permisosUsuario');
        Doo::loadModel('mensajeUsuario');
        $this->data['tipo'] = "usuario";
        $session = Doo::session(Doo::conf()->APP_NAME,"user");
        //Solicitamos los datos de usuario y sus permisos del usuario
        $this->data['usuario'] = seguridadController::getUsuario($session);
        $this->data['permisos'] = seguridadController::getPermisos($session);

        if($this->data['usuario']==null || $this->data['permisos']==null){
            echo '<h1>Ups. Algo salio mal.</h1><br>Un grupo de excentricos programadores trabaja en solucionar el problema.';
            exit;
        }
        $mensajeInmobiliaria = new mensajeUsuario();
        $mensajeInmobiliaria -> id_usuario_receptor = $this -> data['usuario'] -> id_usuario;
        
        if(isset($_GET['id']))
            {
            
            $var=(int)$_GET['id'];
            $mensajeInmobiliaria = $this -> db() -> find($mensajeInmobiliaria,array("where" => "id_mensaje =".$var));
            if ($mensajeInmobiliaria != null) {
                $mensajeInmobiliaria[0]->fecha_leido= new DooDbExpression('NOW()');
                $mensajeInmobiliaria[0]->leido=1;
                $mensajeInmobiliaria[0]->update();
            }
            
            else{
               header('location:' . Doo::conf()->APP_URL . 'CRM/usuario/mensajes?error=mensaje'); 
                }
                $mensajeInmobiliaria = new mensajeUsuario();
                $mensajeInmobiliaria=$mensajeInmobiliaria->relate("usuario",array("where" => "id_mensaje =".$var));
                $this -> data['mensajeInmobiliaria'] = $mensajeInmobiliaria;
            }
        else {
            header('location:' . Doo::conf()->APP_URL . 'CRM/usuario/mensajes?error=mensaje');
            }
        
        $this->renderc('CRM/mensajes/detalle',$this->data);

    }
    public function Enviados() {
        Doo::loadController('CRM/seguridad/seguridadController');
        if (!seguridadController::validaSesion()) {
            header('location:' . Doo::conf()->APP_URL . 'CRM/?access=denied');
            exit;
        }
        Doo::loadModel('usuario');
        Doo::loadModel('permisosUsuario');
        Doo::loadModel('mensajeUsuario');
        Doo::loadModel('inmobiliaria');
		$this->data['tipo'] = "usuario";
        $session = Doo::session(Doo::conf()->APP_NAME, "user");
        //Solicitamos los datos de usuario y sus permisos del usuario
        $this->data['usuario'] = seguridadController::getUsuario($session);
        $this->data['permisos'] = seguridadController::getPermisos($session);

        if ($this->data['usuario'] == null || $this->data['permisos'] == null) {
            echo '<h1>Ups. Algo salio mal.</h1><br>Un grupo de excentricos programadores trabaja en solucionar el problema.';
            exit;
        }
        $usuarioInfo = new usuario();
        $correos= array();
        $mensajeInmobiliaria = new mensajeUsuario();
        $mensajeInmobiliaria->id_usuario_emisor = $this->data['usuario']->id_usuario;
        $mensajeInmobiliaria=$this -> db() -> find($mensajeInmobiliaria,array("where" => "status_emisor !=0"));
		
        if ($mensajeInmobiliaria != null) {
            for($x=0; $x<count($mensajeInmobiliaria); $x++)
            {
            	$usuarioInfo = new usuario();
            	$usuarioInfo->id_usuario=$mensajeInmobiliaria[$x]->id_usuario_receptor;
            	$usuarioInfo=$this -> db() -> find($usuarioInfo);
            	$correos[$x]=$usuarioInfo[0]->correo;
            }
            $this->data['mensajeInmobiliaria'] = $mensajeInmobiliaria;
            
            $this->data['correos'] = $correos;
        }

        $this->renderc('CRM/mensajes/enviados', $this->data);
    }

}

?>