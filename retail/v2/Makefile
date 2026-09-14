DSOFW_ROOT ?= ../..
TOOLS_ROOT ?= $(DSOFW_ROOT)/tools
INCLUDE_ROOT ?= $(DSOFW_ROOT)/include
REPOSITORY_ROOT ?= $(DSOFW_ROOT)/../dscfw
include $(INCLUDE_ROOT)/build-common.mk

OUTPUT := official_v2.bin
IMAGE_SIZE := 256K
CRC32_END := 0x3F6D0
CRC32_EXPECTED := $(strip $(file <$(REPOSITORY_ROOT)/official_v2.crc32))

.PHONY: all assemble pack verify-firmware clean
.DEFAULT_GOAL := all
all: pack
assemble:
	mkdir -p build tmp
	$(ARMIPS) src/main.s
pack: assemble
	$(DSFWTOOL) -c $(OUTPUT) --layout layout.ld -h build/h.bin -s $(IMAGE_SIZE) -p1 -comp -encrypt build/p1.bin -p2 -comp -encrypt build/p2.bin -p3 -comp build/p3.bin -p4 -comp build/p4.bin -p5 -comp build/p5.bin
verify-firmware: pack
	$(MAKE) -C "$(TOOLS_ROOT)/crc"
	"$(CRC_TOOL)" crc32-official --image "$(OUTPUT)" --range-end "$(CRC32_END)" --private-fill-start "$(OFFICIAL_PRIVATE_FILL_START)" --private-fill-end "$(OFFICIAL_PRIVATE_FILL_END)" --expected "$(CRC32_EXPECTED)"
clean:
	rm -rf build tmp
	rm -f $(OUTPUT)
