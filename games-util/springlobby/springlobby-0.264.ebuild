# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

WX_GTK_VER="3.0"
inherit cmake-utils eutils flag-o-matic wxwidgets

DESCRIPTION="Lobby client for spring rts engine"
HOMEPAGE="http://springlobby.info"
SRC_URI="http://www.springlobby.info/tarballs/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="mirror"
IUSE="debug +libnotify +nls"

RDEPEND="
	>=dev-libs/boost-1.35
	media-libs/alure
	net-misc/curl
	x11-libs/wxGTK:$WX_GTK_VER[X]
	libnotify? ( x11-libs/libnotify )
"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
"

pkg_setup() {
	setup-wxwidgets
}

src_configure() {
	local mycmakeargs=(
		-DOPTION_TRANSLATION_SUPPORT=$(usex nls ON OFF)
		-DOPTION_NOTIFY=$(usex libnotify ON OFF)
		-DAUX_VERSION="(Gentoo,$ARCH)"
		)
	cmake-utils_src_configure
}
