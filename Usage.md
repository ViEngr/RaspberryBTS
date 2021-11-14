Calibrate the Radio Board with MBTS
To calibrate the radio board you must adjust the RX gain until the noise RSSI reaches an average value of -70 dB or -120 dBm.

You can get the RX gain value using the command:

mbts rxgain
The output will be similar to this:

current RX gain is 47 dB
To adjust the Rx gain, you can use Yate's rmanager(Telnet) interface. Run the following command:

mbts rxgain <new value for RX gain>
Example:

mbts rxgain 45
current RX gain is 47 dB
new RX gain is 45 dB
To get the noise value run the command:

mbts noise
The output will be similar to this:

noise RSSI is -68 dB wrt full scale
MS RSSI target is -50 dB wrt full scale
If the noise value is not in the allowed values, try adjusting the RX gain again.
