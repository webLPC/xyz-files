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

<!-- CUSTOM VARIABLES XSL -->

<xsl:stylesheet version="3.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:ou="http://omniupdate.com/XSL/Variables"
  xmlns:fn="http://omniupdate.com/XSL/Functions"
  xmlns:ouc="http://omniupdate.com/XSL/Variables"
  exclude-result-prefixes="xs ou fn ouc">
	
	<!-- production server type -->
	<xsl:variable name="server-type" select="'php'"/>
	<!-- production server include type -->
	<xsl:variable name="include-type" select="'php'"/>
	<!-- production server index file name -->
	<xsl:variable name="index-file" select="'index'"/>
	<!-- production server file type extension -->
	<xsl:variable name="extension" select="'php'"/>
	<!-- enable ou search tags to be output around the include functions and other places -->
	<xsl:variable name="enable-ou-search-tags" select="false()"/>
	<!-- xsl param to enable social meta tag output onto the pages -->
	<xsl:param name="enable-social-meta-tag-output" select="false()" />
	<xsl:variable name="nav-file" select="'_nav.ounav'" />

	<!-- custom directory variables for reading global include files -->
	<!-- for multisite setups they need to exist on the same server -->
	<xsl:param name="ou:www-domain" /> <!-- where is the main domain -->
	<xsl:param name="ou:www-ftproot" /> <!-- where is the main ftp root -->
	
	<!-- Custom Variables -->
	
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
	
	<xsl:variable name="ounav-on">
		<xsl:value-of select="document($this-props-path)/document/ouc:properties[@label='config']/parameter[@name='global-site-settings']/option[@selected='true' and @value='ounav-on']/@value"/>
	</xsl:variable>
	
	<xsl:variable name="contact-bottom-on">
		<xsl:value-of select="document($this-props-path)/document/ouc:properties[@label='config']/parameter[@name='global-site-settings']/option[@selected='true' and @value='contact-bottom-on']/@value"/>
	</xsl:variable>

	<xsl:variable name="newsletter-feed">
		<xsl:value-of select="document($this-props-path)/document/ouc:properties[@label='config']/parameter[@name='newsletter-feed']"/>
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
        
</xsl:stylesheet>