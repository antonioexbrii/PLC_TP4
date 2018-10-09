<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0">
    
    <xsl:output method="html" indent="yes"/>
    
    <xsl:template match="/">
        <xsl:result-document href="website/index.html">
            <html>
                <head>
                    <meta charset="UTF-8"/>
                    <title>ARQ MUSICA DIGITAL</title>
                </head>
                <body>
                    <h1>Arquivo de Musica Digital</h1>
                    <hr/>
                    <ul>
                        <xsl:apply-templates select="//tipo[not(preceding::tipo=.)]">
                            <xsl:sort select="."/>
                        </xsl:apply-templates>             
                        
                    </ul>
                </body>
            </html>
        </xsl:result-document>
        <!-- Paginas de obras -->
        <xsl:apply-templates select="//obra" mode="obra"/>        
        
    </xsl:template>
    <xsl:template match="tipo">
        <xsl:variable name="t" select="."/>
        <li>
            <xsl:value-of select="."/>
            <ol>
                <xsl:for-each select="//obra[tipo=$t]">
                    <xsl:sort select="titulo"/>
                    <li>
                        <a href="http://localhost:4001/obra?id={@id}"><xsl:value-of select="titulo"/></a>
                    </li>
                </xsl:for-each>    
            </ol>
        </li>
    </xsl:template>
    <xsl:template match="obra" mode="obra">
        <xsl:result-document href="website/html/obra{@id}.html">
            <html>
                <head>
                    <meta charset="UTF-8" indent="yes"/>
                </head>
                <body>
                    <h2><xsl:value-of select="titulo"/></h2>
                    <h3><xsl:value-of select="tipo"/></h3>
                    <xsl:if test="compositor">
                        <p><b><xsl:value-of select="compositor"/></b></p>
                    </xsl:if>
                    <xsl:if test="arranjo">
                        <p><b><xsl:value-of select="arranjo"/></b></p>
                    </xsl:if>
                    <xsl:if test="instrumentos/instrumento">
                        <h4>Partituras Disponiveis</h4>
                        <table border="1">
                            <tr>
                                <th>Instrumento</th>
                                <th>Afinacao</th>
                                <th>Voz</th>
                                <th>Clave</th>
                                <th>Doc</th>
                            </tr>
                            <xsl:for-each select="instrumentos/instrumento">
                                <tr>
                                    <td><xsl:value-of select="designacao"/></td>
                                    <td><xsl:value-of select="partitura/@afinacao"/></td>
                                    <td><xsl:value-of select="partitura/@voz"/></td>
                                    <td><xsl:value-of select="partitura/@clave"/></td>
                                    <td><xsl:value-of select="partitura/@path"/></td>
                                </tr>
                            </xsl:for-each>
                        </table>   
                    </xsl:if>
                    <p><address>[<a href="http://localhost:4001/obras">Voltar ao Index</a>]</address></p>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
</xsl:stylesheet>