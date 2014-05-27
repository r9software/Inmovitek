<?php

/**
 * MainController
 *
 * @author maph65
 */
class MainController extends DooController {

    public function index() {
        Doo::loadModel('estado');
        Doo::loadModel('tipoInmueble');
        Doo::loadModel('inmueble');
        Doo::loadModel('direccionInmueble');
        Doo::loadModel('fotoInmueble');
        if (!isset($_GET['edo'])) {
            $ipVisitante = $this->clientIP();//$_SERVER['REMOTE_ADDR'];
            $data = file_get_contents('http://api.ipinfodb.com/v3/ip-city/?key=964d7c4884050df37e29df6dcc1741bd92082ee7561de87ef366631a3b56bd4e&ip='.$ipVisitante.'&format=json');
            $ipInfo = json_decode($data);
            if($ipInfo->statusCode=='OK'){
                if(!empty($ipInfo->cityName) && !empty($ipInfo->regionName) && (strlen($ipInfo->cityName)>1) && (strlen($ipInfo->regionName)>1) ){
                    $ubicacion = $this->db()->find(new estado(),array('where'=>'nombre LIKE \'%'.$ipInfo->regionName.'%\' OR nombre LIKE \'%'.$ipInfo->cityName.'%\'','limit'=>1));
                    if($ubicacion){
                        header('location:'.Doo::conf()->APP_URL.'?edo='.$ubicacion->codigo_estado);
                    }
                }
            }
        }else{
            $ciudad = new estado();
            $ciudad->codigo_estado = strip_tags($_GET['edo']);
            $ciudad = $this->db()->find($ciudad,array('limit'=>1));
            if($ciudad){
                $this->data['ciudad'] = $ciudad;
            }else{
                unset($ciudad);
            }
            
        }
        $this->data['estados'] = $this->db()->find(new estado());
        $this->data['tipos'] = $this->db()->find(new tipoInmueble());
        $this->renderc('index', $this->data);
    }

}

?>
