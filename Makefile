include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Chronofeed
Chronofeed_FILES = Tweak.xm
Chronofeed_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 Instagram"
