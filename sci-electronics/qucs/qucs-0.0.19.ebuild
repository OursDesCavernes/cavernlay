# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit autotools-utils flag-o-matic toolchain-funcs

DESCRIPTION="Quite Universal Circuit Simulator in Qt4"
HOMEPAGE="http://qucs.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="-doc"

RDEPEND="dev-qt/qtcore[qt3support]
	dev-qt/qtgui[qt3support]
	dev-qt/qt3support
	x11-libs/libX11
	>=sys-devel/bison-2.6
	sci-mathematics/octave"
DEPEND="${RDEPEND}"

AUTOTOOLS_IN_SOURCE_BUILD=1

export QT_SELECT="qt4"

src_configure() {
	# the package doesn't use pkg-config on Linux, only on Darwin
	# very smart of upstream...
	append-ldflags $( $(tc-getPKG_CONFIG) --libs-only-L \
			QtCore QtGui QtXml Qt3Support )
	local myeconfargs=(
		$(use_enable doc)
	)
	autotools-utils_src_configure
}
