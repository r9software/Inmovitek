<?php
    
	if(isset($data['emailUsuario'])){
    echo '[';
		for($x=0;$x<count($data['emailUsuario']); $x++){
			if($x!=0 && $x!=count($data['emailUsuario'])-2)
			echo ",";
			echo  "{\"label\":\"".$data['emailUsuario'][$x]->correo."\",\"value\":\"".$data['emailUsuario'][$x]->correo."_value\"}";
		}
	echo ']';	
	}
?>