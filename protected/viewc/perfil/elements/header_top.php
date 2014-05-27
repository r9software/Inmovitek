<div class="header_top">
	<div class="logo">
                <?php
                    if($inmobiliaria->url_logo){
                        ?> 
                            <br />
                            <a href="<?php echo Doo::conf()->APP_URL.$inmobiliaria->identificador; ?>"><img src="<?php echo Doo::conf()->APP_URL. $inmobiliaria->url_logo; ?>" width="300" alt="logo"></a>
                        <?php
                    }
                ?>
		<h1><?php echo Doo::conf()->APP_NAME; ?></h1>
	</div>

	<div class="topmenu">
		<ul class="dropdown">
			<li class="menu-item-home current-menu-item">
				<a href="<?php echo Doo::conf()->APP_URL ?>"><span>Inicio</span></a>
			</li>
			<li>
				<a href="<?php echo Doo::conf()->APP_URL.$inmobiliaria->identificador.'/' ?>buscar"><span>Buscar</span></a>
			</li>
			<li>
				<a href="<?php echo Doo::conf()->APP_URL.$inmobiliaria->identificador.'/' ?>buscar/mapa" target="_blank"><span>Mapa</span></a>
			</li>
			<li>
				<a href="<?php echo Doo::conf()->APP_URL ?>CRM"><span>Mi cuenta</span></a>
			</li>
			<!--<li>
				<a href="<?php echo Doo::conf()->APP_URL ?>contacto"><span>Cont&aacute;cto</span></a>
			</li>-->
		</ul>
	</div>

	<!--<div class="header_phone">
		<a href="#" id="my_saved_offers">MY SAVED OFFERS <em>0</em></a><span>Llama:<br> 01-800-531-HOME</span>
	</div>-->

	<div class="clear"></div>
</div>