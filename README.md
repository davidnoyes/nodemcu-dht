# NodeMCU with DHT Sensor
A simple project using a Lolin NodeMCU ESP8266 to read temperature & humidity from a DHT22 sensor, push to a MQTT server then deep sleep to save power.

## Firmware
- Downloaded from [https://nodemcu-build.com/](https://nodemcu-build.com/)
- Flashed using [esptool.py](https://github.com/espressif/esptool)

$ esptool.py --port /dev/ttyUSB0 write_flash --flash_mode dio --verify 0x0000 nodemcu-master-XX-modules-XXXX-XX-XX-XX-XX-XX-float.bin

## Firmware modules in use
**dht**, **file**, gpio, i2c, **mqtt**, net, **node**, ow, pcm, **tmr**, uart, **wifi**
(Reduce this list as your needs require, essentails in **bold**.)

## Wiring
- RST <-> D0 (GPIO16)
- 3v <-> DHT 3v
- G <-> DHT G
- D1 (GPIO5) <-> DHT Out

![NodeMCU Pin Diagram](./misc/nodemcu_pin_diagram.png  "NodeMCU Pin Diagram")

## Code
Code uploaded using [nodemcu-uploader](https://github.com/kmpm/nodemcu-uploader)

- Clone the project
- Rename and edit the credential.lua.sample with your WiFi details
- Rename and edit the settings.lua.sample with your MQTT settings
- $ nodemcu-uploader upload credentials.lua
- $ nodemcu-uploader upload settings.lua
- $ nodemcu-uploader upload wifi.lua
- $ nodemcu-uploader upload user.lua
- $ nodemcu-uploader upload init.lua
- $ nodemcu-uploader node restart
- $ nodemcu-uploader terminal

Inspired by: [https://odd-one-out.serek.eu/projects/esp8266-nodemcu-dht22-mqtt-deep-sleep/](https://odd-one-out.serek.eu/projects/esp8266-nodemcu-dht22-mqtt-deep-sleep/)
