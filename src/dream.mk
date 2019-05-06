# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := dream
$(PKG)_WEBSITE  := https://drm.sourceforge.io/
$(PKG)_DESCR    := dream
$(PKG)_VERSION  := 2.2
$(PKG)_CHECKSUM := 74fffee82af21fe3a58c341cac6695026ac0070657960db373d0fb043d66c7d8
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)_$($(PKG)_VERSION).orig.tar.gz
$(PKG)_URL      := https://$(SOURCEFORGE_MIRROR)/project/drm/$(PKG)/$($(PKG)_VERSION)/$($(PKG)_FILE)
$(PKG)_QT_DIR   := qt5
$(PKG)_DEPS     := cc qwt fdk-aac fftw hamlib libsndfile opus qwt speexdsp winpcap zlib

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://sourceforge.net/projects/drm/files/dream/' | \
    $(SED) -n 's,.*/projects/.*/\([0-9][^"]*\)/".*,\1,p' | \
    head -1
endef

define $(PKG)_BUILD
    # build
    cd '$(1)' && $(PREFIX)/$(TARGET)/$($(PKG)_QT_DIR)/bin/qmake
    $(MAKE) -C '$(1)' -f 'Makefile.Release' -j '$(JOBS)' install
    cp $(PKG).exe /opt/mxe

endef
