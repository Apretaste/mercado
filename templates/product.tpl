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
	<p>Incluye costos de env&iacute;o hasta su casa. Una vez que pague le mandaremos un email pidiendo sus datos. Actualmente tiene &sect;{$current_user->credit|string_format:"%.2f"}</p>

	{button caption="Comprar" href="CREDITO COMPRAR {$product->code}"}
	{button caption="Ver otros" href="TIENDA" color="grey"}
</center>

{space30}

<small>
<ul>
	<li>Una vez que compre, le mandaremos un email para confirmar antes de rebajar su cr&eacute;dito.</li>
	<li>Los env&iacute;os duran de 15 a 30 d&iacute;as. Por ahora no podemos enviar a Isla de la Juventud.</li>
	<li>Si no tiene suficiente cr&eacute;dito, existen {link href="WEB credito.apretaste.com" caption="v&iacute;as de obtener m&aacute;s cr&eacute;ditos"}.</li>
</ul>
</small>
