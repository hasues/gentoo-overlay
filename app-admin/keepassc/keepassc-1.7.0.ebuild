# Copyright 2015 HazLabs
# Distributed under the terms of the GNU General Public License v2
# $Header: 
EAPI=5
PYTHON_COMPAT=( python{3_3,3_4} )

inherit python-r1 eutils git-2 distutils-r1

EGIT_REPO_URI="git://github.com/raymontag/keepassc.git"
EGIT_MASTER="master"

DESCRIPTION="KeePassC is a password manager fully compatible to KeePass v.1.x and KeePassX."
HOMEPAGE="http://raymontag.github.io/keepassc/"
SRC_URI=""

LICENSE="GPL-3"
SRC_UI=""
SLOT="1"
KEYWORDS="~amd64 ~x86"
IUSE="xsel"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	xsel? ( x11-misc/xsel )
	dev-python/kppy"
	

python_test() {
	esetup.py test || die
}
