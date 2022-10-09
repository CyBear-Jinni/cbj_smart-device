import 'package:cbj_smart_device/application/usecases/smart_device_objects_u/abstracts_devices/smart_device_simple_abstract.dart';
import 'package:cbj_smart_device/application/usecases/wish_classes_u/dynamic_wish_u.dart';
import 'package:cbj_smart_device/infrastructure/gen/cbj_smart_device_server/protoc_as_dart/cbj_smart_device_server.pbgrpc.dart';

//  Abstract class for smart devices class with dynamic property
abstract class SmartDeviceDynamicAbstract extends SmartDeviceSimpleAbstract {
  SmartDeviceDynamicAbstract(
    String uuid,
    String smartInstanceName,
    int onOffPinNumber, {
    int? onOffButtonPinNumber,
  }) : super(
          uuid,
          smartInstanceName,
          onOffPinNumber,
          onOffButtonPinNumber: onOffButtonPinNumber,
        );

  ///  Save how much power to do for action
  double? dynamicValue;

  @override
  Future<String> executeActionString(
    String wishString,
    DeviceStateGRPC deviceState,
  ) async {
    final DeviceActions deviceAction =
        convertWishStringToWishesObject(wishString)!;
    if (deviceAction == null) return 'Your deviceAction does not exist on ';
    return executeDeviceAction(deviceAction, deviceState);
  }

  @override
  Future<String> executeDeviceAction(
    DeviceActions deviceAction,
    DeviceStateGRPC deviceState,
  ) async {
    return _WishInDynamicClass(deviceAction, deviceState);
  }

  ///  Set dynamic value
  String _SetDynamicValue() {
    if (deviceInformation == null) {
      return 'Device information is missing, cant set dynamic value';
    }
    return DynamicWishU.setDynamic(deviceInformation);
  }

  ///  Change dynamic value with open connection
  String _OpenDynamicValue() {
    if (deviceInformation == null) {
      return 'Device information is missing, cant create open connection with dynamic';
    }
    DynamicWishU.openDynamic(deviceInformation);
    onOff = false;
    return 'Turn on successfully';
  }

  ///  All the wishes that are legit to execute from the dynamic class
  String _WishInDynamicClass(
    DeviceActions deviceAction,
    DeviceStateGRPC deviceState,
  ) {
    switch (deviceAction) {
      case DeviceActions.actionNotSupported:
        return _SetDynamicValue();
      default:
        return wishInSimpleClass(deviceAction, deviceState);
    }
  }
}