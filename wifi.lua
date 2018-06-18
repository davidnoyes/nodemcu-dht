-----------------------------------------------
--- Set Variables ---
-----------------------------------------------
dofile("credentials.lua")

--- WIFI CONFIGURATION ---
WIFI_SSID = SSID
WIFI_PASSWORD = PASSWORD
WIFI_SIGNAL_MODE = wifi.PHYMODE_N

--- IP CONFIG (Leave blank to use DHCP) ---
ESP8266_IP=""
ESP8266_NETMASK=""
ESP8266_GATEWAY=""
-----------------------------------------------

--- Connect to the wifi network ---
wifi.setmode(wifi.STATION)
wifi.setphymode(WIFI_SIGNAL_MODE)
wifi.sta.config({ssid=SSID, pwd=PASSWORD})

if ESP8266_IP ~= "" then
  wifi.sta.setip({ip=ESP8266_IP,netmask=ESP8266_NETMASK,gateway=ESP8266_GATEWAY})
end
-----------------------------------------------

