<?xml version="1.0" encoding="utf-8"?>
<!--
OU GALLERIES

Transforms gallery asset XML into a dynamic gallery on the web page. 
Type of gallery is determined by page property.

Dependencies: 
- ou:pcfparams (See kitchensink functions.xsl)
- $domain  	<xsl:param name="domain" select="substring($ou:httproot,1,string-length($ou:httproot)-1)" /> 				

Contributors: Your Name Here
Last Updated: Enter Date Here
-->
<!DOCTYPE xsl:stylesheet SYSTEM "http://commons.omniupdate.com/dtd/standard.dtd">
<xsl:stylesheet version="3.0" 
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:xs="http://www.w3.org/2001/XMLSchema"
				xmlns:ou="http://omniupdate.com/XSL/Variables"
				xmlns:fn="http://omniupdate.com/XSL/Functions"
				xmlns:ouc="http://omniupdate.com/XSL/Variables"
				exclude-result-prefixes="ou xsl xs fn ouc">

	<!--	
The following template matches the LDP gallery nodes and outputs the proper HTML Code based on a specified parameter. 
This will work with existing apply-templates. 
-->
	<xsl:template match="gallery">

		<xsl:param name="gallery-type" select="ou:pcf-param('gallery-type')" />
		<xsl:variable name="gallery-id" select="@asset_id"/>

		<xsl:choose>
			<xsl:when test="$gallery-type = 'flex-slider'">
				<div class="flex-nav-container">
					<div class="flexslider">
						<ul class="slides"> 
							<xsl:for-each select="images/image">
								<li data-thumb="{@url}">
									<xsl:choose>
										<!-- Determine if caption field is empty -->
										<xsl:when test="link != ''"> 
											<!-- Not empty, create a link -->
											<a href="{link}">
												<img src="{@url}" alt="{title}" title="{title}" />
											</a>
										</xsl:when>
										<xsl:otherwise>	
											<img src="{@url}" alt="{title}" title="{title}" />                 
										</xsl:otherwise>
									</xsl:choose>
									<xsl:if test="title != '' or description != ''">
										<!-- Only create a div caption for a div one that has a title or description -->
										<p class="flex-caption">
											<xsl:choose>
												<!-- Determine if caption field is empty -->
												<xsl:when test="link != ''"> 
													<!-- Not empty, create a link -->
													<a href="{link}">
														<xsl:value-of select="title" />
														<xsl:if test="description != ''">
															- <xsl:value-of select="description" />
														</xsl:if>
													</a>
												</xsl:when>
												<xsl:otherwise>	
													<!-- Just output caption, no link -->
													<xsl:value-of select="title" /> 
													<xsl:if test="description != ''">
														- <xsl:value-of select="description" />
													</xsl:if>
												</xsl:otherwise>
											</xsl:choose>
											<xsl:comment> Do not allow div to self close </xsl:comment>
										</p>
									</xsl:if>
								</li>
							</xsl:for-each>
						</ul>
					</div>
				</div>
			</xsl:when>

			<xsl:when test="$gallery-type = 'pretty-photo'">
				<ul class="thumbnails nobullets">
					<xsl:for-each select="images/image">
						<li>
							<a href="{@url}" rel="prettyPhoto[{$gallery-id}]" title="{title}"  class="thumbnail">
								<img src="{thumbnail/@url}" alt="{title}" style="height:{thumbnail/height}px; width:{thumbnail/width}px;"/>
								<p class="gradname"><xsl:value-of select="title" /></p>
							</a>
						</li>
					</xsl:for-each>	
				</ul>
			</xsl:when>	
			<!-- optionally, set a fallback output -->
			<xsl:otherwise>
				<xsl:comment>Undefined parameter for gallery match.</xsl:comment>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!--

Gallery Headcode

To use, include in the appropriate area of the page (after jQuery is loaded).
You can conditionally call this function as such: 

<xsl:if test="content/descendant::gallery"> 
<xsl:copy-of select="ou:gallery-headcode($gallery-type)"/>
</xsl:if>	

-->
	<!-- optionally, remove {$domain} -->
	<xsl:function name="ou:gallery-headcode">
		<xsl:param name="gallery-type" />

		<xsl:choose>		
			<xsl:when test="$gallery-type = 'flex-slider'">
				<link rel="stylesheet" href="/_resources/ldp/galleries/flexslider/flexslider.css" type="text/css"/>
				<link rel="stylesheet" href="/_resources/ldp/galleries/flexslider/flex-caption.css" type="text/css"/>		
			</xsl:when>	
			<xsl:when test="$gallery-type = 'pretty-photo'">			
				<link rel="stylesheet" href="/_resources/ldp/galleries/bootstrap-thumbnails.css"/> 			
				<link rel="stylesheet" href="/_resources/ldp/galleries/pretty-photo/prettyPhoto.css" type="text/css" media="screen" title="prettyPhoto main stylesheet" />
			</xsl:when>
		</xsl:choose>
	</xsl:function>
	
	<xsl:function name="ou:gallery-footcode">
		<xsl:param name="gallery-type" />

		<xsl:choose>		
			<xsl:when test="$gallery-type = 'flex-slider'">
				<script src="/_resources/ldp/galleries/flexslider/jquery.flexslider-min.js"></script>
				<script type="text/javascript">
					$(document).ready(function() {
					$('.flexslider').flexslider({
					animation: "slide"
					});
					});
				</script>		
			</xsl:when>	
			<xsl:when test="$gallery-type = 'pretty-photo'">
				<script src="/_resources/ldp/galleries/pretty-photo/jquery.prettyPhoto.js" type="text/javascript"></script>
				<script type="text/javascript">
					$(document).ready(function() {
					$("a[rel^='prettyPhoto']").prettyPhoto();
					});
				</script>
			</xsl:when>
		</xsl:choose>
	</xsl:function>

</xsl:stylesheet>	
