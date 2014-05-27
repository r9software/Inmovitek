<?php
Doo::loadCore('db/DooModel');
class usuario extends DooModel{
	public $id_usuario;
	public $nombre_usuario;
	public $id_inmobiliaria;
	public $nombres;
	public $apellido_p;
	public $apellido_m;
	public $correo;
	public $password;
	public $telefono_casa;
	public $telefono_celular;
	public $fecha_alta;
	public $fecha_nacimiento;
	public $usuario_activo;
        public $tokenGoogleAccount;

	public $_table = 'ct_usuario';
	public $_primarykey = 'id_usuario';
	public $_fields = array('id_usuario','nombre_usuario','id_inmobiliaria','nombres','apellido_p','apellido_m','correo','password','telefono_casa','telefono_celular','fecha_alta','fecha_nacimiento','usuario_activo','tokenGoogleAccount');
	
	//Constructor
	function __construct(){
        parent::$className = __CLASS__; 
    }
	
    public function getVRules() {
        return array(
            'nombre_usuario' => array(
                array('maxlength',60,'El nombre es demasiado largo'),
                array( 'optional' ),
            ),
            'nombres' => array(
                array('maxlength',50,'El nombre no puede tener mas de 50 caracteres'),
                array( 'notempty', 'El nombre no puede estar vacio' ),
                array( 'optional' ),
            ),
            'apellido_p' => array(
                array('maxlength',40,'El apellido no puede tener mas de 40 caracteres'),
                array( 'notempty', 'El apellido Paterno no puede estar vacio' ),
                array( 'optional' ),
            ),
            'apellido_m' => array(
                array('maxlength',40,'El apellido no puede tener mas de 40 caracteres'),
                array( 'notempty', 'El apellido Materno no puede estar vacio' ),
                array( 'optional' ),
            ),
            'correo' => array(
                array('maxlength',40,'El correo no puede tener mas de 40 caracteres'),
                array( 'notempty', 'El correo no puede estar vacio' ),
                array( 'notnull' ),
            ),
            'password' => array(
                array('maxlength',80,'La contraseña no puede tener mas de 80 caracteres'),
                array( 'notempty', 'La contraseña no puede estar vacia' ),
                array( 'notnull' ),
            ),
            'telefono_casa' => array(
                array('maxlength',40,'El telefono no puede tener mas de 40 caracteres'),
                array( 'optional' ),
            ),
            'telefono_celular' => array(
                array('maxlength',40,'El telefono no puede tener mas de 40 caracteres'),
                array( 'optional' ),
            ),
            'fecha_alta' => array(
                array('date','Ingrese una fecha valida'),
                array( 'notempty', 'El valor de esta fecha no puede estar vacio' ),
                array( 'notnull' ),
            ),
            'fecha_nacimiento' => array(
                array( 'fecha_nacimiento' ),
                array( 'optional' ),
            ),
            'usuario_activo' => array(
                array('integer','Ingrese un numero valido'),
                array( 'notempty', 'Este valor no puede estar vacio' ),
                array( 'notnull' ),
            ),
        );
    }
}
?>