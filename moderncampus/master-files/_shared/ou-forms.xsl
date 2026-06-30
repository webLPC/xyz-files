<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet [
<!ENTITY nbsp   "&#160;">
<!ENTITY lsaquo   "&#8249;">
<!ENTITY rsaquo   "&#8250;">
<!ENTITY laquo  "&#171;">
<!ENTITY raquo  "&#187;">
<!ENTITY copy   "&#169;">
]>
<xsl:stylesheet version="3.0" 
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:xs="http://www.w3.org/2001/XMLSchema" 
				xmlns:ou="http://omniupdate.com/XSL/Variables"
				xmlns:ouc="http://omniupdate.com/XSL/Variables" 
				exclude-result-prefixes="xs ou ouc">

	<xsl:import href="datasets.xsl"/>
	<xsl:param name="serverType">php</xsl:param> <!-- Either: php or asp (for checkboxes and drop-down menus)-->
	<!-- classes for the columns -->
	<xsl:param name="two-column-class">col-md-6</xsl:param> <!-- change this -->
	<xsl:param name="three-column-class">col-md-4</xsl:param> <!-- change this -->
	<xsl:param name="four-column-class">col-md-3</xsl:param> <!-- change this -->

<!--
***Predefined Attributes:***
1.legend : To create a placeholder text inside a form. Format: legend=true;
2.addclass: To add a class to an element block. Format: addclass=[CLASS NAME];
3.fieldset_start: Defines the statring block for a fieldset. Format: fieldset_start=true;
4.fieldset_end: Defines the ending block for a fieldset. Format: fieldset_end=true;
5.fieldset_label: Defines the label of the fieldset. Format: fieldset_label=[FIELDSET LABEL];
6.row_start: Defines the stating block for a row. Format: row_start=true;
7.row_col_count: Defines the number of columns the form element will span, used with row_start and row_end.
Needs to be added to each element for the row. Format: row_col_count=2;
8.row_end: Defines the ending block for a row. Format: row_end=true;
9.size :To add a size attribute to a single-line or multi-line text field. Format: size=10;
10.cols :To add a cloumns attribute to a multi-line text field. Format: cols=10;
11.rows :To add a rows attribute to a multi-line text field. Format: rows=10;
12.dataset: To add a pre-defined dataset to a radio button, checkbox, single-select and multi-select. Format: dataset=[DATASET_NAME];
(state, state_ab, country, year, month, alphabet, numbers)
13.form_classes:To add classes to the form node. Format: form_classes=well well-raised;
14. To add the "class=form-horizontal". Format:  form_classes=form-horizontal;
15. To add class="btn btw-mini" . Format:  reset_btn_classes=btn btn-mini;
16. To add a class to the submit button. Format: submit_btn_classes=class name;

Rules:
1. Every declaration in the advanced field must be terminated with a semicolon. Eg. legend=true;addclass=form_legend;
2. Attributes are always lowercase.
-->
	<xsl:template match="ouform">
		<div class="ou-form">
			<div id="status_{@uuid}"></div>

			<!-- check if form_classes is present in advanced fields, apply to form's class attribute
				 if more than one form_classes is present the last one is used -->
			<xsl:variable name="form-classes">
				<xsl:for-each select="elements/element">
					<xsl:if test="contains(advanced/text(),'form_classes')">
						<xsl:value-of select="ou:get-adv(advanced,'form_classes')"/>
					</xsl:if>
				</xsl:for-each>
			</xsl:variable>

			<!-- Apply correct class to reset button  -->
			<xsl:variable name="reset-btn-classes">
				<xsl:variable name="advanced-value">
					<xsl:for-each select="elements/element">
						<xsl:if test="contains(advanced/text(),'reset_btn_classes')">
							<xsl:value-of select="ou:get-adv(advanced,'reset_btn_classes')"/>
						</xsl:if>
					</xsl:for-each>
				</xsl:variable>
				<xsl:choose>
					<xsl:when test="$advanced-value != ''"><xsl:value-of select="$advanced-value"/></xsl:when>
					<xsl:otherwise>btn btn-default</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>

			<!-- Apply correct class to submit button  -->
			<xsl:variable name="submit-btn-classes">
				<xsl:variable name="advanced-value-submit">
					<xsl:for-each select="elements/element">
						<xsl:if test="contains(advanced/text(),'submit_btn_classes')">
							<xsl:value-of select="ou:get-adv(advanced,'submit_btn_classes')"/>
						</xsl:if>
					</xsl:for-each>
				</xsl:variable>
				<xsl:choose>
					<xsl:when test="$advanced-value-submit != ''"><xsl:value-of select="$advanced-value-submit"/></xsl:when>
					<xsl:otherwise>btn btn-primary</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<form id="form_{@uuid}" name="contact-form" method="post" class="{$form-classes}" autocomplete="off">
				<span class="{concat('hp',@uuid)}">
					<label for="{concat('hp',@uuid)}" class="{concat('hp',@uuid)}">If you see this don't fill out this input box.</label>
					<input type="text" id="{concat('hp',@uuid)}"/>
				</span>
				<xsl:apply-templates select="elements/element" mode="ouforms"/>
				<input type="hidden" name="form_uuid" value ="{@uuid}"/>
				<input type="hidden" name="site_name" value ="{$ou:site}"/>
				<button type="submit" id="btn_{@uuid}" class="{$submit-btn-classes}"><xsl:call-template name="submit-text" /></button>&nbsp;
				<button type="reset" id="clr_{@uuid}" class="{$reset-btn-classes}">Clear</button>
			</form>
			<xsl:call-template name="redirect-path" />
		</div> <!-- /.ou-form -->
		<style>
			.<xsl:value-of select="concat('hp',@uuid)"/>{display:none; margin-left:-1000px;}
		</style>
	</xsl:template>

	<!-- match on each element -->
	<xsl:template match="element" mode="ouforms">
		<!-- This outputs the <fieldset> opening node, if the fieldset_start is set to true in the advanced field. -->
		<xsl:if test="contains(ou:get-adv(advanced,'fieldset_start'),'true')">
			<xsl:text disable-output-escaping="yes">&lt;fieldset&gt;</xsl:text>
			<legend class="none">
				<xsl:attribute name="class"><xsl:value-of select="ou:ldp-create-class(advanced,'none')"/></xsl:attribute>
				<xsl:value-of select="ou:get-adv(advanced,'fieldset_label')"/>
			</legend>
		</xsl:if>
		<!-- detemine if the form has columns -->
		<xsl:variable name="row_start" select="contains(ou:get-adv(advanced,'row_start'),'true')" />
		<xsl:variable name="row_end" select="contains(ou:get-adv(advanced,'row_end'),'true')" />
		<xsl:variable name="row_col_count" select="ou:get-adv(advanced,'row_col_count')" />
		<!-- columns or no columns? -->
		<xsl:choose>
			<xsl:when test="$row_start or $row_end or $row_col_count != 'false'">
				<!-- output the starting div -->
				<xsl:if test="$row_start"><xsl:text disable-output-escaping="yes">&lt;div class="row"&gt;</xsl:text> </xsl:if>
				<xsl:variable name="col-count">
					<xsl:choose>
						<xsl:when test="$row_col_count = 4"><xsl:value-of select="$four-column-class" /></xsl:when>
						<xsl:when test="$row_col_count = 3"><xsl:value-of select="$three-column-class" /></xsl:when> 
						<xsl:otherwise><xsl:value-of select="$two-column-class" /></xsl:otherwise> 
					</xsl:choose>
				</xsl:variable>
				<div id="{@name}" class="{$col-count}">
					<xsl:apply-templates select="." mode="ouforms-input" />
					<xsl:call-template name="help-block" />
				</div>
				 <!-- output the closing div -->
				<xsl:if test="$row_end"><xsl:text disable-output-escaping="yes">&lt;/div&gt;</xsl:text></xsl:if>
			</xsl:when>
			<!-- regular output -->
			<xsl:otherwise>
				<!-- Creates the div that contains the input field -->
				<div id="{@name}" class="form-group">
					<xsl:if test="not(contains(ou:get-adv(advanced,'addclass'),'false'))">
						<xsl:attribute name="class">
							<xsl:value-of select="ou:ldp-create-class(advanced,'form-group')"/>
						</xsl:attribute>
					</xsl:if>
					<xsl:apply-templates select="." mode="ouforms-input" />
					<xsl:call-template name="help-block" />
				</div>
			</xsl:otherwise>
		</xsl:choose>
		<!-- This outputs the </fieldset> closing node, if the fieldset_end is set to true in the advanced field. -->
		<xsl:if test="contains(ou:get-adv(advanced,'fieldset_end'),'true')"><xsl:text disable-output-escaping="yes">&lt;/fieldset&gt;</xsl:text></xsl:if>
	</xsl:template>
	
	<!-- ***FIELD TYPES *** -->
	<!-- Single-line Text Field -->
	<xsl:template match="element[attribute::type = 'input-text']" mode="ouforms-input">
		<xsl:call-template name="create-form-label" />
		<input type="text" name="{@name}" id="{concat('id_',@name)}" placeholder="{default/node()}" class="form-control">
			<xsl:if test="not(contains(ou:get-adv(advanced,'size'),'false'))">
				<xsl:attribute name="size"><xsl:value-of select="ou:get-adv(advanced,'size')" /></xsl:attribute>
				<xsl:attribute name="style">width:auto;</xsl:attribute> 
				<!-- Bootstrap3 sets the width of input fields to 100%, which negates the size attribute, so we override it here. -->
			</xsl:if>
		</input>
	</xsl:template>

	<!-- Single-line Text Field with Legend advanced attribute.  Takes priority over all over single-line text fields. -->
	<xsl:template match="element[attribute::type = 'input-text' and contains(ou:get-adv(advanced,'legend'),'true')]" mode="ouforms-input" priority="1">
		<xsl:copy-of select="default/node()"/>
	</xsl:template>

	<!-- Multi-line Text Field -->
	<xsl:template match="element[attribute::type = 'textarea']" mode="ouforms-input">
		<xsl:variable name="adv" select="advanced/node()"/>
		<xsl:call-template name="create-form-label" />
		<xsl:element name="textarea">
			<xsl:attribute name="class">form-control</xsl:attribute>
			<xsl:attribute name="name"><xsl:value-of select="./@name" /></xsl:attribute>
			<xsl:attribute name="id"><xsl:value-of select="concat('id_',./@name)" /></xsl:attribute>

			<xsl:if test="not(contains(ou:get-adv($adv,'cols'),'false'))">
				<xsl:attribute name="cols"><xsl:value-of select="ou:get-adv($adv,'cols')" /></xsl:attribute>
			</xsl:if>
			<xsl:if test="not(contains(ou:get-adv($adv,'rows'),'false'))">
				<xsl:attribute name="rows"><xsl:value-of select="ou:get-adv($adv,'rows')" /></xsl:attribute>
			</xsl:if>
			<xsl:if test="not(contains(ou:get-adv($adv,'size'),'false'))">
				<xsl:attribute name="size"><xsl:value-of select="ou:get-adv($adv,'size')" /></xsl:attribute>
			</xsl:if>
			<xsl:attribute name="placeholder"><xsl:copy-of select="default/node()"/></xsl:attribute>
		</xsl:element>
	</xsl:template>

	<!-- Radio buttons -->
	<xsl:template match="element[attribute::type = 'input-radio']" mode="ouforms-input">
		<xsl:call-template name="create-form-label" />
		<div class="input-group" id="{concat('id_',@name)}">
			<xsl:for-each select="options/option">
				<div class="radio">
					<label>
						<input type="radio" name="{ancestor::element/attribute::name}" title="{@value}" value="{@value}">
							<xsl:if test="@selected = 'true'">
								<xsl:attribute name="checked">checked</xsl:attribute>
							</xsl:if>
						</input>
						<xsl:copy-of select="node()"/>
					</label>
				</div>
			</xsl:for-each>
		</div>
	</xsl:template>

	<!-- Check boxes -->
	<xsl:template match="element[attribute::type = 'input-checkbox']" mode="ouforms-input">
		<xsl:variable name="field_name" select="if($serverType = 'php') then concat(@name,'[]') else @name "/>
		<xsl:call-template name="create-form-label" />
		<div class="input-group" id="{concat('id_',@name)}">
			<xsl:for-each select="options/option">
				<div class="checkbox">
					<label>
						<input type="checkbox" name="{$field_name}" title="{@value}" value="{@value}">
							<xsl:if test="@selected = 'true'">
								<xsl:attribute name="checked">checked</xsl:attribute>
							</xsl:if>
						</input>
						<xsl:copy-of select="node()"/>
					</label>
				</div>
			</xsl:for-each>
		</div>
	</xsl:template>

	<!-- Single-select Drop Down Menus -->
	<xsl:template match="element[attribute::type = 'select-single']" mode="ouforms-input">
		<xsl:variable name="field_name" select="if($serverType = 'php') then concat(@name,'[]') else @name "/>
		<xsl:call-template name="create-form-label" />
		<select class="form-control" name="{$field_name}" id="{concat('id_',@name)}">
			<option value="" disabled="disabled" selected="selected">Please Select</option>
			<xsl:for-each select="options/option">
				<option value="{@value}" >
					<xsl:if test="@selected = 'true'">
						<xsl:attribute name="selected">selected</xsl:attribute>
					</xsl:if>
					<xsl:copy-of select="node()"/>
				</option>
			</xsl:for-each>
		</select>
	</xsl:template>

	<!-- Multi-select Drop Down Menus -->
	<xsl:template match="element[attribute::type = 'select-multiple']" mode="ouforms-input">
		<xsl:variable name="field_name" select="if($serverType = 'php') then concat(@name,'[]') else @name "/>
		<xsl:call-template name="create-form-label" />
		<select class="form-control" name="{$field_name}" multiple="multiple" size="5" id="{concat('id_',@name)}">
			<xsl:for-each select="options/option">
				<option value="{@value}" >
					<xsl:if test="@selected = 'true'">
						<xsl:attribute name="selected">selected</xsl:attribute>
					</xsl:if>
					<xsl:copy-of select="node()"/>
				</option>
			</xsl:for-each>
		</select>
	</xsl:template>

	<!-- Date/Time Picker -->
	<xsl:template match="element[attribute::type = 'datetime']" mode="ouforms-input">
		<xsl:variable name="field_name" select="if($serverType = 'php') then concat(@name,'[]') else @name "/>
		<xsl:variable name="field_id" select="concat('id_', @name)" />

		<xsl:call-template name="create-form-label" />
		<input type="text" name="{@name}" id="{$field_id}" class="form-control" />

		<script type="text/javascript">
			var OUC = OUC || {};
			OUC.dateTimePickers = OUC.dateTimePickers || [];
			OUC.dateTimePickers.push({
			id: '#<xsl:value-of select="$field_id" />',
			format: '<xsl:value-of select="@format" />',
			default: '<xsl:value-of select="default" />'
			});
		</script>
	</xsl:template>

	<!-- Instructional Text -->
	<xsl:template match="element[attribute::type = 'insttext']" mode="ouforms-input">
		<p><xsl:value-of select="label/node()" disable-output-escaping="yes" /></p>
	</xsl:template>

	<!-- DATASETS (radio, checkbox, and select options)  Higher priority than normal inputs. -->
	<xsl:template match="element[contains(child::advanced,'dataset')]" mode="ouforms-input" priority="1">
		<xsl:variable name="inputType" select="tokenize(@type,'-')" />
		<xsl:variable name="field_name" select="if($serverType = 'php' and @type != 'input-radio') then concat(@name,'[]') else @name " />
		<xsl:choose>
			<xsl:when test="$inputType[1] = 'input'">
				<label class="control-label">
					<xsl:if test="@required = 'true'">
						<span class="required">*</span>
					</xsl:if>
					<xsl:value-of select="label"/>
					<xsl:text disable-output-escaping="yes">&#10;</xsl:text>
				</label>
				<div class="input-group">
					<xsl:for-each select="tokenize(ou:create-dataset(advanced), ',')" >
						<div class="{$inputType[2]}">
							<label>
								<input type="{$inputType[2]}" name="{$field_name}" value="{replace(normalize-space(.),'_D_','')}">
									<xsl:if test="contains(normalize-space(.),'_D_')">
										<xsl:attribute name="checked">checked</xsl:attribute>
									</xsl:if>
								</input>
								<xsl:copy-of select="replace(normalize-space(.),'_D_','')"/>
							</label>
						</div>
					</xsl:for-each>
				</div>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="create-form-label" />
				<select class="form-control" name="{$field_name}" id="{concat('id_',@name)}">
					<xsl:if test="$inputType[2] = 'multiple'">
						<xsl:attribute name="multiple">multiple</xsl:attribute>
						<xsl:attribute name="size">5</xsl:attribute>
					</xsl:if>
					<xsl:for-each select="tokenize(ou:create-dataset(advanced), ',')" >
						<option  value="{replace(normalize-space(.),'_D_','')}" >
							<xsl:if test="contains(normalize-space(.),'_D_')">
								<xsl:attribute name="selected">true</xsl:attribute>
							</xsl:if>
							<xsl:copy-of select="normalize-space(replace(.,'_D_',''))"/>
						</option>
					</xsl:for-each>
				</select>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- catch-all (in case of future types) -->
	<xsl:template match="element" mode="ouforms-input"/>

	<!-- Helper Templates -->
	<!-- Put css files at the top of the page, so the styles are applied on page load.
		 Put the headcode above other stylesheets, so it doesn't overwrite the site's styles.-->
	<xsl:template name="form-headcode">
		<xsl:if test="/document/ouc:div/descendant::ouform">
			<link rel="stylesheet" href="/_resources/ldp/forms/css/ou-forms.bootstrap.min.css"/>
			<xsl:if test="/document/ouc:div/descendant::ouform/elements/element[@type = 'datetime']">
				<link rel="stylesheet" type="text/css" href="/_resources/ldp/forms/css/jquery.datetimepicker.min.css"/>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<!-- Conditional Submit Text button -->
	<xsl:template name="submit-text">
		<xsl:choose>
			<xsl:when test="output/submit_text/text() != ''">
				<xsl:value-of select="output/submit_text/text()" />
			</xsl:when>
			<xsl:otherwise>
				Submit
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<!-- Optional Helper Text -->
	<xsl:template name="help-block">
		<xsl:if test="element_info != ''">
			<span class="help-block"><xsl:value-of select="element_info" /></span>
		</xsl:if>
	</xsl:template>

	<!-- redirect path -->
	<xsl:template name="redirect-path">
		<!-- Redirect Path for Form Submission -->
		<xsl:if test="output/url_redirect[@value = 'true']">
			<script>
				var redirectPath;
				<xsl:variable name="url"><xsl:copy-of select="output/url_redirect_path/node()" /></xsl:variable>
				<xsl:variable name="urlSubstring"><xsl:copy-of select="substring($url, 1, 4)" /></xsl:variable>
				<xsl:choose>
					<xsl:when test="$urlSubstring = 'www.'">
						redirectPath = '<xsl:value-of select="concat('http://', $url)" />';
					</xsl:when>
					<xsl:when test="$urlSubstring = 'http'">
						redirectPath = '<xsl:value-of select="$url" />';
					</xsl:when>
					<xsl:otherwise>
						<xsl:variable name="redirectPath"><xsl:copy-of select="substring($url, 2, string-length($url))" /></xsl:variable>
						<xsl:if test="output/url_redirect[attribute::value = 'true'] and not(unparsed-text-available($redirectPath))">
							redirectPath = '<xsl:value-of select="concat($ou:httproot, $redirectPath)" />';
						</xsl:if>
					</xsl:otherwise>
				</xsl:choose>
			</script>
		</xsl:if>
	</xsl:template>

	<!-- Put this at the bottom, so that we can be sure that jQuery is loaded assuming the site uses it. -->
	<xsl:template name="form-footcode">
		<xsl:if test="/document/ouc:div/descendant::ouform">
			<script type="text/javascript" src="/_resources/ldp/forms/js/ou-forms.js"></script>

			<xsl:if test="/document/ouc:div/descendant::ouform/elements/element[@type = 'datetime']">
				<script type="text/javascript" src="/_resources/ldp/forms/js/jquery.datetimepicker.full.min.js"></script>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<xsl:template name="create-form-label">
		<label for="{concat('id_',@name)}" class="control-label">
			<xsl:value-of select="label"/>
			<xsl:if test="@required = 'true'">
				<span class="required"> *</span>
			</xsl:if>
		</label>
	</xsl:template>

	<!-- *** FUNCTIONS *** -->
	<!-- Function that parses advanced field for an attribute, and returns the value.  If no value is found, returns 'false'. -->
	<xsl:function name="ou:get-adv">
		<xsl:param name="adv"/>
		<xsl:param name="key"/>
		<xsl:choose>
			<xsl:when test="contains($adv,$key)">
				<xsl:value-of select="substring-before(substring-after($adv,concat($key,'=')),';')"/>
			</xsl:when>
			<xsl:otherwise>false</xsl:otherwise>
		</xsl:choose>
	</xsl:function>

	<!-- Function to create a class, uses ou:get-adv -->
	<xsl:function name="ou:ldp-create-class">
		<xsl:param name="adv" />
		<xsl:param name="predefined-class" />
		<xsl:variable name="class-name" select="if(contains($adv,'addclass')) then ou:get-adv($adv,'addclass') else ''" />
		<xsl:value-of select="normalize-space(concat($predefined-class,' ',$class-name))"/>
	</xsl:function>

</xsl:stylesheet>
