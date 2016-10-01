<h1>Productos en venta</h1>
<table width="100%">
<tr>
{foreach name=products from=$products item=$item}
			<td width="30%" valign="top" align="center">
			
			{if $item->image == true}
				{img src="{$wwwroot}/public/products/{$item->code}.jpg" alt="Imagen del producto" width="100"}<br/>
			{/if}
			<b>{$item->name}</b><br/>
			${$item->credits|string_format:"%.2f"}<br/>
			{button href="MERCADO VER {$item->code}" caption="Detalles" size="small" color="blue"}
			</td>

		{if $smarty.foreach.products.iteration % 3 == 0}
		</tr><tr>
		{/if}
{/foreach}
</table>