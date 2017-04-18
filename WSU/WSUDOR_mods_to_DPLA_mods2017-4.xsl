<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" 
    xmlns:mods="http://www.loc.gov/mods/v3">
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:template match="/">
            <mods:mods>
                <xsl:call-template name="titleInfo"/>
                <xsl:call-template name="subject"/>
                <xsl:call-template name="abstract"/>
                <xsl:call-template name="location"/>
                <xsl:call-template name="date"/>
                <xsl:call-template name="type"/>
                <xsl:call-template name="physicalD"/>
                <xsl:call-template name="URLs"/>
                <xsl:call-template name="host"/>
                <xsl:call-template name="otherversion"/>
                <xsl:call-template name="sourceDesc"/>
                <xsl:call-template name="record"/>
                <xsl:call-template name="recordOr"/>
                <xsl:call-template name="rights"/>
                <xsl:call-template name="language"/>
                <xsl:call-template name="name"/>
            </mods:mods>
    </xsl:template>
    
    <xsl:template name="titleInfo">
        <xsl:for-each select="mods:mods/mods:titleInfo">
            <mods:titleInfo>
                <xsl:choose>
                    <xsl:when test="@type">
                        <xsl:attribute name="type"><xsl:value-of select="@type"/></xsl:attribute>
                        <mods:title><xsl:value-of select="mods:title"/></mods:title>
                    </xsl:when>
                    <xsl:otherwise>
                        <mods:title><xsl:value-of select="mods:title"/></mods:title>
                    </xsl:otherwise>
                </xsl:choose>
            </mods:titleInfo>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="subject">
        <xsl:for-each select="*/mods:subject">   
            <xsl:copy-of select="current()"/>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="abstract">
        <xsl:choose>
            <xsl:when test="*/mods:abstract">
                <mods:abstract><xsl:value-of select="*/mods:abstract"/></mods:abstract>
            </xsl:when>
            <xsl:otherwise/>
        </xsl:choose>
        
    </xsl:template>
    
    <xsl:template name="location">
        <mods:subject>
            <mods:geographic>
                <xsl:value-of select="*/mods:originInfo/mods:place/mods:placeTerm[@type='text']"/>
            </mods:geographic>
        </mods:subject>
    </xsl:template>
    
    <xsl:template name="date">
        <mods:originInfo>
            <xsl:for-each select="mods:mods/mods:originInfo">
                <xsl:choose>
                    <xsl:when test="mods:dateIssued[@point='start']">
                        <mods:dateIssued><xsl:value-of select="concat(mods:dateIssued[@point='start'],'-',mods:dateIssued[@point='end'])"/></mods:dateIssued>
                    </xsl:when>
                    <xsl:otherwise>
                        <mods:dateIssued><xsl:value-of select="mods:dateIssued"/></mods:dateIssued>
                    </xsl:otherwise>
                </xsl:choose>
            <xsl:choose>
                <xsl:when test="*/mods:originInfo/mods:publisher">
                    <mods:publisher><xsl:value-of select="*/mods:originInfo/mods:publisher"/></mods:publisher>
                </xsl:when>
                <xsl:otherwise/>
            </xsl:choose>
            </xsl:for-each>
        </mods:originInfo>
    </xsl:template>
    
    <xsl:template name="type">
        <mods:typeOfResource><xsl:value-of select="*/mods:typeOfResource"/></mods:typeOfResource>
    </xsl:template>
    
    <xsl:template name="physicalD">
        <mods:physicalDescription>
            <mods:form>
                <xsl:attribute name="authority"><xsl:value-of select="*/mods:physicalDescription/mods:form/@authority"/></xsl:attribute>
                <xsl:value-of select="*/mods:physicalDescription/mods:form"/>
            </mods:form>
            <xsl:choose>
                <xsl:when test="*/mods:physicalDescription/mods:extent">
                    <mods:extent><xsl:value-of select="*/mods:physicalDescription/mods:extent"/></mods:extent>
                </xsl:when>
                <xsl:otherwise/>
            </xsl:choose>
        </mods:physicalDescription>
    </xsl:template>
    
    <xsl:template name="URLs">
        <mods:location>
            <mods:url>
                <xsl:attribute name="usage">primary</xsl:attribute>
                <xsl:value-of select="*/mods:location/mods:url[@usage='primary']"/>
            </mods:url>
        </mods:location>
        <mods:location>
            <mods:url>
                <xsl:attribute name="access">preview</xsl:attribute>
                <xsl:value-of select="*/mods:location/mods:url[@access='preview']"/>
            </mods:url>
        </mods:location>
    </xsl:template>
    
    <xsl:template name="host">
        <mods:relatedItem type="host">
            <mods:titleInfo>
                <mods:title>
                    <xsl:value-of select="*/mods:relatedItem[@type='host']/mods:titleInfo/mods:title"/>
                </mods:title>
            </mods:titleInfo>
        </mods:relatedItem>
    </xsl:template>
    
    <xsl:template name="otherversion">
        <xsl:choose>
            <xsl:when test="*/mods:relatedItem[@type='otherFormat']/mods:note[@type='originalVersion']">
                <mods:note><xsl:value-of select="concat('Original Version: ',*/mods:relatedItem[@type='otherFormat']/mods:note[@type='originalVersion'])"/></mods:note>
            </xsl:when>
            <xsl:otherwise/>
        </xsl:choose>
        
    </xsl:template>
    
    <xsl:template name="sourceDesc">
        <xsl:choose>
            <xsl:when test="*/mods:note[@type='sourceOfDescription']">
                <mods:note><xsl:value-of select="concat('Source of Description: ',*/mods:note[@type='sourceOfDescription'])"/></mods:note>
            </xsl:when>
            <xsl:otherwise/>
        </xsl:choose>
        
    </xsl:template>
    
    <xsl:template name="record">
        <xsl:choose>
            <xsl:when test="mods:mods/mods:recordInfo/mods:recordContentSource">
                <mods:recordInfo>
                 <xsl:for-each select="mods:mods/mods:recordInfo/mods:recordContentSource">
                    <xsl:copy-of select="current()"/>
                </xsl:for-each>   
                </mods:recordInfo>
            </xsl:when>
            <xsl:otherwise/>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="recordOr">
        <mods:note><xsl:value-of select="concat('Source of Description: ',*/mods:recordInfo/mods:recordOrigin)"/>
        </mods:note>
    </xsl:template>
    
    <xsl:template name="rights">
        <mods:accessCondition type="use and reproduction">
            <xsl:value-of select="*/mods:accessCondition"/>
        </mods:accessCondition>
    </xsl:template>
    
    <xsl:template name="language">
        <xsl:choose>
            <xsl:when test="*/mods:language/mods:languageTerm[@type='code']">
                <mods:language>
                    <mods:languageTerm type="code">
                        <xsl:value-of select="*/mods:language/mods:languageTerm[@type='code']"/>
                    </mods:languageTerm>
                </mods:language>
            </xsl:when>
            <xsl:otherwise/>
        </xsl:choose>
        
    </xsl:template>
    
    <xsl:template name="name">
        <xsl:for-each select="mods:mods/mods:name">
            <xsl:choose>
                <xsl:when test="mods:role/mods:roleTerm='creator' or mods:role/mods:roleTerm='writer' or mods:role/mods:roleTerm='Photographer' 
                or mods:role/mods:roleTerm='Author' or mods:role/mods:roleTerm='Conceptor' or mods:role/mods:roleTerm='Illustrator'">
                    <mods:name>
                        <xsl:attribute name="type"><xsl:value-of select="@type"/></xsl:attribute>
                        <xsl:attribute name="authority"><xsl:value-of select="@authority"/></xsl:attribute>
                        <mods:namePart><xsl:value-of select="mods:namePart"></xsl:value-of></mods:namePart>
                        <mods:role>
                            <mods:roleTerm authority="marcrelator">Creator</mods:roleTerm>
                        </mods:role>
                    </mods:name>
            </xsl:when>
            <xsl:when test="mods:role/mods:roleTerm='Contributor' or mods:role/mods:roleTerm='Translator'">
             
                    <mods:name>
                        <xsl:attribute name="type"><xsl:value-of select="@type"/></xsl:attribute>
                        <xsl:attribute name="authority"><xsl:value-of select="@authority"/></xsl:attribute>
                        <mods:namePart><xsl:value-of select="mods:namePart"></xsl:value-of></mods:namePart>
                        <mods:role>
                            <mods:roleTerm authority="marcrelator">Contributor</mods:roleTerm>
                        </mods:role>
                    </mods:name>
                
            </xsl:when>
                <xsl:otherwise>
                    <mods:name>
                        <xsl:attribute name="type"><xsl:value-of select="@type"/></xsl:attribute>
                        <xsl:attribute name="authority"><xsl:value-of select="@authority"/></xsl:attribute>
                        <mods:namePart><xsl:value-of select="mods:namePart"></xsl:value-of></mods:namePart>
                    </mods:name>
                </xsl:otherwise>
        </xsl:choose>
           </xsl:for-each>
    </xsl:template>
    
   
</xsl:stylesheet>