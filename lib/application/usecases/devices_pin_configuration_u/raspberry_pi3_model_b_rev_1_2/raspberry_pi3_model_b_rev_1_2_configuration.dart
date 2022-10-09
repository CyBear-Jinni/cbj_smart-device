import 'package:cbj_smart_device/application/usecases/devices_pin_configuration_u/device_configuration_base_class.dart';
import 'package:cbj_smart_device/application/usecases/devices_pin_configuration_u/pin_information.dart';

/// Pin configuration of the Raspberry Pi 2/3/4 as they have the same configuration
class RaspberryPi3ModelBRev1_2Configuration
    extends DeviceConfigurationBaseClass {
  RaspberryPi3ModelBRev1_2Configuration() {
    pinList = _pinListRaspberry_pi;
  }

  static final List<PinInformation> _pinListRaspberry_pi = <PinInformation>[
    PinInformation(
      category: 'Power',
      pinAndPhysicalPinConfiguration: 1,
      gpioColumn: 1,
      name: 'VDD_3V3',
    ),
    PinInformation(
      category: 'Power',
      pinAndPhysicalPinConfiguration: 2,
      gpioColumn: 2,
      name: 'VDD_5V',
    ),
    PinInformation(
      category: 'GPIO',
      pinAndPhysicalPinConfiguration: 3,
      gpioColumn: 1,
      name: 'SDA.1/GPIO',
      bcmOrLinuxGpio: 2,
      wPi: 8,
    ),
    PinInformation(
      category: 'Power',
      pinAndPhysicalPinConfiguration: 4,
      gpioColumn: 2,
      name: 'VDD_5V',
    ),
    PinInformation(
      category: 'GPIO',
      pinAndPhysicalPinConfiguration: 5,
      gpioColumn: 1,
      name: 'SCL.1/GPIO',
      bcmOrLinuxGpio: 3,
      wPi: 9,
    ),
    PinInformation(
      category: 'Power',
      pinAndPhysicalPinConfiguration: 6,
      gpioColumn: 2,
      name: 'GND',
    ),
    PinInformation(
      category: 'GPIO',
      pinAndPhysicalPinConfiguration: 7,
      gpioColumn: 1,
      name: 'GPIO7',
      bcmOrLinuxGpio: 4,
      wPi: 7,
    ),
    PinInformation(
      category: 'GPIO',
      pinAndPhysicalPinConfiguration: 8,
      gpioColumn: 2,
      name: 'TxD',
      bcmOrLinuxGpio: 14,
      wPi: 15,
    ),
    PinInformation(
      category: 'Power',
      pinAndPhysicalPinConfiguration: 9,
      gpioColumn: 1,
      name: 'GND',
    ),
    PinInformation(
      category: 'GPIO',
      pinAndPhysicalPinConfiguration: 10,
      gpioColumn: 2,
      name: 'RxD',
      bcmOrLinuxGpio: 15,
      wPi: 16,
    ),
    PinInformation(
      category: 'GPIO',
      pinAndPhysicalPinConfiguration: 11,
      gpioColumn: 1,
      name: 'GPIOG0',
      bcmOrLinuxGpio: 17,
      wPi: 0,
    ),
    PinInformation(
      category: 'GPIO',
      pinAndPhysicalPinConfiguration: 12,
      gpioColumn: 2,
      name: 'GPIO1',
      bcmOrLinuxGpio: 18,
      wPi: 1,
    ),
    PinInformation(
      category: 'GPIO',
      pinAndPhysicalPinConfiguration: 13,
      gpioColumn: 1,
      name: 'GPIO2',
      bcmOrLinuxGpio: 27,
      wPi: 2,
    ),
    PinInformation(
      category: 'Power',
      pinAndPhysicalPinConfiguration: 14,
      gpioColumn: 2,
      name: 'GND',
    ),
    PinInformation(
      category: 'GPIO',
      pinAndPhysicalPinConfiguration: 15,
      gpioColumn: 1,
      name: 'GPIO3',
      bcmOrLinuxGpio: 22,
      wPi: 3,
    ),
    PinInformation(
      category: 'GPIO',
      pinAndPhysicalPinConfiguration: 16,
      gpioColumn: 2,
      name: 'GPIO4',
      bcmOrLinuxGpio: 23,
      wPi: 4,
    ),
    PinInformation(
      category: 'Power',
      pinAndPhysicalPinConfiguration: 17,
      gpioColumn: 1,
      name: 'GND',
    ),
    PinInformation(
      category: 'GPIO',
      pinAndPhysicalPinConfiguration: 18,
      gpioColumn: 2,
      name: 'GPIO5',
      bcmOrLinuxGpio: 24,
      wPi: 5,
    ),
    PinInformation(
      category: 'GPIO',
      pinAndPhysicalPinConfiguration: 19,
      gpioColumn: 1,
      name: 'MOSI/GPIO',
      bcmOrLinuxGpio: 10,
      wPi: 12,
    ),
    PinInformation(
      category: 'Power',
      pinAndPhysicalPinConfiguration: 20,
      gpioColumn: 2,
      name: 'GND',
    ),
    PinInformation(
      category: 'GPIO',
      pinAndPhysicalPinConfiguration: 21,
      gpioColumn: 1,
      name: 'MISO/GPIO',
      bcmOrLinuxGpio: 9,
      wPi: 13,
    ),
    PinInformation(
      category: 'GPIO',
      pinAndPhysicalPinConfiguration: 22,
      gpioColumn: 2,
      name: 'GPIO6',
      bcmOrLinuxGpio: 25,
      wPi: 6,
    ),
    PinInformation(
      category: 'GPIO',
      pinAndPhysicalPinConfiguration: 23,
      gpioColumn: 1,
      name: 'SCLK/GPIO',
      bcmOrLinuxGpio: 11,
      wPi: 14,
    ),
    PinInformation(
      category: 'GPIO',
      pinAndPhysicalPinConfiguration: 24,
      gpioColumn: 2,
      name: 'CE0/GPIO',
      bcmOrLinuxGpio: 8,
      wPi: 10,
    ),
    PinInformation(
      category: 'Power',
      pinAndPhysicalPinConfiguration: 25,
      gpioColumn: 1,
      name: 'GND',
    ),
    PinInformation(
      category: 'GPIO',
      pinAndPhysicalPinConfiguration: 26,
      gpioColumn: 2,
      name: 'CE1/GPIO',
      bcmOrLinuxGpio: 7,
      wPi: 11,
    ),
    PinInformation(
      category: 'GPIO',
      pinAndPhysicalPinConfiguration: 27,
      gpioColumn: 1,
      name: 'SDA.0/GPIO',
      bcmOrLinuxGpio: 0,
      wPi: 30,
    ),
    PinInformation(
      category: 'GPIO',
      pinAndPhysicalPinConfiguration: 28,
      gpioColumn: 2,
      name: 'SCL.0/GPIO',
      bcmOrLinuxGpio: 1,
      wPi: 31,
    ),
    PinInformation(
      category: 'GPIO',
      pinAndPhysicalPinConfiguration: 29,
      gpioColumn: 1,
      name: 'GPIO21',
      bcmOrLinuxGpio: 5,
      wPi: 21,
    ),
    PinInformation(
      category: 'Power',
      pinAndPhysicalPinConfiguration: 30,
      gpioColumn: 2,
      name: 'GND',
    ),
    PinInformation(
      category: 'GPIO',
      pinAndPhysicalPinConfiguration: 31,
      gpioColumn: 1,
      name: 'GPIO22',
      bcmOrLinuxGpio: 6,
      wPi: 22,
    ),
    PinInformation(
      category: 'GPIO',
      pinAndPhysicalPinConfiguration: 32,
      gpioColumn: 2,
      name: 'GPIO26',
      bcmOrLinuxGpio: 12,
      wPi: 26,
    ),
    PinInformation(
      category: 'GPIO',
      pinAndPhysicalPinConfiguration: 33,
      gpioColumn: 1,
      name: 'GPIO23',
      bcmOrLinuxGpio: 13,
      wPi: 23,
    ),
    PinInformation(
      category: 'Power',
      pinAndPhysicalPinConfiguration: 34,
      gpioColumn: 2,
      name: 'GND',
    ),
    PinInformation(
      category: 'GPIO',
      pinAndPhysicalPinConfiguration: 35,
      gpioColumn: 1,
      name: 'GPIO24',
      bcmOrLinuxGpio: 19,
      wPi: 24,
    ),
    PinInformation(
      category: 'GPIO',
      pinAndPhysicalPinConfiguration: 36,
      gpioColumn: 2,
      name: 'GPIO27',
      bcmOrLinuxGpio: 16,
      wPi: 27,
    ),
    PinInformation(
      category: 'GPIO',
      pinAndPhysicalPinConfiguration: 37,
      gpioColumn: 1,
      name: 'GPIO25',
      bcmOrLinuxGpio: 26,
      wPi: 25,
    ),
    PinInformation(
      category: 'GPIO',
      pinAndPhysicalPinConfiguration: 38,
      gpioColumn: 2,
      name: 'GPIO28',
      bcmOrLinuxGpio: 20,
      wPi: 28,
    ),
    PinInformation(
      category: 'Power',
      pinAndPhysicalPinConfiguration: 39,
      gpioColumn: 1,
      name: 'GND',
    ),
    PinInformation(
      category: 'GPIO',
      pinAndPhysicalPinConfiguration: 40,
      gpioColumn: 2,
      name: 'GPIO29',
      bcmOrLinuxGpio: 21,
      wPi: 29,
    ),
  ];

  @override
  PinInformation getNextFreeGpioPin({List<PinInformation?>? ignorePinsList}) =>
      getNextFreeGpioPinHelper(pinList!, ignorePinsList: ignorePinsList)!;
}