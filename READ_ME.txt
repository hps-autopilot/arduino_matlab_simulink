Below are the detailed information of each file listed in the 'matlab_simulink' folder via the HPS Autopilot GitHub. Please note, there are additional files in there that are automatically generated when you run the scripts.
For additional information and more thorough calculations, please refer to the UW Thesis, 'Autonomous Roll Control in a Cross-Form Rudder Submarine Using PID Controllers' by Karine Chen, via the UW dissertations and thesis list.

'arduino_nano_33_ble_initialtest'
 This sketch was used to check if the Arduino Nano 33 BLE is working.

'arduino_nano_33_ble_sampletest'
 This sketch was used to do a sample test on the Arduino Nano 33 BLE.

'arduino_nano_33_ble_serial'
 Version 1 dated 20200309
 Version 2 dated 20200511
 Version 3 dated 20200511
 Version 4 dated 20200511

'arduino_nano_33_iot_matlab_converter'
 This sketch contains the codes to convert between Arduino and MATLAB.

'arduino_nano_33_iot_matlab_to_arduino'
 This is code that allows the Arduino to read data sent from MATLAB.

'arduino_nano_33_iot_orientationtest'

'arduino_nano_33_iot_serial'
 This is the main sketch used for the Arduino Nano 33 IoT via serial port.

'arduino_nano_33_iot_serialplotter'
 This is the sketch used conduct the serial plotter test.

'arduino_nano_33_iot_wifi_connector'
 This sketch connects the Arduino Nano 33 IoT to your WiFi network and enables the Network Monitor.

'matlab_simulink'
This folder contains MATLAB and Simulink files for the human-powered submraine auto pilot project.
  'arduino_matlab'
    Main script for specific information and data
  'arduino_nano_33_ble'
    Arduino-MATLAB connection file for the Arduino Nano 33 BLE and MATLAB. Note: There is currently no support for the Arduino Nano 33 BLE via MATLAB, therefore, please use nano33iot.m.
  'arduino_nano_33_iot'
    Arduino-MATLAB connection file for the Arduino Nano 33 IoT and MATLAB.
  'e520'
    Airfoil data E520. Also the horizontal hull (beam) profile for The Underdawg.
  'e838'
    Airfoil data E838. Also the vertical hull (draft) profile for The Underdawg.
  'finsgraph'
    Script originally used to start creating a fin forces graph for each fin, but project was scrapped.
  'forcesgraph'
    Script originally used to start creating a fin rotation over time graph for each fin, but project was scrapped.
  'hps_autopilot_simulink_control_loop'
    Human-powered submarine autopilot double control loop simulink file.
  'restoringforces'
    MATLAB Script used to compute the 6x1 vector of restoring forces about an arbitrarily point CO for a submerged body.
  'sorting'
    A sorting method using the GUI via MATLAB if not using the coded sorting script.
  'trajectory'
    Animated real-time 3D trajectory plotter test. Scrapped since another member wanted to take on the plotting in real-time task.
  'vehicle_hull_airfoil'
   Plots the beam and draft profile of The Underdawg (separately and in comparison).

'testdata'
This folder contains data files used to test the Arduino and MATLAB scripts.
  'data'
    Random sample data,
  'sensordata_20200310_sample'
    Sample data from the sensor
  'newData'
    Sorted data using 'data'
  'sortscript'
    Script used to sort 'data' to 'newData' via MATLAB