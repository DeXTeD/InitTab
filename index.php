<!doctype html>
<html lang="pl" ng-app="App">
<head>
	<meta charset="UTF-8">
	<title> </title>
	<link rel="stylesheet" href="/css/style.css">
	<link rel="apple-touch-icon" sizes="57x57" href="images/favicons/apple-touch-icon-57x57.png">
	<link rel="apple-touch-icon" sizes="114x114" href="images/favicons/apple-touch-icon-114x114.png">
	<link rel="apple-touch-icon" sizes="72x72" href="images/favicons/apple-touch-icon-72x72.png">
	<link rel="apple-touch-icon" sizes="144x144" href="images/favicons/apple-touch-icon-144x144.png">
	<link rel="apple-touch-icon" sizes="60x60" href="images/favicons/apple-touch-icon-60x60.png">
	<link rel="apple-touch-icon" sizes="120x120" href="images/favicons/apple-touch-icon-120x120.png">
	<link rel="apple-touch-icon" sizes="76x76" href="images/favicons/apple-touch-icon-76x76.png">
	<link rel="apple-touch-icon" sizes="152x152" href="images/favicons/apple-touch-icon-152x152.png">
	<link rel="icon" type="image/png" href="images/favicons/favicon-196x196.png" sizes="196x196">
	<link rel="icon" type="image/png" href="images/favicons/favicon-160x160.png" sizes="160x160">
	<link rel="icon" type="image/png" href="images/favicons/favicon-96x96.png" sizes="96x96">
	<link rel="icon" type="image/png" href="images/favicons/favicon-16x16.png" sizes="16x16">
	<link rel="icon" type="image/png" href="images/favicons/favicon-32x32.png" sizes="32x32">
	<meta name="msapplication-TileColor" content="#ffffff">
	<meta name="msapplication-TileImage" content="images/favicons/mstile-144x144.png">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body ng-view>

	<script type="text/ng-template" id="grid.html">
		<div class="nav">
			<a href="#/new" class="nav-add">+</a>
			<input type="text" class="nav-search" tabindex="1" ng-model="q">
		</div>
		<ul class="blocksWrapper" sv-root sv-part="list" sv-on-sort="onSort($item, $partFrom, $partTo, $indexFrom, $indexTo)">
			<li ng-repeat="l in list | find:q" sv-element class="block">
				<a href="{{l.url}}" class="block-image">
					<img src="{{l.thumbnail}}">
					<span class="block-title">
						{{l.title}}
					</span>
				</a>
				<a href="#/remove/{{l.id}}" class="block-destroy" type="button">&times;</a>
				<a href="#/edit/{{l.id}}" class="block-edit" type="button">&bull;</a>
			</li>
		</ul>
	</script>

	<script type="text/ng-template" id="detail.html">
		<div class="nav">
			<a href="#/" class="nav-add" type="button">&lt;</a>
		</div>
		<ul class="blocksWrapper">
			<li class="block">
				<a href="{{block.url}}" class="block-image">
					<img src="{{block.thumbnail}}">
					<span class="block-title">
						{{block.title}}
					</span>
				</a>
			</li>
		</ul>
		<form class="content content--array" ng-submit="save()">
			<h2>{{block.title || "..."}}</h2>
			<label class="label">
				<span class="label-name">title</span>
				<input type="text" ng-model="block.title" class="input input--full">
			</label>
			<label class="label">
				<span class="label-name">url</span>
				<input type="text" ng-model="block.url" class="input input--full">
			</label>
			<label class="label">
				<span class="label-name">thumbnail</span>
				<input type="text" ng-model="block.thumbnail" class="input input--full">
			</label>
			<p class="alignCenter">
				<button class="button">Zapisz</button>
			</p>
		</form>
	</script>

	<script type="text/ng-template" id="remove.html">
		<div class="nav">
			<a href="#/" class="nav-add" type="button">&lt;</a>
		</div>
		<ul class="blocksWrapper">
			<li class="block">
				<a href="{{block.url}}" class="block-image">
					<img src="{{block.thumbnail}}">
					<span class="block-title">
						{{block.title}}
					</span>
				</a>
			</li>
		</ul>
		<div class="content content--array">
			<h2>Na pewno usuąć: <strong>{{block.title}}</strong></h2>
			<p class="alignCenter">
				<button ng-click="remove()" class="button">Usuń</button>
			</p>
		</div>
	</script>


	<script>
		window.user = { key: '<?php echo htmlentities(trim($_SERVER["PATH_INFO"], "/"), ENT_QUOTES) ?>' };
	</script>

	<script src="/build/all.js"></script>

</body>
</html>
