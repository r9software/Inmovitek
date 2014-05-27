<?php

Doo::loadCore('db/DooModel');

class licencia extends DooModel {

    public $licencia;
    public $activacion;
    public $numero_usuarios;
    public $usuarios_activos;
    public $fecha_activacion;
    public $fecha_termino;
    public $_table = 'ct_licencia';
    public $_primarykey = 'licencia';
    public $_fields = array('licencia', 'activacion', 'numero_usuarios', 'usuarios_activos', 'fecha_activacion', 'fecha_termino');

    //Constructor
    function __construct() {
        parent::$className = __CLASS__;
    }

    public function getVRules() {
        //edited for inserting Comments
        return array(
            'licencia' => array(
                array('integer', 'Ingrese un numero valido'),
                array('notempty', 'La licencia no puede estar vacia'),
                array('notnull'),
            ),
            'activacion' => array(
                array('integer', 'Ingrese un valor valido'),
                array('notempty', 'La activacion no puede estar vacia'),
                array('notnull'),
            ),
            'numero_usuarios' => array(
                array('integer', 'Ingrese un numero valido'),
                array('notempty', 'Este numero no puede estar vacio'),
                array('notnull'),
            ),
            'usuarios_activos' => array(
                array('integer', 'Ingrese un mumero valido'),
                array('notempty', 'El numero  no puede estar vacio'),
                array('notnull'),
            ),
            'fecha_activacion' => array(
                array('date', 'Ingrese una fecha valida'),
                array('notempty', 'La alberca no puede estar vacia'),
                array('notnull'),
            ),
            'fecha_termino' => array(
                array('date', 'Ingrese una fecha valida'),
                array('notempty', 'Este valor no puede estar vacio'),
                array('notnull'),
            ),
        );
    }

    function activaLicencia() {
        $this->activacion = 1;
        $this->fecha_activacion = date("Y-m-d");
        $ProxAnio = date("Y") + 1;
        $this->fecha_termino = $ProxAnio . date("-m-d");
        $this->usuarios_activos = 1;
    }

    public static function generaLicencia() {
        $longitud = 29;
        $key = '';
        $pattern = '1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ';
        $max = strlen($pattern) - 1;
        for ($i = 0; $i < $longitud; $i++)
            $key .= $pattern{mt_rand(0, $max)};
        $key{5} = '-';
        $key{11} = '-';
        $key{17} = '-';
        $key{23} = '-';
        return $key;
    }

}

?>