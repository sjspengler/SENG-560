<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="1.0">
    
<xsl:output method="html" omit-xml-declaration="yes"/>

<!-- ABOUT THIS DOCUMENT: This library is a collection of basic math functions in xslt and was created to minimize effort when reusing these functions.
        
XSLT Version 1.0 only supports the generic sum function and that function does not require calls to specific tags; a generic xpath to a basic location will do.
All other math functions in xslt require a call to a specific location (i.e. tag). Each function below calls a specific letter (i.e. tag) and updating that function to use a different location is as easy as changing the letters (i.e. tags) in the select attribute of a function.

To restrict the reach of these functions to specific elements within the xml, each function relies on an xpath call to it's own name (addition calls addition, division calls division) and will only calculate within that xpath and using the specified letters (i.e. tags).

Changes should only be made in the template match="document" section of this xsl as that creates the output. The template=”sqrt” and template=”Pow” support the functions in the template match="document" section and can be treated as black boxes. -->
    
    
    <xsl:template match="document">
        <html><body>
            
        <p>Addition: <xsl:for-each select="addition"><xsl:value-of select="sum(*)"/></xsl:for-each></p>  

        <p>Subtraction: <xsl:for-each select="subtraction"><xsl:value-of select="e - f - g"/></xsl:for-each></p>
        
        <p>Multiplication: <xsl:for-each select="multiplication"><xsl:value-of select="i * j * k"/></xsl:for-each></p>
        
            <p>Division: <xsl:for-each select="division"><xsl:value-of select="m div n div o"/></xsl:for-each></p>
            
        <p>Square Root: <xsl:for-each select="squareroot"><xsl:call-template name="sqrt">
                <xsl:with-param name="num" select="q"/>
            </xsl:call-template></xsl:for-each></p>
            
        <p>Exponent: <xsl:for-each select="exponent"><xsl:call-template name="Pow"><xsl:with-param name="Base" select="x"/><xsl:with-param name="Exponent" select="y"/><xsl:with-param name="Result" select="1"/></xsl:call-template></xsl:for-each></p>
       
        </body>
        </html>  
        
    </xsl:template>
    
    
    
<!-- NOTE: The following was acquired from https://sourceware.org/ml/xsl-list/2001-08/msg00740.html; black box as I did not need to modify any of the sqrt code and left the creator's notes for reference -->   
    
    <xsl:template name="sqrt">
           <xsl:param name="num" select="0"/>  <!-- The number you want to find the square root of -->
          <xsl:param name="try" select="1"/>  <!-- The current 'try'.  This is used internally. -->
           <xsl:param name="iter" select="1"/> <!-- The current iteration, checked against maxiter to limit loop count -->
          <xsl:param name="maxiter" select="10"/>  <!-- Set this up to insure against infinite loops -->
        
          <!-- note by the code author: This template was written by Nate Austin using Sir Isaac Newton's method of finding roots -->
        
          <xsl:choose>
                 <xsl:when test="$try * $try = $num or $iter &gt; $maxiter">
                     <xsl:value-of select="$try"/>
                     </xsl:when>
                 <xsl:otherwise>
                      <xsl:call-template name="sqrt">
                            <xsl:with-param name="num" select="$num"/>
                            <xsl:with-param name="try" select="$try - (($try * $try - $num) div (2 * $try))"/>
                             <xsl:with-param name="iter" select="$iter + 1"/>
                             <xsl:with-param name="maxiter" select="$maxiter"/>
                           </xsl:call-template>
                     </xsl:otherwise>
              </xsl:choose>
         </xsl:template>



<!-- NOTE: The following was acquired from http://openwritings.net/public/xslt/raise-power; white box as I needed to modify the code to pull my x and y values (set select to 0 so it uses the numbers [letter tags] in the function above). -->
    
<!-- notes by the code author: Generic function: Pow($Base, $Exponent). - Multiple $Base $Exponent time recursively until $Exponent is equal to 0. - Always set Result to 1 when Pow() function is used. -->
    
    <xsl:template name="Pow">
        <xsl:param name="Base" select="0"/>
        <xsl:param name="Exponent" select="0"/>
        <xsl:param name="Result" select="1"/>
        <xsl:choose>
            <xsl:when test="$Exponent = 0">
                <xsl:value-of select="1"/>
            </xsl:when>
            <xsl:when test="$Exponent = 1">
                <xsl:value-of select="$Result * $Base"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="Pow">
                    <xsl:with-param name="Base" select="$Base"/>
                    <xsl:with-param name="Exponent" select="$Exponent - 1"/>
                    <xsl:with-param name="Result" select="$Result * $Base"/>
                </xsl:call-template>                          
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>  


</xsl:stylesheet>