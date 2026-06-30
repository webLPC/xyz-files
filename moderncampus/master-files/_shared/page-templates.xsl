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

<!-- PAGE TEMPLATE MATCHES -->

<xsl:stylesheet version="3.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:ou="http://omniupdate.com/XSL/Variables"
  xmlns:fn="http://omniupdate.com/XSL/Functions"
  xmlns:ouc="http://omniupdate.com/XSL/Variables"
  exclude-result-prefixes="xs ou fn ouc">
	
    <!-- Identity Matches -->
	<xsl:template name="newsletter" expand-text="yes">
		<div class="container-xxl">
			<xsl:call-template name="breadcrumb-section"/>
			<div class="row px-0 px-lg-4 mt-1">
					<div class="col-12 col-lg-9 lpc-newsletter">
						
						<xsl:if test="normalize-space($top-img) != ''">
							<div class="top-img-wrapper">
								<img src="{$top-img}" alt="{$top-img-alt}" class="img-fluid w-100" />
							</div>
						</xsl:if>
						
						<xsl:if test="normalize-space($newsletter-feed) != ''">
							<xsl:if test="normalize-space($top-img) = ''">
								
								<xsl:variable name="murl-src">
            						<xsl:text>/_resources/scripts/newsletter/murl.php</xsl:text>
        						</xsl:variable>
							
								<!-- parsing -->
								<xsl:processing-instruction name="php">
									$feed = "{$newsletter-feed}"; 
									?</xsl:processing-instruction>
								<xsl:copy-of select="ou:ssi($murl-src)" />
							
							</xsl:if>
						</xsl:if>

						<h1><xsl:value-of select="$page-title" /></h1>
						
						<xsl:apply-templates select="ouc:div[@label='maincontent']" />
					
					</div>
				
				<xsl:call-template name="sidebar-section"/>
			</div>
		</div>
	</xsl:template>
	
    <xsl:template name="newsletter-listing">
        <div class="container-xxl">
            <xsl:call-template name="breadcrumb-section"/>
            <div class="row px-0 px-lg-4 mt-1">
                <div class="col-12 col-lg-9 lpc-newsletter-listing">
                    
                    <xsl:apply-templates select="ouc:div[@label='maincontent']" />
					
					<xsl:if test="ou:pcf-param('has-listing') = '1'">
                        <div class="listing-wrapper">
                            <xsl:call-template name="newsletter-listing-feed"/>
                        </div>
                    </xsl:if>
					
                </div>
                <xsl:call-template name="sidebar-section"/>
            </div>
        </div>	
    </xsl:template>
    
    <xsl:template name="newsletter-listing-feed" expand-text="yes">

        <xsl:variable name="news-count" select="if (string(number(ou:pcf-param('news-display-count'))) eq 'NaN') then 5 else normalize-space(ou:pcf-param('news-display-count'))" />
        
        <xsl:variable name="news-config">
            <categories>{ou:pcf-param('rss-feed-categories')}</categories>
            <count>{$news-count}</count>
            <feed>{ou:pcf-param('news-rss-feed')}</feed>
        </xsl:variable>

        <xsl:call-template name="display-parsing">
            <xsl:with-param name="contents" select="$news-config" />
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template name="display-parsing" expand-text="yes">
        
        <xsl:param name="contents" />

        <xsl:variable name="listing-src">
            <xsl:value-of select="ou:pcf-param('listing-src')" />
        </xsl:variable>
        
        <!-- parsing -->
        <xsl:processing-instruction name="php">
            $feed = "{$contents/feed}"; 
            $amount_per_page = {$contents/count};
            $categories = "{$contents/categories}";
            $counter = 1;
            ?</xsl:processing-instruction>
        <xsl:copy-of select="ou:ssi($listing-src)" />
        <!-- <xsl:copy-of select="ou:ssi($ou:news-listing-script)" /> -->
        <!-- / parsing -->
    </xsl:template>
	
	<xsl:template name="one-column">
		<div class="container-xxl">
			<xsl:call-template name="breadcrumb-section"/>
			<div class="row px-0 px-lg-4 mt-1">
				<div class="col-12 modo-content">
					<xsl:apply-templates select="ouc:div[@label='maincontent']" />
					<xsl:if test="ou:pcf-param('has-listing') = '1'">
						<div>
							<xsl:call-template name="directory-listing"/>
						</div>
					</xsl:if>
				</div>
			</div>
		</div>
	</xsl:template>
	
	<xsl:template name="one-column-google-sheet">
		<div class="container-xxl">
			<xsl:call-template name="breadcrumb-section"/>
			<div class="row px-0 px-lg-4 mt-1">
				<div class="col-12">
					<xsl:apply-templates select="ouc:div[@label='maincontent']" />
				</div>
				<div class="col-12">
					<xsl:call-template name="course-table"/>
				</div>
			</div>
		</div>
	</xsl:template>
	
	<xsl:template name="two-column">
		<div class="container-xxl">
			<xsl:call-template name="breadcrumb-section"/>
			<div class="row px-0 px-lg-4 mt-1 modo-content">
				<div class="col-12 col-lg-9">
					<xsl:apply-templates select="ouc:div[@label='maincontent']" />
					<xsl:if test="ou:pcf-param('has-listing') = '1'">
						<div>
							<xsl:call-template name="directory-listing"/>
						</div>
					</xsl:if>
				</div>
				<xsl:call-template name="sidebar-section"/>
			</div>
		</div>
	</xsl:template>
	
	<xsl:template name="three-column" expand-text="yes">
		<div class="container-xxl">
			<xsl:call-template name="breadcrumb-section"/>
			<div class="row px-0 px-lg-4 mt-1">
				
				<xsl:choose>
					<xsl:when test="$ounav-on = 'ounav-on'">
						<xsl:call-template name="ounav-on"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="left-sidebar-nav"/>
					</xsl:otherwise>
				</xsl:choose>

					<div class="col-12 col-lg-6 main-content-column">
						<xsl:apply-templates select="ouc:div[@label='maincontent']" />
						<xsl:if test="ou:pcf-param('has-listing') = '1'">
							<div>
								<xsl:call-template name="directory-listing"/>
							</div>
						</xsl:if>
					</div>
				
				<xsl:call-template name="sidebar-section"/>
			</div>
		</div>
	</xsl:template>
	
	<xsl:template name="two-column-50-50">
		<div class="container-xxl">
			<xsl:call-template name="breadcrumb-section"/>
			<div class="row px-0 px-lg-4 mt-1 modo-content">
				<div class="col-12 header-one-row">
					<h1><xsl:value-of select="ou:pcf-param('breadcrumb')" /></h1>
				</div>
				<div class="col-12 col-lg-6 p-3 left-col-main">
					<xsl:apply-templates select="ouc:div[@label='maincontent']" />
				</div>
				<div class="col-12 col-lg-6 p-3 right-col-main">
					<xsl:apply-templates select="ouc:div[@label='rightsidebar']" />
				</div>
			</div>
		</div>
	</xsl:template>
	
	<xsl:template name="two-column-nav">
		<div class="container-xxl">
			<xsl:call-template name="breadcrumb-section"/>
			<div class="row px-0 px-lg-4 mt-1">
				<xsl:call-template name="left-sidebar-nav"/>
				<div class="col-12 col-lg-9 main-content-column">
					<xsl:apply-templates select="ouc:div[@label='maincontent']" />
				</div>
			</div>
		</div>
	</xsl:template>
	
	<xsl:template name="minutes-sidebar">
		<div class="col-12 col-lg-3">
			<div class="minutes-mission">
<h3>LPC Mission Statement</h3>
<p>Las Positas College is an inclusive, learning centered, equity-focused environment that offers educational opportunities and support for completion of students’ transfer, degree, and career-technical goals while promoting lifelong learning.</p>

<h3>LPC Planning Priorities</h3>


<p><strong>Equity:</strong> Establish a knowledge base and an appreciation for equity; create a sense of urgency about moving toward equity; institutionalize equity in decision-making, assessment, and accountability; and build capacity to resolve inequities.</p>
<p><strong>Student Success &amp; Completion:</strong> Increase student success and completion through change in college practices and processes: coordinating needed academic support, removing barriers, and supporting focused professional development across the campus.</p>
<p><strong>Health and Wellness:</strong> Establish a knowledgebase and an appreciation for health and wellness in the workplace; create a sense of urgency about wellness in decision-making, assessment, and accountability; and build capacity to support wellnes</p>

</div>
		</div>
	</xsl:template>
	
	<xsl:template name="minutes">
		<div class="container-xxl">
			<xsl:call-template name="breadcrumb-section"/>
			<div class="row px-0 px-lg-4 mt-1 minutes-agenda">
				<xsl:call-template name="minutes-sidebar"/>
					
				<div class="col-12 col-lg-6 main-content-column">
					<h1><xsl:value-of select="$committee-name" /><br /><span class="minutes-subheading">Meeting Minutes</span></h1>
					<p class="meetingdate">MEETING DATE: <xsl:value-of select="$meeting-date" /></p>
					<xsl:apply-templates select="ouc:div[@label='maincontent']" />
				</div>
				
				<div class="col-12 col-lg-3">
					<xsl:apply-templates select="ouc:div[@label='members']" />
				</div>
			</div>
		</div>
	</xsl:template>
	
	<xsl:template name="agenda">
		<div class="container-xxl">
			<xsl:call-template name="breadcrumb-section"/>
			<div class="row px-0 px-lg-4 mt-1 minutes-agenda">
				<xsl:call-template name="minutes-sidebar"/>
				
				<div class="col-12 col-lg-6 main-content-column">
					<h1><xsl:value-of select="$committee-name" /><br /><span class="minutes-subheading">Agenda</span></h1>
					<p class="meetingdate">MEETING DATE: <xsl:value-of select="$meeting-date" /></p>
					<xsl:apply-templates select="ouc:div[@label='maincontent']" />
				</div>
				
				<div class="col-12 col-lg-3">
					<xsl:apply-templates select="ouc:div[@label='members']" />
				</div>
			</div>
		</div>
	</xsl:template>
	
	<xsl:template name="directory-listing">
		<xsl:processing-instruction name="php">
		$tag = "<xsl:value-of select="ou:pcf-param('dept')" />";	
		?</xsl:processing-instruction>
		<xsl:variable name="listing-src">
			<xsl:value-of select="ou:pcf-param('listing-src')" />
		</xsl:variable>
		<xsl:copy-of select="ou:ssi($listing-src)" />
	</xsl:template>
	
	<!-- Academic Calendar -->
	
	<xsl:template name="academic-calendar">
		<div class="container-xxl">
			<xsl:call-template name="breadcrumb-section"/>
			<div class="row px-0 px-lg-4 mt-1">
				<div class="col-12 col-lg-9">
					<h1>Academic Calendar</h1>
					<div class="academic-calendar-tabs">
						<!-- Nav tabs -->
						<ul class="nav nav-tabs" role="tablist">
							<xsl:choose>
								<xsl:when test="ou:pcf-param('active-calendar') = '0'">
									<li class="nav-item" role="presentation" id="fall-tab"><a class="nav-link active" role="tab" href="#fall" aria-controls="fall" data-bs-toggle="tab" data-bs-target="#fall">Fall Calendar</a></li>
								</xsl:when>
								<xsl:otherwise>
									<li class="nav-item" role="presentation" id="fall-tab"><a class="nav-link" role="tab" href="#fall" aria-controls="fall" data-bs-toggle="tab" data-bs-target="#fall">Fall Calendar</a></li>
								</xsl:otherwise>
							</xsl:choose>
							
							<xsl:choose>
								<xsl:when test="ou:pcf-param('active-calendar') = '1'">
									<li class="nav-item" role="presentation" id="winter-tab"><a class="nav-link active" role="tab" href="#winter" aria-controls="winter" data-bs-toggle="tab" data-bs-target="#winter">Winter Intersession</a></li>
								</xsl:when>
								<xsl:otherwise>
									<li class="nav-item" role="presentation" id="winter-tab"><a class="nav-link" role="tab" href="#winter" aria-controls="winter" data-bs-toggle="tab" data-bs-target="#winter">Winter Intersession</a></li>
								</xsl:otherwise>
							</xsl:choose>

							<xsl:choose>
								<xsl:when test="ou:pcf-param('active-calendar') = '2'">
									<li class="nav-item" role="presentation" id="spring-tab"><a class="nav-link active" role="tab" href="#spring" aria-controls="spring" data-bs-toggle="tab" data-bs-target="#spring">Spring Calendar</a></li>
								</xsl:when>
								<xsl:otherwise>
									<li class="nav-item" role="presentation" id="spring-tab"><a class="nav-link" role="tab" href="#spring" aria-controls="spring" data-bs-toggle="tab" data-bs-target="#spring">Spring Calendar</a></li>
								</xsl:otherwise>
							</xsl:choose>

							<xsl:choose>
								<xsl:when test="ou:pcf-param('active-calendar') = '3'">
									<li class="nav-item" role="presentation" id="summer-tab"><a class="nav-link active" role="tab" href="#summer" aria-controls="summer" data-bs-toggle="tab" data-bs-target="#summer">Summer Calendar</a></li>
								</xsl:when>
								<xsl:otherwise>
									<li class="nav-item" role="presentation" id="summer-tab"><a class="nav-link" role="tab" href="#summer" aria-controls="summer" data-bs-toggle="tab" data-bs-target="#summer">Summer Calendar</a></li>
								</xsl:otherwise>
							</xsl:choose>
							<li class="nav-item" role="presentation"><a role="tab" href="/class-schedule/finals.php">Final Exam Schedule</a></li>
						</ul>

						<!-- Tab panes -->
						<div class="tab-content">

							<!-- Fall -->
							<xsl:call-template name="fall-calendar" />
							
							<!-- Winter -->
							<xsl:call-template name="winter-calendar" />

							<!-- Spring -->
							<xsl:call-template name="spring-calendar" />

							<!-- Summer -->
							<xsl:call-template name="summer-calendar" />

						</div>
					</div>
					
				</div>
				<xsl:call-template name="sidebar-section"/>
			</div>
		</div>
		
	</xsl:template>
	
	<xsl:template name="fall-calendar">
		
		<xsl:choose>
			<xsl:when test="ou:pcf-param('active-calendar') = '0'">
				<div id="fall" class="tab-pane fade show active" role="tabpanel" aria-labelledby="fall-tab" tabindex="0">
					<xsl:apply-templates select="ouc:div[@label='fall-calendar']" />
				</div>
			</xsl:when>
			<xsl:otherwise>
					<div id="fall" class="tab-pane fade" role="tabpanel" aria-labelledby="fall-tab" tabindex="0">
					<xsl:apply-templates select="ouc:div[@label='fall-calendar']" />
				</div>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template name="winter-calendar">
		<xsl:choose>
			<xsl:when test="ou:pcf-param('active-calendar') = '1'">
				<div id="winter" class="tab-pane fade show active" role="tabpanel" aria-labelledby="winter-tab" tabindex="0">
					<xsl:apply-templates select="ouc:div[@label='winter-calendar']" />
				</div>
			</xsl:when>
			<xsl:otherwise>
				<div id="winter" class="tab-pane fade" role="tabpanel" aria-labelledby="winter-tab" tabindex="0">
					<xsl:apply-templates select="ouc:div[@label='winter-calendar']" />
				</div>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template name="spring-calendar">
		<xsl:choose>
			<xsl:when test="ou:pcf-param('active-calendar') = '2'">
				<div id="spring" class="tab-pane fade show active" role="tabpanel" aria-labelledby="spring-tab" tabindex="0">
					<xsl:apply-templates select="ouc:div[@label='spring-calendar']" />
				</div>
			</xsl:when>
			<xsl:otherwise>
				<div id="spring" class="tab-pane fade" role="tabpanel" aria-labelledby="spring-tab" tabindex="0">
					<xsl:apply-templates select="ouc:div[@label='spring-calendar']" />
				</div>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template name="summer-calendar">
		<xsl:choose>
			<xsl:when test="ou:pcf-param('active-calendar') = '3'">
				<div id="summer" class="tab-pane fade show active" role="tabpanel" aria-labelledby="summer-tab" tabindex="0">
					<xsl:apply-templates select="ouc:div[@label='summer-calendar']" />
				</div>
			</xsl:when>
			<xsl:otherwise>
				<div id="summer" class="tab-pane fade" role="tabpanel" aria-labelledby="summer-tab" tabindex="0">
					<xsl:apply-templates select="ouc:div[@label='summer-calendar']" />
				</div>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<!-- END Academic Calendar -->

	<!-- FSP Page -->
		<xsl:template name="fsp-page">
		<div class="container-xxl">
			<xsl:call-template name="breadcrumb-section"/>
			<div class="row px-0 px-lg-4 mt-1">
				<div class="col-12">
					<h1><xsl:value-of select="ou:pcf-param('breadcrumb')" /></h1>
					<xsl:choose>
						<xsl:when test="ou:pcf-param('active-calendar') = '0'">
							
							<xsl:call-template name="fall-semester" />
						</xsl:when>
						<xsl:when test="ou:pcf-param('active-calendar') = '1'">
							
							<xsl:call-template name="spring-semester" />
						</xsl:when>
						<xsl:when test="ou:pcf-param('active-calendar') = '2'">
							
							<xsl:call-template name="summer-semester" />
						</xsl:when>
						<xsl:otherwise>
						</xsl:otherwise>
					</xsl:choose>	
				</div>
			</div>
		</div>
	</xsl:template>
	
	<xsl:template name="fall-semester">
		
		<xsl:choose>
			<xsl:when test="ou:pcf-param('active-calendar') = '0'">
				<div id="fall" class="fall-tab">
					<div class="row mt-1">
						<div class="col-12 p-3">
							<xsl:apply-templates select="ouc:div[@label='fall-semester-col-1']" />
						</div>
					</div>
				</div>
			</xsl:when>
			<xsl:otherwise>
					<div id="fall" class="tab-pane fade" role="tabpanel" aria-labelledby="fall-tab" tabindex="0">
						<div class="row mt-1">
							<div class="col-12 col-lg-6 p-3">
								<xsl:apply-templates select="ouc:div[@label='fall-semester-col-1']" />
							</div>
							<div class="col-12 col-lg-6 right-col-main p-3">
								<xsl:apply-templates select="ouc:div[@label='fall-semester-col-2']" />
							</div>
						</div>
				</div>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template name="spring-semester">
		<xsl:choose>
			<xsl:when test="ou:pcf-param('active-calendar') = '1'">
				<div id="spring" class="spring-tab">
					<div class="row mt-1">
						<div class="col-12 col-lg-6 p-3">
							<xsl:apply-templates select="ouc:div[@label='spring-semester-col-1']" />
						</div>
						<div class="col-12 col-lg-6 right-col-main p-3">
							<xsl:apply-templates select="ouc:div[@label='spring-semester-col-2']" />
						</div>
					</div>
				</div>
			</xsl:when>
			<xsl:otherwise>
				<div id="spring" class="tab-pane fade" role="tabpanel" aria-labelledby="spring-tab" tabindex="0">
					<div class="row mt-1">
						<div class="col-12 col-lg-6 p-3">
							<xsl:apply-templates select="ouc:div[@label='spring-semester-col-1']" />
						</div>
						<div class="col-12 col-lg-6 right-col-main p-3">
							<xsl:apply-templates select="ouc:div[@label='spring-semester-col-2']" />
						</div>
					</div>
				</div>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template name="summer-semester">
		<xsl:choose>
			<xsl:when test="ou:pcf-param('active-calendar') = '2'">
				<div id="summer" class="summer-tab">
					<div class="row mt-1">
						<div class="col-12 col-lg-6 p-3">
							<xsl:apply-templates select="ouc:div[@label='summer-semester-col-1']" />
						</div>
						<div class="col-12 col-lg-6 right-col-main p-3">
							<xsl:apply-templates select="ouc:div[@label='summer-semester-col-2']" />
						</div>
					</div>
				</div>
			</xsl:when>
			<xsl:otherwise>
				<div id="summer" class="tab-pane fade" role="tabpanel" aria-labelledby="summer-tab" tabindex="0">
					<div class="row mt-1">
						<div class="col-12 col-lg-6 p-3">
							<xsl:apply-templates select="ouc:div[@label='summer-semester-col-1']" />
						</div>
						<div class="col-12 col-lg-6 right-col-main p-3">
							<xsl:apply-templates select="ouc:div[@label='summer-semester-col-2']" />
						</div>
					</div>
				</div>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- END FSP Page -->
	
</xsl:stylesheet>
