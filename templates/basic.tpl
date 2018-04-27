<h1>Productos en la tienda</h1>

<p align="justify"><b>Su cr&eacute;dito es §{$current_user->credit|string_format:"%.2f"}.</b> A continuaci&oacute;n una lista de los productos disponibles en la tienda. El precio incluye el env&iacute;o hasta su casa. Si necesita, vea {link href="WEB credito.apretaste.com" caption="formas de conseguir m&aacute;s credito"}.</p>

{foreach from=$products item=item name=products}
<table width="100%" bgcolor="{cycle values="#f2f2f2,white"}">
	<tr>
		<td rowspan="3" align="left" width="110" valign="middle">
			{if $item->image == true}
				{img src="{$wwwroot}/public/products/{$item->code}.jpg" alt="Imagen del producto" width="100"}<br/>
			{else}
				{noimage}
			{/if}
		</td>
		<td>
			{if $item->price neq 0 AND $item->price neq ""}
				<font color="#5EBB47">&sect;{$item->credits|string_format:"%.2f"}</font>
				{separator}
				{$item->name}
			{/if}
		</td>
	</tr>
	<tr>
		<td valign="top">
			{if $item->description ne ''}
				{$item->description|truncate:100:' ...'}
			{/if}
		</td>
	</tr>
	<tr>
		<td>
			{button size="small" href="TIENDA VER {$item->code}" caption="Detalles" color="grey"}
			{button size="small" caption="Comprar" href="CREDITO COMPRAR {$item->code}" color="green"}
		</td>
	</tr>
</table>
{space5}
{/foreach}

<small>
<ul>
	<li>Una vez que compre, le llegar&aacute; un email preguntando su tel&eacute;fono y direcci&oacute;n.</li>
	<li>Los env&iacute;os duran de 15 a 30 d&iacute;as. Por ahora no podemos enviar a Isla de la Juventud.</li>
</ul>
</small>
