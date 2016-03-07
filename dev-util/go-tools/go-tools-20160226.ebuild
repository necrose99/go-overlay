# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

GOLANG_PKG_IMPORTPATH="github.com/golang"
GOLANG_PKG_IMPORTPATH_ALIAS="golang.org/x"
GOLANG_PKG_NAME="${PN/go-}"
GOLANG_PKG_VERSION="8b178a93c1f5b5c8f4e36cd6bd64e0d5bf0ee180"
GOLANG_PKG_IS_MULTIPLE=1
GOLANG_PKG_USE_GENERATE=1
GOLANG_PKG_HAVE_TEST=1

# Declare dependencies
GOLANG_PKG_DEPENDENCIES=(
	"github.com/golang/net:b6d7b13 -> golang.org/x"
	"github.com/golang/protobuf:1270911"
	"github.com/golang/appengine:75a29a6"
	"github.com/GoogleCloudPlatform/gcloud-golang:137f428"
)

inherit golang-single

DESCRIPTION="Various packages and tools that support the Go programming language"
HOMEPAGE="https://${GOLANG_PKG_IMPORTPATH}/${PN}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86 arm"

DEPEND="!dev-go/go-tools"

# FIX for unit testing
GOLANG_PKG_VENDOR=(
	"${S}"
)

src_prepare() {
	golang-single_src_prepare

	golang_fix_importpath_alias \
		"github.com/golang/appengine" \
		"google.golang.org/appengine"

	golang_fix_importpath_alias \
		"github.com/GoogleCloudPlatform/gcloud-golang" \
		"google.golang.org/cloud"
}

src_install() {
	golang-single_src_install

	# Fixes a file collision with dev-ruby/bundler
	# (see github.com/Dr-Terrible/go-overlay/issues/22)
	mv "${ED}"/usr/bin/bundle "${ED}"/usr/bin/gobundle || die
}