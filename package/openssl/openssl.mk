# Use Curl + jq + GitHub API to always fetch @latest Version
openssl/VERSION := $(shell curl -qfsSL https://api.github.com/repos/openssl/openssl/releases | jq -r '.[0].name' | sed 's/[^0-9.]//g')
#openssl/VERSION := 1.1.1u
openssl/TARBALL := https://www.openssl.org/source/openssl-$(openssl/VERSION).tar.gz
# We can also use these alt channels: 
# openssl/TARBALL := https://github.com/openssl/openssl/releases/download/openssl-$(openssl/VERSION)/openssl-$(openssl/VERSION).tar.gz
# openssl/TARBALL := $( shell curl -qfsSL https://api.github.com/repos/openssl/openssl/releases/latest | jq -r '.tarball_url')

openssl/dir = $(build_dir)/openssl/openssl-$(openssl/VERSION)

define openssl/build :=
	+cd '$(openssl/dir)'
	./Configure --prefix="$(prefix)" --cross-compile-prefix="$(host_triplet)-" \
		no-shared no-asm linux-elf
	'$(MAKE)'
endef

define openssl/install :=
	+'$(MAKE)' -C '$(openssl/dir)' install DESTDIR='$(staging_dir)'
endef
