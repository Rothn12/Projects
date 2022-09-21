# Pneumatic Control Unit

# Overview
This was a project I did with the MSOE VEX-U team. We had an issue, with the amount of pneumatics we could control, the way in which we currently controlled them, and the cost. So an alumni of the group, Andrew Kempen, had reverse engineered the circuit that VEX used to control the pneumatics. We then took this and put eight of these circuits on a board that was controlled with two RS485 ports from the VEX V5 brain. The pneumatics can now run at either 5V or 12V from the VEX V5 brain. We take power from the smart ports to power the pneumatics, then based on the jumpers will step down the voltage to 5V or keep it at 12V. The signal sent to the board will be read by a MicoMod teensy and will then send a signal to the corresponding pneumatic device. The transmit port is for future versions, and power delivery.

# Initial thoughts
Going into this project neither Asher Sprigler nor I had any experience with PCB design. This made the project initially seem a little daunting. Although, we did have a reference design that Andrew had created the previous year for a different project so we had some confidence. We were both excited to dig into a new area of electronic design and learn new design techniques.

# Takeaways 
My main takeaways from this project was the importance of well documented design, the utility of having multiple eyes on the same project and the wonderful documentation that can be found on datasheets. With our project being started from a reference that Andrew had created, we adopted his schematic layout style. This style was incredibly helpful later on in the project for ourselves and Andrew, who helped verify our designs. This style had us box our components by major component, for example we had a box around our Arduino and the supporting capacitors/connectors and we also had a box around our power delivery, separating 5V and 3.3V. Working on this project side-by-side with Asher was a great experience, because of the work environment we created and the perspectives we were able to bring. There were many instances where either Asher or I would glance over an issue and the other would catch it right away, saving potentially hours of debugging and headaches. Another headache relief was the datasheets. When it came to wiring the switching voltage regulator a very complex task of getting 12V down to 3.3V was made incredibly easy due to the example usages in the datasheets. 

- [MSOE VEX PCB REPO](https://github.com/msoe-vex/pcb-design)

### Project Information
This board was originally created by Nathan Roth and Asher Sprigler, with assistance provided by Andrew Kempen in the 2021-2022 VEX season.
