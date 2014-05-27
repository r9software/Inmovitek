<?php
Doo::loadCore('db/DooModel');
class inmobiliariaAmiga extends DooModel{
	public $id_inmobiliaria;
	public $id_inmobiliaria_amiga;
	
	public $_table = 'rl_inmobiliaria_amiga';
	public $_primarykey = array('id_inmobiliaria','id_inmobiliaria_amiga');
	public $_fields = array('id_inmobiliaria','id_inmobiliaria_amiga');
	
	//Constructor
	function __construct(){
		parent::$className = __CLASS__;
	}
}
?>