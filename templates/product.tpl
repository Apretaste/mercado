<h1>{$product->name}</h1>
<center>
{if $product->image == true} 
	{img src="{$wwwroot}/public/products/{$product->code}.jpg" alt="Imagen del producto" width="300"}
{/if}
{space5}
<p align="center"><i>{$product->description}</i></p>
{space5}
Precio:<br/> 
<big><strong>&sect;{$product->credits|string_format:"%.2f"}</strong></big><br />
{space5}
Costo de env&iacute;o incluido: <br/>
<strong>${$product->shipping_price|string_format:"%.2f"}</strong>
{space5}
Categor&iacute;a:<br/>
<strong>{$product->category}</strong>
{space5}
</center>
{if $future_credit >= 0}
	<p align="justify">
	Tu cr&eacute;dito actual es <b>&sect;{$current_user->credit|string_format:"%.2f"}</b>
	y tu cr&eacute;dito despu&eacute;s de comprar ser&aacute;<b> &sect;{$future_credit|string_format:"%.2f"}</b>. 
	Si te interesa comprar este art&iacute;culo haz clic en el siguiente bot&oacute;n con lo cual no se te 
	disminuye el cr&eacute;dito ahora, sino que <b>se te pedir&aacute; confirmaci&oacute;n despu&eacute;s.</b>
</p>
<center>{button caption="Comprar" href="CREDITO COMPRAR {$product->code}"} {button caption="Ver otros" href="MERCADO" color="blue"}</center>
{else}
<p align="justify">
	Tu cr&eacute;dito actual es <b>&sect;{$current_user->credit|string_format:"%.2f"}</b> y no es suficiente para comprar este art&iacute;culo.</p>
	<center>{button caption="Ver otros" href="MERCADO"}</center>
{/if}