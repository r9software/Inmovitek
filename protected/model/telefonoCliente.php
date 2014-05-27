<?php
Doo::loadCore('db/DooModel');
class telefonoCliente extends DooModel{
	public $id_telefono_cliente;
	public $id_cliente;
	public $telefono_cliente;

	public $_table = 'ct_telefono_cliente';
	public $_primarykey = 'id_telefono_cliente';
	public $_fields = array('id_telefono_cliente','id_cliente','telefono_cliente');
	
	//Constructor
	function __construct(){
		parent::$className = __CLASS__;
	}
    public function getRules() {
        //edited for inserting Comments
        return array(
            'telefono_cliente' => array(
                array( 'maxlength',50, 'El telefono no puede contener mas de 50 caracteres' ),
                array( 'notempty', 'El telefono no puede estar vacio' ),
                array( 'notnull' ),
            ),
        );
    }
}
?>