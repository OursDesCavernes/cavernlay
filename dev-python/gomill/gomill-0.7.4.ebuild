# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 flag-o-matic

DESCRIPTION="Python tools for the game of Go"
HOMEPAGE="http://mjw.woodcraft.me.uk/gomill/"
SRC_URI="http://mjw.woodcraft.me.uk/gomill/download/gomill-${PV}.tar.gz"

LICENSE="gpl-2"
SLOT="0"
KEYWORDS="amd64 x86 arm"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

#S="${WORKDIR}/gomill-${PV}/gomill_setup/"

#python_configure_all() {
#	append-cxxflags -fno-strict-aliasing
#}
