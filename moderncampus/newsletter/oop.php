<?php
require_once($_SERVER['DOCUMENT_ROOT'].'/_resources/php/wnl/wnl2026.php');

if (!isset($feed)) {
	$feed = isset($feed) && $feed !== '' ? $feed : '/newsletter/rss.xml';
}
if (!isset($amount_per_page)) {
	$amount_per_page = isset($_GET["amount_per_page"]) && $_GET["amount_per_page"] !== '' ? $_GET["amount_per_page"] : 5;
}
if (!isset($categories)) {
	$categories = isset($_GET["categories"]) ? $_GET["categories"] : '';
}

$t = new WNL($feed,"/rss/channel/item");

$item_count = $amount_per_page;

function getItemCategories($item) {
	$categories = array();
	if (!is_object($item) || !isset($item->category)) {
		return $categories;
	}

	$category_values = $item->category;
	if (is_object($category_values)) {
		$category_values = (array) $category_values;
	}
	if (is_array($category_values)) {
		foreach ($category_values as $category_value) {
			$category_value = trim((string) $category_value);
			if ($category_value !== '') {
				$categories[] = $category_value;
			}
		}
	} else {
		$category_value = trim((string) $category_values);
		if ($category_value !== '') {
			$categories[] = $category_value;
		}
	}

	return $categories;
}

function hasTopArticleCategory($item) {
	foreach (getItemCategories($item) as $category) {
		if (strtolower(trim($category)) === 'top-of-newsletter') {
			return true;
		}
	}
	return false;
}

function getItemPubDateTimestamp($item) {
	if (!is_object($item)) {
		return 0;
	}
	if (isset($item->pubDateAsTime)) {
		return (int) $item->pubDateAsTime;
	}
	return (int) strtotime((string) $item->pubDate);
}

function cmpTopArticleThenPubDate($a, $b) {
	$aTop = hasTopArticleCategory($a) ? 1 : 0;
	$bTop = hasTopArticleCategory($b) ? 1 : 0;

	if ($aTop !== $bTop) {
		return $bTop <=> $aTop;
	}

	$aTime = getItemPubDateTimestamp($a);
	$bTime = getItemPubDateTimestamp($b);
	if ($aTime === $bTime) {
		return 0;
	}
	return ($aTime > $bTime) ? -1 : 1;
}

function displayNews($x){
	$y = new CategoryRssItem($x);
	
	global $counter;
	global $item_count;
	
	$res = "";
	$categories = getItemCategories($x);
	$has_top_article = hasTopArticleCategory($x);

	$item_class = 'newsletter-content-item';
	if ($has_top_article) {
		$item_class = 'newsletter-content-item top-article';
	}

	if ($counter < $item_count || $counter == 0 ){	
		$res .= '<div class="' . $item_class . '">';		
		$counter++;
	}
	else {
		$res .= '<div class="' . $item_class . '">';			
	}
		
		if ($has_top_article) {
			$res .= '<div class="top-article-badge">Top of Newsletter</div>';
		}

		if (strlen(@$y->mthumb) > 0){
			$res .= '<div class="image-container"><a href="' . $y->link . '"><img src="' . $y->mthumb . '"  class="img-fluid" alt="' . $y->mdesc . '" /></a></div>';
		}
	
		$res .= '<div class="article-title"><a href="' . $y->link . '"><h2>' . $y->title . '</h2></a></div>';
		
// 		$res .= '<p>' . date("F j, Y", strtotime($y->pubDate)) . ' | ' . $y->author . '</p>';
		$res .= '<div class="content-preview"><p>' . $y->description . '</p></div>';
	
		$res .= '<div class="readmore-link"><a href="' . $y->link . '" aria-label="Read more about ' . $y->title . '">Read more</a></div>';
	
		if (!empty($categories)) {
			$res .= '<div class="categories"><p><strong>Categories:</strong> ' . implode(', ', array_map('htmlspecialchars', $categories)) . '</p></div>';
		}
	
		$res .= '<div class="bottom-border"></div>';
	$res .= '</div>';	if ($has_top_article) {
		$res .= '<div class="new-line"></div>';
	}  	echo($res);
}


$t->sortByPubDate()->categoryFilter($categories);
usort($t->items, 'cmpTopArticleThenPubDate');
$t->paginate($amount_per_page)->iterate('displayNews');

echo "<div class=\"pagination-bottom\">";
 	echo "<ul class=\"pagination\">";
$t->paginateNavigation('displayPaginationLink', 4);
	echo "</ul>";
echo "</div>";


?>