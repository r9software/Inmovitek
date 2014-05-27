<?php
Doo::loadCore('db/DooModel');
class limiteUsuario extends DooModel{
	public $id_usuario;
	public $limite_inmuebles;
	public $caducidad_cuenta;
	
	public $_table = 'ct_limite_usuario';
	public $_primarykey = 'id_usuario';
	public $_fields = array('id_usuario','limite_inmuebles','caducidad_cuenta');
	
	//Constructor
	function __construct(){
		parent::$className = __CLASS__;
	}
    public function getRules() {
        //edited for inserting Comments
        return array(
            'limite_inmuebles' => array(
                array('integer','Ingrese un numero valido'),
                array( 'notempty', 'El limite no puede estar vacio' ),
                array( 'notnull' ),
            ),
            'caducidad_cuenta' => array(
                array('date','Ingrese una fecha valida'),
                array( 'notempty', 'La Caducidad no puede estar vacia' ),
                array( 'notnull' ),
            ),
        );
    }
}
?>