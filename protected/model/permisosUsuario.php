<?php
Doo::loadCore('db/DooModel');
class permisosUsuario extends DooModel{
	public $id_usuario;
	public $administrar_permisos;
	public $agenda;
	public $administrar_usuarios;
	public $registrar_venta;
	public $registrar_inmueble;
	public $registrar_cliente;
	public $eliminar_inmueble;
	public $eliminar_cliente;
	public $registrar_pago_renta;
	public $mensajes_inmobiliarias;
	public $mensajes_usuarios;
	public $inmobiliaria_amiga;
        public $administrar_inmobiliaria;

	public $_table = 'ct_permisos_usuario';
	public $_primarykey = 'id_usuario';
	public $_fields = array('id_usuario','administrar_permisos','agenda','administrar_usuarios','registrar_venta','registrar_inmueble','registrar_cliente','eliminar_inmueble','eliminar_cliente','registrar_pago_renta','mensajes_inmobiliarias','mensajes_usuarios','inmobiliaria_amiga','administrar_inmobiliaria');
	
	//Constructor
	function __construct(){
		parent::$className = __CLASS__;
	}
    public function getRules() {
        //edited for inserting Comments
        return array(
            'administrar_permisos' => array(
                array('integer','Ingrese un numero valido'),
                array( 'notempty', 'Este valor no puede estar vacio' ),
                array( 'notnull' ),
            ),
            'agenda' => array(
                array('integer','Ingrese un numero valido'),
                array( 'notempty', 'Este valor no puede estar vacio' ),
                array( 'notnull' ),
            ),
            'administrar_usuarios' => array(
                array('integer','Ingrese un numero valido'),
                array( 'notempty', 'Este valor no puede estar vacio' ),
                array( 'notnull' ),
            ),
            'registrar_venta' => array(
                array('integer','Ingrese un numero valido'),
                array( 'notempty', 'Este valor no puede estar vacio' ),
                array( 'notnull' ),
            ),
            'registrar_inmueble' => array(
                array('integer','Ingrese un numero valido'),
                array( 'notempty', 'Este valor no puede estar vacio' ),
                array( 'notnull' ),
            ),
            'registrar_cliente' => array(
                array('integer','Ingrese un numero valido'),
                array( 'notempty', 'Este valor no puede estar vacio' ),
                array( 'notnull' ),

            ),
            'eliminar_inmueble' => array(
                array('integer','Ingrese un numero valido'),
                array( 'notempty', 'Este valor no puede estar vacio' ),
                array( 'notnull' ),
            ),
            'eliminar_cliente' => array(
                array('integer','Ingrese un numero valido'),
                array( 'notempty', 'Este valor no puede estar vacio' ),
                array( 'notnull' ),
            ),
            'registrar_pago_renta' => array(
                array('integer','Ingrese un numero valido'),
                array( 'notempty', 'Este valor no puede estar vacio' ),
                array( 'notnull' ),
            ),
            'mensajes_inmobiliarias' => array(
                array('integer','Ingrese un numero valido'),
                array( 'notempty', 'Este valor no puede estar vacio' ),
                array( 'notnull' ),
            ),
            'mensajes_usuarios' => array(
                array('integer','Ingrese un numero valido'),
                array( 'notempty', 'Este valor no puede estar vacio' ),
                array( 'notnull' ),
            ),
            'inmobiliaria_amiga' => array(
                array('integer','Ingrese un numero valido'),
                array( 'notempty', 'Este valor no puede estar vacio' ),
                array( 'notnull' ),
            ),
        );
    }


	function setPermisosUsuarioGratuito(){
		$this -> administrar_permisos = 0;
		$this -> agenda = 0;
		$this -> administrar_usuarios = 0;
		$this -> registrar_venta = 1;
		$this -> registrar_inmueble = 1;
		$this -> registrar_cliente = 1;
		$this -> eliminar_inmueble = 1;
		$this -> eliminar_cliente = 1;
		$this -> registrar_pago_renta = 0;
		$this -> mensajes_inmobiliarias = 0;
		$this -> mensajes_usuarios = 0;
		$this -> inmobiliaria_amiga = 0;
                $this -> administrar_inmobiliaria = 0;
	}
	
	function setPermisosNuevaInmobiliaria(){
		$this -> administrar_permisos = 1;
		$this -> agenda = 1;
		$this -> administrar_usuarios = 1;
		$this -> registrar_venta = 1;
		$this -> registrar_inmueble = 1;
		$this -> registrar_cliente = 1;
		$this -> eliminar_inmueble = 1;
		$this -> eliminar_cliente = 1;
		$this -> registrar_pago_renta = 1;
		$this -> mensajes_inmobiliarias = 1;
		$this -> mensajes_usuarios = 1;
		$this -> inmobiliaria_amiga = 1;
                $this -> administrar_inmobiliaria = 1;
	}
}
?>