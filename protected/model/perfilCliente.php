<?php
Doo::loadCore('db/DooModel');
class perfilCliente extends DooModel{
	public $id_cliente;
	public $id_estado_busca_inmueble;
	public $id_tipo_inmueble;
	public $no_habitaciones_min;
	public $no_habitaciones_max;
	public $alberca;
	public $no_sanitarios_min;
	public $no_sanitarios_max;
	public $cochera;
	public $no_plantas;
	public $rango_precio_min;
	public $rango_precio_max;
	public $compra_renta;
	
	public $_table = 'ct_perfil_cliente';
	public $_primarykey = 'id_cliente';
	public $_fields = array('id_cliente','id_estado_busca_inmueble','id_tipo_inmueble','no_habitaciones_min','no_habitaciones_max','alberca','no_sanitarios_min','no_sanitarios_max','cochera','no_plantas','rango_precio_min','rango_precio_max','compra_renta');
	
	//Constructor
	function __construct(){
		parent::$className = __CLASS__;
	}
    public function getRules() {
        //edited for inserting Comments
        return array(
            'no_habitaciones_min' => array(
                array('integer','Ingrese un numero valido'),
                array( 'notempty', 'Este valor no puede estar vacio' ),
                array( 'notnull' ),
            ),
            'no_habitaciones_max' => array(
                array('integer','Ingrese un numero valido'),
                array( 'notempty', 'Este valor no puede estar vacio' ),
                array( 'notnull' ),
            ),
            'alberca' => array(
                array('integer','Ingrese un numero valido'),
                array( 'notempty', 'Este valor no puede estar vacio' ),
                array( 'notnull' ),
            ),
            'no_sanitarios_min' => array(
                array('integer','Ingrese un numero valido'),
                array( 'notempty', 'Este valor no puede estar vacio' ),
                array( 'notnull' ),
            ),
            'no_sanitarios_max' => array(
                array('integer','Ingrese un numero valido'),
                array( 'notempty', 'Este valor no puede estar vacio' ),
                array( 'notnull' ),
            ),
            'cochera' => array(
                array('integer','Ingrese un numero valido'),
                array( 'notempty', 'Este valor no puede estar vacio' ),
                array( 'notnull' ),

            ),
            'no_plantas' => array(
                array('integer','Ingrese un numero valido'),
                array( 'notempty', 'Este valor no puede estar vacio' ),
                array( 'notnull' ),
            ),
            'rango_precio_min' => array(
                array('integer','Ingrese un numero valido'),
                array( 'notempty', 'Este valor no puede estar vacio' ),
                array( 'notnull' ),
            ),
            'rango_precio_max' => array(
                array('integer','Ingrese un numero valido'),
                array( 'notempty', 'Este valor no puede estar vacio' ),
                array( 'notnull' ),
            ),
            'compra_renta' => array(
                array('integer','Ingrese un numero valido'),
                array( 'notempty', 'Este valor no puede estar vacio' ),
                array( 'notnull' ),
            ),

        );
    }
}
?>