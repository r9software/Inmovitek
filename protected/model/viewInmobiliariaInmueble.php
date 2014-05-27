<?php

Doo::loadCore('db/DooModel');

class viewInmobiliariaInmueble extends DooModel {

    public $id_inmueble;
    public $fecha_registro;
    public $id_tipo_inmueble;
    public $metros_cuadrados;
    public $num_recamaras;
    public $num_sanitarios;
    public $alberca;
    public $cochera;
    public $num_autos_cochera;
    public $num_plantas;
    public $precio;
    public $detalles;
    public $venta_renta;
    public $id_usuario;
    public $vendida_rentada;
    public $id_propietario;
    public $activo;
    public $id_inmobiliaria;
    public $_table = 'vw_inmobiliaria_inmueble';
    public $_primarykey = 'id_inmueble';
    public $_fields = array('id_inmueble', 'fecha_registro', 'id_tipo_inmueble', 'metros_cuadrados', 'num_recamaras', 'num_sanitarios', 'alberca', 'cochera', 'num_autos_cochera', 'num_plantas', 'precio', 'detalles', 'venta_renta', 'id_usuario', 'vendida_rentada', 'id_propietario', 'activo', 'id_inmobiliaria');

    //Constructor
    function __construct() {
        parent::$className = __CLASS__;
    }

}

?>