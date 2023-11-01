import 'package:cbj_smart_device/application/usecases/button_object_u/button_object_local_u.dart';
import 'package:cbj_smart_device/application/usecases/devices_pin_configuration_u/pin_information.dart';
import 'package:cbj_smart_device/application/usecases/smart_device_objects_u/abstracts_devices/smart_device_static_abstract.dart';
import 'package:cbj_smart_device/application/usecases/wish_classes_u/blinds_wish_u.dart';
import 'package:cbj_smart_device/domain/entities/core_e/enums_e.dart';
import 'package:cbj_smart_device/infrastructure/datasources/core_d/manage_physical_components/device_pin_manager.dart';
import 'package:cbj_integrations_controller/infrastructure/gen/cbj_smart_device_server/protoc_as_dart/cbj_smart_device_server.pbgrpc.dart';

/// Object to control blinds
class BlindsObject extends SmartDeviceStaticAbstract {
  /// Setting up pins for up down, buttons for up down but not at the same time.
  BlindsObject(
    super.uuid,
    String? super.smartInstanceName,
    super.onOffPinNumber,
    onOffButtonPinNumber,
    int? blindsUpPin,
    int? upButtonPinNumber,
    int? blindsDownPin,
    int? downButtonPinNumber,
  ) : super(
          onOffButtonPinNumber: onOffButtonPinNumber,
        ) {
    buttonPinUp = DevicePinListManager().getGpioPin(upButtonPinNumber);
    buttonPinDown = DevicePinListManager().getGpioPin(downButtonPinNumber);

    this.blindsUpPin = DevicePinListManager().getGpioPin(blindsUpPin);
    this.blindsDownPin = DevicePinListManager().getGpioPin(blindsDownPin);
    listenToTwoButtonsPress();

    setDeviceType(CbjDeviceTypes.blinds);
    print('New blinds object');
  }

  PinInformation? buttonPinUp;
  PinInformation? blindsUpPin;
  PinInformation? buttonPinDown;
  PinInformation? blindsDownPin;

  @override
  List<String> getNeededPinTypesList() =>
      <String>['gpio', 'gpio', 'gpio', 'gpio'];

  @override
  static List<String> neededPinTypesList() =>
      <String>['gpio', 'gpio', 'gpio', 'gpio'];

  @override
  CbjDeviceTypes getDeviceType() => CbjDeviceTypes.blinds;

  @override
  Future<String> executeActionString(
    String wishString,
    CbjDeviceStateGRPC deviceState,
  ) async {
    final CbjDeviceActions deviceAction =
        convertWishStringToWishesObject(wishString)!;
    return executeDeviceAction(deviceAction, deviceState);
  }

  @override
  Future<String> executeDeviceAction(
    CbjDeviceActions deviceAction,
    CbjDeviceStateGRPC deviceState,
  ) async {
    return deviceActionInBlindsClass(deviceAction, deviceState);
  }

  ///  All the wishes that are legit to execute from the blinds class
  Future<String> deviceActionInBlindsClass(
    CbjDeviceActions deviceAction,
    CbjDeviceStateGRPC deviceState,
  ) async {
    String? wishExecuteResult;

    if (deviceAction == null) return 'Your wish does not exist in blinds class';
    if (deviceAction == CbjDeviceActions.moveUp) {
      wishExecuteResult = await BlindsWishU.blindsUp(this);
    }
    if (deviceAction == CbjDeviceActions.moveDown) {
      wishExecuteResult = await BlindsWishU.blindsDown(this);
    }
    if (deviceAction == CbjDeviceActions.stop) {
      wishExecuteResult = await BlindsWishU.blindsStop(this);
    }

    if (wishExecuteResult != null) {
      if (deviceState != CbjDeviceStateGRPC.ack) {
        final String cbjDeviceActionstring =
            EnumHelper.deviceActionToString(deviceAction);
      }
      return wishExecuteResult;
    }

    return wishInStaticClass(deviceAction, deviceState);
  }

  /// Listening to two buttons press but will not do action for the two of them
  /// at the same time.
  void listenToTwoButtonsPress() {
    if (buttonPinUp != null &&
        buttonPinDown != null &&
        blindsUpPin != null &&
        blindsDownPin != null) {
      ButtonObjectLocalU()
          .listenToTwoButtonPressedButtOnlyOneCanBePressedAtATime(
        this,
        buttonPinUp!,
        blindsUpPin!,
        buttonPinDown!,
        blindsDownPin!,
      );
    } else {
      print('Cannot listen to blinds, one of the variables is null');
      print('ButtonPinUp: $buttonPinUp, ButtonPinDown: $buttonPinDown, '
          'BlindsUpPin: $blindsUpPin, BlindsDownPin: $blindsDownPin');
    }
  }
}
