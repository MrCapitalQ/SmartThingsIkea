# SmartThings Edge Ikea On/Off Remote Driver
This is a SmartThings Edge device driver implementation for the IKEA 2 button remote sold as the "IKEA TRÅDFRI Wireless Dimmer" (104.085.98). SmartThings has official support for this device as the "IKEA Dimmer" under "Remote/button" and this driver is similar to that.

Like the official device type handler, this cannot be used as a dimming switch when integrated with SmartThings. Instead, it provides a configurable action for pressing the top button (Toggled up), pressing the bottom button (Toggled down), and holding down the top and bottom buttons (Held up and Held down respectively).

Another key difference to the official device type handler is that **this runs locally on your hub and will enable locally executed automations** if everything else in those automations is capable of running locally.

## Installing the Driver
You can use this SmartThings Edge driver by clicking the link below to accept the invitation to join my drivers channel. Your SmartThings hub must be on a firmware version that supports Edge drivers.

[Join Driver Channel](https://bestow-regional.api.smartthings.com/invite/q0jmLEDBGal1)

Follow the prompts to install the driver(s) you want and to enroll the hub(s) you want. You can also use this link to unenroll hubs and uninstall drivers at a later time.

## Using the Driver with a Device
Once the driver is installed onto a hub, compatible devices can use it.

### New Devices
For new devices, simply add the device in the SmartThings app using the "Scan nearby" method. This is normally done by tapping (+) > Device > Scan nearby and then putting the device into pairing mode.

If done correctly, you should see driver information by going to the device's details view and selecting the "Driver" menu item. If the "Driver" menu item isn't there, remove the device, ensure you've installed the driver, and re-add it again.

### Existing Devices
If your device was previously added to SmartThings and it isn't using an Edge driver, you'll have to remove the device and re-add it to SmartThings.

You can tell if a device is using an Edge driver by going to the device's details view and selecting the "Driver" menu item. If  the "Driver" menu item isn't there, it's not using one.

If your device is using a different edge driver and want to switch to this one, you can do that in the "Driver" menu mentioned above.