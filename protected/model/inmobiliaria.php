<?php
Doo::loadCore('db/DooModel');
class inmobiliaria extends DooModel{
	public $id_inmobiliaria;
	public $identificador;
	public $nombre;
	public $licencia;
	public $directorio_archivos;
	public $url_logo;
	public $inmobiliaria_activa;
	
	public $_table = 'ct_inmobiliaria';
	public $_primarykey = 'id_inmobiliaria';
	public $_fields = array('id_inmobiliaria','identificador','nombre','licencia','directorio_archivos','url_logo','inmobiliaria_activa');
	
	//Constructor
	function __construct(){
		parent::$className = __CLASS__;
	}
    public function getVRules() {
        return array(
            'identificador' => array(
                array( 'maxlength',50, 'El identificador no puede contener mas de 50 caracteres' ),
                array( 'optional' ),
            ),
            'nombre' => array(
                array( 'maxlength',100, 'El nombre no puede contener mas de 100 caracteres' ),
                array( 'notempty', 'El nombre no puede estar vacio' ),
                array( 'notnull' ),
            ),
            'licencia' => array(
                array( 'maxlength',30, 'La licencia no puede contener mas de 30 caracteres' ),
                array( 'notempty', 'La licencia no puede estar vacio' ),
                array( 'notnull' ),
            ),
            'directorio_archivos' => array(
                array( 'maxlength',250, 'El directorio no puede contener mas de 140 caracteres' ),
                array( 'notempty', 'El directorio no puede estar vacio' ),
                array( 'notnull' ),
            ),
            'url_logo' => array(
                array( 'maxlength',250, 'La url no puede contener mas de 140 caracteres' ),
                array( 'optional' ),
            ),
            'inmobiliaria_activa' => array(
                array('integer','Ingrese un entero'),
                array( 'maxlength',1, 'El identificador no puede contener mas de 1 caracteres' ),
                array( 'notempty', 'El identificador no puede estar vacio' ),
                array( 'notnull' ),
            ),
        );
    }
}
?>