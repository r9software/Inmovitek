<?php
Doo::loadCore('db/DooModel');
class tipoInmueble extends DooModel{
	public $id_tipo_inmueble;
	public $tipo_inmueble;
	
	public $_table = 'ct_tipo_inmueble';
	public $_primarykey = 'id_tipo_inmueble';
	public $_fields = array('id_tipo_inmueble','tipo_inmueble');
	
	//Constructor
	function __construct(){
		parent::$className = __CLASS__;
	}
    public function getRules() {
        //edited for inserting Comments
        return array(
            'tipo_inmueble' => array(
                array( 'maxlength',200, 'El tipo no puede contener mas de 200 caracteres' ),
                array( 'notempty', 'El tipo no puede estar vacio' ),
                array( 'notnull' ),
            ),);
    }
}
?>