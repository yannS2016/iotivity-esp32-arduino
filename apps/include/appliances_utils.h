#ifndef APPLIANCES_UTILS_H
#define APPLIANCES_UTILS_H
#include <Arduino.h>       
#define SAMPLING_WINDOW  500   // Duration 0.5 seconds (Approx 25 cycles of 50Hz)

#define GEYSER_STATE    12
#define IRON_STATE    8
#define GEYSER_CURRENT   A2
#define IRON_CURRENT   A3

#define OVEN_STATE    12
#define STOVE_STATE    8
#define OVEN_CURRENT   A2
#define STOVE_CURRENT   A3

#define INIT_GPIO(appliance1, appliance2) \
do {\
	pinMode(appliance1, OUTPUT);\
	pinMode(appliance2, OUTPUT);\
}while(0) 
	
#define POST_STATE(appliance, state) \
do {\
	if(state < 0 || state > 1) { \
		state = 0; \
	}\
	digitalWrite(appliance, state);\
}while(0) 


#ifdef __AVR__
static const int  adc_res = 1023.0;	
static const int  dc_offset_raw = 607; // 509 is the normal value
static const int  adc_vreff = 4932.0;
static const float adc_conv_const = 0.0048211;	 // V/counts	
#else
static const int  adc_res = 4095.0;
static const int  dc_offset_raw = 607; // 509 is the normal value	
static const int  adc_vreff = 3312.0;
static const float adc_conv_const = 0.00323753;	 // V/counts
#endif
static const float voltage = 233.6;	 							


#endif //RESOURCES_UTILS_H
