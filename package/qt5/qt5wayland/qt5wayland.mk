################################################################################
#
# qt5wayland
#
################################################################################

QT5WAYLAND_VERSION = $(QT5_VERSION)
QT5WAYLAND_SITE = $(QT5_SITE)
QT5WAYLAND_SOURCE = qtwayland-opensource-src-$(QT5WAYLAND_VERSION).tar.xz
QT5WAYLAND_DEPENDENCIES = qt5base qt5declarative wayland
ifeq ($(BR2_PACKAGE_HAS_LIBEGL),y)
QT5WAYLAND_DEPENDENCIES += libegl
endif
QT5WAYLAND_INSTALL_STAGING = YES

define QT5WAYLAND_CONFIGURE_CMDS
	(cd $(@D); $(TARGET_MAKE_ENV) $(HOST_DIR)/usr/bin/qmake)
endef

define QT5WAYLAND_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define QT5WAYLAND_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) install
endef

define QT5WAYLAND_INSTALL_TARGET_EXAMPLES
	if [ -d $(STAGING_DIR)/usr/lib/qt/examples/ ] ; then \
		mkdir -p $(TARGET_DIR)/usr/lib/qt/examples ; \
		cp -dpfr $(STAGING_DIR)/usr/lib/qt/examples/* $(TARGET_DIR)/usr/lib/qt/examples ; \
	fi
endef


define QT5WAYLAND_INSTALL_TARGET_CMDS
	cp -dpf $(STAGING_DIR)/usr/lib/libQt5Wayland*.so* $(TARGET_DIR)/usr/lib
	cp -dpfr $(STAGING_DIR)/usr/lib/qt/plugins/wayland-* $(TARGET_DIR)/usr/lib/qt/plugins
	cp -dpf $(STAGING_DIR)/usr/lib/qt/plugins/platforms/libqwayland-*.so $(TARGET_DIR)/usr/lib/qt/plugins/platforms
	cp -dpfr $(STAGING_DIR)/usr/qml* $(TARGET_DIR)/usr
	$(QT5WAYLAND_INSTALL_TARGET_EXAMPLES)
endef

$(eval $(generic-package))
