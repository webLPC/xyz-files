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
<xsl:stylesheet version="3.0" expand-text="yes"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:ou="http://omniupdate.com/XSL/Variables"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	xmlns:ouc="http://omniupdate.com/XSL/Variables"
	exclude-result-prefixes="xs ou fn ouc">

	<xsl:import href="contact.xsl" />

	<xsl:template name="publish-output">
		<xsl:apply-templates select="ouc:div[@label='content']"/>
	</xsl:template>
	
	<xsl:template name="page-content">
		<!-- see breadcrumbs xsl -->
		<div class="main-content">
			<div class="container">
				<xsl:call-template name="breadcrumb-section"/>
				
				<xsl:if test="normalize-space($page-heading)">
					<h1 class="main-title">{$page-heading}</h1>
				</xsl:if>
				
				<div class="row yellow-outer">
					<xsl:call-template name="left-nav" />
					<div class="col-md-6 main-content-text col-sm-6 col-xs-12 side-padding">
						<h2>Right Side Section Content</h2>
						<p>Modify your content in the right sidebar region.</p> 
					</div>
					<div class="col-md-3 col-sm-3 col-xs-12 right-side-bar">
						<xsl:apply-templates select="ouc:div[@label='content']"/>
					</div>
				</div>
			</div>
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
	
	<xsl:template match="ouc:div">
		<div class="right-side-bar-text">
			<xsl:next-match/>
		</div>
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
	
</xsl:stylesheet>