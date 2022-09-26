# ROS serial over the VEX V5 brain's RS485 ports

# Overview
This was a project I did with the MSOE VEX-U team. A previous member, Andrew Kempen, had created a RS485 to usb PCB that needed to be tested. So I took over this project when I joined. I first had to verify the PCB was functioning as intended. To test this I had connected the USB to my computer, and wired the rx port to the tx port on the PCB. I then opened realterm, this is a program that allows someone to send/view data on the serial port. We used this program in our embedded 2 course to see our print to console. I opened the port that the USB was plugged into and sent a keypress, I then watched it return to the console. I then had to get the VEX V5 brain to communicate with serial over its RS485 ports, while it was running the Robot Operating System (ROS). There was some starter code, but it was not functioning properly. To fix what was there I had to make a few variables into pointers, then I needed to fix the ring buffer and timing of the sent and received bytes. 

# Initial thoughts
Going into this project I had a year of experience with C, but limited experience with C++. Although I was not intimidated with the project because of my experience with C. I was also very comfortable with debugging hardware because of my embedded systems courses.

# Takeaways 
My main takeaways from this project was the importance of documentation and not overcomplicating tests if I don’t need to. A lot of the information I needed to understand how to communicate with serial over the RS485 port was very well documented by Purdue, who make PROS which is an abstraction of the VEX SDK. This really cut down on the digging I needed to do, because of how it is laid out. My initial thought on testing the PCB was writing a program in C to interface with my USB ports in a windows environment. I did not know how daunting of a task that was until I was researching windows API calls. I then thought about that program that we used to monitor our USB ports in embedded systems 2, and used that instead. That saved me a lot of time.

- [ROS serial REPO](https://github.com/ros-drivers/rosserial)
- [My PR, I changed the V5RS485.h file](https://github.com/ros-drivers/rosserial/pull/580/files)
