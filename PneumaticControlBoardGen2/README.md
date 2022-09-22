# Pneumatic Control Unit Gen 2

# Overview
This was a project I assisted with the MSOE VEX-U team. We had an issue, with the amount of pneumatics we could control, the way in which we currently controlled them,  the cost, and the terribly slow VEX V5 brain. This project was based on my pneumatic control unit, it was part of a senior design project by a senior at the time Julian Singkham. All of my board was kept, Julian had just added additional functionality. One of the larger goals a founder of our young VEX U team had, was to get A.I. to run our robot. This could not be accomplished with the VEX V5 brain, it just did not have the power. So we needed an external processor, this is where this gen 2 board comes in. This board will act as an interconnect between our external processor and our VEX V5 brain. The schematic and part selection was done by Julian, but he ran out of time and did not finish the PCB layout. That is where I picked this up at, I finished the PCB layout and added one more 5V linear regulator to provide a little more current.

# Initial thoughts
Going into this project I was pumped to start this realization of our founders dream. At this point I had a good amount of PCB design knowledge under my belt, so I was very confident. 

# Takeaways 
My main takeaways from this project was the importance of well documented design and the utility of having multiple layers on a more complex board. This project was super easy to pick up because of this design standard we had. It was easy to know what parts were grouped together, why they were chosen and I was also able to find a current supply issue that was missed. This was also the first board I started as a 4 layer board. This was so nice, it allowed me to make more planes than just 5V and GND, this really cleaned up the trace routing. The traces were also cleaned up because I could route them in more layers, which I did not realize until half way into the design, this really let me properly space my traces and avoid via hopping as much as I could.


- [MSOE VEX PCB REPO](https://github.com/msoe-vex/pcb-design)

### Project Information
This board was originally created by Julian Singkham, then finished by Nathan Roth and Asher Sprigler, with assistance provided by Andrew Kempen in the 2021-2022 VEX season.
