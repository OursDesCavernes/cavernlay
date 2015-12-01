# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 python3_4 )

inherit git-r3 distutils-r1

DESCRIPTION="A lightweight streaming server which brings DLNA / UPNP and Chromecast support to PulseAudio and Linux."
HOMEPAGE="https://github.com/masmu/pulseaudio-dlna"
EGIT_REPO_URI="https://github.com/masmu/pulseaudio-dlna.git"


LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-python/virtualenv
		dev-python/netifaces[${PYTHON_USEDEP}]
		dev-python/psutil[${PYTHON_USEDEP}]
		dev-python/notify2[${PYTHON_USEDEP}]
		dev-python/setproctitle[${PYTHON_USEDEP}]
		dev-python/docopt[${PYTHON_USEDEP}]
		dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

