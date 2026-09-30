<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/">
        <table style="font-family: 'Times New Roman', Times, serif; font-weight: normal; border-collapse: collapse; width: 100%;">
            <thead>
                <tr>
                    <th style="font-weight: normal; font-family: 'Times New Roman', Times, serif;">id</th>
                    <th style="font-weight: normal; font-family: 'Times New Roman', Times, serif;">name</th>
                    <th style="font-weight: normal; font-family: 'Times New Roman', Times, serif;">course</th>
                    <th style="font-weight: normal; font-family: 'Times New Roman', Times, serif;">rating</th>
                    <th style="font-weight: normal; font-family: 'Times New Roman', Times, serif;">comment</th>
                </tr>
            </thead>
            <tbody>
                <xsl:for-each select="feedbacks/feedback">
                    <tr>
                        <td style="font-weight: normal; font-family: 'Times New Roman', Times, serif;"><xsl:value-of select="id"/></td>
                        <td style="font-weight: normal; font-family: 'Times New Roman', Times, serif;"><xsl:value-of select="name"/></td>
                        <td style="font-weight: normal; font-family: 'Times New Roman', Times, serif;"><xsl:value-of select="course"/></td>
                        <td style="font-weight: normal; font-family: 'Times New Roman', Times, serif;"><xsl:value-of select="rating"/></td>
                        <td style="font-weight: normal; font-family: 'Times New Roman', Times, serif;"><xsl:value-of select="comment"/></td>
                    </tr>
                </xsl:for-each>
            </tbody>
        </table>
    </xsl:template>
</xsl:stylesheet>
