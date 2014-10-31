#ifndef FLEX_H
 #define FLEX_H
 
 enum {
   TIMER_PERIOD_MILLI = 4000,
   AM_BLINKTORADIO = 10
 
 };
 typedef nx_struct FlexMsg {
  nx_uint16_t nodeid;
  nx_uint16_t flex_value;
  //nx_uint16_t temp_float;
} FlexMsg;
 #endif
