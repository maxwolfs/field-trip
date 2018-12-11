# Tech Info

wip sloppy tech documentation

* vvvv 
* mosquitto server
* esp8266 mcu
* 

### run

* create wifi network with router/phone
* let nodes and mqtt server connect to it
* run vvvv

### vvvv

* install vpm
* install pack: field-trip + dependencies
* install pack: vvvv-mqtt
* install pack: vaudio
* install pack: PhongDDN
* install pack: VObjects

### Mosquitto Server

* install: https://mosquitto.org/
* install dependecies: 

http://slproweb.com/products/Win32OpenSSL.html
    Install "Win32 OpenSSL 1.1.0* Light" or "Win64 OpenSSL 1.1.0* Light"
    Required DLLs: libssl-1_1.dll, libcrypto-1_1.dll or libssl-1_1-x64.dll, libcrypto-1_1-x64.dll
Please ensure that the required DLLs are on the system path, or are in the same directory as
the mosquitto executable - usually C:\Program Files (x86)\mosquitto or C:\Program Files\mosquitto.

* turn off firewall
* run 2 cmd prompts as admin
* broker test: ``` mosquitto_sub -d -t hallo/welt ```
* publish test: ``` mosquitto_pub -d -t hallo/welt -m “Hallo Mosquitto!” ```

### ESP8266

* install library: pubsubclient

#### resources

* http://blue-pc.net/2014/09/05/mqtt-unter-windows-installieren/
