<?php
Doo::loadCore('db/DooModel');
class telefonoInmobiliaria extends DooModel{
	public $id_telefono;
	public $id_inmobiliaria;
	public $telefono_inmobiliaria;
	
	public $_table = 'ct_telefono_inmobiliaria';
	public $_primarykey = 'id_telefono';
	public $_fields = array('id_telefono','id_inmobiliaria','telefono_inmobiliaria');
	
	//Constructor
	function __construct(){
		parent::$className = __CLASS__;
	}
    public function getRules() {
        //edited for inserting Comments
        return array(
            'telefono_inmobiliaria' => array(
                array( 'maxlength',50, 'El telefono no puede contener mas de 50 caracteres' ),
                array( 'notempty', 'El telefono no puede estar vacio' ),
                array( 'notnull' ),
            ),
        );
    }
}
?>