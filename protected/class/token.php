<?php

class token {

    protected $token; // md5($_SERVER['REMOTE_ADDR'].$_SERVER['REMOTE_HOST']);
    protected $ip;

    //protected $remoteHost;

    function __construct() {
        //$this->ip = $_SERVER['REMOTE_ADDR'];
        //$this->remoteHost = $_ENV["COMPUTERNAME"];
        //$this->token = md5($this->ip);
        $this->token = md5(" ");
    }

    public function getToken() {
        return $this->token;
    }

    public function validaToken() {
        //$res = strcmp($this->token, md5($_SERVER['REMOTE_ADDR']));
        $res = strcmp($this->token, md5(" "));
        if ($res == 0) {
            return TRUE;
        } else {
            return FALSE;
        }
    }

}

?>