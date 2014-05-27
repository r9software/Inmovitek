<?php

class InmuebleController extends DooController {

    public function verInmueble() {
        Doo::loadModel('inmueble');
        Doo::loadModel('viewInmobiliariaInmueble');
        Doo::loadModel('direccionInmueble');
        Doo::loadModel('estado');
        Doo::loadModel('tipoInmueble');
        
        $idInmueble = (int) strip_tags(htmlentities($this->params['idInmueble']));
        $inmueble = new inmueble();
        
        $inmueble->id_inmueble = $idInmueble;
        //Cargamos los datos del inmueble
        $inmueble = $inmueble->relateMany(array('direccionInmueble', 'tipoInmueble', 'fotoInmueble', 'visitaVirtual'), array('limit' => 1));
        if ($inmueble != null) {
            $this->data['inmueble'] = $inmueble[0];
            $estado = new estado();
            $estado->id_estado = $inmueble[0]->direccionInmueble->id_estado;
            $estado = $estado->find();

            $this->data['estado'] = $estado[0];

            //Mostramos la vista del inmueble
            $this->renderc('verInmueble', $this->data);
        } else {
            header('location:' . Doo::conf()->APP_URL . 'buscar');
            exit;
        }
        /* $data['idInmueble'] = $this->params['idInmueble'];
          $this->renderc('verInmueble',$data); */
    }

}

?>