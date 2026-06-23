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
     
     HOME PAGE 
     A complex page type.
     
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
    
    <xsl:import href="common-lpc2024.xsl"/>
    
    <xsl:template name="template-headcode"/>
    
    <xsl:variable name="this-props-path" select="concat($ou:root, $ou:site, $dirname, $props-file)"/>
    <xsl:variable name="global-banner-path">
        <xsl:value-of select="document($this-props-path)/document/ouc:properties[@label='config']/parameter[@name='global-banner-source']"/>
    </xsl:variable>
    <xsl:variable name="global-top-banner-on">
        <xsl:value-of select="document($this-props-path)/document/ouc:properties[@label='config']/parameter[@name='global-site-settings']/option[@selected='true' and @value='global-top-banner-on']/@value"/>
    </xsl:variable>
    <xsl:variable name="global-banner-alt">
        <xsl:value-of select="document($this-props-path)/document/ouc:properties[@label='config']/parameter[@name='global-banner-alt']"/>
    </xsl:variable>
    <xsl:variable name="contact-top-on">
        <xsl:value-of select="document($this-props-path)/document/ouc:properties[@label='config']/parameter[@name='global-site-settings']/option[@selected='true' and @value='contact-top-on']/@value"/>
    </xsl:variable>
    <xsl:variable name="contact-bottom-on">
        <xsl:value-of select="document($this-props-path)/document/ouc:properties[@label='config']/parameter[@name='global-site-settings']/option[@selected='true' and @value='contact-bottom-on']/@value"/>
    </xsl:variable>
    
    <xsl:variable name="committee-name">
        <xsl:value-of select="ou:pcf-param('committeename')"/>
    </xsl:variable>
    
    <xsl:variable name="meeting-date">
        <xsl:value-of select="ou:pcf-param('meetingdate')"/>
    </xsl:variable>
    
    <xsl:variable name="top-img-alt">
        <xsl:value-of select="ou:pcf-param('top-img-alt')"/>
    </xsl:variable>
    
    <xsl:variable name="top-img">
        <xsl:value-of select="ou:pcf-param('top-img')"/>
    </xsl:variable>
    
    <xsl:template name="page-content" expand-text="yes">
        
        <main id="main">
            
            
            <xsl:choose>
                <xsl:when test="$global-top-banner-on = 'global-top-banner-on'">
                    <div class="section lpc-banner-bg">	
                        <div class="container-xxl">
                            <div class="banner-img-fixed">
                                <img class="img-fluid" src="{$global-banner-path}" alt="{$global-banner-alt}" />
                            </div>
                        </div>
                    </div>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:choose>
                        <xsl:when test="ou:pcf-param('has-top-banner') = '1'">
                            <xsl:call-template name="banner" />
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:choose>
                                <xsl:when test="ou:pcf-param('has-top-bar') = '1'">
                                    <xsl:call-template name="top-bar" />
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:choose>
                                        <xsl:when test="ou:pcf-param('has-top-banner') = '2'">
                                            <xsl:call-template name="fixed-width-banner" />
                                        </xsl:when>
                                        <xsl:otherwise>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
            
            <div class="section">
                
                <xsl:apply-templates select="ouc:div[@label='slick-slider']" />
                
                <xsl:apply-templates select="ouc:div[@label='red-callout']" />
                
                <xsl:apply-templates select="ouc:div[@label='feature-section']" />
                
                <xsl:choose>
                    <xsl:when test="ou:pcf-param('layout-section-toggle') = 'newsletter'">
                        <xsl:call-template name="newsletter" />
                    </xsl:when>
                    <xsl:when test="ou:pcf-param('layout-section-toggle') = 'newsletter-listing'">
                        <xsl:call-template name="newsletter-listing" />
                    </xsl:when>
                    <xsl:otherwise>
                    </xsl:otherwise>
                </xsl:choose>
                
                <xsl:choose>
                    <xsl:when test="ou:pcf-param('main-section-toggle') = '1'">
                        <xsl:call-template name="main-section"/>
                    </xsl:when>
                    <xsl:otherwise>
                    </xsl:otherwise>
                </xsl:choose>
                
                <xsl:choose>
                    <xsl:when test="ou:pcf-param('sidebar-toggle') = '1'">
                        <xsl:call-template name="right-sidebar-section"/>
                    </xsl:when>
                    <xsl:otherwise>
                    </xsl:otherwise>
                </xsl:choose>
                
                <xsl:choose>
                    <xsl:when test="ou:pcf-param('media-section-toggle') = '1'">
                        <xsl:call-template name="media-section"/>
                    </xsl:when>
                    <xsl:otherwise>
                    </xsl:otherwise>
                </xsl:choose>
                
            </div>
        </main>
        
    </xsl:template>
    
    <xsl:template name="breadcrumb-section">
        <div class="row px-lg-3">
            <div class="col-12 mt-4">
                <xsl:call-template name="breadcrumb">
                    <xsl:with-param name="path" select="$ou:dirname"/>								
                </xsl:call-template>
            </div>
        </div>
    </xsl:template>
    
    <xsl:template name="sidebar-section">
        <div class="col-12 col-lg-3">
            
            <xsl:variable name="this-props-path" select="concat($ou:root, $ou:site, $dirname, $props-file)"/>
            <xsl:variable name="contact-info-path">
                <xsl:choose>
                    <xsl:when test="$ou:contactinfo-start = ''">
                        <xsl:value-of select="concat($dirname, '_contact.php')"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="concat($ou:contactinfo-start, '_contact.php')"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            
            
            
            
            <!-- 			<xsl:variable name="contact-info-path" select="concat($dirname, '_contact.php')"/> -->
            <xsl:variable name="contact-info-on">
                <xsl:value-of select="document($this-props-path)/document/ouc:properties[@label='config']/parameter[@name='global-site-settings']/option[@selected='true' and @value='contact-info-on']/@value"/>
            </xsl:variable>
            
            <xsl:if test="$contact-top-on = 'contact-top-on'">
                <xsl:apply-templates select="ouc:div[@label='rightsidebar-top']" />
            </xsl:if>
            
            <xsl:if test="$contact-info-on = 'contact-info-on'">
                <div class="contact-info-wrapper">
                    <xsl:call-template name="unparsed-include-file">
                        <xsl:with-param name="path" select="$contact-info-path" />
                    </xsl:call-template>
                </div>
            </xsl:if>
            
            <xsl:apply-templates select="ouc:div[@label='rightsidebar']" />
        </div>
    </xsl:template>
    
    <xsl:template name="left-sidebar-nav">
        <div class="col-12 col-lg-3 left-navigation">
            <!-- 			<xsl:call-template name="unparsed-include-file">
                 <xsl:with-param name="path" select="concat($navigation-start, '_nav.php')" />
                 </xsl:call-template> -->
            <!-- 			<xsl:copy-of select="ou:ssi($navigation-start'_nav.php')" /> -->
            <xsl:variable name="apinav">
                <xsl:value-of select="concat($navigation-start, '_nav.php')" />
            </xsl:variable>
            <xsl:call-template name="unparsed-include-file">
                <xsl:with-param name="path" select="$apinav" />
            </xsl:call-template>
            <!-- 			<xsl:copy-of select="ou:ssi($apinav)" /> -->
        </div>
    </xsl:template>
    
    <xsl:template name="newsletter">
        <div class="container-xxl">
            <xsl:call-template name="breadcrumb-section"/>
            <div class="row px-0 px-lg-4 mt-1">
                <div class="col-12 col-lg-9 lpc-newsletter">
                    
                    <xsl:if test="normalize-space($top-img) != ''">
                        <div class="top-img-wrapper">
                            <img src="{$top-img}" alt="{$top-img-alt}" class="img-fluid w-100" />
                        </div>
                    </xsl:if>
                    
                    <h1><xsl:value-of select="$page-title" /></h1>
                    
                    <xsl:apply-templates select="ouc:div[@label='maincontent']" />
                    
                </div>
                
                <xsl:call-template name="sidebar-section"/>
            </div>
        </div>
    </xsl:template>
    
    <xsl:template name="newsletter-listing">
        <div class="container-xxl">
            <xsl:call-template name="breadcrumb-section"/>
            <div class="row px-0 px-lg-4 mt-1">
                <div class="col-12 col-lg-9 lpc-newsletter-listing">
                    <xsl:if test="ou:pcf-param('has-listing') = '1'">
                        <div>
                            <xsl:call-template name="directory-listing-feed"/>
                        </div>
                    </xsl:if>
                    <xsl:apply-templates select="ouc:div[@label='maincontent']" />
                </div>
                <xsl:call-template name="sidebar-section"/>
            </div>
        </div>	
    </xsl:template>
    
    <xsl:template name="newsletter-listing-feed">
        <xsl:processing-instruction name="php">
            $tag = "<xsl:value-of select="ou:pcf-param('dept')" />";	
            ?</xsl:processing-instruction>
        <xsl:variable name="listing-src">
            <xsl:value-of select="ou:pcf-param('listing-src')" />
        </xsl:variable>
        <xsl:copy-of select="ou:ssi($listing-src)" />
    </xsl:template>
    
    <xsl:template name="main-section">
        <div class="container-xxl">
            <xsl:call-template name="breadcrumb-section"/>
            <div class="row px-5 mt-1">
                <div class="col-12 modo-content">
                    <xsl:apply-templates select="ouc:div[@label='maincontent']" />
                    <xsl:if test="ou:pcf-param('has-listing') = '1'">
                        <div>
                            <xsl:call-template name="directory-listing"/>
                        </div>
                    </xsl:if>
                </div>
            </div>
        </div>
    </xsl:template>
    
    <xsl:template name="right-sidebar-section">
        <div class="container-xxl">
            <xsl:call-template name="breadcrumb-section"/>
            <div class="row px-5 mt-1">
                <div class="col-12 col-md-9">
                    <xsl:apply-templates select="ouc:div[@label='maincontent']" />
                </div>
                <xsl:call-template name="sidebar-section"/>
            </div>
        </div>
    </xsl:template>
    
    <xsl:template name="media-section">
        <div class="section media-section">
            <div class="container-fluid">
                <div class="row px-5">
                    
                    <div class="col-md-4 calendar-section">
                        <div>
                            <h2>Event Calendar</h2>
                            <xsl:copy-of select="ou:ssi('/_resources/scripts/events-rss.php')" />
                        </div>
                    </div>
                    
                    <div class="col-md-4 athletics-section">
                        <div>
                            <h2>Hawks Athletics</h2>
                            <xsl:copy-of select="ou:ssi('/_resources/scripts/athletics-rss.php')" />
                        </div>
                    </div>
                    
                    <div class="col-md-4 info-section">
                        <div>
                            <h2>Announcements</h2>
                            <xsl:apply-templates select="ouc:div[@label='announcements']" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </xsl:template>
    
    <xsl:template match="ul[@class='pgas-list list-purple']/li">
        <xsl:for-each select=".">
            <li>
                <a target="_blank" rel="noopener">
                    <xsl:attribute name="href"><xsl:value-of select="a/@href"/></xsl:attribute>
                    <xsl:attribute name="aria-label"><xsl:value-of select="." /></xsl:attribute>
                    <xsl:value-of select="a/strong" /><br /><xsl:value-of select="a/em" />
                </a>
            </li>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="ul[@class='pgas-list list-blue']/li">
        <xsl:for-each select=".">
            <li>
                <a target="_blank" rel="noopener">
                    <xsl:attribute name="href"><xsl:value-of select="a/@href"/></xsl:attribute>
                    <xsl:attribute name="aria-label"><xsl:value-of select="." /></xsl:attribute>
                    <xsl:value-of select="a/strong" /><br /><xsl:value-of select="a/em" />
                </a>
            </li>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="table[@class='ou-lpc-accordion']">
        <xsl:variable name="linkId">
            <xsl:value-of select="generate-id()" />
        </xsl:variable>
        
        <div class="accordion">
            <div class="accordion-item">
                <h2 class="accordion-header" id="{$linkId}-heading">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#{$linkId}" aria-expanded="false" aria-controls="{$linkId}">
                        <xsl:value-of select="tbody/tr[1]/td" />
                    </button>
                </h2>
                
                <div id="{$linkId}" class="accordion-collapse collapse" aria-labelledby="{$linkId}-heading">
                    <div class="accordion-body">
                        <xsl:apply-templates select="tbody/tr[2]/td" />
                    </div>
                </div>
            </div>
        </div>	
    </xsl:template>
    
    <xsl:template name="top-bar">
        <div class="section top-bar-are black-bar">
            <div class="container-xxl">
                <div class="row">
                    <xsl:apply-templates select="ouc:div[@label='top-bar-content']" />
                </div>
            </div>
        </div>
    </xsl:template>
    
    <xsl:template name="banner" expand-text="yes">
        <xsl:variable name="images">
            <img>
                <source>{if (normalize-space(ou:pcf-param('photo-1')) != '') then ou:pcf-param('photo-1') else $ou:top-banner-image }</source>
                <alt>{if (normalize-space(ou:pcf-param('photo-alt-1')) != '') then ou:pcf-param('photo-alt-1') else $ou:top-banner-image-alt}</alt>
                <link>{ if (normalize-space(ou:pcf-param('photo-link-1')) != '') then ou:pcf-param('photo-link-1') else $ou:top-banner-image-link}</link>
            </img>
        </xsl:variable>
        
        <div class="section">
            <div class="d-flex p-4 text-center bg-image interior-bg-image flex-sm-column flex-lg-row align-items-center" style="
                    background-image: url('{$images/img[1]/source}');
                    height: {ou:pcf-param('top-banner-height')}px;">
                
                <xsl:if test="ou:pcf-param('top-banner-text') != '' ">
                    <div class="banner-text">
                        <span class="d-flex align-items-center">
                            <xsl:value-of select="ou:pcf-param('top-banner-text')" />
                        </span>
                    </div>
                </xsl:if>
                
            </div>
        </div>
    </xsl:template>
    
    
    
    <xsl:template name="fixed-width-banner" expand-text="yes">
        <xsl:variable name="images">
            <img>
                <source>{if (normalize-space(ou:pcf-param('photo-1')) != '') then ou:pcf-param('photo-1') else $ou:top-banner-image }</source>
                <alt>{if (normalize-space(ou:pcf-param('photo-alt-1')) != '') then ou:pcf-param('photo-alt-1') else $ou:top-banner-image-alt}</alt>
                <link>{ if (normalize-space(ou:pcf-param('photo-link-1')) != '') then ou:pcf-param('photo-link-1') else $ou:top-banner-image-link}</link>
            </img>
        </xsl:variable>
        <div class="section lpc-banner-bg">	
            <div class="container-xxl">
                <div class="banner-img-fixed">
                    <img class="img-fluid" src="{$images/img[1]/source}" alt="{$images/img[1]/alt}" />
                </div>
            </div>
        </div>
    </xsl:template>
    
    <xsl:template name="course-table">
        <table class="display nowrap" summary="Faculty and Staff Directory" id="profiles" style="width:100%">
            <thead>
                <tr>
                    <th data-orderable="false" scope="col">Register</th>
                    <th scope="col">Subject</th>
                    <th data-orderable="false" scope="col">Title</th>
                    <th data-orderable="false" scope="col">Section</th>
                    <th data-orderable="false" scope="col">CRN</th>
                    <th scope="col">Location</th>
                    <th scope="col">Days</th>
                    <th data-orderable="false" scope="col">Start Time</th>
                    <th data-orderable="false" scope="col">End Time</th>
                    <th scope="col">Units</th>
                    <th scope="col">Start Date</th>
                    <th scope="col">End Date</th>
                    <th scope="col">Instructor</th>
                </tr>
            </thead>
            <tbody>
                <xsl:call-template name="google-sheet-src" />
            </tbody>	
        </table>
    </xsl:template>
    
    <xsl:template name="google-sheet-src">
        <xsl:copy-of select="ou:ssi('/_resources/scripts/8-week-classes.php')" />
    </xsl:template>
    
    <xsl:template match="table[@class='open-hours-table']">
        <div class="open-hours-table">
            <p>Office Hours</p>
            <xsl:for-each select="tbody/tr">
                <div>
                    <div>
                        <xsl:value-of select="normalize-space(td[1])" />
                    </div>
                    <div>
                        <xsl:value-of select="normalize-space(td[2])" />
                    </div>
                </div>
            </xsl:for-each>
        </div>
    </xsl:template>
    
    <xsl:template match="social-flex-wrapper">
        
        
        <div class="social-flex-wrapper">
            
            <xsl:for-each select="lpc-sm">
                <xsl:variable name="platform" select="platform" />
                <xsl:variable name="url" select="url" />
                
                <xsl:choose>
                    
                    <xsl:when test="$platform = 'Facebook'">
                        <div class="social-fa-flex facebook-bg">
                            <a class="social-fa" href="{$url}" target="_blank" rel="noopener" aria-label="Facebook">
                                <span class="fa-brands fa-facebook-f"></span>
                            </a>
                        </div>
                    </xsl:when>
                    
                    <xsl:when test="$platform = 'Twitter'">
                        <div class="social-fa-flex twitter-bg">
                            <a class="social-fa" href="{$url}" target="_blank" rel="noopener" aria-label="Twitter">
                                <span class="fa-brands fa-twitter"></span>
                            </a>
                        </div>
                    </xsl:when>
                    
                    <xsl:when test="$platform = 'Instagram'">
                        <div class="social-fa-flex instagram-bg">
                            <a class="social-fa" href="{$url}" target="_blank" rel="noopener" aria-label="Instagram">
                                <span class="fa-brands fa-instagram"></span>
                            </a>
                        </div>
                    </xsl:when>
                    
                    <xsl:when test="$platform = 'YouTube'">
                        <div class="social-fa-flex youtube-bg">
                            <a class="social-fa" href="{$url}" target="_blank" rel="noopener" aria-label="YouTube">
                                <span class="fa-brands fa-youtube"></span>
                            </a>
                        </div>
                    </xsl:when>
                    
                    <xsl:when test="$platform = 'LinkedIn'">
                        <div class="social-fa-flex linkedin-bg">
                            <a class="social-fa" href="{$url}" target="_blank" rel="noopener" aria-label="LinkedIn">
                                <span class="fa-brands fa-linkedin"></span>
                            </a>
                        </div>
                    </xsl:when>
                    
                    <xsl:otherwise></xsl:otherwise>
                    
                </xsl:choose>
                
            </xsl:for-each>
            
        </div>
        
        <!-- 		<div class="open-hours-table">
             <p>Office Hours</p>
             <xsl:for-each select="tbody/tr">
             <div>
             <div>
             <xsl:value-of select="normalize-space(td[1])" />
             </div>
             <div>
             <xsl:value-of select="normalize-space(td[2])" />
             </div>
             </div>
             </xsl:for-each>
             </div> -->
     </xsl:template>
    
    <xsl:template name="directory-listing">
        <xsl:processing-instruction name="php">
            $tag = "<xsl:value-of select="ou:pcf-param('dept')" />";	
            ?</xsl:processing-instruction>
        <xsl:variable name="listing-src">
            <xsl:value-of select="ou:pcf-param('listing-src')" />
        </xsl:variable>
        <xsl:copy-of select="ou:ssi($listing-src)" />
    </xsl:template>
    
    <!-- Academic Calendar -->
    
    
    
    <xsl:template name="academic-calendar">
        <div class="container-xxl">
            <xsl:call-template name="breadcrumb-section"/>
            <div class="row px-0 px-lg-4 mt-1">
                <div class="col-12 col-lg-9">
                    <h1>Academic Calendar</h1>
                    <div class="academic-calendar-tabs">
                        <!-- Nav tabs -->
                        <ul class="nav nav-tabs" role="tablist">
                            <xsl:choose>
                                <xsl:when test="ou:pcf-param('active-calendar') = '0'">
                                    <li class="nav-item" role="presentation" id="fall-tab"><a class="nav-link active" role="tab" href="#fall" aria-controls="fall" data-bs-toggle="tab" data-bs-target="#fall">Fall Calendar</a></li>
                                </xsl:when>
                                <xsl:otherwise>
                                    <li class="nav-item" role="presentation" id="fall-tab"><a class="nav-link" role="tab" href="#fall" aria-controls="fall" data-bs-toggle="tab" data-bs-target="#fall">Fall Calendar</a></li>
                                </xsl:otherwise>
                            </xsl:choose>
                            
                            <xsl:choose>
                                <xsl:when test="ou:pcf-param('active-calendar') = '1'">
                                    <li class="nav-item" role="presentation" id="winter-tab"><a class="nav-link active" role="tab" href="#winter" aria-controls="winter" data-bs-toggle="tab" data-bs-target="#winter">Winter Intersession</a></li>
                                </xsl:when>
                                <xsl:otherwise>
                                    <li class="nav-item" role="presentation" id="winter-tab"><a class="nav-link" role="tab" href="#winter" aria-controls="winter" data-bs-toggle="tab" data-bs-target="#winter">Winter Intersession</a></li>
                                </xsl:otherwise>
                            </xsl:choose>
                            
                            <xsl:choose>
                                <xsl:when test="ou:pcf-param('active-calendar') = '2'">
                                    <li class="nav-item" role="presentation" id="spring-tab"><a class="nav-link active" role="tab" href="#spring" aria-controls="spring" data-bs-toggle="tab" data-bs-target="#spring">Spring Calendar</a></li>
                                </xsl:when>
                                <xsl:otherwise>
                                    <li class="nav-item" role="presentation" id="spring-tab"><a class="nav-link" role="tab" href="#spring" aria-controls="spring" data-bs-toggle="tab" data-bs-target="#spring">Spring Calendar</a></li>
                                </xsl:otherwise>
                            </xsl:choose>
                            
                            <xsl:choose>
                                <xsl:when test="ou:pcf-param('active-calendar') = '3'">
                                    <li class="nav-item" role="presentation" id="summer-tab"><a class="nav-link active" role="tab" href="#summer" aria-controls="summer" data-bs-toggle="tab" data-bs-target="#summer">Summer Calendar</a></li>
                                </xsl:when>
                                <xsl:otherwise>
                                    <li class="nav-item" role="presentation" id="summer-tab"><a class="nav-link" role="tab" href="#summer" aria-controls="summer" data-bs-toggle="tab" data-bs-target="#summer">Summer Calendar</a></li>
                                </xsl:otherwise>
                            </xsl:choose>
                            <li class="nav-item" role="presentation"><a role="tab" href="{{f:24833544}}">Final Exam Schedule</a></li>
                        </ul>
                        
                        <!-- Tab panes -->
                        <div class="tab-content">
                            
                            <!-- Fall -->
                            <xsl:call-template name="fall-calendar" />
                            
                            <!-- Winter -->
                            <xsl:call-template name="winter-calendar" />
                            
                            <!-- Spring -->
                            <xsl:call-template name="spring-calendar" />
                            
                            <!-- Summer -->
                            <xsl:call-template name="summer-calendar" />
                            
                        </div>
                    </div>
                    
                </div>
                <xsl:call-template name="sidebar-section"/>
            </div>
        </div>
        
    </xsl:template>
    
    <xsl:template name="fall-calendar">
        
        <xsl:choose>
            <xsl:when test="ou:pcf-param('active-calendar') = '0'">
                <div id="fall" class="tab-pane fade show active" role="tabpanel" aria-labelledby="fall-tab" tabindex="0">
                    <xsl:apply-templates select="ouc:div[@label='fall-calendar']" />
                </div>
            </xsl:when>
            <xsl:otherwise>
                <div id="fall" class="tab-pane fade" role="tabpanel" aria-labelledby="fall-tab" tabindex="0">
                    <xsl:apply-templates select="ouc:div[@label='fall-calendar']" />
                </div>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="winter-calendar">
        <xsl:choose>
            <xsl:when test="ou:pcf-param('active-calendar') = '1'">
                <div id="winter" class="tab-pane fade show active" role="tabpanel" aria-labelledby="winter-tab" tabindex="0">
                    <xsl:apply-templates select="ouc:div[@label='winter-calendar']" />
                </div>
            </xsl:when>
            <xsl:otherwise>
                <div id="winter" class="tab-pane fade" role="tabpanel" aria-labelledby="winter-tab" tabindex="0">
                    <xsl:apply-templates select="ouc:div[@label='winter-calendar']" />
                </div>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="spring-calendar">
        <xsl:choose>
            <xsl:when test="ou:pcf-param('active-calendar') = '2'">
                <div id="spring" class="tab-pane fade show active" role="tabpanel" aria-labelledby="spring-tab" tabindex="0">
                    <xsl:apply-templates select="ouc:div[@label='spring-calendar']" />
                </div>
            </xsl:when>
            <xsl:otherwise>
                <div id="spring" class="tab-pane fade" role="tabpanel" aria-labelledby="spring-tab" tabindex="0">
                    <xsl:apply-templates select="ouc:div[@label='spring-calendar']" />
                </div>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="summer-calendar">
        <xsl:choose>
            <xsl:when test="ou:pcf-param('active-calendar') = '3'">
                <div id="summer" class="tab-pane fade show active" role="tabpanel" aria-labelledby="summer-tab" tabindex="0">
                    <xsl:apply-templates select="ouc:div[@label='summer-calendar']" />
                </div>
            </xsl:when>
            <xsl:otherwise>
                <div id="summer" class="tab-pane fade" role="tabpanel" aria-labelledby="summer-tab" tabindex="0">
                    <xsl:apply-templates select="ouc:div[@label='summer-calendar']" />
                </div>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- END Academic Calendar -->
    
    <!-- FSP Page -->
    <xsl:template name="fsp-page">
        <div class="container-xxl">
            <xsl:call-template name="breadcrumb-section"/>
            <div class="row px-0 px-lg-4 mt-1">
                <div class="col-12">
                    <h1><xsl:value-of select="ou:pcf-param('breadcrumb')" /></h1>
                    <xsl:choose>
                        <xsl:when test="ou:pcf-param('active-calendar') = '0'">
                            
                            <xsl:call-template name="fall-semester" />
                        </xsl:when>
                        <xsl:when test="ou:pcf-param('active-calendar') = '1'">
                            
                            <xsl:call-template name="spring-semester" />
                        </xsl:when>
                        <xsl:when test="ou:pcf-param('active-calendar') = '2'">
                            
                            <xsl:call-template name="summer-semester" />
                        </xsl:when>
                        <xsl:otherwise>
                        </xsl:otherwise>
                    </xsl:choose>	
                </div>
            </div>
        </div>
    </xsl:template>
    
    <xsl:template name="fall-semester">
        
        <xsl:choose>
            <xsl:when test="ou:pcf-param('active-calendar') = '0'">
                <div id="fall" class="fall-tab">
                    <div class="row mt-1">
                        <div class="col-12 p-3">
                            <xsl:apply-templates select="ouc:div[@label='fall-semester-col-1']" />
                        </div>
                    </div>
                </div>
            </xsl:when>
            <xsl:otherwise>
                <div id="fall" class="tab-pane fade" role="tabpanel" aria-labelledby="fall-tab" tabindex="0">
                    <div class="row mt-1">
                        <div class="col-12 col-lg-6 p-3">
                            <xsl:apply-templates select="ouc:div[@label='fall-semester-col-1']" />
                        </div>
                        <div class="col-12 col-lg-6 right-col-main p-3">
                            <xsl:apply-templates select="ouc:div[@label='fall-semester-col-2']" />
                        </div>
                    </div>
                </div>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="spring-semester">
        <xsl:choose>
            <xsl:when test="ou:pcf-param('active-calendar') = '1'">
                <div id="spring" class="spring-tab">
                    <div class="row mt-1">
                        <div class="col-12 col-lg-6 p-3">
                            <xsl:apply-templates select="ouc:div[@label='spring-semester-col-1']" />
                        </div>
                        <div class="col-12 col-lg-6 right-col-main p-3">
                            <xsl:apply-templates select="ouc:div[@label='spring-semester-col-2']" />
                        </div>
                    </div>
                </div>
            </xsl:when>
            <xsl:otherwise>
                <div id="spring" class="tab-pane fade" role="tabpanel" aria-labelledby="spring-tab" tabindex="0">
                    <div class="row mt-1">
                        <div class="col-12 col-lg-6 p-3">
                            <xsl:apply-templates select="ouc:div[@label='spring-semester-col-1']" />
                        </div>
                        <div class="col-12 col-lg-6 right-col-main p-3">
                            <xsl:apply-templates select="ouc:div[@label='spring-semester-col-2']" />
                        </div>
                    </div>
                </div>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="summer-semester">
        <xsl:choose>
            <xsl:when test="ou:pcf-param('active-calendar') = '2'">
                <div id="summer" class="summer-tab">
                    <div class="row mt-1">
                        <div class="col-12 col-lg-6 p-3">
                            <xsl:apply-templates select="ouc:div[@label='summer-semester-col-1']" />
                        </div>
                        <div class="col-12 col-lg-6 right-col-main p-3">
                            <xsl:apply-templates select="ouc:div[@label='summer-semester-col-2']" />
                        </div>
                    </div>
                </div>
            </xsl:when>
            <xsl:otherwise>
                <div id="summer" class="tab-pane fade" role="tabpanel" aria-labelledby="summer-tab" tabindex="0">
                    <div class="row mt-1">
                        <div class="col-12 col-lg-6 p-3">
                            <xsl:apply-templates select="ouc:div[@label='summer-semester-col-1']" />
                        </div>
                        <div class="col-12 col-lg-6 right-col-main p-3">
                            <xsl:apply-templates select="ouc:div[@label='summer-semester-col-2']" />
                        </div>
                    </div>
                </div>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- END FSP Page -->
    
    <xsl:template match="table[@class='table table-striped ar-staff-table']">
        <xsl:for-each select="tbody/tr">
            <div class="staff-card">
                
                <div>
                    <p><xsl:value-of select="td[1]" /></p>
                    <p><xsl:apply-templates select="td[2]" /></p>
                    <p>
                        <a class="staff-email">
                            <xsl:attribute name="href">mailto:<xsl:value-of select="normalize-space(td[3])" /></xsl:attribute>
                            <xsl:value-of select="normalize-space(td[3])" />
                        </a>
                    </p>
                    
                    <xsl:if test="string-length(td[4]) &gt; 2">
                        <p>
                            <a class="staff-phone">
                                <xsl:attribute name="href">tel:<xsl:value-of select="normalize-space(td[4])" /></xsl:attribute>
                                <xsl:value-of select="normalize-space(td[4])" />
                            </a>
                        </p>
                    </xsl:if>
                    
                </div>
                
                <xsl:if test="string-length(td[5]) &gt; 5">
                    <div>
                        <p><strong>A&amp;R Services:</strong></p>
                        <p><xsl:apply-templates select="td[5]" /></p>
                    </div>	
                </xsl:if>
                
            </div>
        </xsl:for-each>
    </xsl:template>
    
    <!-- STEPS TO SUCCESS - ACCORDIONS	 -->
    
    <xsl:template match="table[@class='ou-lpc-accordion-apply']">
        <xsl:variable name="linkId" select="if (tbody/@id) then tbody/@id else generate-id()" />
        
        <div class="accordion" role="tablist">
            <div class="accordion-item apply">
                <h2 class="accordion-header" id="{$linkId}-heading">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#{$linkId}" aria-expanded="false" aria-controls="{$linkId}">
                        <xsl:value-of select="tbody/tr[1]/td" />
                    </button>
                </h2>
                
                <div id="{$linkId}" class="accordion-collapse collapse" role="tabpanel" aria-labelledby="{$linkId}-heading">
                    <div class="accordion-body">
                        <xsl:apply-templates select="tbody/tr[2]/td" />
                    </div>
                </div>
            </div>
        </div>	
    </xsl:template>
    
    <xsl:template match="table[@class='ou-lpc-accordion-financialaid']">
        <xsl:variable name="linkId" select="if (tbody/@id) then tbody/@id else generate-id()" />
        
        <div class="accordion" role="tablist">
            <div class="accordion-item financialaid">
                <h2 class="accordion-header" id="{$linkId}-heading">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#{$linkId}" aria-expanded="false" aria-controls="{$linkId}">
                        <xsl:value-of select="tbody/tr[1]/td" />
                    </button>
                </h2>
                
                <div id="{$linkId}" class="accordion-collapse collapse" role="tabpanel" aria-labelledby="{$linkId}-heading">
                    <div class="accordion-body">
                        <xsl:apply-templates select="tbody/tr[2]/td" />
                    </div>
                </div>
            </div>
        </div>	
    </xsl:template>
    
    <xsl:template match="table[@class='ou-lpc-accordion-orientation']">
        <xsl:variable name="linkId" select="if (tbody/@id) then tbody/@id else generate-id()" />
        
        <div class="accordion" role="tablist">
            <div class="accordion-item orientation">
                <h2 class="accordion-header" id="{$linkId}-heading">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#{$linkId}" aria-expanded="false" aria-controls="{$linkId}">
                        <xsl:value-of select="tbody/tr[1]/td" />
                    </button>
                </h2>
                
                <div id="{$linkId}" class="accordion-collapse collapse" role="tabpanel" aria-labelledby="{$linkId}-heading">
                    <div class="accordion-body">
                        <xsl:apply-templates select="tbody/tr[2]/td" />
                    </div>
                </div>
            </div>
        </div>
    </xsl:template>
    
    <xsl:template match="table[@class='ou-lpc-accordion-assessment']">
        <xsl:variable name="linkId" select="if (tbody/@id) then tbody/@id else generate-id()" />
        
        <div class="accordion" role="tablist">
            <div class="accordion-item assessment">
                <h2 class="accordion-header" id="{$linkId}-heading">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#{$linkId}" aria-expanded="false" aria-controls="{$linkId}">
                        <xsl:value-of select="tbody/tr[1]/td" />
                    </button>
                </h2>
                
                <div id="{$linkId}" class="accordion-collapse collapse" role="tabpanel" aria-labelledby="{$linkId}-heading">
                    <div class="accordion-body">
                        <xsl:apply-templates select="tbody/tr[2]/td" />
                    </div>
                </div>
            </div>
        </div>
    </xsl:template>
    
    <xsl:template match="table[@class='ou-lpc-accordion-plan']">
        <xsl:variable name="linkId" select="if (tbody/@id) then tbody/@id else generate-id()" />
        
        <div class="accordion" role="tablist">
            <div class="accordion-item plan">
                <h2 class="accordion-header" id="{$linkId}-heading">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#{$linkId}" aria-expanded="false" aria-controls="{$linkId}">
                        <xsl:value-of select="tbody/tr[1]/td" />
                    </button>
                </h2>
                
                <div id="{$linkId}" class="accordion-collapse collapse" role="tabpanel" aria-labelledby="{$linkId}-heading">
                    <div class="accordion-body">
                        <xsl:apply-templates select="tbody/tr[2]/td" />
                    </div>
                </div>
            </div>
        </div>
    </xsl:template>
    
    <xsl:template match="table[@class='ou-lpc-accordion-payfees']">
        <xsl:variable name="linkId" select="if (tbody/@id) then tbody/@id else generate-id()" />
        
        <div class="accordion" role="tablist">
            <div class="accordion-item payfees">
                <h2 class="accordion-header" id="{$linkId}-heading">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#{$linkId}" aria-expanded="false" aria-controls="{$linkId}">
                        <xsl:value-of select="tbody/tr[1]/td" />
                    </button>
                </h2>
                
                <div id="{$linkId}" class="accordion-collapse collapse" role="tabpanel" aria-labelledby="{$linkId}-heading">
                    <div class="accordion-body">
                        <xsl:apply-templates select="tbody/tr[2]/td" />
                    </div>
                </div>
            </div>
        </div>
    </xsl:template>
    
    <xsl:template match="table[@class='ou-lpc-accordion-light']">
        <xsl:variable name="linkId" select="if (tbody/@id) then tbody/@id else generate-id()" />
        
        <div class="accordion" role="tablist">
            <div class="accordion-item light">
                <h2 class="accordion-header" id="{$linkId}-heading">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#{$linkId}" aria-expanded="false" aria-controls="{$linkId}">
                        <xsl:value-of select="tbody/tr[1]/td" />
                    </button>
                </h2>
                
                <div id="{$linkId}" class="accordion-collapse collapse" role="tabpanel" aria-labelledby="{$linkId}-heading">
                    <div class="accordion-body">
                        <xsl:apply-templates select="tbody/tr[2]/td" />
                    </div>
                </div>
            </div>
        </div>
    </xsl:template>
    
</xsl:stylesheet>