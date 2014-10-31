/** LDR_C.nc
 * Main code for the LDR demo application.
 *
 */
#include<math.h>
#include "flex.h"
module Flex_C
{
 
 uses interface Boot;
   uses interface Leds;
   uses interface Timer<TMilli> as Timer0;
   uses interface Packet;
   uses interface AMPacket;
   uses interface AMSend;
  uses interface SplitControl as AMControl;
   uses interface Read<uint16_t>;                          // provided by MainC to start the scheduler 
 
}

implementation
{

 bool busy = FALSE;
   message_t pkt;
   int count=1;
   uint16_t analog_val;
	 /* At boot time, start the periodic timer and the radio */
	 event void Boot.booted() 
	 {
	  call AMControl.start();
	 }
		  event void AMControl.startDone(error_t err) {
			    if (err == SUCCESS) {
			      call Timer0.startPeriodic(TIMER_PERIOD_MILLI);
			    }
			    else {
			      call AMControl.start();
			    }
		  }

  event void AMControl.stopDone(error_t err) {
  }


	 event void Timer0.fired() {
	   
	   	    call Read.read();  
	     
		    if (!busy) {
		    
		    FlexMsg* btrpkt = (FlexMsg*)(call Packet.getPayload(&pkt, sizeof (FlexMsg)));
		    if(count==1)
		    btrpkt->nodeid = TOS_NODE_ID;

		    btrpkt->flex_value = analog_val;
		    
		    

		    //btrpkt->temp_float=decimal;
			    //if(count==10) 
			    {
			    		if (call AMSend.send(AM_BROADCAST_ADDR, &pkt, sizeof(FlexMsg)) == SUCCESS) 
			      		busy = TRUE;
                              // count=1; 
			    }
	
		    //count++;

		    }
	 }
 
 

	 event void AMSend.sendDone(message_t* msg, error_t error) {
	    if (&pkt == msg) {
	      busy = FALSE;
	    }
	  }
 
	 event void Read.readDone(error_t ok, uint16_t val) 
	 {

	   if(ok== SUCCESS){        
		 analog_val=val;
		
	    call Leds.led2Toggle();
	   
	   }
	 }     
    
   
          
  
}



