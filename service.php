<?php

class Tienda extends Service
{
	/**
	 * Function executed when the service is called
	 *
	 * @param Request $request
	 * @return Response
	 */
	public function _main (Request $request)
	{
		// get products
		$connection = new Connection();
		$products = $connection->query("SELECT * FROM _tienda_products WHERE active = '1' ORDER BY category,name;");
		$current_user = $this->utils->getPerson($request->email);

		if (is_array($products))
		{
			$di = \Phalcon\DI\FactoryDefault::getDefault();
			$wwwroot = $di->get('path')['root'];

			$newproducts = array();
			$images = array();

			foreach($products as $product)
			{
				$cat = $this->translate($product->category);
				$product->cat = $cat;
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

				$newproducts[] = $product;
			}

			$content = array(
				"products" => $newproducts,
				"wwwroot" => $wwwroot,
				"current_user" => $current_user
			);

			$response = new Response();
			$response->setCache("week");
			$response->setResponseSubject("Productos en la tienda");
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
		// do not accept empty codes
		if(empty($request->query)) return new Response();

		$di = \Phalcon\DI\FactoryDefault::getDefault();
		$wwwroot = $di->get('path')['root'];

		$code = trim($request->query);
		$code = str_replace("'", "", $code);

		$connection = new Connection();
		$product = $connection->query("SELECT * FROM _tienda_products WHERE code = '$code' AND active = '1';");

		$current_user = $this->utils->getPerson($request->email);

		$response = new Response();
		$response->setCache();
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
			$response->setResponseSubject("Tienda: {$product->name}");
			$response->createFromTemplate('product.tpl', $content, array($imgpath));
			return $response;
		}

		$response->setResponseSubject("Articulo no encontrado");
		$response->createFromText("El codigo recibido <b>{$code}</b> no corresponde con ningun articulo a la venta. Por favor verificalo y si el problema persiste consulta con el soporte tecnico.");
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

		if (isset($translation[$text])) return $translation[$text];
		return $text;
	}

	/**
	 * Function executed when a payment is finalized
	 *
	 * @author kuma
	 **/
	public function payment(Payment $payment)
	{
		// Insert the order
		$connection = new Connection();
		$connection->query("
			INSERT INTO _tienda_orders (id, product, email, inserted_date)
			SELECT id, inventory_code, sender, transfer_time
			FROM transfer INNER JOIN inventory on transfer.inventory_code = inventory.code
			WHERE inventory.service = 'TIENDA' AND transfer.transfered = '1'
			AND NOT EXISTS (SELECT * FROM _tienda_orders WHERE _tienda_orders.id = transfer.id)");

		$subject = "Se necesitan datos para enviar el articulo comprado a su destino";

		// Send email to user
		$response = new Response();
		$response->setResponseSubject($subject);
		$response->internal = false;
		$response->createFromTemplate('request_destination.tpl', array('payment' => $payment));

		$service = new Service();
		$service->serviceName = 'tienda';
		$html = Render::renderHTML($service, $response);

		$email = new Email();
		$email->sendEmail($payment->buyer, $subject, $html);
	}
}
