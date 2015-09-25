# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/libapreq2/libapreq2-2.13.ebuild,v 1.5 2011/07/24 13:35:46 xarthisius Exp $

inherit apache-module multilib

DESCRIPTION="webapp module"
SRC_URI="http://127.0.0.1/${P}.tar.gz"
HOMEPAGE="http://httpd.apache.org/webapp/"

LICENSE="Apache-2.0"
SLOT="2"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE="debug"

DEPEND="${DEPEND}"
RDEPEND="${DEPEND}"

APXS2_ARGS="-c -l sqlite3 ${PN}.c -p"
APACHE2_MOD_CONF="99_${PN}"
APACHE2_MOD_DEFINE="WEBAPP"
DOCFILES="CHANGES README INSTALL MANIFEST"

need_apache2


