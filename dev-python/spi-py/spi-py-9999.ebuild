# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python3_4 )

inherit distutils-r1 flag-o-matic git-r3

DESCRIPTION="Hardware SPI as a C Extension for Python"
HOMEPAGE="https://github.com/lthiery/SPI-Py"
EGIT_REPO_URI="https://github.com/lthiery/SPI-Py.git"
EGIT_BRANCH="master"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86 arm"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	dev-vcs/git
	dev-python/setuptools[${PYTHON_USEDEP}]"

python_configure_all() {
	append-cxxflags -fno-strict-aliasing
}
