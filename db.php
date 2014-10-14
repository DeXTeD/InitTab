<?php
$post = json_decode(file_get_contents('php://input'), true);
$key = md5($_GET['user']);
$action = isset($_GET['action']) ? $_GET['action'] : null;

$file = __DIR__."/data/$key.json";

if(!file_exists($file))
{
	file_put_contents($file, json_encode([]));
}

$data = json_decode(file_get_contents($file));


header('Content-Type: application/json');

if($action)
{
	$save = false;

	if($action === "create")
	{
		$post['id'] = rand();
		array_unshift($data, $post);
		$save = true;
	}

	if($action === "sort")
	{
		$ids = $post['ids'];
		$newData = [];
		foreach ($data as $key => $row)
		{
			$newData[array_search($row->id, $ids)] = $row;
		}
		ksort($newData);
		$data = $newData;
		$save = true;
	}


	$id = isset($post['id']) ? $post['id'] : false;

	if($id and in_array($action, ["edit", "remove"]))
	{
		foreach ($data as $key => $row)
		{
			if($row->id == $id)
			{
				if($action === "remove")
				{
					unset($data[$key]);
				}
				elseif($post)
				{
					$data[$key] = $post;
				}
			}
		}
		$save = true;
	}

	if($save)
	{
		$data = array_values($data);
		file_put_contents($file, json_encode($data, JSON_PRETTY_PRINT));
	}
}

echo json_encode($data);