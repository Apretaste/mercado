<h1>{$product->name}</h1>
<table width="100%">
	<tr>
		<td valign="top" width="300">
			{if $product->image == true} 
				{img src="{$wwwroot}/public/products/{$product->code}" alt="Imagen del producto" width="300"}<br /> 
			{/if}
		</td>
		<td>&nbsp;&nbsp;</td>
		<td align="left" valign="top">
			Precio:<br/> 
			<big>${$product->credits|string_format:"%.2f"}</big><br />
			{space5}
			Costo de env&iacute;o incluido: <br/>
			<b>${$product->shipping_price|string_format:"%.2f"}</b>
			{space5}
			Categor&iacute;a:<br/>
			<b>{$product->category}</b>
			{space5}
			<p align="justify"><i>{$product->description}</i></p>
		</td>
	</tr>
</table>
{space5}

{if $future_credit >= 0}
	<p align="justify">
	Tu cr&eacute;dito actual es <b>${$current_user->credit|string_format:"%.2f"}</b>
	y tu cr&eacute;dito despu&eacute;s de comprar ser&aacute;<b> ${$future_credit|string_format:"%.2f"}</b>. 
	Si te interesa comprar este art&iacute;culo haz clic en el siguiente bot&oacute;n con lo cual no se te 
	disminuye el cr&eacute;dito ahora, sino que <b>se te pedir&aacute; confirmaci&oacute; despu&eacute;s.</b>
</p>
<center>{button caption="Comprar" href="CREDITO COMPRAR {$product->code}"} {button caption="Ver otros" href="MERCADO" color="blue"}</center>
{else}
<p align="justify">
	Tu cr&eacute;dito actual es <b>${$current_user->credit|string_format:"%.2f"}</b> y no es suficiente para comprar este art&iacute;culo.</p>
	<center>{button caption="Ver otros" href="MERCADO"}</center>
{/if}