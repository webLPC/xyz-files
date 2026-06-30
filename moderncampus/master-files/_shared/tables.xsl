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
	
	<xsl:template match="table[@class='open-hours-table']">
		<div class="open-hours-table">
			<p>Office Hours</p>
			<xsl:for-each select="tbody/tr">
				<div>
					<div>
						<xsl:value-of select="normalize-space(td[1])" />
					</div>
					<div>
						<xsl:value-of select="normalize-space(td[2])" />
					</div>
				</div>
			</xsl:for-each>
		</div>
	</xsl:template>
	
	<xsl:template match="table[@class='ou-lpc-accordion']">
		<xsl:variable name="linkId">
			<xsl:value-of select="generate-id()" />
		</xsl:variable>
		
		<div class="accordion">
        	<div class="accordion-item">
            	<h2 class="accordion-header" id="{$linkId}-heading">
                	<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#{$linkId}" aria-expanded="false" aria-controls="{$linkId}">
                    	<xsl:value-of select="tbody/tr[1]/td" />
                    </button>
                </h2>

               	<div id="{$linkId}" class="accordion-collapse collapse" aria-labelledby="{$linkId}-heading">
                	<div class="accordion-body">
                    	<xsl:apply-templates select="tbody/tr[2]/td" />
                   	</div>
              	</div>
    		</div>
		</div>	
	</xsl:template>
	
	<xsl:template match="table[@class='table table-striped ar-staff-table']">
		<xsl:for-each select="tbody/tr">
			<div class="staff-card">
				
				<div>
					<p><xsl:value-of select="td[1]" /></p>
					<p><xsl:apply-templates select="td[2]" /></p>
					<p>
						<a class="staff-email">
							<xsl:attribute name="href">mailto:<xsl:value-of select="normalize-space(td[3])" /></xsl:attribute>
							<xsl:value-of select="normalize-space(td[3])" />
						</a>
					</p>
					
					<xsl:if test="string-length(td[4]) &gt; 2">
						<p>
							<a class="staff-phone">
								<xsl:attribute name="href">tel:<xsl:value-of select="normalize-space(td[4])" /></xsl:attribute>
								<xsl:value-of select="normalize-space(td[4])" />
							</a>
						</p>
					</xsl:if>
					
				</div>
				
				<xsl:if test="string-length(td[5]) &gt; 5">
					<div>
						<p><strong>A&amp;R Services:</strong></p>
						<p><xsl:apply-templates select="td[5]" /></p>
					</div>	
				</xsl:if>
				
			</div>
		</xsl:for-each>
	</xsl:template>
	
</xsl:stylesheet>
