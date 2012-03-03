TWEAK_NAME = iPadRetina
iPadRetina_FILES = Tweak.x
iPadRetina_FRAMEWORKS = Foundation
iPadRetina_LDFLAGS = -fobjc-gc

ADDITIONAL_CFLAGS = -std=c99 -fobjc-gc

ARCHS = i386 x86_64
TARGET_MACOSX_DEPLOYMENT_VERSION = 10.5

target=macosx

include framework/makefiles/common.mk
include framework/makefiles/tweak.mk
