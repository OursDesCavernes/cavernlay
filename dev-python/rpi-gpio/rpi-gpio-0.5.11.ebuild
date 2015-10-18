# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python3_4 )

inherit distutils-r1 flag-o-matic

DESCRIPTION="This package provides a class to control the GPIO on a Raspberry Pi"
HOMEPAGE="https://pypi.python.org/pypi/RPi.GPIO/"
SRC_URI="https://pypi.python.org/packages/source/R/RPi.GPIO/RPi.GPIO-${PV}.tar.gz"

LICENSE="gpl-2"
SLOT="0"
KEYWORDS="amd64 x86 arm"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	app-arch/gzip
	app-arch/tar
	dev-python/setuptools[${PYTHON_USEDEP}]"

S="${WORKDIR}/RPi.GPIO-${PV}"

python_configure_all() {
	append-cxxflags -fno-strict-aliasing
}
