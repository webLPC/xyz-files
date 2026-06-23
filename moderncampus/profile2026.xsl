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
    
    <xsl:import href="../common-lpc2024.xsl"/>
    
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
                    <xsl:when test="ou:pcf-param('layout-section-toggle') = '0'">
                        <xsl:call-template name="one-column"/>
                    </xsl:when>
                    <xsl:when test="ou:pcf-param('layout-section-toggle') = '1'">
                        <xsl:call-template name="two-column"/>
                    </xsl:when>
                    <xsl:when test="ou:pcf-param('layout-section-toggle') = '2'">
                        <xsl:call-template name="three-column"/>
                    </xsl:when>
                    <xsl:when test="ou:pcf-param('layout-section-toggle') = '3'">
                        <xsl:call-template name="two-column-nav"/>
                    </xsl:when>
                    <xsl:when test="ou:pcf-param('layout-section-toggle') = '4'">
                        <xsl:call-template name="one-column-google-sheet"/>
                    </xsl:when>
                    <xsl:when test="ou:pcf-param('layout-section-toggle') = '5'">
                        <xsl:call-template name="two-column-50-50"/>
                    </xsl:when>
                    <xsl:when test="ou:pcf-param('layout-section-toggle') = '6'">
                        <xsl:call-template name="academic-calendar" />
                    </xsl:when>
                    <xsl:when test="ou:pcf-param('layout-section-toggle') = '7'">
                        <xsl:call-template name="fsp-page" />
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
            <xsl:variable name="apinav">
                <xsl:value-of select="concat($navigation-start, '_nav.php')" />
            </xsl:variable>
            <xsl:call-template name="unparsed-include-file">
                <xsl:with-param name="path" select="$apinav" />
            </xsl:call-template>
            <!-- 			<xsl:copy-of select="ou:ssi($apinav)" /> -->
        </div>
    </xsl:template>
    
    <xsl:template name="one-column">
        <div class="container-xxl">
            <xsl:call-template name="breadcrumb-section"/>
            <div class="row px-0 px-lg-4 mt-1">
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
    
    <xsl:template name="one-column-google-sheet">
        <div class="container-xxl">
            <xsl:call-template name="breadcrumb-section"/>
            <div class="row px-0 px-lg-4 mt-1">
                <div class="col-12">
                    <xsl:apply-templates select="ouc:div[@label='maincontent']" />
                </div>
                <div class="col-12">
                    <xsl:call-template name="course-table"/>
                </div>
            </div>
        </div>
    </xsl:template>
    
    <xsl:template name="two-column">
        <div class="container-xxl">
            <xsl:call-template name="breadcrumb-section"/>
            <div class="row px-0 px-lg-4 mt-1 modo-content">
                <div class="col-12 col-lg-9">
                    <xsl:apply-templates select="ouc:div[@label='maincontent']" />
                    <xsl:if test="ou:pcf-param('has-listing') = '1'">
                        <div>
                            <xsl:call-template name="directory-listing"/>
                        </div>
                    </xsl:if>
                </div>
                <xsl:call-template name="sidebar-section"/>
            </div>
        </div>
    </xsl:template>
    
    <xsl:template name="three-column">
        <div class="container-xxl">
            <xsl:call-template name="breadcrumb-section"/>
            <div class="row px-0 px-lg-4 mt-1">
                <xsl:call-template name="left-sidebar-nav"/>
                <div class="col-12 col-lg-6 main-content-column">
                    <xsl:apply-templates select="ouc:div[@label='maincontent']" />
                    <xsl:if test="ou:pcf-param('has-listing') = '1'">
                        <div>
                            <xsl:call-template name="directory-listing"/>
                        </div>
                    </xsl:if>
                </div>
                
                <xsl:call-template name="sidebar-section"/>
            </div>
        </div>
    </xsl:template>
    
    <xsl:template name="two-column-50-50">
        <div class="container-xxl">
            <xsl:call-template name="breadcrumb-section"/>
            <div class="row px-0 px-lg-4 mt-1 modo-content">
                <div class="col-12 header-one-row">
                    <h1><xsl:value-of select="ou:pcf-param('breadcrumb')" /></h1>
                </div>
                <div class="col-12 col-lg-6 p-3 left-col-main">
                    <xsl:apply-templates select="ouc:div[@label='maincontent']" />
                </div>
                <div class="col-12 col-lg-6 p-3 right-col-main">
                    <xsl:apply-templates select="ouc:div[@label='rightsidebar']" />
                </div>
            </div>
        </div>
    </xsl:template>
    
    <xsl:template name="two-column-nav">
        <div class="container-xxl">
            <xsl:call-template name="breadcrumb-section"/>
            <div class="row px-0 px-lg-4 mt-1">
                <xsl:call-template name="left-sidebar-nav"/>
                <div class="col-12 col-lg-9 main-content-column">
                    <xsl:apply-templates select="profile"/>	
                    <xsl:apply-templates select="ouc:div[@label='maincontent']" />
                </div>
            </div>
        </div>
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
    
    <!-- multiedit -->
    <xsl:template name="multiedit-content" match="profile" expand-text="yes">
        <xsl:variable name="first-name" select="ou:multiedit-field('first-name')"/>
        <xsl:variable name="last-name" select="ou:multiedit-field('last-name')"/>
        <xsl:variable name="title" select="ou:multiedit-field('title')"/>
        <xsl:variable name="classification" select="ou:multiedit-field('classification')"/>
        <xsl:variable name="department" select="ou:multiedit-field('department')"/>
        <xsl:variable name="email" select="ou:multiedit-field('email')"/>
        <xsl:variable name="phone" select="ou:multiedit-field('phone')"/>
        <xsl:variable name="office" select="ou:multiedit-field('office')"/>
        <xsl:variable name="office-hours" select="ou:multiedit-field('office-hours')"/>
        <xsl:variable name="zoom-link" select="ou:multiedit-field('zoom-link')"/>
        <xsl:variable name="resources" select="ou:multiedit-field('resources')"/>
        <div class="row">
            <div class="profile-top-area">
                <div class="col-md-8 col-sm-8 profile-top">
                    <h2><xsl:value-of select="$first-name"/><xsl:text> </xsl:text><xsl:value-of select="$last-name"/></h2>
                    <h3><xsl:value-of select="$title"/></h3>
                    <h4><a href="{$navigation-start}"><xsl:value-of select="$department"/></a></h4>
                    <ul>
                        <li><strong>E-mail:</strong><xsl:text> </xsl:text><a href="mailto:{$email}"><xsl:value-of select="$email"/></a></li>
                        <li><strong>Phone:</strong><xsl:text> </xsl:text><xsl:value-of select="$phone"/></li>
                        
                        <xsl:if test="not($office='')">
                            <li><strong>Office:</strong><xsl:text> </xsl:text><xsl:value-of select="$office"/></li>
                        </xsl:if>
                        
                        <xsl:if test="not($zoom-link='')">
                            <li><strong>Office Hours: </strong><a href="{$zoom-link}" target="_blank" rel="noopener">Office Hours Zoom Link</a></li>
                        </xsl:if>	
                    </ul>
                    
                    <xsl:if test="not($office-hours='')">
                        <xsl:copy-of select="$office-hours"/>
                    </xsl:if>
                    
                </div>
                <!-- image element -->
                <div class="col-md-4 col-sm-4">
                    <xsl:if test="ou:multiedit-field('image')/img/@src != ''">
                        <img src="{ou:multiedit-field('image')/img/@src}" alt="{ou:multiedit-field('image')/img/@alt}" class="profile-image img-responsive"/>			
                    </xsl:if>
                </div>
            </div>
        </div>
    </xsl:template>
    
</xsl:stylesheet>