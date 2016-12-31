<h1>Productos en el mercado</h1>
<p align="justify"><b>Su cr&eacute;dito es §{$current_user->credit|string_format:"%.2f"}.</b> A continuaci&oacute;n una lista de los
	productos que puede comprar con su cr&eacute;dito. El precio incluye el env&iacute;o hasta su casa.
	Si necesita, vea {link href="WEB credito.apretaste.com" caption="formas de conseguir m&aacute;s credito"}.
</p>

{foreach from=$products item=item name=products}
<table width="100%">
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
			<small>
				{button size="small" href="MERCADO VER {$item->code}" caption="Detalles" color="grey"}
				{separator}
                {button size="small" caption="Comprar" href="CREDITO COMPRAR {$item->code}" color="green"}

			</small>
		</td>
	</tr>
</table>
{/foreach}
{space30}
<ul>
	<li>
		<small>
			Una vez que compre, le llegar&aacutr; un email preguntando su tel&eacute;fono
			y direcci&oacute;n para mandarle el producto a su casa.
		</small>
	</li>
	<li>
		<small>
			Los env&iacute;os duran de 15 a 30 d&iacute;as y por ahora solo podemos
			enviar a La Habana (podemos enviar a casa de su familia o amigos). Pronto
			agregaremos m&aacute;s provincias.
		</small>
	</li>
	<li>
		<small>
			Si no tiene suficientes cr&eacute;ditos, existen
            {link href="WEB credito.apretaste.com" caption="v&iacute;as de obtener m&aacute;s cr&eacute;ditos"}.
			Cont&aacute;ctenos para comprar cr&eacute;ditos usando PayPal o una Tarjeta de Cr&eacute;dito.
		</small>
	</li>
</ul>