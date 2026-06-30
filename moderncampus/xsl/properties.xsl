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
Implementations Skeleton- 01/10/2017

SECTION PROPERTIES 

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
	
	<xsl:template match="/document">
		<html lang="en">			
			<head>
				<link href="//netdna.bootstrapcdn.com/bootswatch/3.1.0/cerulean/bootstrap.min.css" rel="stylesheet"/>
				<link href="/_resources/css/oustaging.css" rel="stylesheet" />
				<style>
					body{
					font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
					}
					.ox-regioneditbutton {
					display: none;
					}
				</style>
			</head>			
			<body id="properties">				
				<div class="container">
					<h1>Section Properties</h1>
					To edit the following section properties, please check out this page and go to the Page Properties screen.<br/>
					Changes will take effect immediately in OUCampus - this file does not need to be published. <br/> 
					<strong>However, the PCF files within this directory must be republished for changes to appear on <xsl:value-of select="concat($domain,$dirname)"/>.<br/></strong>
					<br/>					
					<h2>Properties for the folder "<xsl:value-of select="if ($ou:dirname!='/') then(normalize-space(ou:current-folder($ou:dirname))) else '/'"/>"</h2>					
					<dl>	
						<xsl:apply-templates select="descendant::parameter"/>
					</dl>	 											
				</div>				
				<div style="display:none;">
					<ouc:div label="fake" group="fake" button="hide"/>
				</div>				
			</body>
		</html>					
	</xsl:template>
	
	<xsl:template match="parameter[.!='']">
		<xsl:apply-templates select="@section"/>
		<dt><xsl:value-of select="@prompt"/></dt>
		<dd><xsl:value-of select="."/></dd>
	</xsl:template>	
	
	<xsl:template match="parameter[option]">
		<xsl:apply-templates select="@section"/>
		<dt><xsl:value-of select="@prompt"/></dt>
		<dd><xsl:value-of select="option[@selected='true']"/></dd>
	</xsl:template>	
	
	<xsl:template match="parameter[contains(.,'jpg')]">
		<xsl:apply-templates select="@section"/>
		<dt><xsl:value-of select="@prompt"/></dt>
		<dd><img style="width:50%; height:auto" src="{.}"/></dd>
	</xsl:template>	
	
	<xsl:template match="@section">
		<dt><h5><xsl:value-of select="."/></h5></dt>
	</xsl:template>
	
</xsl:stylesheet>
