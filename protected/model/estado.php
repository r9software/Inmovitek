<?php
Doo::loadCore('db/DooModel');
class estado extends DooModel{
	public $id_estado;
	public $nombre;
        public $codigo_estado;
        public $latitud;
        public $longitud;

	public $_table = 'ct_estado';
	public $_primarykey = 'id_estado';
	public $_fields = array('id_estado','nombre','codigo_estado','latitud','longitud');
	
	//Constructor
	function __construct(){
		parent::$className = __CLASS__;
	}
    public function getRules() {
        //edited for inserting Comments
        return array(
            'nombre' => array(
                array( 'maxlength',100, 'El nombre no puede contener mas de 100 caracteres' ),
                array( 'notempty', 'El nombre no puede estar vacio' ),
                array( 'notnull' ),
            ),
        );
    }
}
?>