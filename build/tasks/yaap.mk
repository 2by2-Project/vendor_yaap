YAAP_TARGET_PACKAGE := $(PRODUCT_OUT)/$(CUSTOM_VERSION).zip
SHA256 := prebuilts/build-tools/path/$(HOST_PREBUILT_TAG)/sha256sum

.PHONY: otapackage yaap bacon
otapackage: $(INTERNAL_OTA_PACKAGE_TARGET)
yaap: otapackage
	$(hide) mv $(INTERNAL_OTA_PACKAGE_TARGET) $(YAAP_TARGET_PACKAGE)
	$(hide) $(SHA256) $(YAAP_TARGET_PACKAGE) | cut -d ' ' -f1 > $(YAAP_TARGET_PACKAGE).sha256sum
	$(hide) source ./vendor/yaap/tools/generate_json_build_info.sh $(YAAP_TARGET_PACKAGE)
	$(hide) mkdir -p vendor/2by2-ota/$(YAAP_BUILD)/
	$(hide) cp $(PRODUCT_OUT)/$(YAAP_BUILD).json vendor/2by2-ota/$(YAAP_BUILD)/$(YAAP_BUILD).json
	@echo -e ""
	@echo -e "2by2 Project OTA package build completed."
	@echo -e ""
	@echo -e "zip: "$(YAAP_TARGET_PACKAGE)
	@echo -e "sha256: `cat $(YAAP_TARGET_PACKAGE).sha256sum | cut -d ' ' -f 1`"
	@echo -e "size: `ls -lah $(YAAP_TARGET_PACKAGE) | cut -d ' ' -f 5`"
	@echo -e ""

bacon: yaap
