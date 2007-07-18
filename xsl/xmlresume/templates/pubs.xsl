<?xml version="1.0" encoding="UTF-8"?>

<!--

   Copyright 2006 Trevor Harmon

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.

-->

<xsl:stylesheet version="2.0"
	xmlns="http://ns.hr-xml.org/2007-04-15" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:res="http://xmlresume.sourceforge.net/resume/0.0"
	exclude-result-prefixes="res">

	<xsl:template match="res:pubs"> 
		<PublicationHistory> 
			<xsl:apply-templates select="res:pub"/> 
		</PublicationHistory> 
	</xsl:template> 

	<xsl:template match="res:pub"> 
		
		<xsl:choose>
			<xsl:when test="res:artTitle">
				<!-- If an artTitle is specified, assume it's an article -->
				<Article> 
					<Title>
						<xsl:value-of select="res:artTitle"/>
					</Title>
					<xsl:apply-templates select="res:author"/>
					<PublicationDate> 
						<xsl:apply-templates select="res:date"/>
					</PublicationDate> 
					<xsl:if test="res:para">
						<Abstract>
							<xsl:value-of select="res:para"/>
						</Abstract> 
					</xsl:if>
					<JournalOrSerialName>
						<xsl:value-of select="res:bookTitle"/>
					</JournalOrSerialName> 
					<xsl:if test="res:pageNums">
						<PageNumber>
							<xsl:value-of select="res:pageNums"/>
						</PageNumber>
					</xsl:if>
					<xsl:if test="res:publisher">
						<xsl:call-template name="comment">
							<xsl:with-param name="name">Publisher of articles not supported.</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
				</Article> 
			</xsl:when>
			<!-- Otherwise, assume it's a book -->
			<xsl:otherwise>
				<xsl:call-template name="comment">
					<xsl:with-param name="name">This publication lacks an article name, so it is assumed to be a book. Note that this may cause this HR-XML file to be invalid: All articles must come before books; they cannot be interspersed with each other. In other words, you might need to reorder your PublicationHistory elements manually before this file will validate.</xsl:with-param>
				</xsl:call-template>
				<Book> 
					<Title>
						<xsl:value-of select="res:bookTitle"/>
					</Title>
					<xsl:apply-templates select="res:author"/>
					<PublicationDate> 
						<xsl:apply-templates select="res:date"/>
					</PublicationDate> 
					<xsl:if test="res:para">
						<Abstract>
							<xsl:value-of select="res:para"/>
						</Abstract> 
					</xsl:if>
					<xsl:if test="res:publisher">
						<PublisherName>
							<xsl:value-of select="res:publisher"/>
						</PublisherName>
					</xsl:if>
				</Book> 
			</xsl:otherwise>
		</xsl:choose>
		
	</xsl:template> 
	
	<xsl:template match="res:author">
		
		<xsl:choose>
			<xsl:when test="string-length(.) = 0">
				<xsl:call-template name="comment">
					<xsl:with-param name="name">Author IDs not supported.</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<Name role="author">
					<FormattedName>
						<xsl:value-of select="."/>
					</FormattedName>
				</Name>
			</xsl:otherwise>
		</xsl:choose>
	
	</xsl:template>

</xsl:stylesheet>
