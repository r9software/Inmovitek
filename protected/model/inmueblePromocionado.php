<?php
Doo::loadCore('db/DooModel');
class inmueblePromocionado extends DooModel{
	public $id_inmueble;
	public $rank;
	public $no_clicks;
	public $promocion_inicia;
	public $promocion_termina;
	
	public $_table = 'ct_inmueble_promocionado';
	public $_primarykey = 'id_inmueble';
	public $_fields = array('id_inmueble','rank','no_clicks','promocion_inicia','promocion_termina');
	
	//Constructor
	function __construct(){
		parent::$className = __CLASS__;
	}
    public function getRules() {
        //edited for inserting Comments
        return array(
            'rank' => array(
                array('float','Ingrese un valor valido'),
                array( 'notempty', 'El rank no puede estar vacio' ),
                array( 'notnull' ),
            ),
            'no_clicks' => array(
                array('integer','Ingrese un valor valido'),
                array( 'notempty', 'El numero no puede estar vacio' ),
                array( 'notnull' ),
            ),
            'promocion_inicia' => array(
                array('date','Ingrese una fecha valida'),
                array( 'notempty', 'Esta fecha no puede estar vacia' ),
                array( 'notnull' ),
            ),
            'promocion_termina' => array(
                array('date','Ingrese una fecha valida'),
                array( 'notempty', 'Esta fecha  no puede estar vacia' ),
                array( 'notnull' ),
            ),
        );
    }
}

?>