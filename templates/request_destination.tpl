<h1>Qui&eacute;n recibir&aacute; lo que acabas de comprar?</h1>
<p>Acaba de comprar el art&iacute;culo <b>{$payment->name}</b> por <b>${$payment->price|string_format: "%.2f"}</b>. Necesitamos que nos env&iacute;es al correo
soporte@apretaste.com, los siguientes datos tuyos o de otra persona que lo vaya a recibir: </p>
<ul>
	<li>C&oacute;digo de transferencia: {$payment->transfer->id}</li>
	<li>carnet de identidad</li>
	<li>nombre y apellidos</li>
	<li>direcci&oacute;n particular</li>
	<li>provincia</li>
	<li>tel&eacute;fono de contacto</li>
</ul>
<p>Con esos datos le haremos llegar a su casa el art&iacute;culo comprado.</p>