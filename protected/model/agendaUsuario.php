<?php
Doo::loadCore('db/DooModel');
class agendaUsuario extends DooModel{
	public $id_registro;
	public $id_usuario;
	public $titulo;
	public $detalles;
	public $fecha_inicio;
	public $fecha_termino;

	public $_table = 'ht_agenda_usuario';
	public $_primarykey = 'id_registro';
	public $_fields = array('id_registro','id_usuario','titulo','detalles','fecha_inicio','fecha_termino');
	
	//Constructor
	function __construct(){
		parent::$className = __CLASS__;
	}
    public function getRules() {
        //edited for inserting Comments
        return array(
            'titulo' => array(
                array( 'maxlength',200, 'El titulo no puede contener mas de 200 caracteres' ),
                array( 'notempty', 'El titulo no puede estar vacio' ),
                array( 'notnull' ),
            ),

            'detalles' => array(
                array( 'notempty', 'Detalles no puede estar vacio' ),
                array( 'notnull' ),
            ),

            'fecha_inicio' => array(
                array( 'notempty', 'La fecha de inicio no puede estar vacio' ),
                array( 'notnull'),
            ),


            'fecha_termino' => array(
                array( 'fecha_termino'),
                array( 'optional' ),
            ),
        );
    }
}
?>