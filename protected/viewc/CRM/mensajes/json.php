<?php
    
	if(isset($data['nombreInmobiliaria'])){
    echo '[';
		for($x=0;$x<count($data['nombreInmobiliaria']); $x++){
			if($x!=0 && $x!=count($data['nombreInmobiliaria'])-2)
			echo ",";
			echo  "{\"label\":\"".$data['nombreInmobiliaria'][$x]->nombre."\",\"value\":\"".$data['nombreInmobiliaria'][$x]->nombre."_value\"}";
		}
	echo ']';	
	}
?>