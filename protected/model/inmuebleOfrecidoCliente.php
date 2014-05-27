<?php
Doo::loadCore('db/DooModel');
class inmuebleOfrecidoCliente extends DooModel{
	public $id_cliente;
	public $id_inmueble;
	
	public $_table = 'rl_inmueble_ofrecido_cliente';
	public $_primarykey = array('id_cliente','id_inmueble');
	public $_fields = array('id_cliente','id_inmueble');
	
	//Constructor
	function __construct(){
		parent::$className = __CLASS__;
	}
}
?>