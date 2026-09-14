# Rebuild all recovered Nintendo retail firmware variants.
VERSIONS := v1 v2 v3 v4 v5 v6 v7 ique_v1 ique_v2 kor_v1

.PHONY: all verify-firmware clean $(VERSIONS) $(addprefix verify-,$(VERSIONS))
.DEFAULT_GOAL := all

all: $(VERSIONS)

$(VERSIONS):
	$(MAKE) -C $@

define VERIFY_VERSION
verify-$(1):
	$(MAKE) -C $(1) verify-firmware
endef
$(foreach VERSION,$(VERSIONS),$(eval $(call VERIFY_VERSION,$(VERSION))))

verify-firmware: $(addprefix verify-,$(VERSIONS))

clean:
	@for version in $(VERSIONS); do $(MAKE) -C $$version clean; done
