# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 python3_4 )

inherit distutils-r1 flag-o-matic git-r3

DESCRIPTION="Python bindings for DeepCL"
HOMEPAGE="http://deepcl.hughperkins.com/"
EGIT_REPO_URI="https://github.com/hughperkins/DeepCL.git"
if [ "${PV%9999}" = "${PV}" ]; then
	EGIT_COMMIT="v${PV}"
else
	EGIT_COMMIT="HEAD"
fi

LICENSE="MPL"
SLOT="0"
KEYWORDS="amd64 x86 arm"
IUSE=""

RDEPEND="=sci-libs/deepcl-${PV}
	dev-python/numpy"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

S="${S}/python/"

python_configure_all() {
	append-cxxflags -I/usr/include/deepcl -I/usr/include/easycl
}
