/**LDR_AppC.nc
 * Top-level configuration for node code for the LDR demo app.
 * Instantiates the sensors and does all the necessary wiring.
 *
 */


configuration Flex_AppC { }
implementation
{
   components MainC;
   components LedsC;
   components Flex_C;
   components new TimerMilliC() as Timer0;
   components ActiveMessageC;
   components new AMSenderC(AM_BLINKTORADIO);
 


   
 

 Flex_C.Packet -> AMSenderC;
  Flex_C.AMPacket -> AMSenderC;
  Flex_C.AMSend -> AMSenderC;
  Flex_C.AMControl -> ActiveMessageC;
  

  Flex_C.Boot -> MainC.Boot;
  Flex_C.Timer0 -> Timer0;
  Flex_C.Leds -> LedsC;

  /* Instantiate, wire MDA100 sensor board components. */
  components new myBatteryC();
  Flex_C.Read -> myBatteryC;
}

