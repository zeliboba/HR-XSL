<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet  [
	<!ENTITY nbsp   "&#160;">
  <!ENTITY copy   "&#169;">
]><xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:europass="http://europass.cedefop.europa.eu/Europass/V2.0">
<xsl:template match="/">
<xsl:comment>
  # © European Communities, 2002-2009 http://europass.cedefop.europa.eu
  # http://europass.cedefop.europa.eu/europass/home/botnav/LegalNotice.csp
  # Name      : lp_es_ES_V2.0.xsl
  # Version   : V2.0
  # Purpose   : Provides a way to show the Europass LP in HTML format.
  # Author(s) : Europass team
  # URL       : http://europass.cedefop.europa.eu/TechnicalResources/XML/xsl/europass-xsl-V2.0/lp_es_ES_V2.0.xsl
</xsl:comment>
<html>
	<head>
	  <title>LP - HTML</title>
	  <link href="http://europass.cedefop.europa.eu/instruments/css/html.css" type="text/css" rel="stylesheet"/>
	</head>
	<body>
		<xsl:call-template name="logoheader"/>
		<xsl:call-template name="personalinformation"/>
		<xsl:call-template name="foreignlanguageinformation"/>
		<xsl:call-template name="footnoteasterisk"/>
		<xsl:if test="//field[@name='grid' and @keep='true']">
			<xsl:call-template name="grid"/>
		</xsl:if>
	</body>
</html>
</xsl:template>
<xsl:template name="logoheader">
	<table class="LP" cellSpacing="0" cellPadding="10" width="740" border="0">
		<tbody>
			<tr align="middle">
				<td width="20%"><img height="53" src="http://europass.cedefop.europa.eu/instruments/images/logos/logo_europass_lp.gif" width="95"/></td>
				<td style="text-align: center" width="60%">
					<span class="LabelBold">Pasaporte de Lenguas Europass</span>
					<br/>
					<span class="Label">Parte del Portafolio Europeo de Lenguas desarrollado por el Consejo de Europa</span>
				</td>
				<td width="20%"><img height="53" src="http://europass.cedefop.europa.eu/instruments/images/logos/otherlogo_lp.gif" width="95"/></td>
			</tr>
		</tbody>
	</table>
</xsl:template>
<xsl:template name="personalinformation">
	<xsl:variable name="firstNameBefore">
		<xsl:choose>
		  <xsl:when test="//field[@name='personal.firstName' and @before='personal.lastName']">1</xsl:when>
		  <xsl:otherwise>0</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<div class="VerLine_LP">
		<table class="LP" cellSpacing="0" cellPadding="0" width="710" border="0">
			<tbody>
				<xsl:call-template name="firstlinePersonalinformationtable"/>
				<xsl:call-template name="labelRowBold">
					<xsl:with-param name="label">
						<xsl:choose>
							<xsl:when test="$firstNameBefore=0">
							  <xsl:text>Apellido(s) </xsl:text>
							</xsl:when>
							<xsl:otherwise>
							  <xsl:text> Apellido(s)</xsl:text>
							</xsl:otherwise>
						  </xsl:choose>
					</xsl:with-param>
					<xsl:with-param name="labelcontent">
						<xsl:choose>
							<xsl:when test="$firstNameBefore=0">
								<xsl:value-of select="europass:learnerinfo/identification/lastname" />&#160;<xsl:value-of select="europass:learnerinfo/identification/firstname" />
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="europass:learnerinfo/identification/firstname" />&#160;<xsl:value-of select="europass:learnerinfo/identification/lastname" />
							</xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="emptyLabelRow"/>
				<xsl:if test="//field[@name='personal.birthDate' and @keep='true']">
					<xsl:call-template name="labelRow">
						<xsl:with-param name="label"><xsl:text>Fecha de nacimiento</xsl:text></xsl:with-param>
						<xsl:with-param name="labelcontent"><xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 9, 2)" />/<xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 6, 2)" />/<xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 1, 4)" />
						</xsl:with-param>
					</xsl:call-template>
				<xsl:call-template name="emptyLabelRow"/>
				</xsl:if>
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Idioma(s) materno(s)</xsl:text></xsl:with-param>
					<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/languagelist/language[@xsi:type='europass:mother']/label" /></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="emptyLabelRow"/>
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Otro(s) idioma(s)</xsl:text></xsl:with-param>
					<xsl:with-param name="labelcontent">
						<xsl:for-each select="europass:learnerinfo/languagelist/language[@xsi:type='europass:foreign']">
						  <xsl:if test="position() != 1">,&#160;</xsl:if>
						  <xsl:value-of select="label" />
						</xsl:for-each>
					</xsl:with-param>
				</xsl:call-template>
			</tbody>
		</table>
	</div>
</xsl:template>
<xsl:template name="foreignlanguageinformation">
	<xsl:for-each select="europass:learnerinfo/languagelist/language[@xsi:type='europass:foreign']">
		<xsl:call-template name="foreignlanguage"/>
	</xsl:for-each>
</xsl:template>
<xsl:template name="foreignlanguage">
	<br/>
	<div class="VerLine_LP">
		<table class="LP" cellSpacing="0" cellPadding="0" width="710" border="0">
			<tbody>
				<xsl:call-template name="firstlineForeignlanguageinformationtable"/>
				<tr>
					<td/>
					<td class="NormalHighlight"><xsl:value-of select="label" /> </td>
					<td/>
				</tr>
				<tr>
					<td/>
					<td>
						<xsl:call-template name="selfassessmenttable">
							<xsl:with-param name="indexedLang"><xsl:value-of select="concat('foreignLanguageList[', position()-1, ']')" /></xsl:with-param>
						</xsl:call-template>
					</td>
					<td/>
				</tr>    
				<xsl:call-template name="emptyTableRow"/>
				<tr>
					<td/>
					<td>
						<xsl:call-template name="linguisticdiplomatable">
							<xsl:with-param name="indexedLang"><xsl:value-of select="concat('foreignLanguageList[', position()-1, ']')" /></xsl:with-param>
						</xsl:call-template>
					</td>
					<td/>
				</tr> 
				<xsl:call-template name="emptyTableRow"/>
				<tr>
					<td/>
					<td>
						<xsl:call-template name="linguisticexperiencetable">
							<xsl:with-param name="indexedLang"><xsl:value-of select="concat('foreignLanguageList[', position()-1, ']')" /></xsl:with-param>
						</xsl:call-template>
					</td>
					<td/>
				</tr> 
				<xsl:call-template name="emptyTableRow"/>
			</tbody>
		</table>
	</div>
</xsl:template>
<xsl:template name="selfassessmenttable">
	<xsl:param name="indexedLang"/>
	<xsl:if test="//field[@name=concat($indexedLang,'.ass') and @keep='true']">
		<table>
			<tbody>
				<xsl:call-template name="firstlineSelfassessmenttable"/>
				<tr>
					<td class="GridHeadingBold" colspan="10">Autoevaluación de la capacidad lingüística</td>
				</tr>
				<tr>
					<td class="GridHeadingBold" colspan="4">Comprender</td>
					<td class="GridHeadingBold" colspan="4">Hablar</td>
					<td class="GridHeadingBold" colspan="2">Escribir</td>
				</tr>
				<tr>
					<td class="GridHeading" colspan="2">Comprensión auditiva</td>
					<td class="GridHeading" colspan="2">Comprensión de lectura</td>
					<td class="GridHeading" colspan="2">Interacción oral</td>
					<td class="GridHeading" colspan="2">Expresión oral</td>
					<td colspan="2"/>
				</tr>
				<tr>
					<xsl:call-template name="selfassessmentlevel">
						<xsl:with-param name="element"><xsl:value-of select="level/listening" /></xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="selfassessmentlevel">
						<xsl:with-param name="element"><xsl:value-of select="level/reading" /></xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="selfassessmentlevel">
						<xsl:with-param name="element"><xsl:value-of select="level/spokeninteraction" /></xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="selfassessmentlevel">
						<xsl:with-param name="element"><xsl:value-of select="level/spokenproduction" /></xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="selfassessmentlevel">
					  <xsl:with-param name="element"><xsl:value-of select="level/writing" /></xsl:with-param>
					</xsl:call-template>
				</tr>
			</tbody>
		</table>
	</xsl:if>
</xsl:template>
<xsl:template name="selfassessmentlevel">
	<xsl:param name="element"/>
	<td class="NormalCenter"><xsl:value-of select="$element" /></td>
	<td class="NormalCenter">
		<xsl:if test="$element='a1'">Usuario básico</xsl:if>
		<xsl:if test="$element='b1'">Usuario autónomo</xsl:if>
		<xsl:if test="$element='c1'">Usuario competente</xsl:if>
		<xsl:if test="$element='a2'">Usuario básico</xsl:if>
		<xsl:if test="$element='b2'">Usuario autónomo</xsl:if>
		<xsl:if test="$element='c2'">Usuario competente</xsl:if>
	</td>
</xsl:template>
<xsl:template name="linguisticdiplomatable">
	<xsl:param name="indexedLang"/>
	<table>
		<tbody>
			<xsl:call-template name="firstlineLinguisticdiplomatable"/>
			<tr>
			  <td class="GridHeadingBold" colspan="4">Título(s) o certificado(s)</td>
			</tr>
			<tr>
				<td class="GridHeading">Denominación del / de los título(s) o certificado(s)</td>
				<td class="GridHeading">Centro emisor</td>
				<td class="GridHeading">Fecha</td>
				<td class="GridHeading">Nivel europeo</td>
			</tr>
			<xsl:for-each select="diplomalist/diploma">
				<xsl:variable name="indexedDiploma">
					<xsl:value-of select="concat('.diplomaList[', position()-1, ']')" />
				</xsl:variable>
				<xsl:variable name="indexedBoth">
					<xsl:value-of select="concat('', $indexedLang, $indexedDiploma)" />
				</xsl:variable>
				<xsl:if test="//field[@name=$indexedBoth and @keep='true']">
					<tr>
						<td class="Normal"><xsl:value-of select="title" /></td>
						<td class="Normal"><xsl:value-of select="awardingBody" /></td>
						<td class="NormalCenter">
							<xsl:value-of select="translate(date/day,'-','')" /><xsl:if test="string-length(date/day) != 0">/</xsl:if><xsl:value-of select="translate(date/month,'-','')" /><xsl:if test="string-length(date/month) != 0">/</xsl:if><xsl:value-of select="translate(date/year,'-','')" />
						</td>
						<td class="NormalCenter"><xsl:value-of select="level" /> </td>
					</tr>
				</xsl:if>
			</xsl:for-each>
		</tbody>
	</table>
</xsl:template>
<xsl:template name="linguisticexperiencetable">
	<xsl:param name="indexedLang"/>
	<table>
		<tbody>
			<xsl:call-template name="firstlineLinguisticexperiencetable"/>
			<tr>
				<td class="GridHeadingBold" colspan="3">Experiencia(s) lingüística(s) en el idioma</td>
			</tr>
			<tr>
				<td class="GridHeading">Descripción</td>
				<td class="GridHeading">Desde</td>
				<td class="GridHeading">Hasta</td>
			</tr>
			<xsl:for-each select="experiencelist/experience">
				<xsl:variable name="indexedExperience">
					<xsl:value-of select="concat('.experienceList[', position()-1, ']')" />
				</xsl:variable>
				<xsl:variable name="indexedBoth">
					<xsl:value-of select="concat('', $indexedLang, $indexedExperience)" />
				</xsl:variable>
				<xsl:if test="//field[@name=$indexedBoth and @keep='true']">
					<tr>
						<td class="Normal"><xsl:value-of select="description" /></td>
						<td class="NormalCenter">
							<xsl:value-of select="translate(period/from/day,'-','')" /><xsl:if test="string-length(period/from/day) != 0">/</xsl:if><xsl:value-of select="translate(period/from/month,'-','')" /><xsl:if test="string-length(period/from/month) != 0">/</xsl:if><xsl:value-of select="translate(period/from/year,'-','')" />
						</td>
						<td class="NormalCenter"><xsl:value-of select="translate(period/to/day,'-','')" /><xsl:if test="string-length(period/to/day) != 0">/</xsl:if><xsl:value-of select="translate(period/to/month,'-','')" /><xsl:if test="string-length(period/to/month) != 0">/</xsl:if><xsl:value-of select="translate(period/to/year,'-','')" />
						</td>
					</tr>
				</xsl:if>
			</xsl:for-each>
		</tbody>
	</table>
</xsl:template>
<xsl:template name="labelRow">
	<xsl:param name="label"/>
	<xsl:param name="labelcontent"/>
	<tr>
		<td class="Label"><xsl:value-of select="$label"/></td>
		<td class="Normal"><xsl:value-of select="$labelcontent"/></td>
		<td>&#160;</td>
	</tr>
</xsl:template>
<xsl:template name="labelRowBold">
	<xsl:param name="label"/>
	<xsl:param name="labelcontent"/>
	<tr>
		<td class="LabelBold"><xsl:value-of select="$label"/></td>
		<td class="Normal"><xsl:value-of select="$labelcontent"/></td>
		<td>&#160;</td>
	</tr>
</xsl:template>
<xsl:template name="emptyLabelRow">
	<tr>
		<td colSpan="3"/>
	</tr>
</xsl:template>  
<xsl:template name="emptyTableRow">
	<tr>
		<td colspan="3"/>
	</tr>
</xsl:template>  
<xsl:template name="firstlinePersonalinformationtable">
	<tr>
		<td width="173"/>
		<td width="516"/>
		<td width="21"/>
	</tr>
</xsl:template>
<xsl:template name="firstlineForeignlanguageinformationtable">
	<tr>
		<td width="20"/>
		<td width="670"/>
		<td width="20"/>
	</tr>
</xsl:template>
<xsl:template name="firstlineSelfassessmenttable">
	<tr>
		<td width="25"/>
		<td width="109"/>
		<td width="25"/>
		<td width="109"/>
		<td width="25"/>
		<td width="109"/>
		<td width="25"/>
		<td width="109"/>
		<td width="25"/>
		<td width="109"/>
	</tr>
</xsl:template>
<xsl:template name="firstlineLinguisticdiplomatable">
	<tr>
		<td width="270"/>
		<td width="230"/>
		<td width="85"/>
		<td width="85"/>
	</tr>
</xsl:template>
<xsl:template name="firstlineLinguisticexperiencetable">
	<tr>
		<td width="500"/>
		<td width="85"/>
		<td width="85"/>
	</tr>
</xsl:template>
<xsl:template name="footnoteasterisk">
	<div class="Asterix">
		(*)Las casillas marcadas con asterisco son opcionales.
		(**)Véase la plantilla de autoevaluación al dorso.
		(***)Nivel según el Marco Común Europeo de Referencia (MCE), cuando lo indique el certificado o título original.<br/>
	</div>
	<br/>
	<div class="Footnote">
		<b>Nota explicativa</b><br/>
		El Pasaporte de Lenguas Europass es parte del Portafolio Europeo de Lenguas elaborado por el Consejo de Europa, y utiliza los seis niveles europeos del Marco Común Europeo de Referencia sobre idiomas (MCE) para registrar la capacidad lingüística de manera estandarizada.<br/>
		Puede obtenerse más información sobre Europass en http://europass.cedefop.europa.eu - Puede consultarse otras informaciones sobre el Portafolio Europeo de Lenguas en www.coe.int/portfolio<br/>
		Puede descargarse gratuitamente la plantilla electrónica del  Pasaporte de Lenguas Europass en las direcciones web arriba indicadas<br/>
		© Consejo de Europa y Comunidades Europeas, 2004   20060628<br/>
	</div>
	<br/>
</xsl:template>
  <xsl:template name="grid">
	    <table width="710" border="0" cellspacing="0" cellpadding="0" class="Grid">
			<tr class="spacer">
				<th colspan="6"/>
			</tr>
			<tr>
				<th colspan="6" class="title">Niveles europeos – Tabla de auto evaluación</th>
			</tr>
			<tr class="level">
				<th>A1</th>
				<td>Reconozco palabras y expresiones muy básicas que se usan habitualmente, relativas a mí mismo, a mi familia y a mi entorno inmediato cuando se habla despacio y con claridad.</td>
				<td>Comprendo palabras y nombres conocidos y frases muy sencillas, por ejemplo las que hay en letreros, carteles y catálogos.</td>
				<td>Puedo participar en una conversación de forma sencilla siempre que la otra persona esté dispuesta a repetir lo que ha dicho o a decirlo con otras palabras y a una velocidad más lenta y me ayude a formular lo que intento decir. Planteo y contesto preguntas sencillas sobre temas de necesidad inmediata o  asuntos muy habituales.</td>
				<td>Utilizo expresiones y frases sencillas para describir el lugar donde vivo y las personas que conozco.</td>
				<td>Soy capaz de escribir postales cortas y sencillas, por ejemplo para enviar felicitaciones. 
Sé rellenar formularios con datos personales, por ejemplo mi nombre, mi nacionalidad y mi dirección en el formulario del registro de un hotel.</td>
			</tr>
			<tr class="level">
				<th>A2</th>
				<td>Comprendo frases y el vocabulario más habitual sobre temas de interés personal (información personal y familiar muy básica, compras, lugar de residencia, empleo).</td>
				<td>Soy capaz de leer textos muy breves y sencillos. Sé encontrar información específica y predecible en escritos sencillos y cotidianos como anuncios publicitarios, prospectos, menús y horarios y comprendo cartas personales breves y sencillas.</td>
				<td>Puedo comunicarme en tareas sencillas y habituales que requieren un intercambio simple y directo de información sobre actividades y asuntos cotidianos. Soy capaz de realizar intercambios sociales muy breves, aunque, por lo general, no puedo comprender lo suficiente como para mantener la conversación por mí mismo.</td>
				<td>Utilizo una serie de expresiones y frases para describir con términos sencillos a mi familia y otras personas, mis condiciones de vida, mi origen educativo y mi trabajo actual o el último que tuve.</td>
				<td>Soy capaz de escribir notas y mensajes breves y sencillos relativos a mis necesidades inmediatas. 
Puedo escribir cartas personales muy sencillas, por ejemplo agradeciendo algo a alguien.</td>
			</tr>
			<tr class="level">
				<th>B1</th>
				<td>Comprendo las ideas principales cuando el discurso es claro y normal y se tratan asuntos cotidianos que tienen lugar en el trabajo, en la escuela, durante el tiempo de ocio, etc. Comprendo la idea principal de muchos programas de radio o televisión que tratan temas actuales o asuntos de interés personal o profesional, cuando la articulación es relativamente lenta y clara.</td>
				<td>Comprendo textos redactados en una lengua de uso habitual y cotidiano o relacionada con el trabajo. Comprendo la descripción de acontecimientos, sentimientos y deseos en cartas personales.</td>
				<td>Sé desenvolverme en casi todas las situaciones que se me presentan cuando viajo donde se habla esa lengua. Puedo participar espontáneamente en una conversación que trate temas cotidianos de interés personal o que sean pertinentes para la vida diaria (por ejemplo, familia, aficiones, trabajo, viajes y acontecimientos actuales).</td>
				<td>Sé enlazar frases de forma sencilla con el fin de describir experiencias y hechos, mis sueños, esperanzas y ambiciones.</td>
				<td>Soy capaz de escribir textos sencillos y bien enlazados sobre temas que me son conocidos o de interés personal. 
Puedo escribir cartas personales que describen experiencias e impresiones.</td>
			</tr>
			<tr class="level">
				<th>B2</th>
				<td>Comprendo discursos y conferencias extensos e incluso sigo líneas argumentales complejas siempre que el tema sea relativamente conocido. Comprendo casi todas las noticias de la televisión y los programas sobre temas actuales.</td>
				<td>Soy capaz de leer artículos e informes relativos a problemas contemporáneos en los que los autores adoptan posturas o puntos de vista concretos. Comprendo la prosa literaria contemporánea.</td>
				<td>Puedo participar en una conversación con cierta fluidez y espontaneidad, lo que posibilita la comunicación normal con hablantes nativos. Puedo tomar parte activa en debates desarrollados en situaciones cotidianas explicando y defendiendo mis puntos de vista.</td>
				<td>Presento descripciones claras y detalladas de una amplia serie de temas relacionados con mi especialidad.</td>
				<td>Soy capaz de escribir textos claros y detallados sobre una amplia serie de temas relacionados con mis intereses. 
Puedo escribir redacciones o informes transmitiendo información o proponiendo motivos que apoyen o refuten un punto de vista concreto. Sé escribir cartas que destacan la importancia que le doy a determinados hechos y experiencias.</td>
			</tr>
			<tr class="level">
				<th>C1</th>
				<td>Comprendo discursos extensos incluso cuando no están estructurados con claridad y cuando las relaciones están sólo implícitas y no se señalan explícitamente. Comprendo sin mucho esfuerzo los programas de televisión y las películas.</td>
				<td>Comprendo textos largos y complejos de carácter literario o basados en hechos, apreciando distinciones de estilo.</td>
				<td>Me expreso con fluidez y espontaneidad sin tener que buscar de forma muy evidente las expresiones adecuadas. Utilizo el lenguaje con flexibilidad y eficacia para fines sociales y profesionales.</td>
				<td>Presento descripciones claras y detalladas sobre temas complejos que incluyen otros temas, desarrollando ideas concretas y terminando con una conclusión apropiada.</td>
				<td>Soy capaz de expresarme en textos claros y bien estructurados exponiendo puntos de vista con cierta extensión. 
Puedo escribir sobre temas complejos en cartas, redacciones o informes resaltando lo que considero que son aspectos importantes. Selecciono el estilo apropiado para los lectores a los que van dirigidos mis escritos.</td>
			</tr>
			<tr class="level">
				<th>C2</th>
				<td>No tengo ninguna dificultad para comprender cualquier tipo de lengua hablada, tanto en conversaciones en vivo como en discursos retransmitidos, aunque se produzcan a una velocidad de hablante nativo, siempre que tenga tiempo para familiarizarme con el acento.</td>
				<td>Soy capaz de leer con facilidad prácticamente todas las formas de lengua escrita, incluyendo textos abstractos estructural o lingüísticamente complejos como, por ejemplo, manuales, artículos especializados y obras literarias.</td>
				<td>Tomo parte sin esfuerzo en cualquier conversación o debate y conozco bien modismos, frases hechas y expresiones coloquiales. Me expreso con fluidez y transmito matices sutiles de sentido con precisión. Si tengo un problema, sorteo la dificultad con tanta discreción que los demás apenas se dan cuenta.</td>
				<td>Presento descripciones o argumentos de forma clara y fluida y con un estilo que es adecuado al contexto y con una estructura lógica y eficaz que ayuda al oyente a fijarse en las ideas importantes y a recordarlas.</td>
				<td>Soy capaz de escribir textos claros y fluidos en un estilo apropiado. Puedo escribir cartas, informes o artículos complejos que presentan argumentos con una estructura lógica y eficaz que ayuda al oyente a fijarse en las ideas importantes y a recordarlas. Escribo resúmenes y reseñas de obras profesionales o literarias.</td>
			</tr>
	  </table>
  </xsl:template>
</xsl:stylesheet>
