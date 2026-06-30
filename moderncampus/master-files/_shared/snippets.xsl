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

SNIPPET XSL
Place snippet XSL template matches in this file.

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
	
   <!-- Insert snippet xsls -->
	
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
        
</xsl:stylesheet>
