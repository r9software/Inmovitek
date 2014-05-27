<?php
Doo::loadCore('db/DooModel');
class direccionInmueble extends DooModel{
	public $id_inmueble;
	public $id_estado;
	public $calle_no;
	public $colonia;
	public $municipio;
	public $cp;
	public $latitud;
	public $longitud;
	public $domicilio_completo;
	
	public $_table = 'ct_direccion_inmueble';
	public $_primarykey = 'id_inmueble';
	public $_fields = array('id_inmueble','id_estado','calle_no','colonia','municipio','cp','latitud','longitud','domicilio_completo');
	
	//Constructor
	function __construct(){
		parent::$className = __CLASS__;
	}
    public function getRules() {
        //edited for inserting Comments
        return array(
            'calle_no' => array(
                array( 'maxlength',200, 'El numero de calle no puede ser superior a 200 digitos' ),
                array( 'notempty', 'Este numero no puede estar vacio' ),
                array( 'notnull' ),
            ),

            'colonia' => array(
                array( 'maxlength',100, 'El nombre de la colonia no puede ser superior a 100' ),
                array( 'notempty','La colonia no puede estar vacio' ),
                array( 'notnull' ),
            ),

            'municipio' => array(
                array( 'maxlength',100, 'El municipio no puede contener mas de 100 caracteres' ),
                array( 'notempty','El municipio no puede estar vacio' ),
                array( 'notnull' ),
            ),


            'cp' => array(
                array( 'integer','Ingrese un entero  valido' ),
                array( 'maxlength',6, 'El Codigo Postal no puede contener mas de 6 digitos' ),
                array( 'notempty','El Codigo Postal no puede estar vacio' ),
                array( 'notnull' ),
            ),
            'latitud' => array(
                array( 'double','Ingrese una latitud valida' ),
               array( 'notempty','La latitud no puede estar vacia' ),
                array( 'notnull' ),
            ),
            'longitud' => array(
                array( 'double','Ingrese una longitud valida' ),
                array( 'notempty','La longitud no puede estar vacia' ),
                array( 'notnull' ),
            ),
            'domicilio_completo' => array(
                array( 'maxlength',250, 'El Domicilio no puede contener mas de 250 caracteres' ),
                array( 'notempty','El Codigo Postal no puede estar vacio' ),
                array( 'notnull' ),
            ),
        );
    }
}
?>