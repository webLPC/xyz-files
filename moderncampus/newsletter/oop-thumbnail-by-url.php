<?php
require_once($_SERVER['DOCUMENT_ROOT'] . '/_resources/php/wnl/wnl2026.php');

echo "<p><strong>MURL - PHP Includes</strong></p>";
echo "<p>Feed - " . $feed . "</p>";

if (!isset($feed)) {
    $feed = isset($feed) && $feed !== '' ? $feed : '/newsletter/rss.xml';
}

$current_url = 'https://' . $_SERVER['HTTP_HOST'] . $_SERVER['REQUEST_URI'];

echo "<p>Current URL - " . $current_url . "</p>";

$t = new WNL($feed, '/rss/channel/item');

function outputThumbnailForCurrentPage($item) {
    global $current_url;

    echo '<pre>called for item</pre>';

    $y = new CategoryRssItem($item);
    if (empty($y->link) || trim((string) $y->link) !== trim((string) $current_url)) {
        return;
    }

    $media_url = '';
    $media_title = '';

    if (!empty($y->murl)) {
        $media_url = (string) $y->murl;
    }

    if (!empty($y->mtitle)) {
        $media_title = (string) $y->mtitle;
    }

    if (!empty($media_url)) {
        echo '<div class="thumbnail-wrapper"><img src="' . htmlspecialchars(trim($media_url), ENT_QUOTES, 'UTF-8') . '" alt="' . htmlspecialchars(trim($media_title), ENT_QUOTES, 'UTF-8') . '" /></div>';
    }
}

$t->iterate('outputThumbnailForCurrentPage');
?>
