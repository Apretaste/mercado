<h1>&iquest;Qui&eacute;n recibir&aacute; el paquete?</h1>

<p>Usted acaba de comprar el art&iacute;culo <b>{$payment->name}</b> por <b>&sect;{$payment->price|string_format: "%.2f"}</b>. Necesitamos que nos env&iacute;e la informaci&oacute;n de quien recibir&aacute; el paquete (generalmente usted) a la direcci&oacute;n compras@apretaste.com o a nuestro soporte.</p>

<p>Por favor env&iacute;enos cuanto antes la siguiente informaci&oacute;n:</p>

<ul>
	<li>C&oacute;digo de transferencia: {$payment->transfer->id}</li>
	<li>carnet de identidad</li>
	<li>nombre y apellidos</li>
	<li>direcci&oacute;n particular</li>
	<li>provincia</li>
	<li>tel&eacute;fono de contacto</li>
</ul>

<p>Con esos datos le haremos llegar a su casa el art&iacute;culo comprado de 15 a 30 d&iacute;as. Si tiene alguna duda, por favor escriba a compras@apretaste.com, ponga en el email su C&oacute;digo de Transferencia y le atenderemos con gusto.</p>
