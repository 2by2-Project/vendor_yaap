YAAP_FASTBOOT_PACKAGE := $(PRODUCT_OUT)/$(CUSTOM_VERSION)-img.zip

.PHONY: updatepackage yaap-fastboot
updatepackage: $(INTERNAL_UPDATE_PACKAGE_TARGET)
yaap-fastboot: updatepackage
	$(hide) mv $(INTERNAL_UPDATE_PACKAGE_TARGET) $(YAAP_FASTBOOT_PACKAGE)
	@echo -e ""
	@echo -e "2by2 Project fastboot package build completed."
	@echo -e ""
	@echo -e "zip: "$(YAAP_FASTBOOT_PACKAGE)
	@echo -e "size: `ls -lah $(YAAP_FASTBOOT_PACKAGE) | cut -d ' ' -f 5`"
	@echo -e ""
