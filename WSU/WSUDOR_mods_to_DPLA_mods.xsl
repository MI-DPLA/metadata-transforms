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
        <xsl:choose>
            <xsl:when test="*/mods:titleInfo/@type">
                <mods:titleInfo>
                    <xsl:attribute name="type"><xsl:value-of select="*/mods:titleInfo/@type"/></xsl:attribute>
                    <mods:title><xsl:value-of select="normalize-space(*/mods:titleInfo)"/></mods:title>
                </mods:titleInfo>     
            </xsl:when>
            <xsl:otherwise>
                <mods:titleInfo>
                    <mods:title><xsl:value-of select="normalize-space(*/mods:titleInfo)"/></mods:title>
                </mods:titleInfo>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="subject">
        <xsl:for-each select="*/mods:subject">   
            <xsl:copy-of select="current()"/>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="abstract">
        <xsl:choose>
            <xsl:when test="*/mods:abstract">
                <mods:abstract><xsl:value-of select="normalize-space(*/mods:abstract)"/></mods:abstract>
            </xsl:when>
            <xsl:otherwise/>
        </xsl:choose>
        
    </xsl:template>
    
    <xsl:template name="location">
        <mods:subject>
            <mods:geographic>
                <xsl:value-of select="normalize-space(*/mods:originInfo/mods:place/mods:placeTerm[@type='text'])"/>
            </mods:geographic>
        </mods:subject>
    </xsl:template>
    
    <xsl:template name="date">
        <mods:originInfo>
            <xsl:for-each select="*/mods:originInfo/mods:dateIssued">   
                <xsl:copy-of select="current()"/>
            </xsl:for-each>
            <xsl:choose>
                <xsl:when test="*/mods:originInfo/mods:publisher">
                    <mods:publisher><xsl:value-of select="*/mods:originInfo/mods:publisher"/></mods:publisher>
                </xsl:when>
                <xsl:otherwise/>
            </xsl:choose>
        </mods:originInfo>
    </xsl:template>
    
    <xsl:template name="type">
        <mods:typeOfResource><xsl:value-of select="normalize-space(*/mods:typeOfResource)"/></mods:typeOfResource>
    </xsl:template>
    
    <xsl:template name="physicalD">
        <mods:physicalDescription>
            <mods:form>
                <xsl:attribute name="authority"><xsl:value-of select="*/mods:physicalDescription/mods:form/@authority"/></xsl:attribute>
                <xsl:value-of select="normalize-space(*/mods:physicalDescription/mods:form)"/>
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
                <xsl:value-of select="normalize-space(*/mods:location/mods:url[@usage='primary'])"/>
            </mods:url>
            <mods:url>
                <xsl:attribute name="access">preview</xsl:attribute>
                <xsl:value-of select="normalize-space(*/mods:location/mods:url[@access='preview'])"/>
            </mods:url>
        </mods:location>
    </xsl:template>
    
    <xsl:template name="host">
        <mods:relatedItem type="host">
            <mods:titleInfo>
                <mods:title>
                    <xsl:value-of select="normalize-space(*/mods:relatedItem[@type='host']/mods:titleInfo/mods:title)"/>
                </mods:title>
            </mods:titleInfo>
        </mods:relatedItem>
    </xsl:template>
    
    <xsl:template name="otherversion">
        <xsl:choose>
            <xsl:when test="*/mods:relatedItem[@type='otherFormat']/mods:note[@type='originalVersion']">
                <mods:note><xsl:value-of select="concat('Original Version: ',normalize-space(*/mods:relatedItem[@type='otherFormat']/mods:note[@type='originalVersion']))"/></mods:note>
            </xsl:when>
            <xsl:otherwise/>
        </xsl:choose>
        
    </xsl:template>
    
    <xsl:template name="sourceDesc">
        <xsl:choose>
            <xsl:when test="*/mods:note[@type='sourceOfDescription']">
                <mods:note><xsl:value-of select="concat('Source of Description: ',normalize-space(*/mods:note[@type='sourceOfDescription']))"/></mods:note>
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
        <mods:note><xsl:value-of select="concat('Source of Description: ',normalize-space(*/mods:recordInfo/mods:recordOrigin))"/>
        </mods:note>
    </xsl:template>
    
    <xsl:template name="rights">
        <mods:accessCondition type="use and reproduction">
            <xsl:value-of select="normalize-space(*/mods:accessCondition)"/>
        </mods:accessCondition>
    </xsl:template>
    
    <xsl:template name="language">
        <xsl:choose>
            <xsl:when test="*/mods:language/mods:languageTerm[@type='code']">
                <mods:language>
                    <mods:languageTerm type="code">
                        <xsl:value-of select="normalize-space(*/mods:language/mods:languageTerm[@type='code'])"/>
                    </mods:languageTerm>
                </mods:language>
            </xsl:when>
            <xsl:otherwise/>
        </xsl:choose>
        
    </xsl:template>
    
    <xsl:template name="name">
        <xsl:choose>
            
        
            <xsl:when test="not(mods:mods/mods:name)"/>
            <xsl:when test="mods:mods/mods:name/mods:role/mods:roleTerm='creator' or mods:mods/mods:name/mods:role/mods:roleTerm='writer' or mods:mods/mods:name/mods:role/mods:roleTerm='Photographer' 
                or mods:mods/mods:name/mods:role/mods:roleTerm='Author' or mods:mods/mods:name/mods:role/mods:roleTerm='Conceptor'">
               
                    <mods:name>
                        <xsl:attribute name="type"><xsl:value-of select="mods:mods/mods:name/@type"/></xsl:attribute>
                        <xsl:attribute name="authority"><xsl:value-of select="mods:mods/mods:name/@authority"/></xsl:attribute>
                        <mods:namePart><xsl:value-of select="mods:mods/mods:name/mods:namePart"></xsl:value-of></mods:namePart>
                        <mods:role>
                            <mods:roleTerm authority="marcrelator">Creator</mods:roleTerm>
                        </mods:role>
                    </mods:name>
                
            </xsl:when>
            <xsl:when test="mods:mods/mods:name/mods:role/mods:roleTerm=not('creator') or mods:mods/mods:name/mods:role/mods:roleTerm=not('writer') or mods:mods/mods:name/mods:role/mods:roleTerm=not('Photographer') 
                or mods:mods/mods:name/mods:role/mods:roleTerm=not('Author') or mods:mods/mods:name/mods:role/mods:roleTerm=not('Conceptor')">
                
                    <mods:name>
                        <xsl:attribute name="type"><xsl:value-of select="mods:mods/mods:name/@type"/></xsl:attribute>
                        <xsl:attribute name="authority"><xsl:value-of select="mods:mods/mods:name/@authority"/></xsl:attribute>
                        <mods:namePart><xsl:value-of select="mods:mods/mods:name/mods:namePart"></xsl:value-of></mods:namePart>
                        <mods:role>
                            <mods:roleTerm authority="marcrelator">Contributor</mods:roleTerm>
                        </mods:role>
                    </mods:name>
                
            </xsl:when>
        </xsl:choose>
           
    </xsl:template>
    
   
</xsl:stylesheet>