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
     
     INTERIOR PAGE 
     A simple page type.
     
     Contributors: Your Name Here
     Last Updated: Enter Date Here
-->
<xsl:stylesheet version="3.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:ou="http://omniupdate.com/XSL/Variables"
                xmlns:fn="http://omniupdate.com/XSL/Functions"
                xmlns:ouc="http://omniupdate.com/XSL/Variables"
                exclude-result-prefixes="ou xsl xs fn ouc">
    
    <xsl:import href="common.xsl"/>	
    
    <xsl:template name="template-headcode">
        <xsl:copy-of select="ou:include-file('/_resources/includes/news-headcode.inc')" />
    </xsl:template>
    
    <xsl:template name="template-footcode"/>
    
    <xsl:template name="page-content">
        <div class="container">
            <div class="ou-margin-right">
                <xsl:call-template name="alert" />
            </div>
        </div>
        <section class="news-section">
            <div class="container">
                <div class="padding-bottom-breadcrumb">
                    <!-- see breadcrumbs xsl -->
                    <xsl:call-template name="breadcrumb">
                        <xsl:with-param name="path" select="$ou:dirname"/>								
                    </xsl:call-template>
                </div>
                <div class="col-md-8 col-sm-8 col-xs-12 padding-top">
                    <div class="col-md-12">
                        <xsl:call-template name="news-meta" />
                        <xsl:call-template name="main-content" />
                    </div>
                </div>							
                <xsl:call-template name="events-sidebar" />
            </div>
        </section>
    </xsl:template>
    
    <xsl:template name="main-content" expand-text="yes">
        <xsl:variable name="news-count" select="if (string(number(ou:pcf-param('news-display-count'))) eq 'NaN') 
                                                then 5 else normalize-space(ou:pcf-param('news-display-count'))" />
        <xsl:variable name="news-config">
            <categories>{ou:pcf-param('rss-feed-categories')}</categories>
            <count>{$news-count}</count>
            <feed>{ou:pcf-param('news-rss-feed')}</feed>
        </xsl:variable>
        <xsl:call-template name="display-parsing">
            <xsl:with-param name="contents" select="$news-config" />
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template name="display-parsing" expand-text="yes">
        <xsl:param name="contents" />
        <xsl:if test="$ou:action != 'pub'">
            <br /><br /><br /><br />
            <div class="alert alert-danger">
                <p><strong>News will display on publish with the following configuration:</strong></p>
                <p>Number of items per page: {$contents/count}<br />Feed: {$contents/feed}<br />Categories: {$contents/categories}</p>
            </div>
        </xsl:if>
        
        <!-- parsing -->
        <xsl:processing-instruction name="php">
            $feed = "{$contents/feed}"; 
            $amount_per_page = {$contents/count};
            $categories = "{$contents/categories}";
            $counter = 1;
            ?</xsl:processing-instruction>
        <xsl:copy-of select="ou:ssi($ou:news-listing-script)" />
        <!-- / parsing -->
    </xsl:template>
    
    
    <xsl:template name="news-meta" expand-text="yes">
        <div class="col-md-12">
            <div class="campus-heading">
                <div>{ou:pcf-param('heading')}</div>
            </div>
            <xsl:if test="$ou:action = 'edt'">
                <style>
                    a[data-region-style='button'].ou-btn {{
                    float: right;
                    clear: both;
                    }}
                </style>
            </xsl:if>
            <xsl:apply-templates select="if($ou:action = 'edt') then 
                                         ouc:div[@label='category-filter'] else 
                                         ouc:div[@label='category-filter']/descendant::table[@class='ou-category-filter']" />
        </div>
    </xsl:template>
    
    <xsl:function name="ou:month-name">
        <xsl:param name="month-num" />
        <xsl:variable name="months" select="('January','February','March','April','May','June','July','August','September','October','November','December')" />
        <xsl:value-of select="$months[number($month-num)]" />
    </xsl:function>
    
    <xsl:template match="table[@class='ou-category-filter']">
        <div class="select-years">
            <div class="category">
                <span id="category-select" data-toggle="collapse" role="button" data-target="#category-drop" aria-expanded="false" class="collapsed">
                    <xsl:value-of select="tbody/tr[1]/td[1]" /><xsl:text> </xsl:text>
                    <span class="fa fa-caret-down" aria-hidden="true"></span>
                </span>
                <div id="category-drop" role="button" class="collapse" aria-expanded="false">
                    <xsl:apply-templates select="tbody/tr[1]/td[2]/descendant::a" />
                </div>
            </div>
        </div>
    </xsl:template>
</xsl:stylesheet>
