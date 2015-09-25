# Copyright 2014 Julian Ospald <hasufell@posteo.de>
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

#inherit git-r3

#MY_PN=${PN%-data}

DESCRIPTION="Data files for h-craft"
HOMEPAGE="http://h-craft"
#EGIT_REPO_URI="https://github.com/OpenDungeons/OpenDungeons-media-source.git"
SRC_URI="http://data.oursdescavernes.fr/${P}.tar.xz"

LICENSE="GPL-3 CC-BY-SA-3.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="demo linguas_ru"

S="${S}/media"
src_install() {
	insinto /usr/share/h-craft
	doins -r *
}

