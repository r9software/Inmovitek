<?php

/**
 * MainController
 *
 * @author maph65
 */
class PerfilController extends DooController {

    public function index() {
        Doo::loadModel('estado');
        Doo::loadModel('inmobiliaria');
        Doo::loadModel('tipoInmueble');
        Doo::loadModel('inmueble');
        Doo::loadModel('direccionInmueble');
        Doo::loadModel('fotoInmueble');

        $identificadorInmobiliaria = $this->params['idenInmobiliaria'];
        $inmobiliaria = new inmobiliaria();
        $inmobiliaria->identificador = $identificadorInmobiliaria;
        $inmobiliaria = $this->db()->find($inmobiliaria, array('limit' => 1));
        if ($inmobiliaria) {
            if (!isset($_GET['edo'])) {
                $ipVisitante = $this->clientIP();
                //$ipVisitante = '148.204.64.71';
                $data = file_get_contents('http://api.ipinfodb.com/v3/ip-city/?key=964d7c4884050df37e29df6dcc1741bd92082ee7561de87ef366631a3b56bd4e&ip=' . $ipVisitante . '&format=json');
                $ipInfo = json_decode($data);
                if ($ipInfo->statusCode == 'OK') {
                    if (!empty($ipInfo->cityName) && !empty($ipInfo->regionName) && (strlen($ipInfo->cityName) > 1) && (strlen($ipInfo->regionName) > 1)) {
                        $ubicacion = $this->db()->find(new estado(), array('where' => 'nombre LIKE \'%' . $ipInfo->regionName . '%\' OR nombre LIKE \'%' . $ipInfo->cityName . '%\'', 'limit' => 1));
                        if ($ubicacion) {
                            header('location:' . Doo::conf()->APP_URL . $identificadorInmobiliaria . '?edo=' . $ubicacion->codigo_estado);
                        }
                    }
                }
            } else {
                $ciudad = new estado();
                $ciudad->codigo_estado = strip_tags($_GET['edo']);
                $ciudad = $this->db()->find($ciudad, array('limit' => 1));
                if ($ciudad) {
                    $this->data['ciudad'] = $ciudad;
                } else {
                    unset($ciudad);
                }
            }
            $this->data['inmobiliaria'] = $inmobiliaria;
            //Verificamos si existe el wallpapaper
            if (is_file(Doo::conf()->SITE_PATH . $inmobiliaria->directorio_archivos . '/wallpaper.jpg')) {
                $this->data['wallpaper'] = Doo::conf()->APP_URL . str_replace('\\', '/', $inmobiliaria->directorio_archivos) . '/wallpaper.jpg';
            }

            $this->data['estados'] = $this->db()->find(new estado());
            $this->data['tipos'] = $this->db()->find(new tipoInmueble());
            $this->renderc('perfil/index', $this->data);
        } else {//La inmobiliaria solicitada no existe
            $this->renderc('errores/error404');
        }
    }

    public function buscador() {
        //Buscador principal
        Doo::loadModel('inmueble');
        Doo::loadModel('inmobiliaria');
        Doo::loadModel('viewInmobiliariaInmueble');
        Doo::loadModel('direccionInmueble');
        Doo::loadModel('estado');
        Doo::loadModel('fotoInmueble');
        Doo::loadModel('tipoInmueble');

        $this->data['paginaActual'] = 0;
        $this->data['numPaginas'] = 0;
        //Buscamos los inmuebles
        //Cargamos la informacion de la inmobiliaria
        $identificadorInmobiliaria = $this->params['idenInmobiliaria'];
        $inmobiliaria = new inmobiliaria();
        $inmobiliaria->identificador = $identificadorInmobiliaria;
        $inmobiliaria = $this->db()->find($inmobiliaria, array('limit' => 1));
        if ($inmobiliaria) {
            //Si existe la inmobiliaria
            $this->data['inmobiliaria'] = $inmobiliaria;
            //Verificamos si existe el wallpapaper
            if (is_file(Doo::conf()->SITE_PATH . $inmobiliaria->directorio_archivos . '/wallpaper.jpg')) {
                $this->data['wallpaper'] = Doo::conf()->APP_URL . str_replace('\\', '/', $inmobiliaria->directorio_archivos) . '/wallpaper.jpg';
            }

            $this->data['estados'] = $this->db()->find(new estado());

            //Buscamos inmuebles
            if (isset($_GET) && !empty($_GET)) {
                foreach ($_GET as $key => $val) {
                    $_GET[$key] = htmlentities(addslashes($val));
                }
                //Paginacion
                if (isset($_GET['pagActual'])) {
                    $pagina = ((int) $_GET['pagActual']) - 1;
                } else {
                    $pagina = 0;
                }
                $this->data['paginaActual'] = $pagina + 1;

                $inmueble = new viewInmobiliariaInmueble();
                $inmueble->id_inmobiliaria = $inmobiliaria->id_inmobiliaria;

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

                $countResultados = sizeof($this->db()->relate($inmueble, 'direccionInmueble', array('where' => $where)));
                $NumResultadoBuscado = $pagina * Doo::conf()->NUM_INMUEBLES_RESULTADOS;
                $listaInmuebles = $this->db()->relate($inmueble, 'direccionInmueble', array('where' => $where, 'limit' => $NumResultadoBuscado . ', ' . Doo::conf()->NUM_INMUEBLES_RESULTADOS));
                $this->data['inmuebles'] = $listaInmuebles;
                $this->data['numInmuebles'] = $countResultados;
                $this->data['numPaginas'] = round($countResultados / Doo::conf()->NUM_INMUEBLES_RESULTADOS) + 1;
            } else {
                $this->data['numInmuebles'] = 0;
            }


            $estado = new estado();
            $this->data['estados'] = $this->db()->find($estado);
            $this->data['tipos'] = $this->db()->find(new tipoInmueble());

            //generamos la url de la pagina siguiente y anterior en caso de ser necesario
            $pagSiguiente = $this->data['paginaActual'] + 1;
            $pagAnterior = $this->data['paginaActual'] - 1;

            if ($pagSiguiente <= $this->data['numPaginas']) {
                $urlSiguiente = Doo::conf()->APP_URL . 'buscar?';
                foreach ($_GET as $key => $val) {
                    if ($key != 'pagActual')
                        $urlSiguiente .= '&' . $key . '=' . $val;
                }
                $urlSiguiente .= '&pagActual=' . $pagSiguiente;
                //$urlSiguiente = urlencode($urlSiguiente);
                $this->data['urlSiguiente'] = $urlSiguiente;
            }

            if ($pagAnterior > 0) {
                $urlAnterior = Doo::conf()->APP_URL . 'buscar?';
                foreach ($_GET as $key => $val) {
                    if ($key != 'pagActual')
                        $urlAnterior .= '&' . $key . '=' . $val;
                }
                $urlAnterior .= '&pagActual=' . $pagAnterior;
                //$urlAnterior = urlencode($urlAnterior);
                $this->data['urlAnterior'] = $urlAnterior;
            }

            $this->renderc('buscar', $this->data);
        }else {
            //La inmobiliaria solicitada no existe
            $this->renderc('errores/error404');
        }
    }

    public function buscadorMapa() {
        Doo::loadModel('inmobiliaria');
        Doo::loadModel('estado');
        Doo::loadModel('tipoInmueble');
        //Cargamos la informacion de la inmobiliaria
        $identificadorInmobiliaria = $this->params['idenInmobiliaria'];
        $inmobiliaria = new inmobiliaria();
        $inmobiliaria->identificador = $identificadorInmobiliaria;
        $inmobiliaria = $this->db()->find($inmobiliaria, array('limit' => 1));
        if ($inmobiliaria) {

            if (isset($_GET) && !empty($_GET)) {
                //Aseguramos la info recibidia
                foreach ($_GET as $key => $val) {
                    $_GET[$key] = htmlentities(addslashes($val));
                }
                $urlBuscarMarcadores = '';
                foreach ($_GET as $key => $val) {
                    $urlBuscarMarcadores .= '&' . $key . '=' . $val;
                }
                $this->data['urlBuscarMarcadores'] = $urlBuscarMarcadores;
            }


            $this->data['inmobiliaria'] = $inmobiliaria;
            $estado = new estado();
            $this->data['estados'] = $this->db()->find($estado);
            $this->data['tipos'] = $this->db()->find(new tipoInmueble());
            $this->renderc('perfil/buscarMapa', $this->data);
        } else {//La inmobiliaria solicitada no existe
            $this->renderc('errores/error404');
        }
    }

}

?>