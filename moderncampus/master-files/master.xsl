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
			
	<xsl:import href="common-lpc.xsl"/>
			
	<xsl:template name="template-headcode"/>
	
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
				<xsl:when test="ou:pcf-param('layout-section-toggle') = 'minutes'">
					<xsl:call-template name="minutes" />
				</xsl:when>
				<xsl:when test="ou:pcf-param('layout-section-toggle') = 'agenda'">
					<xsl:call-template name="agenda" />
				</xsl:when>
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
	
</xsl:stylesheet>