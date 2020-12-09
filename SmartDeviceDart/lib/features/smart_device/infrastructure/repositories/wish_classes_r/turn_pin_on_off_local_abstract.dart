import 'package:smart_device_dart/features/smart_device/application/usecases/devices_pin_configuration_u/pin_information.dart';

abstract class TurnPinOnOffLocalAbstract {
  Future<String> pinOn(PinInformation pinNumber);

  Future<String> pinOff(PinInformation pinNumber);
}
