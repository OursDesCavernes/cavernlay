# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
AUTOTOOLS_AUTORECONF="true"
inherit git-r3 autotools-utils

DESCRIPTION="Headless UPnP Renderer"
HOMEPAGE="https://github.com/hzeller/gmrender-resurrect/"
EGIT_REPO_URI="https://github.com/hzeller/gmrender-resurrect.git"

LICENSE="GPL-v2"
SLOT="0"
KEYWORDS="~amd64 ~arm"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
