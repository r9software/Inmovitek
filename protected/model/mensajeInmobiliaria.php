<?php
Doo::loadCore('db/DooModel');
class mensajeInmobiliaria extends DooModel{
	public $id_mensaje;
	public $id_inmobiliaria_emisor;
	public $id_inmobiliaria_receptor;
	public $asunto;
	public $mensaje;
	public $fecha;
	public $leido;
	public $fecha_leido;
	public $status_emisor;
	public $status_receptor;
	
	public $_table = 'ht_mensaje_inmobiliaria';
	public $_primarykey = 'id_mensaje';
	public $_fields = array('id_mensaje','id_inmobiliaria_emisor','id_inmobiliaria_receptor','asunto','mensaje','fecha','leido','fecha_leido','status_emisor','status_receptor');
	
	//Constructor
	function __construct(){
		parent::$className = __CLASS__;
	}
    public function getRules() {
        //edited for inserting Comments
        return array(
            'status_receptor' => array(
                array('integer','Ingrese un numero valido'),
                array( 'notempty', 'Este valor no puede estar vacio' ),
                array( 'notnull' ),
            ),
            'status_emisor' => array(
                array('integer','Ingrese un numero valido'),
                array( 'notempty', 'Este valor no puede estar vacio' ),
                array( 'notnull' ),
            ),
            'fecha_leido' => array(
                array('datetime','Ingresa la fechas valida'),
                array( 'notempty', 'El valor fecha  no puede estar vacio' ),
                array( 'notnull' ),
            ),
            'leido' => array(
                array('integer','Ingrese un numero valido'),
                array( 'notempty', 'Este valor no puede estar vacio' ),
                array( 'notnull' ),
            ),
            'fecha' => array(
                array('datetime','Ingresa una fecha valida'),
                array( 'notempty', 'La fecha no puede estar vacio' ),
                array( 'notnull' ),
            ),
            'mensaje' => array(
                array( 'notempty', 'El mensaje no puede estar vacio' ),

                array( 'notnull' ),
            ),
            'asunto' => array(
                array('maxlength',200,'El asunto no puede tener mas de 200 caracteres'),
                array( 'notempty', 'La fecha no puede estar vacio' ),

                array( 'notnull' ),
            ),

        );
    }
}
?>