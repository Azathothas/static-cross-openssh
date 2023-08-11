zlib/VERSION := $(shell curl -qfsSL https://api.github.com/repos/madler/zlib/releases | jq -r '.[0].name' | sed 's/[^0-9.]//g')
zlib/TARBALL := https://zlib.net/current/zlib.tar.gz
# zlib/TARBALL := https://zlib.net/zlib-$(zlib/VERSION).tar.gz
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
