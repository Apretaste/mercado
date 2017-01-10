<p align="right">&gt;&gt;&nbsp;{link href="WEB credito.apretaste.com" caption="C&oacute;mo obtener cr&eacute;dito"}</p>
<h1>{$product->name}</h1>
<center>
{if $product->image == true} 
	{img src="{$wwwroot}/public/products/{$product->code}.jpg" alt="Imagen del producto" width="100%"}
{/if}
</center>
{space5}
<p>{$product->description}</p>
{space5}
<center>
	<big><b>&sect;{$product->credits|string_format:"%.2f"}</b></big>
	<p>Incluye costos de env&iacute;o hasta su casa. Una vez que pague le mandaremos
		un email pidiendo sus datos. Actualmente tiene &sect;{$current_user->credit|string_format:"%.2f"}</p>
</center>
<center>
	{button caption="Comprar" href="CREDITO COMPRAR {$product->code}"}
	{space10}
	{button caption="Ver otros" href="MERCADO" color="grey"}
</center>
{space30}

<ul>
	<li>
		<small>
			Una vez que compre, le mandaremos un email para confirmar antes de rebajar
			su cr&eacute;dito.
		</small>
	</li>
	<li>
		<small>
			Los env&iacute;os duran de 15 a 30 d&iacute;as y por ahora solo podemos
			enviar a La Habana (podemos enviar a casa de su familia o amigos).
			Pronto agregaremos m&aacute;s provincias.
		</small>
	</li>
	<li>
		<small>Si no tiene suficiente cr&eacute;dito, existen
            {link href="WEB credito.apretaste.com" caption="v&iacute;as de obtener m&aacute;s cr&eacute;ditos"}.
			Cont&aacute;ctenos para comprar cr&eacute;ditos usando PayPal o una Tarjeta de Cr&eacute;dito.
		</small>
	</li>
</ul>