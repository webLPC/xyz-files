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
Implementation Skeleton - 08/24/2018

Variables XSL
Customer Variables particular to the school
-->

<xsl:stylesheet version="3.0" 
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:xs="http://www.w3.org/2001/XMLSchema"
				xmlns:ou="http://omniupdate.com/XSL/Variables"
				xmlns:fn="http://omniupdate.com/XSL/Functions"
				xmlns:ouc="http://omniupdate.com/XSL/Variables"
				exclude-result-prefixes="ou xsl xs fn ouc">
	

	
	
	<xsl:import href="_shared/template-matches.xsl"/>
	<xsl:import href="_shared/snippets.xsl"/>
	<xsl:import href="_shared/ouvariables.xsl"/>
	<xsl:import href="_shared/functions.xsl"/>
	<xsl:import href="_shared/breadcrumb.xsl"/>
	<xsl:import href="_shared/ou-forms.xsl"/>
	<xsl:import href="_shared/ougalleries.xsl"/>
	<xsl:import href="_shared/tables.xsl"/>
	
	<!-- MODIFIED -->
	
	<xsl:import href="_shared/variables.xsl"/>
	<xsl:import href="_shared/page-templates.xsl"/>
	
	
	
	

	
	<!-- Default: for HTML5 use below output declaration -->
	<xsl:output method="html" version="5.0" indent="yes" encoding="UTF-8" include-content-type="no"/>

	<!-- If using xml or xhtml output, add in the below attribute to your xsl:output statement -->
	<!-- omit-xml-declaration="yes" -->

	<!-- If your output is not HTML5 -->
	<!-- 
	<xsl:output method="html" version="4.01"     
            doctype-public="-//W3C//DTD HTML 4.01//EN" doctype-system="http://www.w3.org/TR/html4/strict.dtd" 
            indent="yes" encoding="UTF-8" include-content-type="no" /> 
     -->

	<xsl:template match="/document"> 
		
		<!-- begin html -->
		<!-- <html lang="en"> -->
		<html>
			<xsl:choose>
				<xsl:when test="not($page-lang = '')">
					<xsl:attribute name="lang"><xsl:value-of select="$page-lang" /></xsl:attribute>
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="lang">en</xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
			
			<head>
				<title><xsl:value-of select="$page-title"/></title>
				<xsl:call-template name="common-headcode"/> <!-- common headcode -->
				<xsl:call-template name="template-headcode"/> <!-- each page type may have a version of this template -->
				<xsl:apply-templates select="headcode/node()"/>
				<!-- copy meta tags from pcf, but only those with content -->				
				<xsl:apply-templates select="/document/ouc:properties[@label='metadata']/meta[string-length(@content)>0]"/>
				<xsl:call-template name="form-headcode" />
				<script type="text/javascript">
					var page_url="<xsl:value-of select="concat(string-join(remove(tokenize(substring($ou:httproot, 1), '/'), count(tokenize(substring($ou:httproot, 1), '/'))), '/'),$ou:path)"/>";
				</script>
				
				<xsl:call-template name="site-custom-css" />
				
				<xsl:copy-of select="ou:gallery-headcode(ou:pcf-param('gallery-type'))" />
			</head>
			<body>				
				<xsl:apply-templates select="bodycode/node()"/> <!-- pcf -->
				<xsl:call-template name="common-header"/>
				<xsl:call-template name="alert"/>
				<xsl:call-template name="common-top-nav"/>
				<xsl:call-template name="page-content"/> <!-- each page type has a unique version of this template -->
				<xsl:call-template name="common-footer"/>
				<xsl:call-template name="template-footcode"/>
				<xsl:apply-templates select="footcode/node()"/> <!-- pcf -->
				<xsl:call-template name="form-footcode" />
				<xsl:copy-of select="ou:gallery-footcode(ou:pcf-param('gallery-type'))" />
			</body>	
		</html>	
		<!-- end html -->
	</xsl:template>
	
	<xsl:template name="alert">
		<xsl:call-template name="unparsed-include-file">
			<xsl:with-param name="path">/_resources/includes/alert2024.php</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
			
	<xsl:template name="common-headcode">
		<xsl:copy-of select="ou:include-file('/_resources/includes/2024/headcode-page.inc')"/> 
	</xsl:template>
	
	<xsl:template name="common-header">
		<xsl:copy-of select="ou:include-file('/_resources/includes/2024/header.inc')"/>
	</xsl:template>
	
	<xsl:template name="common-top-nav">
		<xsl:copy-of select="ou:include-file('/_resources/includes/2024/top-nav.inc')"/>
	</xsl:template>
	
	<xsl:template name="common-footer">
		<xsl:copy-of select="ou:include-file('/_resources/includes/2024/footer.inc')"/>
		<xsl:copy-of select="ou:include-file('/_resources/includes/2024/footcode.inc')"/>
		<div id="hidden" style='display:none;'><xsl:comment> com.omniupdate.ob </xsl:comment><xsl:comment> /com.omniupdate.ob </xsl:comment></div>
	</xsl:template>

	<!-- in case not defined in page type xsl -->
	<xsl:template name="page-content"><p>No template defined.</p></xsl:template><!-- leave for debugging purposes -->			
	<xsl:template name="template-headcode"/>
	<xsl:template name="template-footcode"/>
	
	<xsl:template name ="site-custom-css">
		
		<xsl:variable name="this-props-path" select="concat($ou:root, $ou:site, $dirname, $props-file)"/>
		
		<xsl:variable name="custom-css-path">
				<xsl:value-of select="document($this-props-path)/document/ouc:properties[@label='config']/parameter[@name='custom-css-source']"/>
		</xsl:variable>

		<xsl:variable name="custom-css-on">
			<xsl:value-of select="document($this-props-path)/document/ouc:properties[@label='config']/parameter[@name='global-site-settings']/option[@selected='true' and @value='custom-css-on']/@value"/>
		</xsl:variable>

		<xsl:if test="$custom-css-on = 'custom-css-on'">
			<link rel="stylesheet" href="{$custom-css-path}" />
		</xsl:if>

	</xsl:template>
	
	
	
</xsl:stylesheet>
