<?php

/**
 * Apretaste
 * 
 * MERCADO 
 * 
 * @author kumahacker <kumahavana@gmail.com>
 *
 */
class mercado extends Service
{
	/**
	 * Function executed when the service is called
	 *
	 * @param Request $request			
	 * @return Response
	 *
	 */
	public function _main (Request $request)
	{
		$connection = new Connection();
		$sql = "SELECT * FROM _tienda_products WHERE active = '1' ORDER BY category,name;";
		$products = $connection->deepQuery($sql);
		
		if (is_array($products))
		{
			$newproducts = array();
			
			$di = \Phalcon\DI\FactoryDefault::getDefault();
			$wwwroot = $di->get('path')['root'];
			
			$images = array();
			
			foreach($products as $product)
			{
				$cat = $this->translate($product->category);
				
				$product->image = false;
				$c = $product->code;
				$file = "$wwwroot/public/products/$c.jpg";
				$tempFile = "$wwwroot/temp/$c.jpg";
				
				if(file_exists($file))
				{
					copy($file, $tempFile);
					$this->utils->optimizeImage($tempFile, 100);
					$product->image = true;
					$images[] = $tempFile;
				} 
				
				$newproducts[$cat][] = $product;				
			}
			
			$products = $newproducts;
			
			$response = new Response();
			$response->setResponseSubject("Articulos a la venta");
			
			$content = array(
				"products" => $products,
				"wwwroot" => $wwwroot
			);
			
			$response->createFromTemplate('basic.tpl', $content, $images);
			
			return $response;
		}	
	}
	
	/**
	 * Subservice VER
	 * 
	 * @author kuma
	 * @param Request $request
	 */
	public function _ver(Request $request)
	{
		$di = \Phalcon\DI\FactoryDefault::getDefault();
		$wwwroot = $di->get('path')['root'];
			
		$code = trim($request->query);
		$code = str_replace("'", "", $code);
		
		$connection = new Connection();
		$product = $connection->deepQuery("SELECT * FROM _tienda_products WHERE code = '$code' AND active = '1';");
		
		$current_user = $this->utils->getPerson($request->email);
		
		$response = new Response();
		
		if (is_array($product))
		{
			$product = $product[0];
			$content = array(
				'product' => $product,
				'wwwroot' => $wwwroot,
				'current_user' => $current_user,
				'future_credit' => $current_user->credit - $product->credits
			);
			
			$imgpath = "$wwwroot/public/products/{$product->code}.jpg";
			$product->image = false;
			
			if (file_exists($imgpath))
			{
				$product->image = true;
				copy("$wwwroot/public/products/{$product->code}.jpg", "$wwwroot/temp/{$product->code}.jpg");
				$imgpath = "$wwwroot/temp/{$product->code}.jpg";
				$this->utils->optimizeImage($imgpath, 300, "", 85, 'jpg');
			}
			
			$product->category = $this->translate($product->category); 
			$response->setResponseSubject("Mercado: {$product->name}");
			$response->createFromTemplate('product.tpl', $content, array($imgpath));
			return $response;
		}
		
		$response->setResponseSubject("Articulo a la venta no encontrado");
		$response->createFromText("El c&oacute;digo recibido <b>{$code}</b> no corresponde con ning&uacute;n art&iacute;culo a la venta. Por favor verif&iacute;calo y si el problema persiste consulta con el soporte t&eacute;cnico.");
		return $response;
	}
	
	/**
	 * Translation
	 * 
	 * @author kuma
	 * @param string $text
	 * @return string
	 */
	private function translate($text)
	{
		$translation = array(
			'peripheral' => 'Perif&eacute;ricos',
			'computer' => 'Computadoras',
			'mobile' => 'M&oacute;viles',
			'accessory' => 'Accesorios',
			'clothe' => 'Ropa',
			'service' => 'Servicios'
		);
		
		if (isset($translation[$text]))
			return $translation[$text];
		
		return $text;
	}
	
	/**
	 * Function executed when a payment is finalized
	 * 
	 * @author kuma
	 **/
	public function payment(Payment $payment)
	{
		// Insert order
		$sql = "INSERT INTO _tienda_orders (id, product, email, inserted_date)
				SELECT id, inventory_code, sender, transfer_time
				FROM transfer INNER JOIN inventory on transfer.inventory_code = inventory.code
				WHERE inventory.service = 'MERCADO' AND transfer.transfered = '1'
				AND NOT EXISTS (SELECT * FROM _tienda_orders WHERE _tienda_orders.id = transfer.id);";
		
		$connection = new Connection();
		$connection->deepQuery($sql);
		
		// Send email to user
		$subject = "Se necesitan datos para enviar el articulo comprado a su destino";
		$content = array('payment' => $payment);
		
		$response = new Response();
		$response->setResponseSubject($subject);
		$response->internal = true;
		$render = new Render();
		$response->createFromTemplate('request_destination.tpl', $content);
		$service = new Service();
		$service->serviceName = 'mercado';
		$html = $render->renderHTML($service, $response);
		$email = new Email();
		$email->sendEmail($payment->buyer, $subject, $html);
	}
}