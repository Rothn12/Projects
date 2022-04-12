# IOT Temperature Sensor

# Overview
This was a project that I did during a hack-a-thon at Direct Supply. While this was a time to work on personal projects, projects related to the business was encouraged. So I tried to merge the two with this simple IOT temperature sensor. I also used this as an opportunity to dip my toes into embedded programming in python. 

I was initially expecting a challenge when transitioning from embedded development using C to using python, but the transition ended up being smooth. Python has a similar structure to C which made the transition relatively smooth, with only needing to look up a few syntax differences. Unlike my embedded courses, I was able to use existing libraries. These existing libraries were a big help in making the development painless. 

# What it does
The temperature sensor is using a thermistor circuit and an ADC. The raspberry pi read the data off the ADC using 12c. If the raspberry pi read a temperature that was either too hot or too cold, it would send an email with details of what the temperature was and what time it recorded that temperature, it will send another email every 10 seconds if the temperature does not change. 

# Takeaways 
My main takeaway from this project was just how powerful of a tool python can be. Before this project I had used python in small games that I could make in an hour or so, or for a deep learning class that I took. This project showed me that I could leverage python's widespread adoption for higher level services and its ability to interface with hardware, and bring them together to make a more powerful embedded system.

- [Prewritten Code](https://github.com/Freenove/Freenove_Ultimate_Starter_Kit_for_Raspberry_Pi) - Code and libraries included with the raspberry pi kit I bought
- [AWS SES documentation](https://aws.amazon.com/ses/) - Information about SES
- [Boto3 Documentation](https://boto3.amazonaws.com/v1/documentation/api/latest/index.html) - The library for interfacing with AWS
