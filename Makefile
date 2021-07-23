SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := all
.DELETE_ON_ERROR:
.SUFFIXES:

BUILD_DIR := ./build
SRC_DIR := ./src
SRC := Makefile $(shell find $(SRC_DIR))

EXTERNAL_SRC_DIR := ./external
PICO_SDK := $(EXTERNAL_SRC_DIR)/pico-sdk

BUILD_SENTINEL := $(BUILD_DIR)/sentinel

.PHONY:
all: $(BUILD_SENTINEL)

.PHONY:
clean:
	rm -rf $(BUILD_DIR)

$(PICO_SDK)/.git:
	git submodule update --init $(PICO_SDK)

$(PICO_SDK)/lib/tinyusb/.git: $(PICO_SDK)/.git
	git -C $(PICO_SDK) submodule update --init

$(BUILD_DIR):
	mkdir $@

$(BUILD_DIR)/Makefile: $(SRC) $(PICO_SDK)/.git $(PICO_SDK)/lib/tinyusb/.git | $(BUILD_DIR)
	PICO_SDK_PATH=$(abspath $(PICO_SDK)) cmake -S $(SRC_DIR) -B $(BUILD_DIR)

$(BUILD_SENTINEL): $(BUILD_DIR)/Makefile
	make -C $(BUILD_DIR)
	touch $@
