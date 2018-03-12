################################################################################
#
# hwloc
#
################################################################################

HWLOC_VERSION_MAJOR = 1.11
HWLOC_VERSION = $(HWLOC_VERSION_MAJOR).7
HWLOC_SOURCE = hwloc-$(HWLOC_VERSION).tar.bz2
HWLOC_SITE = http://www.open-mpi.org/software/hwloc/v$(HWLOC_VERSION_MAJOR)/downloads
HWLOC_LICENSE = BSD-3-Clause
HWLOC_LICENSE_FILES = COPYING
HWLOC_DEPENDENCIES = host-pkgconf
HWLOC_INSTALL_STAGING = YES

HWLOC_CONF_OPTS = \
	--disable-nvml \
	--disable-gl \
	--disable-cairo \
	--disable-libxml2 \
	--disable-doxygen

ifeq ($(BR2_PACKAGE_HWLOC_USE_OPENCL),y)
HWLOC_DEPENDENCIES += libopencl
# hwloc do not have an option for explicitly enable OpenCL
# We have to trust there configuration scripts to find OpenCL
ifneq ($(BR2_PACKAGE_PROVIDES_LIBOPENCL),nvidia-driver)
HWLOC_CONF_OPTS += \
	--disable-cuda
endif
else
HWLOC_CONF_OPTS += \
	--disable-opencl \
	--disable-cuda
endif

ifeq ($(BR2_PACKAGE_LIBPCIACCESS),y)
HWLOC_CONF_OPTS += --enable-pci
HWLOC_DEPENDENCIES += libpciaccess
else
HWLOC_CONF_OPTS += --disable-pci
endif

ifeq ($(BR2_PACKAGE_NUMACTL),y)
HWLOC_CONF_OPTS += --enable-libnuma
HWLOC_DEPENDENCIES += numactl
else
HWLOC_CONF_OPTS += --disable-libnuma
endif

$(eval $(autotools-package))
