<?php
Doo::loadCore('db/DooModel');
class venta extends DooModel{
	public $id_venta;
	public $id_inmueble;
	public $id_vendedor;
	public $id_comprador;
	public $precio_venta;
	public $ganancia_venta;
	public $fecha_venta;
	public $anotaciones;
	

	public $_table = 'ht_venta';
	public $_primarykey = 'id_venta';
	public $_fields = array('id_venta','id_inmueble','id_vendedor','id_comprador','precio_venta','ganancia_venta','fecha_venta','anotaciones');
	
	//Constructor
	function __construct(){
		parent::$className = __CLASS__;
	}
    public function getRules() {
        //edited for inserting Comments
        return array(
            'precio_venta' => array(
                array( 'float','Ingrese un valor valido'),
                array( 'notempty', 'El precio no puede estar vacio' ),
                array( 'notnull' ),
            ),

            'ganancia_venta' => array(
                array( 'float','Ingrese un valor valido'),
                array( 'optional' ),
            ),
            'fecha_venta' => array(
                array( 'date','Ingrese una fecha valida' ),
                array( 'notempty', 'La fecha no puede estar vacia' ),
                array( 'notnull' ),
            ),
            'anotaciones' => array(
                array( 'anotaciones'),
                array( 'optional' ),
            ),

        );
    }
}
?>