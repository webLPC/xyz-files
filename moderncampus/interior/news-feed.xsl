<xsl:template name="newsletter-feed">
    
    <xsl:param name="feed" select="normalize-space(ou:pcf-param('news-rss-feed'))"/>
    <xsl:param name="display-count" select="(number(ou:pcf-param('news-display-count')), 5)[string(.) != 'NaN'][1]"/>
    <xsl:param name="categories" select="normalize-space(ou:pcf-param('rss-feed-categories'))"/>
    
    <div class="">
        <xsl:choose>
            <xsl:when test="$feed">
                <xsl:choose>
                    <xsl:when test="$is-pub">
                        <xsl:processing-instruction name="php">
                            $feed = "{$feed}"; 
                            $amount_per_page = {$display-count};
                            $categories = "{$categories}";
                            $counter = 1;
                            ?</xsl:processing-instruction>
                        <xsl:copy-of select="ou:ssi('/_resources/scripts/newsletter/newsletter-listing.php')" />
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:variable name="params" as="element(item)*">
                            <xsl:if test="$feed">
                                <item>feed={encode-for-uri($feed)}</item>
                            </xsl:if>
                            <xsl:if test="$display-count">
                                <item>amount_per_page={$display-count}</item>
                            </xsl:if>
                            <xsl:if test="$categories">
                                <item>categories={encode-for-uri($categories)}</item>
                            </xsl:if>
                        </xsl:variable>
                        <xsl:value-of select="unparsed-text($domain || $ou:news-listing-script || '?' || string-join($params, '&amp;'))" disable-output-escaping="yes"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <h2>Empty Feed Field</h2>
                <p>Please enter a valid RSS feed into the News RSS Feed field.</p>
            </xsl:otherwise>
        </xsl:choose>
    </div>
</xsl:template>