# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := dream
$(PKG)_WEBSITE  := https://drm.sourceforge.io/
$(PKG)_DESCR    := dream
$(PKG)_VERSION  := 2.2
$(PKG)_CHECKSUM := f7211ee3c19b42116b6d1f999d45007c1a9e62fee92906aa37d56eb00219ef56
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
    cd $(BUILD_DIR) && $(PREFIX)/$(TARGET)/$($(PKG)_QT_DIR)/bin/qmake $(SOURCE_DIR)/dream.pro
    cd $(BUILD_DIR) && $(MAKE) -f 'Makefile.Release' -j '$(JOBS)'
    cd $(BUILD_DIR) && $(MAKE) -f 'Makefile.Release' -j '$(JOBS)' install
endef
