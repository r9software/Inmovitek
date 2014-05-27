<?php

class BuscadorController extends DooController {

    public function index() {
        //Buscador principal
        Doo::loadModel('inmueble');
        Doo::loadModel('viewInmobiliariaInmueble');
        Doo::loadModel('direccionInmueble');
        Doo::loadModel('estado');
        Doo::loadModel('fotoInmueble');
        Doo::loadModel('tipoInmueble');
        
        $this->data['paginaActual'] = 0;
        $this->data['numPaginas'] = 0;
        //Buscamos los inmuebles
        if (isset($_GET) && !empty($_GET)) {
            foreach($_GET as $key=>$val){
                $_GET[$key] = htmlentities(addslashes($val));
            }
            //Paginacion
            if(isset($_GET['pagActual'])){
                $pagina = ((int)$_GET['pagActual']) - 1;
            }else{
                $pagina = 0;
            }
            $this->data['paginaActual'] = $pagina + 1;
            
            $inmueble = new inmueble();
            //Agregamos los parametros de busqueda
            $where = '';
            if(isset($_GET['estado']) && ($_GET['estado']!=0) ){
                if (strlen($where) > 0) $where .= ' AND ct_direccion_inmueble.id_estado = '.$_GET['estado'];
                else $where .= 'ct_direccion_inmueble.id_estado = '.$_GET['estado'].' ';
            }
            if(isset($_GET['tipo']) && ($_GET['tipo']!=0) ){
                if (strlen($where) > 0) $where .= ' AND ct_inmueble.id_tipo_inmueble = '.$_GET['tipo'];
                else $where .= 'ct_inmueble.id_tipo_inmueble = '.$_GET['tipo'];
            }
            if(isset($_GET['precio']) ){
                $precio = explode(';', $_GET['precio']);
                if (strlen($where) > 0) $where .= ' AND (ct_inmueble.precio BETWEEN '.$precio[0].' AND '. $precio[1] .')';
                else $where .= '(ct_inmueble.precio BETWEEN '.$precio[0].' AND '. $precio[1] .')';
            }
            if(isset($_GET['noRecamaras']) ){
                $numRecamaras = (int)$_GET['noRecamaras'];
                if (strlen($where) > 0 && $numRecamaras != 0) $where .= ' AND ct_inmueble.num_recamaras = '.$numRecamaras;
                if (strlen($where) > 0 && $numRecamaras == 5) $where .= ' AND ct_inmueble.num_recamaras > '.$numRecamaras;
            }
            
            if(isset($_GET['noBanios']) ){
                $numSanitarios = (int)$_GET['noBanios'];
                if (strlen($where) > 0 && $numSanitarios != 0) $where .= ' AND ct_inmueble.num_sanitarios = '.$numSanitarios;
                if (strlen($where) > 0 && $numSanitarios == 5) $where .= ' AND ct_inmueble.num_sanitarios > '.$numSanitarios;
            }
            
            if(isset($_GET['metros_cuadrados']) && ((int)$_GET['search_advanced']==1) ){
                $metros = explode(';', $_GET['metros_cuadrados']);
                if (strlen($where) > 0) $where .= ' AND (ct_inmueble.metros_cuadrados BETWEEN '.$metros[0].' AND '. $metros[1] .')';
                else $where .= '(ct_inmueble.metros_cuadrados BETWEEN '.$metros[0].' AND '. $metros[1] .')';
            }
            
            if(strlen($where)==0){
                $where = 'TRUE';
            }
            
            $countResultados = sizeof($this->db()->relate($inmueble, 'direccionInmueble',array('where'=>$where)));
            $NumResultadoBuscado = $pagina * Doo::conf()->NUM_INMUEBLES_RESULTADOS;
            $listaInmuebles = $this->db()->relate($inmueble, 'direccionInmueble',array('where'=>$where,'limit'=> $NumResultadoBuscado.', '.Doo::conf()->NUM_INMUEBLES_RESULTADOS));
            $this->data['inmuebles'] = $listaInmuebles;
            $this->data['numInmuebles'] = $countResultados;
            $this->data['numPaginas'] = round($countResultados/Doo::conf()->NUM_INMUEBLES_RESULTADOS) + 1;
            
        } else {
            $this->data['numInmuebles'] = 0;
        }
        

        $estado = new estado();
        $this->data['estados'] = $this->db()->find($estado);
        $this->data['tipos'] = $this->db()->find(new tipoInmueble());
        
        //generamos la url de la pagina siguiente y anterior en caso de ser necesario
        $pagSiguiente = $this->data['paginaActual'] + 1;
        $pagAnterior = $this->data['paginaActual'] - 1;
        
        if($pagSiguiente <= $this->data['numPaginas']){
            $urlSiguiente = Doo::conf()->APP_URL.'buscar?';
            foreach($_GET as $key=>$val){
                if($key!='pagActual') $urlSiguiente .= '&'.$key.'='.$val;
            }
            $urlSiguiente .= '&pagActual='.$pagSiguiente;
            //$urlSiguiente = urlencode($urlSiguiente);
            $this->data['urlSiguiente'] = $urlSiguiente;
        }
        
        if($pagAnterior > 0){
            $urlAnterior = Doo::conf()->APP_URL.'buscar?';
            foreach($_GET as $key=>$val){
                if($key!='pagActual') $urlAnterior .= '&'.$key.'='.$val;
            }
            $urlAnterior .= '&pagActual='.$pagAnterior;
            //$urlAnterior = urlencode($urlAnterior);
            $this->data['urlAnterior'] = $urlAnterior;
        }
        
        $this->renderc('buscar', $this->data);
    }

    public function buscaMapa() {
        Doo::loadModel('estado');
        Doo::loadModel('tipoInmueble');
        $estado = new estado();
        $this->data['estados'] = $this->db()->find($estado);
        $this->data['tipos'] = $this->db()->find(new tipoInmueble());
        if (isset($_GET) && !empty($_GET)) {
            //Aseguramos la info recibidia
            foreach($_GET as $key=>$val){
                $_GET[$key] = htmlentities(addslashes($val));
            }
            $urlBuscarMarcadores = '';
            foreach($_GET as $key=>$val){
                $urlBuscarMarcadores .= '&'.$key.'='.$val;
            }
            $this->data['urlBuscarMarcadores'] = $urlBuscarMarcadores;
            
        }
        $this->renderc('buscarMapa', $this->data);
    }

}

?>