<?php

class CRMClienteController extends DooController {

    public function index() {
        Doo::loadController('CRM/seguridad/seguridadController');
        if (!seguridadController::validaSesion()) {
            header('location:' . Doo::conf()->APP_URL . 'CRM/?access=denied');
            exit;
        }
        Doo::loadModel('usuario');
        Doo::loadModel('permisosUsuario');
        $session = Doo::session(Doo::conf()->APP_NAME, "user");
        //Solicitamos los datos de usuario y sus permisos del usuario
        $this->data['usuario'] = seguridadController::getUsuario($session);
        $this->data['permisos'] = seguridadController::getPermisos($session);

        if ($this->data['usuario'] == null || $this->data['permisos'] == null) {
            echo '<h1>Ups. Algo salio mal.</h1><br>Un grupo de excentricos programadores trabaja en solucionar el problema.';
            exit;
        }
        $this->renderc('CRM/clientes/principal', $this->data);
    }

    public function nuevoCliente() {
        Doo::loadController('CRM/seguridad/seguridadController');
        if (!seguridadController::validaSesion()) {
            header('location:' . Doo::conf()->APP_URL . 'CRM/?access=denied');
            exit;
        }
        Doo::loadModel('usuario');
        Doo::loadModel('permisosUsuario');
        $session = Doo::session(Doo::conf()->APP_NAME, "user");
        //Solicitamos los datos de usuario y sus permisos del usuario
        $this->data['usuario'] = seguridadController::getUsuario($session);
        $this->data['permisos'] = seguridadController::getPermisos($session);

        if ($this->data['usuario'] == null || $this->data['permisos'] == null) {
            echo '<h1>Ups. Algo salio mal.</h1><br>Un grupo de excentricos programadores trabaja en solucionar el problema.';
            exit;
        }
        $this->renderc('CRM/clientes/nuevoCliente', $this->data);
    }
    public function clienteBusca() {
        Doo::loadController('CRM/seguridad/seguridadController');
        if (!seguridadController::validaSesion()) {
            header('location:' . Doo::conf()->APP_URL . 'CRM/?access=denied');
            exit;
        }
        Doo::loadModel('usuario');
        Doo::loadModel('cliente');
        Doo::loadModel('tipoInmueble');
        Doo::loadModel('estado');
        Doo::loadModel('perfilCliente');
        Doo::loadModel('permisosUsuario');
        $session = Doo::session(Doo::conf()->APP_NAME, "user");
        $idCliente = (int) strip_tags(htmlentities($this->params['idCliente']));
        if(!$idCliente){
            header('location:' . Doo::conf()->APP_URL . 'CRM/clientes');
            exit();
        }
        $cliente= new cliente(); 
        $cliente->id_cliente=$idCliente;
        $cliente=$this->db()->find($cliente,array('limit'=>1));
        
        if($cliente!=null){
            $estado = new estado();
            $this->data['ArrayEstado'] = $estado->find();
            $tipoInmueble = new tipoInmueble();
            $this->data['ArrayTipoInmueble'] = $tipoInmueble->find();
            $perfil=new perfilCliente();
            $perfil->id_cliente=$idCliente;
            $perfil=$this->db()->find($perfil,array('limit'=>1));
            if($perfil!=null){
                $this->data['registrado']='Registrado';
                $this->data['perfil']=$perfil;
                  
            }else{
                $this->data['registrado']='NoRegistrado';
                
            }
           
        }
        else{
            
            header('location:' . Doo::conf()->APP_URL . 'CRM/home/?access=denied');
            exit;
        }
        //Solicitamos los datos de usuario y sus permisos del usuario
        $this->data['usuario'] = seguridadController::getUsuario($session);
        $this->data['permisos'] = seguridadController::getPermisos($session);

        if ($this->data['usuario'] == null || $this->data['permisos'] == null) {
            echo '<h1>Ups. Algo salio mal.</h1><br>Un grupo de excentricos programadores trabaja en solucionar el problema.';
            exit;
        }
        $this->renderc('CRM/clientes/clienteBusca', $this->data);
    }
    public function actionClienteBusca() {
        Doo::loadController('CRM/seguridad/seguridadController');
        if (!seguridadController::validaSesion()) {
            header('location:' . Doo::conf()->APP_URL . 'CRM/?access=denied');
            exit;
        }
        Doo::loadModel('usuario');
        Doo::loadModel('permisosUsuario');
        Doo::loadModel('perfilCliente');
        Doo::autoload('DooDbExpression');
        $session = Doo::session(Doo::conf()->APP_NAME, "user");
        //Solicitamos los datos de usuario y sus permisos del usuario
        $this->data['usuario'] = seguridadController::getUsuario($session);
        $this->data['permisos'] = seguridadController::getPermisos($session);
        
         $idCliente = (int) strip_tags(htmlentities($this->params['idCliente']));
        if(!$idCliente){
            header('location:' . Doo::conf()->APP_URL . 'CRM/clientes');
            exit();
        }

        if ($this->data['usuario'] == null || $this->data['permisos'] == null) {
            echo '<h1>Ups. Algo salio mal.</h1><br>Un grupo de excentricos programadores trabaja en solucionar el problema.';
            exit;
        }
        
        $permisos = $this->data['permisos'];
        if($permisos->registrar_cliente != 1){
            header('location:' . Doo::conf()->APP_URL . 'CRM/home/?access=denied');
            exit;
        }
        $variables = "";
       /* $incompleto = FALSE;
        foreach($_POST as $key => $value){
            if(!is_array($value)){
                $_POST[$key] = stripslashes(strip_tags($value));
            }
            $variables .= '&'.$key.'='.$value;
            if(empty($_POST[$key])){
                $incompleto = TRUE;
            }
        }
        if($incompleto){
            header('location:' . Doo::conf()->APP_URL . 'CRM/cliente/'.$idCliente.'/busca?error=incompleto'.$variables);
            exit;
        }
        */
            if($_POST['registrado']=='NoRegistrado'){
                
                $cliente = new perfilCliente();
                $cliente->id_estado_busca_inmueble = $_POST['entidad'];
                $cliente->id_tipo_inmueble =$_POST['tipo-propiedad'];
                $cliente->alberca = $_POST['buscaAl'];
                $cliente->cochera = $_POST['buscaCo'];
                $cliente->compra_renta = $_POST['buscaCo'];
                $cliente->id_cliente = $idCliente;
                $cliente->no_habitaciones_max = $_POST['nomax'];
                $cliente->no_habitaciones_min= $_POST['nomin'];
                $cliente->no_plantas= $_POST['noplantas'];
                $cliente->no_sanitarios_max= $_POST['nomaxba'];
                $cliente->no_sanitarios_min= $_POST['nominba'];
                $cliente->rango_precio_max= $_POST['preciomax'];
                $cliente->rango_precio_min= $_POST['preciomin'];
                $idperfil = $cliente->insert();
                if($idCliente){
                        header('location:' . Doo::conf()->APP_URL . 'CRM/cliente/'.$idCliente.'/busca?registro=perfil');
                        exit;
                    }else{
                        header('location:' . Doo::conf()->APP_URL . 'CRM/clientes'.$idCliente.'/busca?error=unknown'.$variables);
                        exit;
                    }
            }
            else{
                $cliente = new perfilCliente();
                $cliente->id_estado_busca_inmueble = $_POST['entidad'];
                $cliente->id_tipo_inmueble =$_POST['tipo-propiedad'];
                $cliente->alberca = $_POST['buscaAl'];
                $cliente->cochera = $_POST['buscaCo'];
                $cliente->compra_renta = $_POST['buscaCo'];
                $cliente->id_cliente = $idCliente;
                $cliente->no_habitaciones_max = $_POST['nomax'];
                $cliente->no_habitaciones_min= $_POST['nomin'];
                $cliente->no_plantas= $_POST['noplantas'];
                $cliente->no_sanitarios_max= $_POST['nomaxba'];
                $cliente->no_sanitarios_min= $_POST['nominba'];
                $cliente->rango_precio_max= $_POST['preciomax'];
                $cliente->rango_precio_min= $_POST['preciomin'];
                $idperfil = $cliente->update();
                if($idCliente){
                        header('location:' . Doo::conf()->APP_URL . 'CRM/cliente/'.$idCliente.'/busca?registro=update');
                        exit;
                    }else{
                        header('location:' . Doo::conf()->APP_URL . 'CRM/cliente/'.$idCliente.'/busca?error=unknown'.$variables);
                        exit;
                    }
            }
            
        
        
        
    }
    
    public function actionNuevoCliente() {
        Doo::loadController('CRM/seguridad/seguridadController');
        if (!seguridadController::validaSesion()) {
            header('location:' . Doo::conf()->APP_URL . 'CRM/?access=denied');
            exit;
        }
        Doo::loadModel('usuario');
        Doo::loadModel('permisosUsuario');
        Doo::loadModel('cliente');
        Doo::autoload('DooDbExpression');
        $session = Doo::session(Doo::conf()->APP_NAME, "user");
        //Solicitamos los datos de usuario y sus permisos del usuario
        $this->data['usuario'] = seguridadController::getUsuario($session);
        $this->data['permisos'] = seguridadController::getPermisos($session);

        if ($this->data['usuario'] == null || $this->data['permisos'] == null) {
            echo '<h1>Ups. Algo salio mal.</h1><br>Un grupo de excentricos programadores trabaja en solucionar el problema.';
            exit;
        }
        
        $permisos = $this->data['permisos'];
        if($permisos->registrar_cliente != 1){
            header('location:' . Doo::conf()->APP_URL . 'CRM/home/?access=denied');
            exit;
        }
        $variables = "";
        $incompleto = FALSE;
        foreach($_POST as $key => $value){
            if(!is_array($value)){
                $_POST[$key] = stripslashes(strip_tags($value));
            }
            $variables .= '&'.$key.'='.$value;
            if(empty($_POST[$key])){
                $incompleto = TRUE;
            }
        }
        if($incompleto){
            header('location:' . Doo::conf()->APP_URL . 'CRM/inmobiliaria/clientes/nuevo?error=incompleto'.$variables);
            exit;
        }
        
        $cliente = new cliente();
        $cliente->nombre = $_POST['nombre'].' '.$_POST['apaterno'].' '.$_POST['amaterno'];
        $cliente->id_usuario = $this->data['usuario']->id_usuario;
        $cliente->telefono = $_POST['telefono'];
        $cliente->correo = $_POST['email'];
        $cliente->fecha_alta = new DooDbExpression('NOW()');
        $cliente->horario_llamada = $_POST['horacontactoi'].' - '.$_POST['horacontactof'];
        $busca=$_POST['busca'];
        
        
        $idCliente = $cliente->insert();
        
        if($idCliente){
            if($busca == 'si')
            header('location:' . Doo::conf()->APP_URL . 'CRM/cliente/'.$idCliente.'/busca?registro=success');
            else
            header('location:' . Doo::conf()->APP_URL . 'CRM/clientes/nuevo?registro=success');
            exit;
        }else{
            header('location:' . Doo::conf()->APP_URL . 'CRM/clientes/nuevo?error=unknown'.$variables);
            exit;
        }
    }

    public function buscarCliente() {
        Doo::loadController('CRM/seguridad/seguridadController');
        if (!seguridadController::validaSesion()) {
            header('location:' . Doo::conf()->APP_URL . 'CRM/?access=denied');
            exit;
        }
        Doo::loadModel('usuario');
        Doo::loadModel('permisosUsuario');
        $session = Doo::session(Doo::conf()->APP_NAME, "user");
        //Solicitamos los datos de usuario y sus permisos del usuario
        $this->data['usuario'] = seguridadController::getUsuario($session);
        $this->data['permisos'] = seguridadController::getPermisos($session);

        if ($this->data['usuario'] == null || $this->data['permisos'] == null) {
            echo '<h1>Ups. Algo salio mal.</h1><br>Un grupo de excentricos programadores trabaja en solucionar el problema.';
            exit;
        }
        $this->renderc('CRM/clientes/buscaCliente', $this->data);
    }
    
    public function listarCliente() {
        Doo::loadController('CRM/seguridad/seguridadController');
        if (!seguridadController::validaSesion()) {
            header('location:' . Doo::conf()->APP_URL . 'CRM/?access=denied');
            exit;
        }
        Doo::loadModel('usuario');
        Doo::loadModel('permisosUsuario');
        Doo::loadModel('cliente');
        
        $session = Doo::session(Doo::conf()->APP_NAME, "user");
        //Solicitamos los datos de usuario y sus permisos del usuario
        $this->data['usuario'] = seguridadController::getUsuario($session);
        $this->data['permisos'] = seguridadController::getPermisos($session);

        if ($this->data['usuario'] == null || $this->data['permisos'] == null) {
            echo '<h1>Ups. Algo salio mal.</h1><br>Un grupo de excentricos programadores trabaja en solucionar el problema.';
            exit;
        }
        $listaClientes = new cliente();
        $listaClientes->id_usuario = $this->data['usuario']->id_usuario();
        $listaClientes = $this->db()->find($listaClientes);
        $this->data['clientes'] = $listaClientes; 
        $this->data['numClientes'] = sizeof($listaClientes);
        $this->renderc('CRM/clientes/listar', $this->data);
    }
    
    public function perfilCliente() {
        Doo::loadController('CRM/seguridad/seguridadController');
        if (!seguridadController::validaSesion()) {
            header('location:' . Doo::conf()->APP_URL . 'CRM/?access=denied');
            exit;
        }
        Doo::loadModel('usuario');
        Doo::loadModel('permisosUsuario');
        Doo::loadModel('perfilCliente');
        Doo::loadModel('cliente');
        Doo::loadModel('tipoInmueble');
        Doo::loadModel('estado');
        
        $idCliente = (int) strip_tags(htmlentities($this->params['idCliente']));
        if(!$idCliente){
            header('location:' . Doo::conf()->APP_URL . 'CRM/clientes');
            exit();
        }
        $estado = new estado();
            $this->data['ArrayEstado'] = $estado->find();
            $tipoInmueble = new tipoInmueble();
            $this->data['ArrayTipoInmueble'] = $tipoInmueble->find();
        $session = Doo::session(Doo::conf()->APP_NAME, "user");
        //Solicitamos los datos de usuario y sus permisos del usuario
        $this->data['usuario'] = seguridadController::getUsuario($session);
        $this->data['permisos'] = seguridadController::getPermisos($session);

        if ($this->data['usuario'] == null || $this->data['permisos'] == null) {
            echo '<h1>Ups. Algo salio mal.</h1><br>Un grupo de excentricos programadores trabaja en solucionar el problema.';
            exit;
        }
        $cliente = new cliente();
        $cliente->id_usuario = $this->data['usuario']->id_usuario();
        $cliente->id_cliente = $idCliente;
        $cliente = $this->db()->find($cliente,array('limit'=>1));
        $perfil = new perfilCliente();
        $perfil->id_cliente = $idCliente;
        $perfil = $this->db()->find($perfil,array('limit'=>1));
        if(!$cliente){
            header('location:' . Doo::conf()->APP_URL . 'CRM/clientes');
            exit();
        }
        if($perfil){
           $this->data['perfil'] = $perfil; 
        }
        
        $this->data['cliente'] = $cliente; 
        $this->renderc('CRM/clientes/verCliente', $this->data);
    }

}

?>
