<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:mods="http://www.loc.gov/mods/v3"
    exclude-result-prefixes="xs"
    version="1.0">
    <xsl:output indent="yes"/>
<!-- This XSL transforms MODS created from MARCXML into MODS compatible with the Michigan DPLA metadata profile. The resources described are scanned books.-->
    
    <xsl:template match="/mods:mods">
        <mods:mods>
            <xsl:apply-templates/>
            <mods:genre authority="aat">Books</mods:genre>
            <mods:genre authority="lcgtf">Cookbooks</mods:genre>
            <mods:relatedItem type="host">
                <mods:titleInfo>
                    <mods:title>"Feeding America: the Historic American Cookbook Project" (Digitization project)</mods:title>
                </mods:titleInfo>
                <mods:identifier type="oai_set">feeding_america_cookbooks</mods:identifier>
            </mods:relatedItem>
            <!--URN values were filled in separately. The URLs below are placeholders.-->
            <mods:location><mods:url usage="primary">http://www.lib.msu.edu/uri-res/N2L?urn:x-msulib::</mods:url></mods:location>
            <mods:location><mods:url access="preview">http://www.lib.msu.edu/uri-res/N2L?urn:x-msulib::</mods:url></mods:location>
            <mods:accessCondition type="use and reproduction">These materials are either in the public domain, according to U.S. copyright law, or permission has been obtained from rights owners or best effort has been made to find the copyright holders to ask permission. If you have reason to think otherwise please contact spc@mail.lib.msu.edu. The digital version and supplementary materials are available for all educational uses worldwide.</mods:accessCondition>
            <mods:recordInfo>
                <mods:recordContentSource authority="naf">Michigan State University. Libraries</mods:recordContentSource>
            </mods:recordInfo>
        </mods:mods>
    </xsl:template>
    
    <xsl:template match="mods:titleInfo[not(@type)]">
        <xsl:element name="mods:titleInfo">
            <xsl:element name="mods:title">
                <xsl:value-of select="mods:nonSort"/>
                <xsl:value-of select="mods:title"/>
                <xsl:if test="mods:subTitle">
                    <xsl:text>: </xsl:text>
                    <xsl:value-of select="mods:subTitle"/>
                </xsl:if>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="mods:name[@type='personal' or 'corporate']">
        <xsl:element name="mods:name">
            <xsl:attribute name="type"><xsl:value-of select="@type"/></xsl:attribute>
            <xsl:for-each select="mods:namePart[not(@type)]">
            <xsl:element name="mods:namePart">
                <xsl:value-of select="."/>
            </xsl:element>
            </xsl:for-each>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="mods:typeOfResource">
       <xsl:element name="mods:typeOfResource"><xsl:value-of select="."/></xsl:element>
    </xsl:template>
    
    <xsl:template match="mods:originInfo">
        <xsl:element name="mods:originInfo">
            <xsl:for-each select="mods:place/mods:placeTerm[@type='text']">
            <xsl:element name="mods:place">
                <xsl:element name="mods:placeTerm">
                    <xsl:attribute name="type"><xsl:value-of select="@type"/></xsl:attribute>
                    <xsl:value-of select="."/>
                </xsl:element>
            </xsl:element>
            </xsl:for-each>
            <xsl:for-each select="mods:publisher">
            <xsl:element name="mods:publisher">
            <xsl:value-of select="."/>
            </xsl:element>
            </xsl:for-each>
            
            <xsl:for-each select="mods:dateIssued">
            <xsl:element name="mods:dateIssued">
                <xsl:choose>
                    <xsl:when test="@encoding">
                        <xsl:attribute name="encoding"><xsl:text>w3cdtf</xsl:text></xsl:attribute>
                        <xsl:value-of select="."/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="."/>
                    </xsl:otherwise>
                </xsl:choose>
             </xsl:element>
            </xsl:for-each>
            
            <xsl:element name="mods:issuance">
                <xsl:value-of select="mods:issuance"/>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="mods:language">
        <xsl:element name="mods:language">
            <xsl:element name="mods:languageTerm">
                <xsl:attribute name="authority"><xsl:value-of select="mods:languageTerm/@authority"/></xsl:attribute>                
                <xsl:attribute name="type"><xsl:value-of select="mods:languageTerm/@type"/></xsl:attribute>
                <xsl:value-of select="."/>
            </xsl:element>
        </xsl:element>
    </xsl:template>

    <xsl:template match="mods:physicalDescription">
        <xsl:element name="mods:physicalDescription">
            <xsl:for-each select="mods:form[@authority]">
                <xsl:element name="mods:form">
                    <xsl:attribute name="authority"><xsl:value-of select="@authority"/></xsl:attribute>
                    <xsl:value-of select="."/>
                </xsl:element>
            </xsl:for-each>
            <xsl:for-each select="mods:extent">
                <xsl:element name="mods:extent">
                    <xsl:value-of select="."/>
                </xsl:element>
            </xsl:for-each>
            <xsl:element name="mods:internetMediaType">
                <xsl:text>application/pdf</xsl:text>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    
 
    <xsl:template match="mods:note">
        <xsl:for-each select=".">
            <xsl:element name="mods:note">
                <xsl:if test="@type">
                    <xsl:attribute name="type"><xsl:value-of select="@type"/></xsl:attribute>
                </xsl:if>
                    <xsl:value-of select="."></xsl:value-of>
        </xsl:element>
        </xsl:for-each>
    </xsl:template>
  
    
    <xsl:template match="mods:subject[@authority='lcsh']">
        <xsl:element name="mods:subject">
        <xsl:attribute name="authority"><xsl:value-of select="@authority"/></xsl:attribute>
            <xsl:for-each select="mods:topic">
            <xsl:element name="mods:topic">
                <xsl:value-of select="."/>
            </xsl:element>
            </xsl:for-each>
            <xsl:for-each select="mods:geographic">
                <xsl:element name="mods:geographic">
                    <xsl:value-of select="."/>
                </xsl:element>
            </xsl:for-each>
        </xsl:element>
    </xsl:template>

<xsl:template match="mods:identifier">
    <xsl:element name="mods:identifier">
        <xsl:if test="@type">
            <xsl:attribute name="type"><xsl:value-of select="@type"/></xsl:attribute>
        </xsl:if>
        <xsl:value-of select="."></xsl:value-of>
    </xsl:element>
</xsl:template>
    
    <!--ignore all other unused MODS elements-->
    <xsl:template match="*"/>
</xsl:stylesheet>