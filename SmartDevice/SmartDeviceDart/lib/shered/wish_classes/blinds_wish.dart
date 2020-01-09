import 'package:SmartDeviceDart/smart_device/smart_device_objects/static_devices/blinds_object.dart';

import 'off_wish.dart';
import 'on_wish.dart';

//  This class take the request to turn up or down the blinds and act in a safe manner with the pins, act so that blinds up and down will not work simultaneously and stop other tasks on them
class BlindsWish {

  static String BlindsUp(BlindsObject blindsInformation) {
    String status;
    print("Turning blind up");

    blindsInformation.blindsUpPin.onDuration = -1;
    blindsInformation.blindsDownPin.onDuration = 0;

    status = OffWish.SetOff(
        blindsInformation.deviceInformation, blindsInformation.blindsDownPin);
    Future.delayed(
        const Duration(seconds: 2));
    status += " " +
        OnWish.SetOn(
            blindsInformation.deviceInformation, blindsInformation.blindsUpPin);

    return status;
  }

  static String BlindsDown(BlindsObject blindsInformation) {
    String status;

    blindsInformation.blindsDownPin.onDuration = -1;
    blindsInformation.blindsUpPin.onDuration = 0;

    status = OffWish.SetOff(
        blindsInformation.deviceInformation, blindsInformation.blindsUpPin);
    Future.delayed(
        const Duration(seconds: 2));
    status += " " +
        OnWish.SetOn(blindsInformation.deviceInformation,
            blindsInformation.blindsDownPin);

    return status;
  }

  static String BlindsStop(BlindsObject blindsInformation) {
    String status;

    blindsInformation.blindsDownPin.onDuration = 0;
    blindsInformation.blindsUpPin.onDuration = 0;

    status = OffWish.SetOff(
        blindsInformation.deviceInformation, blindsInformation.blindsUpPin);
    status += " " +
        OffWish.SetOff(blindsInformation.deviceInformation,
            blindsInformation.blindsDownPin);

    return status;
  }
}