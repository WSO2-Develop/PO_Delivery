<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
	xmlns:env="urn:org.milyn.edi.unedifact.v41" xmlns:orders="urn:org.milyn.edi.unedifact:un:d96a:orders"
	xmlns:c="urn:org.milyn.edi.unedifact:un:d96a:common"
	exclude-result-prefixes="soapenv env orders c">
 
	<xsl:strip-space elements="*" />
	<xsl:output method="xml" version="1.0" encoding="UTF-8"
		indent="yes" omit-xml-declaration="yes" />

	<xsl:template match="/">
		<root>
			<xsl:apply-templates />
		</root>
	</xsl:template>

	<xsl:template match="env:UNH" />
	<xsl:template match="env:UNT" />
	<xsl:template match="env:UNZ" />

	<xsl:template match="orders:ORDERS">

		<bapirfc name="ZMFSD_0001">
			<tables>
			
				<!-- T_HEADER -->
				<table name="T_HEADER">
					<xsl:for-each select="orders:BGM">
						<row id="{position() - 1}">
							<field name="BSTKD"><!-- Nro de orden -->
								<xsl:value-of select="c:e1004" />
							</field>
							<xsl:for-each select="parent::*/orders:DTM/c:C507">
								<xsl:choose>
									<xsl:when test="c:e2005 = '137'">
										<field name="BSTDK"><!-- Fecha de pedido -->
											<xsl:value-of select="c:e2380" />
										</field>
									</xsl:when>
									<xsl:when test="string(c:e2005) = '43E'">
										<field name="BSTDK_E"><!-- Fecha vencimiento -->
											<xsl:value-of select="c:e2380" />
										</field>
									</xsl:when>
									<xsl:when test="c:e2005 = '10'">
										<field name="VDATU"><!-- Fecha de despacho -->
											<xsl:value-of select="c:e2380" />
										</field>
									</xsl:when>
								</xsl:choose>
							</xsl:for-each>
							<xsl:for-each
								select="parent::*/orders:Segment_group_1/orders:RFF/c:C506">
								<xsl:choose>
									<xsl:when test="c:e1153 = 'SD'">
										<field name="ZDEP"><!-- Departamento -->
											<xsl:value-of select="c:e1154" />
										</field>
									</xsl:when>
									<xsl:when test="c:e1153 = 'ZZZ'">
										<field name="ZTPO"><!-- Tipo PO -->
											<xsl:value-of select="c:e1154" />
										</field>
									</xsl:when>
									<xsl:otherwise>
									<!-- <xsl:when test="c:e1153 = 'PD'"> -->
										<field name="ZMPO"><!-- Descripcion de Orden de compra -->
											<xsl:value-of select="c:e1154" />
										</field>
									<!-- </xsl:when> -->
									</xsl:otherwise>
								</xsl:choose>
							</xsl:for-each>
							<field name="WAERK"><!-- Moneda -->
								<xsl:value-of
									select="parent::*/orders:Segment_group_7/orders:CUX/c:C504_-_-1/c:e6345" />
							</field>
							<field name="ZTERM"><!-- Cond de pago -->
								<xsl:value-of
									select="parent::*/orders:Segment_group_8/orders:PAT/c:C112/c:e2009" />
							</field>
							<field name="ZMODP"><!-- Modo Pago -->
								<xsl:value-of
									select="parent::*/orders:Segment_group_8/orders:PAT/c:C112/c:e2151" />
							</field>
						</row>
					</xsl:for-each>
				</table>
				<!-- -->

				<!-- T_HEADER_INTER -->
				<table name="T_HEADER_INTER">
					<xsl:for-each select="orders:Segment_group_2">
						<xsl:if test="orders:NAD/c:e3035 != 'SN'">
							<row id="{position() - 1}">
								<field name="BSTKD"><!-- Nro de orden -->
									<xsl:value-of select="parent::*/orders:BGM/c:e1004" />
								</field>
								<field name="ZTIPO"><!-- Tipo -->						
									<xsl:value-of select="orders:NAD/c:e3035"/>
								</field>
								<field name="EXPNR"><!-- Int. Externo --> 
									<xsl:if test="parent::*/orders:Segment_group_1/orders:RFF/c:C506/c:e1154= 73">
										<xsl:if test="orders:NAD/c:e3035 = 'ST'">
											<xsl:text>7</xsl:text><!-- El codigo de local contiene un 7 de mas en SAP-->
											<xsl:value-of select="orders:NAD/c:C082/c:e3039" />
										</xsl:if>
										<xsl:if test="orders:NAD/c:e3035 = 'BT'">
											<xsl:text>7</xsl:text><!-- El codigo de local contiene un 7 de mas en SAP-->
											<xsl:value-of select="orders:NAD/c:C082/c:e3039" />
										</xsl:if>
										<xsl:if test="orders:NAD/c:e3035 = 'SF'">
											<!-- <xsl:value-of select="orders:Segment_group_3/orders:RFF/c:C506/c:e1154" /> -->
										</xsl:if>
									</xsl:if>
									<xsl:if test="parent::*/orders:Segment_group_1/orders:RFF/c:C506/c:e1154 = 20">
										<xsl:if test="orders:NAD/c:e3035 = 'BY'">
											<xsl:text>7</xsl:text><!-- El codigo de local contiene un 7 de mas en SAP-->
											<xsl:value-of select="orders:NAD/c:C082/c:e3039" />
										</xsl:if>
										<xsl:if test="orders:NAD/c:e3035 = 'SF'">
											<!-- <xsl:value-of select="orders:Segment_group_3/orders:RFF/c:C506/c:e1154" /> -->
										</xsl:if>
									</xsl:if>
									<xsl:if test="parent::*/orders:Segment_group_1/orders:RFF/c:C506/c:e1154 = 03">
										<xsl:if test="orders:NAD/c:e3035 = 'BY'">
											<xsl:text>7</xsl:text><!-- El codigo de local contiene un 7 de mas en SAP-->
											<xsl:value-of select="orders:NAD/c:C082/c:e3039" />
										</xsl:if>
										<xsl:if test="orders:NAD/c:e3035 = 'SF'">
											<!-- <xsl:value-of select="orders:Segment_group_3/orders:RFF/c:C506/c:e1154" /> -->
										</xsl:if>
									</xsl:if>
									<xsl:if test="parent::*/orders:Segment_group_1/orders:RFF/c:C506/c:e1154 = 33">
										<xsl:if test="orders:NAD/c:e3035 = 'BY'">
											<xsl:text>7</xsl:text><!-- El codigo de local contiene un 7 de mas en SAP-->
											<xsl:value-of select="orders:NAD/c:C082/c:e3039" />
										</xsl:if>
										<xsl:if test="orders:NAD/c:e3035 = 'SF'">
											<!-- <xsl:value-of select="orders:Segment_group_3/orders:RFF/c:C506/c:e1154" /> -->
										</xsl:if>
									</xsl:if>
									<xsl:if test="parent::*/orders:Segment_group_1/orders:RFF/c:C506/c:e1154 = 07">
										<xsl:if test="orders:NAD/c:e3035 = 'FR'">
											<xsl:text>7</xsl:text><!-- El codigo de local contiene un 7 de mas en SAP-->
											<xsl:value-of select="parent::*/orders:Segment_group_25/orders:Segment_group_33/orders:LOC/c:C517/c:e3225" />
										</xsl:if>
										<xsl:if test="orders:NAD/c:e3035 = 'SF'">
											<!-- <xsl:value-of select="orders:Segment_group_3/orders:RFF/c:C506/c:e1154" /> -->
										</xsl:if>
									</xsl:if>
									<xsl:if test="parent::*/orders:Segment_group_1/orders:RFF/c:C506/c:e1154 = 37">
										<xsl:if test="orders:NAD/c:e3035 = 'FR'">
											<xsl:text>7</xsl:text><!-- El codigo de local contiene un 7 de mas en SAP-->
											<xsl:value-of select="parent::*/orders:Segment_group_25/orders:Segment_group_33/orders:LOC/c:C517/c:e3225" />
										</xsl:if>
										<xsl:if test="orders:NAD/c:e3035 = 'SF'">
											<!-- <xsl:value-of select="orders:Segment_group_3/orders:RFF/c:C506/c:e1154" /> -->
										</xsl:if>
									</xsl:if>
								</field>
								<field name="NAME1"><!-- Nombre -->
									<xsl:value-of select="orders:NAD/c:C080"/>
								</field>
								<field name="ZVENDOR"><!-- vendor -->
									<xsl:if test="orders:Segment_group_3/orders:RFF/c:C506/c:e1153 = 'IA'">
										<xsl:value-of select="orders:Segment_group_3/orders:RFF/c:C506/c:e1154"/>	
									</xsl:if>
								</field>
							</row>
						</xsl:if>
					</xsl:for-each>
				</table>
				<!-- -->

				<!-- T_DETAIL_GRAL -->
				<table name="T_DETAIL_GRAL">
					<xsl:for-each select="orders:Segment_group_25">
						<row id="{position() - 1}">
							<field name="BSTKD"><!-- Nro de orden -->
								<xsl:value-of select="parent::*/orders:BGM/c:e1004" />
							</field>							
							<field name="POSNR"><!-- Posición -->
								<xsl:value-of select="orders:LIN/c:e1082"/>
							</field>
							<field name="KDMAT"><!-- DUN14 -->
								<xsl:value-of select="orders:LIN/c:C212/c:e7140"/>
							</field>
							<field name="ZDMAT"><!-- ITEM -->
								<xsl:value-of select="orders:PIA/c:C212_-_-1/c:e7140"/>
							</field>
							<field name="ZVENDOR"><!-- vendor -->
								<xsl:value-of select="orders:PIA/c:C212_-_-2/c:e7140"/>
							</field>
							<field name="ZMENG"><!-- Cantidad total -->
								<xsl:value-of select="orders:QTY/c:C186/c:e6060"/>
							</field>
							<field name="ZPREC"><!-- Monto total -->
								<xsl:value-of select="orders:MOA/c:C516/c:e5004"/>
							</field>
							<field name="NETWR"><!-- Precio de la unidad -->
								<xsl:value-of select="orders:Segment_group_28/orders:PRI/c:C509/c:e5118"/>
							</field>
							<field name="ZTIPP"><!-- Tipo precio -->
								<xsl:value-of select="orders:Segment_group_28/orders:PRI/c:C509/c:e5387"/>
							</field>
							<field name="VRKME"><!-- unidad -->
							</field>
							<field name="ZNUMP"><!-- Number of packages -->
								<xsl:value-of select="orders:Segment_group_30/orders:PAC/c:e7224"/>
							</field>
							<field name="ZPACL"><!-- Packaging level -->
								<xsl:value-of select="orders:Segment_group_30/orders:PAC/c:C531/c:e7075"/>
							</field>
						</row>
					</xsl:for-each>
				</table>
				<!-- -->

				<!-- T_DETAIL_ITEM -->
				<table name="T_DETAIL_ITEM">
					<xsl:for-each select="orders:Segment_group_25">
						<row id="{position() - 1}">
							<field name="BSTKD"><!-- Nro de orden -->
								<xsl:value-of select="parent::*/orders:BGM/c:e1004" />
							</field>							
							<field name="POSNR"><!-- Posición -->
								<xsl:value-of select="orders:LIN/c:e1082"/>
							</field>
							<field name="KDMAT"><!-- DUN14 -->
								<xsl:value-of select="orders:LIN/c:C212/c:e7140"/>
							</field>
							<field name="ZTIPO"><!-- tipo -->
							</field>
							<field name="ZCART"><!-- caracteristica -->
							</field>
							<field name="ZDESC"><!-- descripcion -->
								<xsl:value-of select="orders:IMD/c:C273/c:e7008_-_-1"/>
							</field>
						</row>
					</xsl:for-each>
				</table>
				<!-- -->

				<!-- T_DETAIL_INTER -->
				<table name="T_DETAIL_INTER">
					<xsl:for-each select="orders:Segment_group_25/orders:Segment_group_33">
						<!-- <xsl:for-each select="orders:Segment_group_33"> -->
							<row id="{position() - 1}">
								<field name="BSTKD"><!-- Nro de orden -->
									<xsl:value-of select="parent::*/parent::*/orders:BGM/c:e1004" />
								</field>							
								<field name="POSNR"><!-- Posición -->
									<xsl:value-of select="parent::*/orders:LIN/c:e1082"/>
								</field>
								<field name="EXPNR"><!-- Int. Externo -->
									<xsl:if test="orders:LOC/c:C517/c:e3225">
										<xsl:text>7</xsl:text><!-- El codigo de local contiene un 7 de mas en SAP-->
									</xsl:if>
									<xsl:value-of select="orders:LOC/c:C517/c:e3225"/>
								</field>
								<field name="ZMENG"><!-- Cantidad -->
									<xsl:value-of select="orders:QTY/c:C186/c:e6060"/>
								</field>
							</row>
						<!-- </xsl:for-each> -->
					</xsl:for-each>
				</table>
				<!-- -->

			</tables>
		</bapirfc>

	</xsl:template>

</xsl:stylesheet>
