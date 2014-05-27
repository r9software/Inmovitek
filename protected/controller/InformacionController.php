<?php

class InformacionController extends DooController{
	
	public function acerca(){
		$this->renderc('informacion/about');
	}
	
	public function experiencia(){
		$this->renderc('informacion/experiencia');
	}
	
	
	public function mobile(){
		$this->renderc('informacion/mobile');
	}
	
	public function contacto(){
		$this->renderc('informacion/contacto');
	}
}

?>