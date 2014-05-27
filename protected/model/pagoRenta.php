<?php
Doo::loadCore('db/DooModel');
class pagoRenta extends DooModel{
	public $id_pago_renta;
	public $id_renta;
	public $cantidad_pagada;
	public $fecha_pago;
	public $periodo;
	
	public $_table = 'ht_pago_renta';
	public $_primarykey = 'id_pago_renta';
	public $_fields = array('id_pago_renta','id_renta','cantidad_pagada','fecha_pago','periodo');
	
	//Constructor
	function __construct(){
		parent::$className = __CLASS__;
	}
    public function getRules() {
        //edited for inserting Comments
        return array(
            'cantidad_pagada' => array(
                array('float','Ingrese un numero valido'),
                array( 'notempty', 'Este valor no puede estar vacio' ),
                array( 'notnull' ),
            ),
            'fecha_pago' => array(
                array('date','Ingrese una fecha valida'),
                array( 'notempty', 'Este valor no puede estar vacio' ),
                array( 'notnull' ),
            ),
            'periodo' => array(
                array('maxlength',250,'El periodo es demasiado largo'),
                array( 'notempty', 'El valor periodo  no puede estar vacio' ),
                array( 'notnull' ),
            ),

        );
    }
}
?>