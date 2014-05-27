<?php
Doo::loadCore('db/DooModel');
class inmueble extends DooModel{
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
	
	public $_table = 'ct_inmueble';
	public $_primarykey = 'id_inmueble';
	public $_fields = array('id_inmueble','fecha_registro','id_tipo_inmueble','metros_cuadrados','num_recamaras','num_sanitarios','alberca','cochera','num_autos_cochera','num_plantas','precio','detalles','venta_renta','id_usuario','vendida_rentada','id_propietario','activo');
	
	//Constructor
	function __construct(){
		parent::$className = __CLASS__;
	}
    public function getRules() {
        //edited for inserting Comments
        return array(
            'fecha_registro' => array(
                array('date','Ingrese una fecha valida'),
                array( 'notempty', 'La fecha no puede estar vacia' ),
                array( 'notnull' ),
            ),
            'metros_cuadrados' => array(
                array('float','Ingrese un valor valido'),
                array( 'notempty', 'La extension del terreno no puede estar vacia' ),
                array( 'notnull' ),
            ),
            'num_recamaras' => array(
                array('integer','Ingrese un numero valido'),
                array( 'notempty', 'Este numero no puede estar vacio' ),
                array( 'notnull' ),
            ),
            'num_sanitarios' => array(
                array('integer','Ingrese un mumero valido'),
                array( 'notempty', 'El numero de sanitarios no puede estar vacio' ),
                array( 'notnull' ),
            ),
            'alberca' => array(
                array('integer','Ingrese un numero valido'),
                array( 'notempty', 'La alberca no puede estar vacia' ),
                array( 'notnull' ),
            ),
            'cochera' => array(
                array('integer','Ingrese un numero valido'),
                array( 'notempty', 'Este valor no puede estar vacio' ),
                array( 'notnull' ),
            ),
            'num_autos_cochera' => array(
                array('integer','Ingrese un numero valido'),
                array( 'notempty', 'Este numero no puede estar vacio' ),
                array( 'notnull' ),
            ),
            'num_plantas' => array(
                array('integer','Ingrese un numero valido'),
                array( 'notempty', 'Este numero no puede estar vacio' ),
                array( 'notnull' ),
            ),
            'precio' => array(
                array('float','Ingrese un numero valido'),
                array( 'notempty', 'El precio no puede estar vacio' ),
                array( 'notnull' ),
            ),
            'detalles' => array(
                array( 'detalles' ),
                array( 'optional' ),
            ),
            'venta_renta' => array(
                array('integer','Ingrese un numero valido'),
                array( 'notempty', 'Este valor no puede estar vacio' ),
                array( 'notnull' ),
            ),
            'vendida_rentada' => array(
                array('integer','Ingrese un numero valido'),
                array( 'notempty', 'El valor no puede estar vacio' ),
                array( 'notnull' ),
            ),
            'activo' => array(
                array('integer','Ingrese un numero valido'),
                array( 'notempty', 'El valor no puede estar vacio' ),
                array( 'notnull' ),
            ),
            'inmobiliaria_activa' => array(
                array('integer','Ingrese un entero'),
                array( 'maxlength',1, 'El identificador no puede contener mas de 1 caracteres' ),
                array( 'notempty', 'El identificador no puede estar vacio' ),
                array( 'notnull' ),
            ),
        );
    }
}
?>