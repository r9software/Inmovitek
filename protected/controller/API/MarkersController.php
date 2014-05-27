<?php

class MarkersController extends DooController {

    public function listadoInmuebles() {
        header('Cache-Control: no-cache, must-revalidate');
        header('Expires: Mon, 26 Jul 1997 05:00:00 GMT');
        //header('Content-type: application/json');
        header('Content-type: application/json; charset=ISO-8859-1');

        Doo::loadModel('inmueble');
        Doo::loadModel('direccionInmueble');
        Doo::loadModel('estado');
        Doo::loadModel('fotoInmueble');
        Doo::loadModel('tipoInmueble');

        $inmueble = new inmueble();
        if (isset($_GET) && !empty($_GET)) {
            foreach ($_GET as $key => $val) {
                $_GET[$key] = htmlentities(addslashes($val));
            }
            //Agregamos los parametros de busqueda
            $where = '';
            if (isset($_GET['estado']) && ($_GET['estado'] != 0)) {
                if (strlen($where) > 0)
                    $where .= ' AND ct_direccion_inmueble.id_estado = ' . $_GET['estado'];
                else
                    $where .= 'ct_direccion_inmueble.id_estado = ' . $_GET['estado'] . ' ';
            }
            if (isset($_GET['tipo']) && ($_GET['tipo'] != 0)) {
                if (strlen($where) > 0)
                    $where .= ' AND ct_inmueble.id_tipo_inmueble = ' . $_GET['tipo'];
                else
                    $where .= 'ct_inmueble.id_tipo_inmueble = ' . $_GET['tipo'];
            }
            if (isset($_GET['precio'])) {
                $precio = explode(';', $_GET['precio']);
                if (strlen($where) > 0)
                    $where .= ' AND (ct_inmueble.precio BETWEEN ' . $precio[0] . ' AND ' . $precio[1] . ')';
                else
                    $where .= '(ct_inmueble.precio BETWEEN ' . $precio[0] . ' AND ' . $precio[1] . ')';
            }
            if (isset($_GET['noRecamaras'])) {
                $numRecamaras = (int) $_GET['noRecamaras'];
                if (strlen($where) > 0 && $numRecamaras != 0)
                    $where .= ' AND ct_inmueble.num_recamaras = ' . $numRecamaras;
                if (strlen($where) > 0 && $numRecamaras == 5)
                    $where .= ' AND ct_inmueble.num_recamaras > ' . $numRecamaras;
            }

            if (isset($_GET['noBanios'])) {
                $numSanitarios = (int) $_GET['noBanios'];
                if (strlen($where) > 0 && $numSanitarios != 0)
                    $where .= ' AND ct_inmueble.num_sanitarios = ' . $numSanitarios;
                if (strlen($where) > 0 && $numSanitarios == 5)
                    $where .= ' AND ct_inmueble.num_sanitarios > ' . $numSanitarios;
            }

            if (isset($_GET['metros_cuadrados']) && ((int) $_GET['search_advanced'] == 1)) {
                $metros = explode(';', $_GET['metros_cuadrados']);
                if (strlen($where) > 0)
                    $where .= ' AND (ct_inmueble.metros_cuadrados BETWEEN ' . $metros[0] . ' AND ' . $metros[1] . ')';
                else
                    $where .= '(ct_inmueble.metros_cuadrados BETWEEN ' . $metros[0] . ' AND ' . $metros[1] . ')';
            }
            if (strlen($where) == 0) {
                $where = 'TRUE';
            }
            //$listaInmuebles = $this->db()->relateMany($inmueble, array('direccionInmueble', 'tipoInmueble', 'fotoInmueble'),array('where'=>$where));
            $listaInmuebles = $this->db()->relate($inmueble, 'direccionInmueble', array('where' => $where));
        } else {//No hay terminos de busqueda
            //$listaInmuebles = $this->db()->relateMany($inmueble, array('direccionInmueble', 'tipoInmueble', 'fotoInmueble'));
            $listaInmuebles = $this->db()->relate($inmueble, 'direccionInmueble');
        }

        $numInmuebles = sizeof($listaInmuebles);
        $i = 0;


        echo '[';
        if ($numInmuebles > 0) {
            foreach ($listaInmuebles as $inmueble) {
                //Traemos los datos adicionales necesarios
                $inmueble = $this->db()->relateMany($inmueble, array('direccionInmueble', 'tipoInmueble', 'fotoInmueble'));
                $inmueble = $inmueble[0];
                //
                $i++;
                echo '{';
                echo '"idInmueble":' . $inmueble->id_inmueble . ', ';
                echo '"title": "' . $inmueble->tipoInmueble->tipo_inmueble . ' en la colonia ' . $inmueble->direccionInmueble->colonia . '", ';
                //echo '"desc": "'.$inmueble->detalles.'", ';  //
                echo '"desc": "' . substr($inmueble->detalles, 0, strrpos(substr($inmueble->detalles, 0, 160), " ")) . '...", ';
                if (!empty($inmueble->fotoInmueble)) {
                    echo '"foto": "' . Doo::conf()->APP_URL . $inmueble->fotoInmueble[0]->url_imagen . '", ';
                } else {
                    echo '"foto": "' . Doo::conf()->APP_URL . 'global/images/temp/property_04.jpg", ';
                }
                echo '"marker": "' . Doo::conf()->APP_URL . 'global/images/gmap_marker.png", ';
                echo '"lat": ' . $inmueble->direccionInmueble->latitud . ', ';
                echo '"lon": ' . $inmueble->direccionInmueble->longitud;
                echo '}';
                if ($i != $numInmuebles)
                    echo ', ';
            }
        }

        echo ']';
    }

    public function listadoInmueblesInmobiliaria() {
        header('Cache-Control: no-cache, must-revalidate');
        header('Expires: Mon, 26 Jul 1997 05:00:00 GMT');
        //header('Content-type: application/json');
        header('Content-type: application/json; charset=ISO-8859-1');
        Doo::loadModel('viewInmobiliariaInmueble');
        Doo::loadModel('inmobiliaria');
        Doo::loadModel('inmueble');
        Doo::loadModel('direccionInmueble');
        Doo::loadModel('estado');
        Doo::loadModel('fotoInmueble');
        Doo::loadModel('tipoInmueble');

        $inmobiliaria = new inmobiliaria();
        $inmobiliaria->identificador = $this->params['identificador'];
        $inmobiliaria = $this->db()->find($inmobiliaria, array('limit' => 1));
        if ($inmobiliaria) {
            $inmueble = new viewInmobiliariaInmueble();
            $inmueble->id_inmobiliaria = $inmobiliaria->id_inmobiliaria;
            //Definimos los inmuebles de solo esa inmobiliaria

            if (isset($_GET) && !empty($_GET)) {
                foreach ($_GET as $key => $val) {
                    $_GET[$key] = htmlentities(addslashes($val));
                }
                //Agregamos los parametros de busqueda
                $where = '';
                if (isset($_GET['estado']) && ($_GET['estado'] != 0)) {
                    if (strlen($where) > 0)
                        $where .= ' AND ct_direccion_inmueble.id_estado = ' . $_GET['estado'];
                    else
                        $where .= 'ct_direccion_inmueble.id_estado = ' . $_GET['estado'] . ' ';
                }
                if (isset($_GET['tipo']) && ($_GET['tipo'] != 0)) {
                    if (strlen($where) > 0)
                        $where .= ' AND vw_inmobiliaria_inmueble.id_tipo_inmueble = ' . $_GET['tipo'];
                    else
                        $where .= 'vw_inmobiliaria_inmueble.id_tipo_inmueble = ' . $_GET['tipo'];
                }
                if (isset($_GET['precio'])) {
                    $precio = explode(';', $_GET['precio']);
                    if (strlen($where) > 0)
                        $where .= ' AND (vw_inmobiliaria_inmueble.precio BETWEEN ' . $precio[0] . ' AND ' . $precio[1] . ')';
                    else
                        $where .= '(vw_inmobiliaria_inmueble.precio BETWEEN ' . $precio[0] . ' AND ' . $precio[1] . ')';
                }
                if (isset($_GET['noRecamaras'])) {
                    $numRecamaras = (int) $_GET['noRecamaras'];
                    if (strlen($where) > 0 && $numRecamaras != 0)
                        $where .= ' AND vw_inmobiliaria_inmueble.num_recamaras = ' . $numRecamaras;
                    if (strlen($where) > 0 && $numRecamaras == 5)
                        $where .= ' AND vw_inmobiliaria_inmueble.num_recamaras > ' . $numRecamaras;
                }

                if (isset($_GET['noBanios'])) {
                    $numSanitarios = (int) $_GET['noBanios'];
                    if (strlen($where) > 0 && $numSanitarios != 0)
                        $where .= ' AND vw_inmobiliaria_inmueble.num_sanitarios = ' . $numSanitarios;
                    if (strlen($where) > 0 && $numSanitarios == 5)
                        $where .= ' AND vw_inmobiliaria_inmueble.num_sanitarios > ' . $numSanitarios;
                }

                if (isset($_GET['metros_cuadrados']) && ((int) $_GET['search_advanced'] == 1)) {
                    $metros = explode(';', $_GET['metros_cuadrados']);
                    if (strlen($where) > 0)
                        $where .= ' AND (vw_inmobiliaria_inmueble.metros_cuadrados BETWEEN ' . $metros[0] . ' AND ' . $metros[1] . ')';
                    else
                        $where .= '(vw_inmobiliaria_inmueble.metros_cuadrados BETWEEN ' . $metros[0] . ' AND ' . $metros[1] . ')';
                }
                if (strlen($where) == 0) {
                    $where = 'TRUE';
                }
                //$listaInmuebles = $this->db()->relateMany($inmueble, array('direccionInmueble', 'tipoInmueble', 'fotoInmueble'),array('where'=>$where));
                $listaInmuebles = $this->db()->relate($inmueble, 'direccionInmueble', array('where' => $where));
            } else {//No hay terminos de busqueda
                //$listaInmuebles = $this->db()->relateMany($inmueble, array('direccionInmueble', 'tipoInmueble', 'fotoInmueble'));
                $listaInmuebles = $this->db()->relate($inmueble, 'direccionInmueble');
            }

            $numInmuebles = sizeof($listaInmuebles);
            $i = 0;


            echo '[';
            if ($numInmuebles > 0) {
                foreach ($listaInmuebles as $inmueble) {
                    //Traemos los datos adicionales necesarios
                    $inmueble = $this->db()->relateMany($inmueble, array('direccionInmueble', 'tipoInmueble', 'fotoInmueble'));
                    $inmueble = $inmueble[0];
                    //
                    $i++;
                    echo '{';
                    echo '"idInmueble":' . $inmueble->id_inmueble . ', ';
                    echo '"title": "' . $inmueble->tipoInmueble->tipo_inmueble . ' en la colonia ' . $inmueble->direccionInmueble->colonia . '", ';
                    //echo '"desc": "'.$inmueble->detalles.'", ';  //
                    echo '"desc": "' . substr($inmueble->detalles, 0, strrpos(substr($inmueble->detalles, 0, 160), " ")) . '...", ';
                    if (!empty($inmueble->fotoInmueble)) {
                        echo '"foto": "' . Doo::conf()->APP_URL . $inmueble->fotoInmueble[0]->url_imagen . '", ';
                    } else {
                        echo '"foto": "' . Doo::conf()->APP_URL . 'global/images/temp/property_04.jpg", ';
                    }
                    echo '"marker": "' . Doo::conf()->APP_URL . 'global/images/gmap_marker.png", ';
                    echo '"lat": ' . $inmueble->direccionInmueble->latitud . ', ';
                    echo '"lon": ' . $inmueble->direccionInmueble->longitud;
                    echo '}';
                    if ($i != $numInmuebles)
                        echo ', ';
                }
            }

            echo ']';
        }else {
            echo '{"error":"Inmobiliaria no encontrada"}';
        }
    }

    /*public function listadoInmueblesInmobiliaria() {
        header('Cache-Control: no-cache, must-revalidate');
        header('Expires: Mon, 26 Jul 1997 05:00:00 GMT');
        //header('Content-type: application/json');
        header('Content-type: application/json; charset=ISO-8859-1');

        Doo::loadModel('viewInmobiliariaInmueble');
        Doo::loadModel('inmobiliaria');
        Doo::loadModel('direccionInmueble');
        Doo::loadModel('estado');
        Doo::loadModel('fotoInmueble');
        Doo::loadModel('tipoInmueble');

        $inmobiliaria = new inmobiliaria();
        $inmobiliaria->identificador = $this->params['identificador'];
        $inmobiliaria = $this->db()->find($inmobiliaria, array('limit' => 1));
        if ($inmobiliaria) {
            $inmueble = new viewInmobiliariaInmueble();
            $inmueble->id_inmobiliaria = $inmobiliaria->id_inmobiliaria;
            $listaInmuebles = $this->db()->relateMany($inmueble, array('direccionInmueble', 'tipoInmueble', 'fotoInmueble'));
            $numInmuebles = count($listaInmuebles);
            $i = 0;

            echo '[';
            foreach ($listaInmuebles as $inmueble) {
                $i++;
                echo '{';
                echo '"idInmueble":' . $inmueble->id_inmueble . ', ';
                echo '"title": "' . $inmueble->tipoInmueble->tipo_inmueble . ' en la colonia ' . $inmueble->direccionInmueble->colonia . '", ';
                //echo '"desc": "'.$inmueble->detalles.'", ';  //
                echo '"desc": "' . substr($inmueble->detalles, 0, strrpos(substr($inmueble->detalles, 0, 160), " ")) . '...", ';
                if (!empty($inmueble->fotoInmueble)) {
                    echo '"foto": "' . Doo::conf()->APP_URL . $inmueble->fotoInmueble[0]->url_imagen . '", ';
                } else {
                    echo '"foto": "' . Doo::conf()->APP_URL . 'global/images/temp/property_04.jpg", ';
                }
                echo '"marker": "' . Doo::conf()->APP_URL . 'global/images/gmap_marker.png", ';
                echo '"lat": ' . $inmueble->direccionInmueble->latitud . ', ';
                echo '"lon": ' . $inmueble->direccionInmueble->longitud;
                echo '}';
                if ($i != $numInmuebles)
                    echo ', ';
            }
            echo ']';
        }else {
            echo '{"error":"Inmobiliaria no encontrada"}';
        }
    }*/

}

?>