################################################################################
#
# qt5virtualkeyboard
#
################################################################################

QT5VIRTUALKEYBOARD_VERSION = $(QT5_VERSION)
QT5VIRTUALKEYBOARD_SITE = $(QT5_SITE)
QT5VIRTUALKEYBOARD_SOURCE = qtvirtualkeyboard-opensource-src-$(QT5VIRTUALKEYBOARD_VERSION).tar.xz
QT5VIRTUALKEYBOARD_DEPENDENCIES = qt5base qt5declarative qt5svg
QT5VIRTUALKEYBOARD_INSTALL_STAGING = YES

QT5VIRTUALKEYBOARD_LICENSE = GPLv3
QT5VIRTUALKEYBOARD_LICENSE_FILES = LICENSE.GPL3
define QT5VIRTUALKEYBOARD_CONFIGURE_CMDS
	(cd $(@D); $(TARGET_MAKE_ENV) $(HOST_DIR)/usr/bin/qmake)
endef

define QT5VIRTUALKEYBOARD_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define QT5VIRTUALKEYBOARD_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) install
endef

define QT5VIRTUALKEYBOARD_INSTALL_TARGET_CMDS
	cp -dpfr $(STAGING_DIR)/usr/qml/QtQuick/VirtualKeyboard $(TARGET_DIR)/usr/qml/QtQuick
	cp -dpfr $(STAGING_DIR)/usr/lib/qt/plugins/platforminputcontexts $(TARGET_DIR)/usr/lib/qt/plugins
endef

$(eval $(generic-package))
