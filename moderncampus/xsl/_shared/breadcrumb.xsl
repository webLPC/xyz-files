<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet SYSTEM "http://commons.omniupdate.com/dtd/standard.dtd">
<!--
Implementations Skeleton - 01/10/2017

BREADCRUMBS 
Assumes that a section properties files is being used to extract section titles. 
If there aren't any props files, the xsl can be modified to check the page title of the index/default page of each section instead.
If the user types if the user leaves the breadcrumb value empty or has the value of "$skip", the build out will skip the breacrumb for that folder on build out

Example:
<xsl:call-template name="breadcrumb">
	<xsl:with-param name="path" select="$ou:dirname"/>								
</xsl:call-template>

Requires ouvariables.xsl, and functions.xsl

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
	
	<!-- New Breadcrumbs	 -->
	
	<xsl:variable name="breadcrumb-element">li</xsl:variable>
	<!-- a predefined delimiter to place in between crumbs -->
	<xsl:variable name="breadcrumb-delim"></xsl:variable>
	<xsl:variable name="index-filename" select="concat($index-file, '.' , $extension)"/>
	
		
	<!-- Old Breadcrumbs -->
	
	<xsl:variable name="delim"></xsl:variable>  <!-- a predefined delimiter to place in between crumbs -->
	
	<!-- if a subfolder has been defined in Access Settings -->
	<xsl:variable name="link-start" select="''"/>	
	<xsl:variable name="breadcrumb-start" select="ou:test-variable($ou:breadcrumb-start,'/')"/>
	
	<xsl:template name="breadcrumb">
		<xsl:param name="path" select="$dirname" /> <!-- defined in the vars xsl as $ou:dirname with a trailing '/' -->
		<xsl:param name="title" select="ou:pcf-param('breadcrumb')" /> <!-- originally defined as $page-title from vars -->	
		
		<!-- begin the recursive template for the crumbs (below) -->
		<ol class="breadcrumb">
			<!-- check for valid breadcrumb-start to prevent infinite recursion -->
			<xsl:if test="contains($dirname,$breadcrumb-start)">
				<xsl:call-template name="bc-folders">
					<xsl:with-param name="path" select="$dirname"/>
				</xsl:call-template>	
			</xsl:if>
			<!-- if the file is not the index page, display the final crumb -->
			<xsl:if test="not(contains($ou:filename,concat($index-file,'.')))">
				<li class="breadcrumb-item"><xsl:value-of select="$delim" /><xsl:value-of select="$title" /></li>
			</xsl:if>
		</ol>
	</xsl:template>
	
	<xsl:template name="bc-folders">
		<xsl:param name="path" />
		<!-- The following variables assume that the section breadcrumbs is in a file called '_props.pcf'. With some config the file may be substitued for breadcrumb.xml, index.pcf etc -->
		<xsl:variable name="this-props-path" select="concat($ou:root, $ou:site, $path, $props-file)"/>	<!-- props-file is defined in vars xsl -->
		<xsl:variable name="title">
			<xsl:choose>
				<!-- test if there is a props file before trying to read it -->
				<xsl:when test="doc-available($this-props-path)">
					<xsl:value-of select="document($this-props-path)/document/ouc:properties[@label='config']/parameter[@name='breadcrumb']"/>
				</xsl:when>
				<xsl:otherwise><xsl:if test="$ou:action!='pub'">System Message: Props File Not Found</xsl:if></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		<!-- variable for checking to see if the user would like to skip the the title on breadcrumb build out -->
		<xsl:variable name="check-title" select="normalize-space($title)" as="xs:string"/>

		<xsl:if test="$path != $breadcrumb-start">
			<!-- begin recursive function if the current path doesn't match the root or breadcrumb-start directory variable -->
			<xsl:call-template name="bc-folders">
				<xsl:with-param name="path" select="ou:find-prev-dir($path)"/>
			</xsl:call-template>
			<!-- check to see if the breadcrumb needs to be skipped to do to user input -->
			<xsl:choose>
				<xsl:when test="($check-title != '$skip') and ($check-title != '')">
					<xsl:value-of select="$delim" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:if test="$ou:action != 'pub'"><xsl:value-of select="$delim" /></xsl:if>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
		
		<!-- check to see if the breadcrumb needs to be skipped to do to user input -->
		<xsl:choose>
			<xsl:when test="($check-title != '$skip') and ($check-title != '')">
				<xsl:choose>
					<!-- if the path matches the current directory, and the current page is an index file, then display without an anchor element -->
					<xsl:when test="$path = $dirname and (contains($ou:filename,'default.') or contains($ou:filename,'index.'))">
						<li class="breadcrumb-item"><a href="#"><xsl:value-of select="$title"/></a></li>
					</xsl:when>
					<xsl:otherwise>
						<li class="breadcrumb-item"><a href="{concat($link-start,$path)}"><xsl:value-of select="$title"/></a></li>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="$ou:action != 'pub'">System Message: Props File <xsl:value-of select="if ($check-title = '$skip') then 'Skipped' else 'Empty'" /></xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
