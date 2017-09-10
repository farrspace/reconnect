# reconnect
## A Ruby script for Apple laptops to quickly reconnect or or maintain a connection to a home network.

This is a little ruby script that does it's best to keep you connected when local network conditions aren't ideal. When run it will try twice to reconnect if not already connecting, attempt power-cycling the wireless card, and attempting two more times. 

### Recomended Usage

Copy the script somewhere convenient and enter your home network name and password in the top configuration section. Call the script with no arguments to reconnect as needed. 

If your network is frequently disconnecting and you want to monitor and reconnect, call the script with the argument "start" and it will remain running, checking your network every two minutes and reconnecting if needed.

### Compatibility

Developed on OS X El Capitan (10.11), with a MacBook Pro (15-inch, Mid 2012). May need changes on other devices and operating system versions.

### License: Unlicense / Public Domain
See LICENSE file for details on non-copyright and non-warranty. 

### Credits
Thanks to OS X Daily's article [airport – the Little Known Command Line Wireless Utility](http://osxdaily.com/2007/01/18/airport-the-little-known-command-line-wireless-utility/) for most of the information needed for this script.