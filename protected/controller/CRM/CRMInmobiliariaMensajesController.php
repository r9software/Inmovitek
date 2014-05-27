<?php

class CRMInmobiliariaMensajesController extends DooController {

public function index() {
        Doo::loadController('CRM/seguridad/seguridadController');
        if (!seguridadController::validaSesion()) {
            header('location:' . Doo::conf()->APP_URL . 'CRM/?access=denied');
            exit;
        }
        Doo::loadModel('usuario');
        Doo::loadModel('permisosUsuario');
        Doo::loadModel('mensajeInmobiliaria');
        Doo::loadModel('inmobiliaria');
		$this->data['tipo'] = "inmobiliaria";
        $session = Doo::session(Doo::conf()->APP_NAME, "user");
        //Solicitamos los datos de usuario y sus permisos del usuario
        $this->data['usuario'] = seguridadController::getUsuario($session);
        $this->data['permisos'] = seguridadController::getPermisos($session);

        if ($this->data['usuario'] == null || $this->data['permisos'] == null) {
            echo '<h1>Ups. Algo salio mal.</h1><br>Un grupo de excentricos programadores trabaja en solucionar el problema.';
            exit;
        }
        $mensajeInmobiliaria = new mensajeInmobiliaria();
        $mensajeInmobiliaria->id_inmobiliaria_receptor = $this->data['usuario']->id_inmobiliaria;
        $mensajeInmobiliaria=$mensajeInmobiliaria->relate("inmobiliaria",array("where" => "status_receptor !=0"));
    	
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
        Doo::loadModel('mensajeInmobiliaria');
        $session = Doo::session(Doo::conf()->APP_NAME,"user");
        //Solicitamos los datos de usuario y sus permisos del usuario
        $this->data['usuario'] = seguridadController::getUsuario($session);
        $this->data['permisos'] = seguridadController::getPermisos($session);
		 $this->data['tipo'] = "inmobiliaria";
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
                $mensajeinmobiliaria = new mensajeInmobiliaria();
                $mensajeinmobiliaria -> id_inmobiliaria_receptor= $this->data['usuario']->id_inmobiliaria;
                $entero=(int)$var[$x];
                        if(is_int($entero)){
                            $mensajeinmobiliaria = $this -> db() -> find($mensajeinmobiliaria,array("where" => "id_mensaje =".$var[$x]));
                            if ($mensajeinmobiliaria != null) {
                                $mensajeinmobiliaria[0]->status_receptor=0;
                                $mensajeinmobiliaria[0]->update();
                                $bandera=true;
                                }
                            else{
                               header('location:' . Doo::conf()->APP_URL . 'CRM/inmobiliaria/mensajes?delete=url');
                               
                            }
                        
                            }
                         else{
                             header('location:' . Doo::conf()->APP_URL . 'CRM/inmobiliaria/mensajes?delete=error');
                         }
                    }
                    if($bandera)
                       header('location:' . Doo::conf()->APP_URL . 'CRM/inmobiliaria/mensajes?delete=success');
            
           
                    
   }
   public function eliminarMensajesEnviados() {
        Doo::loadController('CRM/seguridad/seguridadController');
        if(!seguridadController::validaSesion()){
            header('location:' . Doo::conf() -> APP_URL . 'CRM/?access=denied');
            exit;
        }
        Doo::loadModel('usuario');
        Doo::loadModel('permisosUsuario');
        Doo::loadModel('mensajeInmobiliaria');
        $session = Doo::session(Doo::conf()->APP_NAME,"user");
        //Solicitamos los datos de usuario y sus permisos del usuario
        $this->data['usuario'] = seguridadController::getUsuario($session);
        $this->data['permisos'] = seguridadController::getPermisos($session);
		 $this->data['tipo'] = "inmobiliaria";
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
                $mensajeinmobiliaria = new mensajeInmobiliaria();
                $mensajeinmobiliaria -> id_inmobiliaria_emisor= $this->data['usuario']->id_inmobiliaria;
                $entero=(int)$var[$x];
                        if(is_int($entero)){
                            $mensajeinmobiliaria = $this -> db() -> find($mensajeinmobiliaria,array("where" => "id_mensaje =".$var[$x]));
                            if ($mensajeinmobiliaria != null) {
                                $mensajeinmobiliaria[0]->status_emisor=0;
                                $mensajeinmobiliaria[0]->update();
                                $bandera=true;
                                }
                            else{
                               header('location:' . Doo::conf()->APP_URL . 'CRM/inmobiliaria/mensajes?delete=url');
                               
                            }
                        
                            }
                         else{
                             header('location:' . Doo::conf()->APP_URL . 'CRM/inmobiliaria/mensajes?delete=error');
                         }
                    }
                    if($bandera)
                       header('location:' . Doo::conf()->APP_URL . 'CRM/inmobiliaria/mensajes?delete=success');
            
           
                    
   }

    public function crear() {
        Doo::loadController('CRM/seguridad/seguridadController');
        if (!seguridadController::validaSesion()) {
            header('location:' . Doo::conf()->APP_URL . 'CRM/?access=denied');
            exit;
        }
        Doo::loadModel('usuario');
        Doo::loadModel('permisosUsuario');
        Doo::loadModel('mensajeInmobiliaria');
        Doo::loadModel('inmobiliaria');
		 $this->data['tipo'] = "inmobiliaria";
        $session = Doo::session(Doo::conf()->APP_NAME, "user");
        //Solicitamos los datos de usuario y sus permisos del usuario
        $this->data['usuario'] = seguridadController::getUsuario($session);
        $this->data['permisos'] = seguridadController::getPermisos($session);
        $this->data['tipo'] = "inmobiliaria";

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
        Doo::loadModel('mensajeInmobiliaria');
        Doo::loadModel('inmobiliaria');

        $session = Doo::session(Doo::conf()->APP_NAME, "user");
        //Solicitamos los datos de usuario y sus permisos del usuario
        $this->data['usuario'] = seguridadController::getUsuario($session);
        $this->data['permisos'] = seguridadController::getPermisos($session);
        $this->data['tipo'] = "inmobiliaria";

        if ($this->data['usuario'] == null || $this->data['permisos'] == null) {
            echo '<h1>Ups. Algo salio mal.</h1><br>Un grupo de excentricos programadores trabaja en solucionar el problema.';
            exit;
        }
         $busqueda = strip_tags(htmlentities($this->params['busqueda']));
         $inmobiliaria= new inmobiliaria();
         $inmobiliaria = $this -> db() ->  find($inmobiliaria,array("where" => "nombre LIKE '%".$busqueda."%'"));
		    if ($inmobiliaria != null) {
		            $this->data['nombreInmobiliaria'] = $inmobiliaria;
		        }
		     
        $this->renderc('CRM/mensajes/json', $this->data);
    }

    public function actionEnviarMensaje() {
        Doo::loadModel('mensajeInmobiliaria');

        Doo::autoload('DooDbExpression');

        Doo::loadController('CRM/seguridad/seguridadController');
        if (!seguridadController::validaSesion()) {
            header('location:' . Doo::conf()->APP_URL . 'CRM/?access=denied');
            exit;
        }
        Doo::loadModel('inmobiliaria');
        Doo::loadModel('permisosUsuario');
        Doo::loadModel('limiteUsuario');
         $this->data['tipo'] = "inmobiliaria";
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
            header('location:' . Doo::conf()->APP_URL . 'CRM/inmobiliaria/mensajes/crear?' . $datos);
            exit;
        } else {

            $query = "SELECT id_inmobiliaria from ct_inmobiliaria where nombre='" . $this->data['nombre']."'";
            $rs = $this->db()->query($query);
            $array = $rs->fetchAll();

            if(isset($array[0]))
            {
			$inmobiliaria= new inmobiliaria();
			$inmobiliaria->nombre=$this->data['nombre'];
			$inmobiliaria=$this -> db() -> find($inmobiliaria,array("where" => "nombre='" . $this->data['nombre']."'"));
			
            $mensajeInmobiliaria = new mensajeInmobiliaria();
            $mensajeInmobiliaria->asunto= $this->data['asunto'];
            $mensajeInmobiliaria->mensaje = $this->data['mensaje'];
            $mensajeInmobiliaria->fecha = new DooDbExpression('NOW()');
            $mensajeInmobiliaria->id_inmobiliaria_emisor= $this->data['usuario']->id_inmobiliaria;
            $mensajeInmobiliaria->leido=0;
            $mensajeInmobiliaria->id_inmobiliaria_receptor= $inmobiliaria[0]->id_inmobiliaria;
            $mensajeInmobiliaria->status_emisor=1;
            $mensajeInmobiliaria->status_receptor=1;
            
            $mensajeInmobiliaria->insert();
            header('location:' . Doo::conf()->APP_URL . 'CRM/inmobiliaria/mensajes/crear?registro=success');
            }
            else {
                $datos .= '&inmobiliaria=error';
                header('location:' . Doo::conf()->APP_URL . 'CRM/inmobiliaria/mensajes/crear?' . $datos);
            }
        }
    }
    public function detalleResponder() {
         Doo::loadModel('mensajeInmobiliaria');

        Doo::autoload('DooDbExpression');

        Doo::loadController('CRM/seguridad/seguridadController');
        if (!seguridadController::validaSesion()) {
            header('location:' . Doo::conf()->APP_URL . 'CRM/?access=denied');
            exit;
        }
        Doo::loadModel('inmobiliaria');
        Doo::loadModel('permisosUsuario');
        Doo::loadModel('limiteUsuario');
         $this->data['tipo'] = "inmobiliaria";
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
            header('location:' . Doo::conf()->APP_URL . 'CRM/inmobiliaria/mensajes/crear?' . $datos);
            exit;
        } else {

            $inmobiliaria= new inmobiliaria();
			$inmobiliaria->nombre=$this->data['nombre'];
			$inmobiliaria=$this -> db() -> find($inmobiliaria,array("where" => "nombre='" . $this->data['nombre']."'"));
			

            $mensajeInmobiliaria = new mensajeInmobiliaria();
            $mensajeInmobiliaria->asunto= $this->data['asunto'];
            $mensajeInmobiliaria->mensaje = $this->data['mensaje'];
            $mensajeInmobiliaria->fecha = new DooDbExpression('NOW()');
            $mensajeInmobiliaria->id_inmobiliaria_emisor= $this->data['usuario']->id_inmobiliaria;
            $mensajeInmobiliaria->leido=0;
            $mensajeInmobiliaria->id_inmobiliaria_receptor= $inmobiliaria[0]->id_inmobiliaria;
            $mensajeInmobiliaria->status_emisor=1;
            $mensajeInmobiliaria->status_receptor=1;
            
            $mensajeInmobiliaria->insert();
            header('location:' . Doo::conf()->APP_URL . 'CRM/inmobiliaria/mensajes/crear?registro=success');
            
        }
    }
    public function detalleEnviados() {
         Doo::autoload('DooDbExpression');

        Doo::loadController('CRM/seguridad/seguridadController');
        if(!seguridadController::validaSesion()){
            header('location:' . Doo::conf() -> APP_URL . 'CRM/?access=denied');
            exit;
        }
        Doo::loadModel('inmobiliaria');
        Doo::loadModel('permisosUsuario');
        Doo::loadModel('mensajeInmobiliaria');
         $this->data['tipo'] = "inmobiliaria";
        $session = Doo::session(Doo::conf()->APP_NAME,"user");
        //Solicitamos los datos de usuario y sus permisos del usuario
        $this->data['usuario'] = seguridadController::getUsuario($session);
        $this->data['permisos'] = seguridadController::getPermisos($session);

        if($this->data['usuario']==null || $this->data['permisos']==null){
            echo '<h1>Ups. Algo salio mal.</h1><br>Un grupo de excentricos programadores trabaja en solucionar el problema.';
            exit;
        }
        $mensajeInmobiliaria = new mensajeInmobiliaria();
        $mensajeInmobiliaria -> id_inmobiliaria_emisor = $this -> data['usuario'] -> id_inmobiliaria;
        
        if(isset($_GET['id']))
            {
            
            $var=(int)$_GET['id'];
             $mensajeInmobiliaria = new mensajeInmobiliaria();
	        $mensajeInmobiliaria=$this -> db() -> find($mensajeInmobiliaria,array("where" => "id_mensaje =".$var));
	        $temp=$mensajeInmobiliaria[0] -> id_inmobiliaria_receptor;
	        $usuarioInfo = new inmobiliaria();
			//$mensajeInmobiliaria -> id_usuario_receptor = $temp;
			$usuarioInfo->id_inmobiliaria=$temp;
	        $usuarioInfo=$this -> db() -> find($usuarioInfo);
            $this->data['mensajeInmobiliaria'] = $mensajeInmobiliaria;
            $this->data['usuarioInfo'] = $usuarioInfo;
            }
        else {
            header('location:' . Doo::conf()->APP_URL . 'CRM/inmobiliaria/mensajes?error=mensaje');
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
        Doo::loadModel('mensajeInmobiliaria');
         $this->data['tipo'] = "inmobiliaria";
        $session = Doo::session(Doo::conf()->APP_NAME,"user");
        //Solicitamos los datos de usuario y sus permisos del usuario
        $this->data['usuario'] = seguridadController::getUsuario($session);
        $this->data['permisos'] = seguridadController::getPermisos($session);

        if($this->data['usuario']==null || $this->data['permisos']==null){
            echo '<h1>Ups. Algo salio mal.</h1><br>Un grupo de excentricos programadores trabaja en solucionar el problema.';
            exit;
        }
        $mensajeInmobiliaria = new mensajeInmobiliaria();
        $mensajeInmobiliaria -> id_inmobiliaria_receptor = $this -> data['usuario'] -> id_inmobiliaria;
        
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
               header('location:' . Doo::conf()->APP_URL . 'CRM/inmobiliaria/mensajes?error=mensaje'); 
                }
                $mensajeInmobiliaria = new mensajeInmobiliaria();
                $mensajeInmobiliaria=$mensajeInmobiliaria->relate("inmobiliaria",array("where" => "id_mensaje =".$var));
                $this -> data['mensajeInmobiliaria'] = $mensajeInmobiliaria;
            }
        else {
            header('location:' . Doo::conf()->APP_URL . 'CRM/inmobiliaria/mensajes?error=mensaje');
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
        Doo::loadModel('mensajeInmobiliaria');
        Doo::loadModel('inmobiliaria');
		 $this->data['tipo'] = "inmobiliaria";
        $session = Doo::session(Doo::conf()->APP_NAME, "user");
        //Solicitamos los datos de usuario y sus permisos del usuario
        $this->data['usuario'] = seguridadController::getUsuario($session);
        $this->data['permisos'] = seguridadController::getPermisos($session);

        if ($this->data['usuario'] == null || $this->data['permisos'] == null) {
            echo '<h1>Ups. Algo salio mal.</h1><br>Un grupo de excentricos programadores trabaja en solucionar el problema.';
            exit;
        }
        $usuarioInfo = new inmobiliaria();
        $correos= array();
        $mensajeInmobiliaria = new mensajeInmobiliaria();
        $mensajeInmobiliaria->id_inmobiliaria_emisor = $this->data['usuario']->id_inmobiliaria;
        $mensajeInmobiliaria=$this -> db() -> find($mensajeInmobiliaria,array("where" => "status_emisor !=0"));
		
        if ($mensajeInmobiliaria != null) {
            for($x=0; $x<count($mensajeInmobiliaria); $x++)
            {
            	$usuarioInfo = new inmobiliaria();
            	$usuarioInfo->id_inmobiliaria=$mensajeInmobiliaria[$x]->id_inmobiliaria_receptor;
            	$usuarioInfo=$this -> db() -> find($usuarioInfo);
            	$correos[$x]=$usuarioInfo[0]->nombre;
            }
            $this->data['mensajeInmobiliaria'] = $mensajeInmobiliaria;
            
            $this->data['correos'] = $correos;
        }

        $this->renderc('CRM/mensajes/enviados', $this->data);
    }

}

?>