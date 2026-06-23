<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet [
<!ENTITY amp   "&#38;">
<!ENTITY copy   "&#169;">
<!ENTITY gt   "&#62;">
<!ENTITY hellip "&#8230;">
<!ENTITY laquo  "&#171;">
<!ENTITY lsaquo   "&#8249;">
<!ENTITY lsquo   "&#8216;">
<!ENTITY lt   "&#60;">
<!ENTITY nbsp   "&#160;">
<!ENTITY quot   "&#34;">
<!ENTITY raquo  "&#187;">
<!ENTITY rsaquo   "&#8250;">
<!ENTITY rsquo   "&#8217;">
]>
<!-- 
     Implementations Skeleton - 01/10/2017
     
     News Listing Page 
     A simple page type.
     
     Contributors: Akifumi Yamamoto
     Last Updated: January 2019
-->
<xsl:stylesheet version="3.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:ou="http://omniupdate.com/XSL/Variables"
                xmlns:fn="http://omniupdate.com/XSL/Functions"
                xmlns:ouc="http://omniupdate.com/XSL/Variables"
                expand-text="yes"
                exclude-result-prefixes="ou xsl xs fn ouc">
    
    <xsl:import href="common.xsl"/>
    
    <xsl:template name="template-headcode" expand-text="no">
        <style>
            .campus-content { width: 100% }
        </style>
    </xsl:template>
    <xsl:template name="template-footcode"/>
    
    <xsl:template name="page-content">
        <xsl:param name="left-nav" select="ou:pcf-param('leftnav-toggle')"/>
        
        <xsl:call-template name="banner" />
        <!-- see breadcrumbs xsl -->
        <div class="main-content">
            <div class="container">
                <xsl:call-template name="output-breadcrumbs"/>
                
                <xsl:if test="normalize-space($page-heading)">
                    <h1 class="main-title">{$page-heading}</h1>
                </xsl:if>
                
                <div class="row yellow-outer">
                    <xsl:if test="$left-nav = '1'">
                        <xsl:call-template name="left-nav" />
                    </xsl:if>
                    <xsl:call-template name="main-content">
                        <xsl:with-param name="left-nav" select="$left-nav"/>
                    </xsl:call-template>
                </div>
            </div>
        </div>
    </xsl:template>
    
    <xsl:template name="main-content">
        <xsl:param name="left-nav" as="xs:string?"/>
        <xsl:param name="feed" select="normalize-space(ou:pcf-param('news-rss-feed'))"/>
        <xsl:param name="display-count" select="(number(ou:pcf-param('news-display-count')), 5)[string(.) != 'NaN'][1]"/>
        <xsl:param name="categories" select="normalize-space(ou:pcf-param('rss-feed-categories'))"/>
        
        <xsl:variable name="main-col-class">
            <xsl:choose>
                <xsl:when test="$left-nav = '1'">
                    <xsl:text>col-md-9 main-content-text col-sm-9 col-xs-12</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>col-md-12 main-content-text col-sm-12 col-xs-12</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        <div class="{$main-col-class}">
            <xsl:choose>
                <xsl:when test="$feed">
                    <xsl:choose>
                        <xsl:when test="$is-pub">
                            <xsl:processing-instruction name="php">
                                $feed = "{$feed}"; 
                                $amount_per_page = {$display-count};
                                $categories = "{$categories}";
                                $counter = 1;
                                ?</xsl:processing-instruction>
                            <xsl:copy-of select="ou:ssi('/_resources/php/wnl/news-listing.php')" />
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:variable name="params" as="element(item)*">
                                <xsl:if test="$feed">
                                    <item>feed={encode-for-uri($feed)}</item>
                                </xsl:if>
                                <xsl:if test="$display-count">
                                    <item>amount_per_page={$display-count}</item>
                                </xsl:if>
                                <xsl:if test="$categories">
                                    <item>categories={encode-for-uri($categories)}</item>
                                </xsl:if>
                            </xsl:variable>
                            <xsl:value-of select="unparsed-text($domain || $ou:news-listing-script || '?' || string-join($params, '&amp;'))" disable-output-escaping="yes"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                    <h2>Empty Feed Field</h2>
                    <p>Please enter a valid RSS feed into the News RSS Feed field.</p>
                </xsl:otherwise>
            </xsl:choose>
        </div>
    </xsl:template>
    
    <xsl:template name="left-nav">
        <nav class="navbar-default inner-left-drop navbut col-md-12">
            <div class="">
                <button type="button" class="navbar-toggle navbar-header collapsed" data-toggle="collapse" data-target="#inner-left-dropdown"
                        aria-expanded="false"> <span class="sr-only">Toggle navigation</span><span class="navbar-brand">navigation</span>
                    <span class="fa fa-chevron-down pull-right"></span></button>
            </div>
        </nav>
        <div class="col-md-3 col-sm-3 col-xs-12 side-padding">
            <div id="inner-left-dropdown" class="collapse in">
                <xsl:call-template name="unparsed-include-file">
                    <xsl:with-param name="path" select="concat($navigation-start, '_nav.php')" />
                </xsl:call-template>
            </div>
        </div>
    </xsl:template>
    
    <xsl:template name="banner" expand-text="yes">
        <xsl:param name="banner-src" select="normalize-space(ou:pcf-param('photo-1'))"/>
        <xsl:param name="banner-alt" select="normalize-space(ou:pcf-param('photo-alt-1'))"/> 
        
        <xsl:if test="$banner-src">
            <div class="col-md-12 col-sm-12 col-xs-12 sub-page-header">
                <img src="{$banner-src}" alt="{$banner-alt}" />
            </div>
        </xsl:if>
    </xsl:template>
    
</xsl:stylesheet>
