#!/usr/bin/env python3
########################################################################
# Filename    : IOTtempSensor.py
# Description : A thermometer that will alert via email when a
#               temperature is too high or too low
# Author      : Nathan Roth
# modification: 06/03/2021
########################################################################
import RPi.GPIO as GPIO
import time
import math
from ADCDevice import *
from PCF8574 import PCF8574_GPIO
from Adafruit_LCD1602 import Adafruit_CharLCD
from time import sleep, strftime
from datetime import datetime
import smtplib
from email.mime.text import MIMEText
import urllib.request

# Define an ADCDevice class object
adc = ADCDevice()

########################################################################
# Function: setup()
# Purpose: to set up the adc's I2C connection
#          it will check for one of two possible chips, then set the
#          ADC to that chip
# Arguments:
#           none
# Returns:
#           none
########################################################################
def setup():
    global adc
    # Detect the pcf8591.
    if(adc.detectI2C(0x48)):
        adc = PCF8591()
    # Detect the ads7830
    elif(adc.detectI2C(0x4b)):
        adc = ADS7830()
    else:
        print("No correct I2C address found, \n"
        "Please use command 'i2cdetect -y 1' to check the I2C address!"
        "\n"
        "Program Exit. \n")
        exit(-1)

########################################################################
# Function: email(temp)
# Purpose: to email important users that the temperature is too high
# Arguments:
#           temperature - a string of the current temperature
# Returns:
#           none
########################################################################
def email(temp):
    sender = 'nathand12roth@gmail.com'
    receiver = 'test.client.nathan@gmail.com'

    msg = MIMEText('The temperature in the room has reached an unsafe'+
                   ' level. \n' +
                   'It is currently ' + temp + ' \n' +
                   'At ' + get_time_now())

    msg['Subject'] = 'UNSAFE TEMPERATURE'
    msg['From'] = 'nathand12roth@gmail.com'
    msg['To'] = 'test.client.nathan@gmail.com'

    user = 'AKIA4MSHZC43BLIFMWH4'
    password = 'BOxbP94WsziQQc3W0bek3DKXsQcEe3lVjuSkXOggt72l'

    with smtplib.SMTP("email-smtp.us-east-1.amazonaws.com", 587) as server:

        server.starttls()

        server.login(user, password)
        server.sendmail(sender, receiver, msg.as_string())
        print("mail successfully sent")

########################################################################
# Function: get_tempF()
# Purpose: Gets the current temperature in Fahrenheit, and if the
#          temperature is greater than 85F or lower than 68F then
#          an email will be sent to the appropriate users
# Arguments:
#           none
# Returns:
#           CurrentTemp - The Current temperature as a string
########################################################################
def get_tempF():
    tempK = calculate_K()
    # calculate temperature (fahrenheit)
    tempF = ((tempK - 273.15 ) * 1.8) + 32
    currentTemp = '{:.2f}'.format( tempF ) + ' F'
    if(tempF > 85 or tempF < 64):
        time_check(currentTemp)
    return currentTemp

########################################################################
# Function: get_tempC()
# Purpose: Gets the current temperature in Fahrenheit, and if the
#          temperature is greater than 29.5C or lower than 17.8C
#          then an email will be sent to the appropriate users
# Arguments:
#           none
# Returns:
#           CurrentTemp - The Current temperature as a string
########################################################################
def get_tempC():
    tempK = calculate_K()
    # calculate temperature (Celsius)
    tempC = tempK - 273.15
    currentTemp = '{:.2f}'.format( tempC ) + ' C'
    if(tempC > 29.5 or tempC < 17.8):
        time_check(currentTemp)
    return currentTemp

########################################################################
# Function: get_tempK()
# Purpose: Gets the current temperature in Fahrenheit, and if
#          the temperature is greater than 302.6K or lower
#          than 290.9K then an email will be sent to the
#          appropriate users
# Arguments:
#           none
# Returns:
#           CurrentTemp - The Current temperature as a string
########################################################################
def get_tempK():
    tempK = calculate_K()
    currentTemp = '{:.2f}'.format( tempK ) + ' K'
    if(tempK > 302.6 or tempK < 290.9):
        time_check(currentTemp)
    return currentTemp

########################################################################
# Function: time_check(temp)
# Purpose: Checks if there has been an email sent out within
#         10 seconds, then send the appropriate email
# Arguments:
#           CurrentTemp - the temperature that was detected
# Returns:
#           none
########################################################################
def time_check(currentTemp):
    tempTime = time.time()
    if(((tempTime - globals()['emailTime']) > 10) and (globals()['connected'] == 1)):
        email(currentTemp)
        globals()['emailTime'] = tempTime

########################################################################
# Function: calculate_K()
# Purpose: to calculate the temperature in Kelvin
# Arguments:
#           none
# Returns:
#           tempK - the temperature in Kelvin
########################################################################
def calculate_K():
    # read ADC value A0 pin
    value = adc.analogRead(0)
    # calculate voltage
    voltage = value / 255.0 * 3.3
    # calculate resistance value of thermistor
    Rt = 10 * voltage / (3.3 - voltage)
    # calculate temperature (Kelvin)
    tempK = 1/(1/(273.15 + 25) + math.log(Rt/10)/3950.0)
    return tempK

########################################################################
# Function: get_time_now()
# Purpose: to get the current time in H:M:S format
# Arguments:
#           none
# Returns:
#           time - the current time in H:M:S format
########################################################################
def get_time_now():
    time = datetime.now().strftime('%H:%M:%S')
    return time

########################################################################
# Function: loop()
# Purpose: the main polling loop that will get the current
#          temp and time then print them to the LCD
# Arguments:
#           none
# Returns:
#           none
########################################################################
def loop():
    # turn on LCD backlight
    mcp.output(3,1)
    # set number of LCD lines and columns
    lcd.begin(16,2)
    while(True):
        try:
            urllib.request.urlopen('http://google.com')
            globals()['connected'] = 1
        except:
            globals()['connected'] = 0
        # set cursor position
        lcd.setCursor(0,0)
        # display CPU temperature
        lcd.message( 'Temp: ' + get_tempF()+'\n' )
        # display the time
        lcd.message( '    '+get_time_now() )
        sleep(0.1)

########################################################################
#Function: destroy()
#Purpose: Safely errors out the program
#Arguments:
#           none
#Returns:
#           none
########################################################################
def destroy():
    adc.close()
    GPIO.cleanup()
    lcd.clear()

########################################################################
# Initalization
########################################################################
# I2C address of the PCF8574 chip.
PCF8574_address = 0x27
# I2C address of the PCF8574A chip.
PCF8574A_address = 0x3F
# Create PCF8574 GPIO adapter.
try:
    mcp = PCF8574_GPIO(PCF8574_address)
except:
    try:
        mcp = PCF8574_GPIO(PCF8574A_address)
    except:
        print ('I2C Address Error !')
        exit(1)
# Create LCD, passing in MCP GPIO adapter.
lcd = Adafruit_CharLCD(pin_rs=0, pin_e=2, pins_db=[4,5,6,7], GPIO=mcp)
global emailTime
global connected
emailTime = 0
connected = 1
if __name__ == '__main__':
    print ('Program is starting ... ')
    setup()
    try:
        loop()
    except KeyboardInterrupt:
        destroy()
