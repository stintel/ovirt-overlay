# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
SDK_VARIANT="se"
EANT_BUILD_TARGET="package"
EANT_BUILD_XML="build-${SDK_VARIANT}.xml"
JAVA_PKG_BSFIX_NAME="${EANT_BUILD_XML}"
EANT_EXTRA_ARGS="-Dcheckstyle.enabled=false -Dsvn.version=0"
EANT_GENTOO_CLASSPATH="ant-core"

inherit java-pkg-2 java-ant-2

DESCRIPTION="UnboundID LDAP SDK for Java"
HOMEPAGE="https://www.unboundid.com/products/ldap-sdk/"
SRC_URI="https://github.com/UnboundID/ldapsdk/archive/${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="|| ( GPL-2 LGPL-2.1+ UnboundID-LDAPSDK )"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=">=virtual/jdk-1.5:*"
DEPEND="${RDEPEND}"

S="${WORKDIR}/ldapsdk-${PV}"

src_prepare() {
	rm -rf ext/
	sed -i 's/depends="svnversion,/depends="/' build.xml
	java-pkg-2_src_prepare
	java-ant_rewrite-classpath "${EANT_BUILD_XML}"
}

src_compile() {
	java-pkg-2_src_compile
}

src_install() {
	java-pkg_newjar ./build/package/${PN}-*-${SDK_VARIANT}/${PN}-${SDK_VARIANT}.jar ${PN}.jar
}
