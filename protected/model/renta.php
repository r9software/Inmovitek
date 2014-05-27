<?php
Doo::loadCore('db/DooModel');
class renta extends DooModel{
	public $id_renta;
	public $id_inmueble;
	public $cliente_alquila;
	public $fecha_registro;
	public $periodo_renta;
	public $precio_renta;
	public $proximo_cobro;
	public $anotaciones;
	
	public $_table = 'ct_renta';
	public $_primarykey = 'id_renta';
	public $_fields = array('id_renta','id_inmueble','cliente_alquila','fecha_registro','periodo_renta','precio_renta','proximo_cobro','anotaciones');
	
	//Constructor
	function __construct(){
		parent::$className = __CLASS__;
	}
    public function getRules() {
        //edited for inserting Comments
        return array(
            'fecha_registro' => array(
                array('date','Ingrese una fecha valida'),
                array( 'notempty', 'El nombre no puede estar vacio' ),
                array( 'notnull' ),
            ),
            'periodo_renta' => array(
                array('integer','Ingrese un numero en el periodo de renta'),
                array( 'notempty', 'El periodo no puede estar vacio' ),
                array( 'notnull' ),
            ),
            'precio_renta' => array(
                array('float','Ingrese un precio de renta'),
                array( 'notempty', 'El precio no puede estar vacio' ),
                array( 'notnull' ),
            ),
            'proximo_cobro' => array(
                array('date','Ingrese una fecha valida'),
                array( 'optional' ),
            ),
            'anotaciones' => array(
                array( 'anotaciones' ),
                array( 'notnull' ),
            ),
        );
    }
}
?>