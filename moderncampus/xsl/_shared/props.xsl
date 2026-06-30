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
TABLE TRANSFORMATION STYLESHEET

Contributors: Timothy Druley
Last Updated: 1/05/2018
-->
<xsl:stylesheet version="3.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:ou="http://omniupdate.com/XSL/Variables"
    xmlns:fn="http://omniupdate.com/XSL/Functions"
    xmlns:ouc="http://omniupdate.com/XSL/Variables"
    exclude-result-prefixes="xsl xs ou fn ouc">

	<xsl:template match="table[@class='two-column-images']">
		<xsl:for-each select="tbody/tr">
		  <div class="row two-column-images">
			<xsl:for-each select="td">
			  <div class="col-sm-6 col-md-6 col-lg-6">
				<img>
				  <xsl:attribute name="src"><xsl:value-of select="img/@src"/></xsl:attribute>
				  <xsl:attribute name="alt"><xsl:value-of select="img/@alt"/></xsl:attribute>
				  <xsl:attribute name="class">img-responsive center-block</xsl:attribute>
				</img>
				<p>
				  <xsl:value-of select="img/@alt"/>
				</p>   
			  </div>
			</xsl:for-each>
		  </div>
		</xsl:for-each>
	</xsl:template>	
	
</xsl:stylesheet>
