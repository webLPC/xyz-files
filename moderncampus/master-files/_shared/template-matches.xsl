<?xml version="1.0" encoding="UTF-8"?>
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

STANDARD TEMPLATE MATCHES
Identity templates that recursively copies all content, or applies other applicable templates.

Contributors: Your Name Here
Last Updated: Enter Date Here
-->
<xsl:stylesheet version="3.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:ou="http://omniupdate.com/XSL/Variables"
  xmlns:fn="http://omniupdate.com/XSL/Functions"
  xmlns:ouc="http://omniupdate.com/XSL/Variables"
  exclude-result-prefixes="xs ou fn ouc">
	
    <!-- Identity Matches -->
    <!-- The following template matches all items except processing instructions, copies them, then processes any children. -->
    <xsl:template match="attribute()|text()|comment()">
        <xsl:copy />
    </xsl:template>
    
    <xsl:template match="element()">
        <xsl:element name="{name()}">
            <xsl:apply-templates select="attribute()|node()"/>
        </xsl:element>
    </xsl:template>

    <!-- MISC -->
    <!-- don't output ouc tags on publish. -->
    <xsl:template match="ouc:*[$ou:action !='edt']">
        <xsl:apply-templates />
    </xsl:template>  
          
    <!-- Visual warning for broken dependencies tags -->
    <xsl:template match="a[contains(@href,'*** Broken')]">
        <a href="{@href}" style="color: red;"><xsl:value-of select="."/></a> <span style="color: red;">[BROKEN LINK]</span>
    </xsl:template>
    
    <!-- The following template matches processing instructions, outputs the proper syntax with the code escaped properly. -->
    <!-- Remove closing '?' mark if not HTML5 output. -->
    <xsl:template match="processing-instruction('php')">
        <xsl:processing-instruction name="php">
			<xsl:value-of select="." disable-output-escaping="yes" />
		?</xsl:processing-instruction>
    </xsl:template>
	
	<!-- create the » character appended to the anchor element from the styles dropdown -->
	<xsl:template match="a[@class='ou-double-point-arrow']">
		<a>
			<xsl:apply-templates select="node()|attribute()[name() != 'class']" />
			<em class="fa fa-angle-double-right" aria-hidden="true"></em>
		</a>
	</xsl:template>
	
	<xsl:template match="gcsearchresults-only">
		<xsl:text disable-output-escaping="yes">&lt;gcse:searchresults-only&gt;&lt;/gcse:searchresults-only&gt;</xsl:text>
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
			
			<xsl:variable name="newsletter-calendar-on">
				<xsl:value-of select="ou:pcf-param('layout-section-toggle')" />
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
			
			<xsl:if test="$newsletter-calendar-on = 'newsletter' or $newsletter-calendar-on = 'newsletter-listing'">
				<div class="newsletter-calendar">
					<h3>Events Calendar</h3>
<script type="text/javascript" src="//25livepub.collegenet.com/scripts/spuds.js" />
<script type="text/javascript">
	$Trumba.baseUri="https://www.trumba.com/";
	$Trumba.loaderUri="https://www.trumba.com/s.aspx";
	$Trumba.busyImageUri="https://www.trumba.com/images/spinner_trumba.gif";
	$Trumba.addSpud({
	webName: "lpc",
	spudType : "upcomingphoto" ,
	spudConfig : "Cloned" ,
	teaserBase : "https://laspositascollege.edu/cal/" });
</script>
				</div>
			</xsl:if>
			
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
		</div>
	</xsl:template>
	
	<xsl:template name="ounav-on" expand-text="yes">
		<div class="col-12 col-lg-3 left-navigation">
			
			<xsl:variable name="php-nav-file">
				<xsl:value-of select="'/_resources/scripts/nav/sitenav.php'"/>
			</xsl:variable>	
			
			<!-- parsing -->
        	
			<xsl:processing-instruction name="php">
            $navpath = "{$ou:dirname}"; 
            ?</xsl:processing-instruction>
			
			<xsl:copy-of select="ou:ssi($php-nav-file)" />
			
<!-- 			<xsl:call-template name="output-navigation">
				<xsl:with-param name="kind" select="'php'"/>
				<xsl:with-param name="script-loc">
					<xsl:value-of select="'/_resources/scripts/nav/sitenav.php'"/>
				</xsl:with-param>
			</xsl:call-template> -->
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
	
</xsl:stylesheet>
