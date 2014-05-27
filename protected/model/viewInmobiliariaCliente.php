<?php
Doo::loadCore('db/DooModel');
class viewInmobiliariaCliente extends DooModel{
	public $id_cliente;
	public $id_usuario;
	public $nombre;
	public $correo;
	public $telefono;
	public $horario_llamada;
	public $anotaciones;
	public $fecha_alta;
	public $id_inmobiliaria;
	
	public $_table = 'ct_cliente';
	public $_primarykey = 'id_cliente';
	public $_fields = array('id_cliente','id_usuario','nombre','correo','telefono','horario_llamada','anotaciones','fecha_alta','id_inmobiliaria');
	
	//Constructor
	function __construct(){
		parent::$className = __CLASS__;
	}
    public function getRules() {
        //edited for inserting Comments
        return array(
            'nombre' => array(
                array( 'maxlength',250, 'El nombre no puede contener mas de 250 caracteres' ),
                array( 'notempty', 'El Nombre no puede estar vacio' ),
                array( 'notnull' ),
            ),

            'correo' => array(
                array( 'maxlength',45, 'El correo no puede contener mas de 45 caracteres' ),
                array( 'correo' ),
                array( 'optional' ),
            ),

            'telefono' => array(
                array( 'maxlength',80, 'El telefono no puede contener mas de 80 caracteres' ),
                array( 'telefono' ),
                array( 'optional'),
            ),


            'horario_llamada' => array(
                array( 'maxlength',140, 'El horario de llamada no puede contener mas de 140 caracteres' ),
                array( 'horario_llamada'),
                array( 'optional' ),
            ),
            'anotaciones' => array(
                array( 'anotaciones'),
                array( 'optional' ),
            ),
            'fecha_alta' => array(
                array( 'date','Ingrese una fecha valida' ),
                array( 'notempty', 'La fecha no puede estar vacia' ),
                array( 'notnull' ),
            ),
        );
    }
}
?>