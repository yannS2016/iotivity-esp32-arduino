### PROJECT_DIR
UPLOAD_PORT = /dev/ttyUSB0 
CHIP = esp32
BUILD_DIR = $(PWD)/
ARDUINO_ROOT=$(HOME)/arduino-home
ESP_ROOT = $(HOME)/Arduino/hardware/espressif/esp32
IOTIVITY_LITE   = adapter/iotivity-lite
ESPMK = $(HOME)/makeEspArduino

ifeq ($(APP),server)
  #LOCAL_CPP_SRCS 	+= server_arduino_master.cpp	
	SKETCH   = $(PWD)/apps/server/server_esp32.ino
  BUILD_EXTRA_FLAGS 	+= -DOC_SERVER
  TARGET = $(ARCH)_server
	BUILD_DIR = $(PWD)/build-server
else ifeq ($(APP),client)
  BUILD_EXTRA_FLAGS 	+= -DOC_CLIENT
  SKETCH     = $(PWD)/apps/client/client.ino	
  TARGET = $ARCH_client	
	BUILD_DIR = $(PWD)/build-server
else
$(error Must define an app server/client to proceed!)	
endif

ifeq ($(DYNAMIC),1)
	BUILD_EXTRA_FLAGS += -DOC_DYNAMIC_ALLOCATION
endif

ifeq ($(IPV4),1)
	BUILD_EXTRA_FLAGS += -DOC_IPV4
endif
BUILD_THREADS = 2

LIBS += $(ARDUINO_ROOT)/libraries/Time

DEPS_HEADERS  =$(addprefix deps/, pRNG  wiz5500 sdFat serial)
CORE_HEADERS  =$(addprefix $(IOTIVITY_LITE)/, messaging/coap util util/pt include  api port .)

INCLUDE_DIRS += $(PWD)/apps/include  $(PWD)/adapter $(CORE_HEADERS) $(DEPS_HEADERS)

include $(ESPMK)/makeEspArduino.mk