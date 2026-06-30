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
<!-- navigation pcf to include file structure -->
<xsl:stylesheet version="3.0" 
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:xs="http://www.w3.org/2001/XMLSchema"
				xmlns:ou="http://omniupdate.com/XSL/Variables"
				xmlns:fn="http://omniupdate.com/XSL/Functions"
				xmlns:ouc="http://omniupdate.com/XSL/Variables"
				exclude-result-prefixes="ou xsl xs fn ouc">

	<xsl:import href="common-lpc.xsl" />

	<xsl:output method="html" version="4.0" indent="no" encoding="UTF-8" include-content-type="no" omit-xml-declaration="yes"/>
<!-- 	<xsl:strip-space elements="*"/> -->

	<xsl:variable name="message-styling" select="'color: #a94442; background-color: #f2dede; border-color: #ebccd1; padding: 15px; border: 1px solid transparent; border-radius: 4px;'" />

	<xsl:template match="/document[$ou:action = 'pub']">
		<xsl:call-template name="content" />
	</xsl:template>

	<xsl:template match="/document[not($ou:action = 'pub')]">
		<xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>
		<html>
			<head>
				<xsl:call-template name="common-headcode" />
			</head>
			<body>
				<xsl:call-template name="content" />
			</body>
		</html>
	</xsl:template>

	<xsl:template name="content">
		<xsl:param name="title" select="ou:pcf-param('left-nav-heading')" />
		<xsl:choose>
			<xsl:when test="$ou:action = 'edt'">
				<xsl:apply-templates select="ouc:div[@label='sidebar']" />
			</xsl:when>
			<xsl:otherwise>
				<ul class="nav nav-list">
					<xsl:apply-templates select="ouc:div[@label='sidebar']/ul/node()" />
				</ul>
				<div class="mobile-left-nav-bar">
					<div>
						<span><xsl:value-of select="$title" /></span>
						<a href="javascript:void(0);" class="icon" id="mobile-left-nav-btn"><span><span class="sr-only">Toggle Left Navigation</span></span></a>
					</div>
						<ul class="mobile-left-nav" id="mobile-left-nav">
							<xsl:apply-templates select="ouc:div[@label='sidebar']/ul/node()" />
						</ul>
				</div>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="li[ul]">
		<xsl:if test="ou:pcf-param('nav-type') = '0'">
			<li class="nav-head" aria-haspopup="true">
				<span class="nav_caret">
					<xsl:call-template name="create-caret" />
					<xsl:text> </xsl:text>
					<xsl:apply-templates select="a" />
				</span>
				<ul class="nav nav-list tree" aria-hidden="true" aria-label="submenu">
					<xsl:apply-templates select="ul/node()" />
				</ul>
			</li>
		</xsl:if>
		
		<xsl:if test="ou:pcf-param('nav-type') = '1'">
			<li class="nav-head">
				<span class="nav_caret_link" aria-haspopup="true">
					<xsl:call-template name="create-caret-link" />
					<xsl:text> </xsl:text>
					<xsl:apply-templates select="a" />
				</span>
				<ul class="nav nav-list tree" aria-hidden="true" aria-label="submenu">
					<xsl:apply-templates select="ul/node()" />
				</ul>
			</li>
		</xsl:if>
		
		
	</xsl:template>
	
	<xsl:template name="create-caret">
		<span class="tree-toggler nav-header" role="button" tabindex="0">
			<em class="fa fa-caret-right" aria-hidden="true"></em>
		</span>
	</xsl:template>
	
	<xsl:template name="create-caret-link">
		<span class="tree-toggler-link nav-header">
			<em class="fa fa-caret-right" aria-hidden="true"></em>
		</span>
	</xsl:template>
</xsl:stylesheet>
