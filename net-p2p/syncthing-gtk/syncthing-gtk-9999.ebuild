# Copyleft 2016 Fletch Hasues
# Distributed under the terms of the GNU General Public License v2
# $Id$


EAPI=5
PYTHON_COMPAT=(python2_7)
inherit eutils distutils-r1

if [[ ${PV} =~ [9]{4,} ]]; then
	inherit git-2
	EGIT_REPO_URI="git://github.com/syncthing/syncthing-gtk.git
		https://github.com/syncthing/syncthing-gtk.git"
else
	SRC_URI="https://github.com/syncthing/${PN}/tree/${PV}/${PN}.tar.gz"
fi

DESCRIPTION="GTK3 & python based GUI for Syncthing"
HOMEPAGE="https://github.com/syncthing/syncthing-gtk"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="pyinotify libnotify nautilus-python python-caja"
REQUIRED_USE="nautilus-python? ( !python-caja ) python-caja? ( !nautilus-python )"

RDEPEND="
	 x11-libs/gtk+:3
	 dev-python/pygobject:3[${PYTHON_USEDEP},cairo]
	 dev-python/python-dateutil:0[${PYTHON_USEDEP}]
	 sys-process/psmisc:0
	 >=net-p2p/syncthing-0.12"
DEPEND="${RDEPEND}
	 dev-python/setuptools:0[${PYTHON_USEDEP}]"
	
python_test() {
         esetup.py test
}
	 