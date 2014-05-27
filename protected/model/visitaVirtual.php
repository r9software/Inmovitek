<?php
Doo::loadCore('db/DooModel');
class visitaVirtual extends DooModel{
	public $id_visitavirtual;
	public $id_inmueble;
	public $nombre_habitacion;
	public $url_visitavirtual;

	public $_table = 'ct_visita_virtual';
	public $_primarykey = 'id_visitavirtual';
	public $_fields = array('id_visitavirtual','id_inmueble','nombre_habitacion','url_visitavirtual');
	
	//Constructor
	function __construct(){
		parent::$className = __CLASS__;
	}
    public function getRules() {
        //edited for inserting Comments
        return array(
            'nombre_habitacion' => array(
                array( 'maxlength',150, 'El Nombre no puede contener mas de 150 caracteres' ),
                array( 'notempty', 'El nombre no puede estar vacio' ),
                array( 'notnull' ),
            ),

            'url_visitavirtual' => array(
                array( 'maxlength',150, 'La url no puede contener mas de 150 caracteres' ),
                array( 'notempty', 'La Url no puede estar vacio' ),
                array( 'notnull' ),
            ),
    );
    }

}
?>