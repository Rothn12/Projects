# Pneumatics Control Board

# Overview
This was a project that I did in collaboration with a current member of the MSOE VEX team, Asher Sprigler, and a former member of the MSOE VEX team Andrew Kempen. We undertook this project to alleviate the need to buy 8 $15 pneumatic control cables, and to act as a first step towards creating a connector board that allows us to use a more powerful brain for processing.

# Initial thoughts
Going into this project I had no experience with creating custom PCBs, so I did not know what to expect when it came to making traces, making ground planes (or even what a ground plane was), or how to use vias.

# Borrowed parts
The design process started smoothly, we had a general outline of what we needed the board to do, so we drew up a basic block diagram on a white board. Next we created a block diagram schematic. We started by grabbing some of the components from a previous project, designed by Andrew, for the RS485 input and output, the USB port, and pneumatic control circuit. 

# Changes made/New parts
We then needed to change the pneumatic control circuit to accept a dc signal rather than a PWM signal. Then we needed to find a new chip to handle the RS485 to UART conversion, the original chips only did either transmit or receive, the new one is able to do both. We then focused on the microcontroller we were basing our design around, we chose to use a MicroMod Teenst. This board had most of the functionality of a teensy 4.1, but used a standard m.2 connector. We chose this microcontroller for its form factor and power. 

# Power
To power the teensy we needed a 3.3V source. We knew that the VEX brain’s RS485 supplies around 12V, so we used a switching voltage regulator to step the voltage down to 3.3V @ 2.5A. We used a switching voltage regulator because a linear voltage regulator would have gotten too hot. Then we needed a 5V supply for our pneumatics, in this case we could use a linear voltage regulator that allowed us to use less components. These linear voltage regulators supplied 5V @ 0.5A, and the pneumatics circuits could draw 100mA so we needed two of these linear voltage regulators. 

# What it does
The VEX V5 brain will send a byte over a RS485 port, this then is converted to UART and sent to the teensy over UART. The teensy then would turn on the corresponding pneumatics control circuit, the first circuit corresponding the 0th bit, the second to the 1st bit, and so on. 

# Takeaways 
My main takeaway was the PCB design process. Asher and I were lucky enough to be guided through this process by Andrew. He gave us advice on component choice, and capacitor placement as well as reasoning for those choices. It strengthened my knowledge of circuit design and creative thinking when it comes to creating custom PCBs to save money.
