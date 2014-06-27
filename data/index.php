<?php
$post = json_decode(file_get_contents('php://input'), true);

$get = explode('/', trim($_SERVER['PATH_INFO'], '/'));

$key = md5($get[0]?:'none');
$file = __DIR__."/$key.json";
if(!file_exists($file))
{
	file_put_contents($file, json_encode([]));
}

$id = null;
if(isset($get[1]))
{
	$id = +$get[1];
}

$method = $_SERVER['REQUEST_METHOD'];
if(array_key_exists('HTTP_X_HTTP_METHOD_OVERRIDE', $_SERVER))
{
	$method = $_SERVER['HTTP_X_HTTP_METHOD_OVERRIDE'];
}

header('Content-Type: application/json');

if($method !== "GET")
{
	$data = json_decode(file_get_contents($file));
	if($id and in_array($method, ["PUT", "DELETE"])) {
		foreach ($data as $key => $row)
		{
			if($row->id == $id)
			{
				if($method === "DELETE")
				{
					unset($data[$key]);
				}
				else
				{
					$data[$key] = $post;
					echo json_encode($data[$key]);
				}
			}
		}
	}
	elseif($method === "POST")
	{
		$post['id'] = rand();
		$data[] = $post;
		echo json_encode($post);
	}
	file_put_contents($file, json_encode(array_values($data)));
} else {
	readfile($file);
}
