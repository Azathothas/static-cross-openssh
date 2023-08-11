# Use Curl + jq + GitHub API to always fetch @latest Version
zlib/VERSION := $(shell curl -qfsSL https://api.github.com/repos/madler/zlib/releases | jq -r '.[0].name' | sed 's/[^0-9.]//g')
#zlib/VERSION := 1.2.13
# zlib provides a `current` URL to always downlad latest Source
zlib/TARBALL := https://zlib.net/current/zlib.tar.gz
#zlib/TARBALL := https://zlib.net/zlib-$(zlib/VERSION).tar.gz
# We can also use this alt channel:
# zlib/TARBALL := https://github.com/madler/zlib/releases/download/v$(zlib/VERSION)/zlib-$(zlib/VERSION).tar.gz

zlib/dir = $(build_dir)/zlib/zlib-$(zlib/VERSION)

define zlib/build :=
	+cd $(zlib/dir)
	CHOST=$(host_triplet) ./configure --prefix="$(prefix)" --static
	'$(MAKE)'
endef

define zlib/install :=
	+'$(MAKE)' -C '$(zlib/dir)' install DESTDIR='$(staging_dir)'
endef
