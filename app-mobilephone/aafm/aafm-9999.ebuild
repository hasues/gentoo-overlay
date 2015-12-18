# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:

EAPI=5
PYTHON_COMPAT=(python2_7)
inherit eutils distutils-r1

if [[ ${PV} =~ [9]{4,} ]]; then
	inherit git-2
	EGIT_REPO_URI="git://github.com/sole/aafm.git
		https://github.com/sole/aafm.git"
fi

DESCRIPTION="Android ADB File Manager"
HOMEPAGE="http://pithos.github.io/"

LICENSE="GPL-3"
SLOT="0"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	dev-util/android-tools
	dev-python/pygtk"


python_test() {
	esetup.py test || die
}
