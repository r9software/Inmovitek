<?php
Doo::loadCore('db/DooModel');
class fotoInmueble extends DooModel{
	public $id_foto;
	public $id_inmueble;
	public $url_imagen;
	
	public $_table = 'ct_foto_inmueble';
	public $_primarykey = 'id_foto';
	public $_fields = array('id_foto','id_inmueble','url_imagen');
	
	//Constructor
	function __construct(){
		parent::$className = __CLASS__;
	}
    public function getRules() {
        //edited for inserting Comments
        return array(
            'url_imagen' => array(
                array( 'maxlength',250, 'La URL no puede contener mas de 250 caracteres' ),
                array( 'notempty', 'La Url no puede estar vacio' ),
                array( 'notnull' ),
            ),
        );
    }
}
?>