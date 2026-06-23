<?php
require_once($_SERVER['DOCUMENT_ROOT'].'/_resources/php/wnl/WNL.php');

if (!isset($feed)) {
	$feed = isset($_GET["feed"]) && $_GET["feed"] !== '' ? $_GET["feed"] : 'https://districtazure.clpccd.org/_resources/php/wnl/rss-sample.xml';
}
if (!isset($amount_per_page)) {
	$amount_per_page = isset($_GET["amount_per_page"]) && $_GET["amount_per_page"] !== '' ? $_GET["amount_per_page"] : 5;
}
if (!isset($categories)) {
	$categories = isset($_GET["categories"]) ? $_GET["categories"] : '';
}

$t = new WNL($feed,"/rss/channel/item");

$item_count = $amount_per_page;

function displayNews($x){
	$y = new CategoryRssItem($x);
	
	global $counter;
	global $item_count;
	
	$res = "";

	if ($counter < $item_count || $counter == 0 ){	
		$res .= '<div class="campus-content bottom-border">';		
		$counter++;
	}
	else {
		$res .= '<div class="campus-content">';			
	}
		if (strlen(@$y->mthumb) > 0){
			$res .= '<img src="' . $y->mthumb . '"  class="img-responsive pull-left" alt="' . $y->mdesc . '" />';
		}
		$res .= '<a href="' . $y->link . '"><h4>' . $y->title . '</h4></a>';
		$res .= '<p>' . date("F j, Y", strtotime($y->pubDate)) . ' | ' . $y->author . '</p>';
		$res .= '<p>' . $y->description . '</p>';
	$res .= '</div>';
  	echo($res);
}


$t->sortByPubDate()->categoryFilter($categories)->paginate($amount_per_page)->iterate('displayNews');

echo "<div class=\"pagination-bottom\">";
 	echo "<ul class=\"pagination\">";
$t->paginateNavigation('displayPaginationLink', 4);
	echo "</ul>";
echo "</div>";


?>
