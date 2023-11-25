import 'package:cbj_smart_device/application/usecases/button_object_u/button_object_local_u.dart';
import 'package:cbj_smart_device/application/usecases/devices_pin_configuration_u/pin_information.dart';
import 'package:cbj_smart_device/application/usecases/smart_device_objects_u/abstracts_devices/smart_device_base_abstract.dart';
import 'package:cbj_smart_device/application/usecases/wish_classes_u/off_wish_u.dart';
import 'package:cbj_smart_device/application/usecases/wish_classes_u/on_wish_u.dart';
import 'package:cbj_smart_device/application/usecases/wish_classes_u/smart_computer_wish_u.dart';
import 'package:cbj_smart_device/core/device_information.dart';
import 'package:cbj_smart_device/core/helper_methods.dart';
import 'package:cbj_smart_device/core/permissions/permissions_manager.dart';
import 'package:cbj_smart_device/domain/entities/core_e/enums_e.dart';
import 'package:cbj_smart_device/infrastructure/datasources/core_d/manage_physical_components/device_pin_manager.dart';
import 'package:cbj_smart_device/infrastructure/datasources/smart_server_d/smart_server_helper.dart';
import 'package:cbj_integrations_controller/infrastructure/gen/cbj_smart_device_server/protoc_as_dart/cbj_smart_device_server.pbgrpc.dart';
import 'package:cbj_smart_device/infrastructure/repositories/smart_device_objects_r/smart_device_objects_r.dart';
import 'package:cbj_smart_device/utils.dart';

///  Abstract class for smart devices that can get actions from commands.
///  Excluding buttons since they are the one that sending the commands.
abstract class SmartDeviceBase extends SmartDeviceBaseAbstract {
  SmartDeviceBase(
    super.id,
    super.deviceName,
    int? onOffPinNumber, {
    int? onOffButtonPinNumber,
  }) {
    onOffPin =
        onOffPinNumber == null ? null : addPinToGpioPinList(onOffPinNumber);

    //  If pin number was inserted and it exists than listen to button press
    if (onOffButtonPinNumber != null) {
      onOffButtonPin = addPinToGpioPinList(onOffButtonPinNumber);

      if (onOffButtonPin != null) {
        listenToButtonPressed();
      }
    }
  }

  ///  Save data about the device, remote or local IP or pin number
  @override
  DeviceInformation deviceInformation =
      LocalDevice('This is the mac Address', '');

  ///  Mac addresses of the physical device
  @override
  String? uuid;

  ///  Permissions of all the users to this device
  @override
  Map<String, PermissionsManager>? devicePermissions;

  ///  Power consumption of the device
  @override
  double? watts;

  ///  How much time the computer is on since last boot
  @override
  DateTime? computerActiveTime;

  ///  How much time the smart device was active (Doing action) total
  @override
  DateTime? activeTimeTotal;

  ///  Log of all the actions the device was and will do
  @override
  Map<DateTime, Function>? activitiesLog;

  ///  Save the device state on = true, off = false of onOffPin
  @override
  bool onOff = false;

  ///  Number of on or off pin
  @override
  PinInformation? onOffPin;

  ///  Pin for the button that control the onOffPin
  @override
  PinInformation? onOffButtonPin;

  ///  Save all the gpio pins that this instance is using
  final List<PinInformation> _gpioPinList = <PinInformation>[];

  ///  The type of the smart device Light blinds etc
  @override
  CbjDeviceTypes? smartDeviceType;

  /// Get a list of the pins Types that this device need
  @override
  List<String> getNeededPinTypesList() => [];

  @override
  static List<String> neededPinTypesList() => [];

  //  Getters

  ///  Get smart device type
  @override
  CbjDeviceTypes? getDeviceType() => smartDeviceType;

  /// Returning the non abstract of this object
  @override
  Type getTheNonAbstractObjectOfThisInstance() {
    return EnumHelper.getTheNonAbstractObjectOfSmartDeviceBaseAbstract(
      this,
      getDeviceType()!,
    );
  }

  /// Getting the saved IP of this object
  @override
  Future<String?> getIp() async {
    return getIps();
  }

  ///  Get the list of gpio pin of the device
  @override
  List<PinInformation> getGpioPinList() {
    return _gpioPinList;
  }

  @override
  Future<String> getUuid() {
    return SmartDeviceObjectsR.getUuid();
  }

  bool getDeviceState() => onOff;

  //  Setters

  ///  Turn on the device basic action
  String _setOn(PinInformation? pinNumber) {
//    if (deviceInformation == null) {
//      return 'Device information is missing, can't turn on';
//    }
    OnWishU.setOn(deviceInformation, pinNumber);
    onOff = true;
    return 'Turn on successfully';
  }

  ///  Turn off the device basic action
  String _setOff(PinInformation? pinNumber) {
//    if (deviceInformation == null) {
//      return 'Device information is missing, can't turn off';
//    }
    OffWishU.setOff(deviceInformation, pinNumber);
    onOff = false;
    return 'Turn off successfully';
  }

  ///  Suspend computer basic action
  Future<String?> _suspendComputer() {
    return SmartComputerWishU.suspendComputer(deviceInformation);

    // return 'Suspend computer successfully';
  }

  ///  Shutdown computer basic action
  Future<String?> _shutdownComputer() {
    return SmartComputerWishU.shutdownComputer(deviceInformation);
  }

  @override
  void setDeviceType(CbjDeviceTypes deviceType) => smartDeviceType = deviceType;

  ///  Turn device pin to the opposite state
  String _setChangeOppositeToState(PinInformation? pinNumber) {
    return onOff ? _setOff(onOffPin) : _setOn(onOffPin);
  }

  //  More functions

  ///  Add gpio pin for this device
  PinInformation? addPinToGpioPinList(int pinNumber) {
    //  Check if pin is free to be taken,
    //  if not return negative number with error number
    final PinInformation gpioPin =
        DevicePinListManager().getGpioPin(pinNumber)!;
    if (gpioPin == null) {
      return null;
    }
    _gpioPinList.add(gpioPin);
    return gpioPin;
  }

  ///  Return PossibleWishes object if
  ///  string wish exist (in general) else return null
  CbjDeviceActions? convertWishStringToWishesObject(String wish) {
    for (final CbjDeviceActions possibleAction in CbjDeviceActions.values) {
      print('Wish value ${EnumHelper.deviceActionToString(possibleAction)}');
      if (EnumHelper.deviceActionToString(possibleAction) == wish) {
        return possibleAction; //  If wish exist return the PossibleWish object
      }
    }
    return null;
  }

  ///  Check if wish exist at all if true than check if base abstract have
  ///  this wish and if true than execute it
  Future<String> executeActionString(
    String wishString,
    CbjDeviceStateGRPC deviceState,
  ) async {
    final CbjDeviceActions action =
        convertWishStringToWishesObject(wishString)!;
    return executeDeviceAction(action, deviceState);
  }

  Future<String> executeDeviceAction(
    CbjDeviceActions action,
    CbjDeviceStateGRPC deviceState,
  ) async {
    return wishInBaseClass(action, deviceState);
  }

  ///  All the wishes that are legit to execute from the base class
  Future<String> wishInBaseClass(
    CbjDeviceActions action,
    CbjDeviceStateGRPC deviceState,
  ) async {
    String executionMassage = ' ';
    if (action == null) executionMassage = 'Your wish does not exist';

    final bool deviceStatus = getDeviceState();
    String? resultOfTheWish = '';

    switch (action) {
      case CbjDeviceActions.off:
        if (onOffPin == null) {
          executionMassage = 'Cant turn off this pin: $onOffPin Number';
        }
        resultOfTheWish = _setOff(onOffPin);
        break;
      case CbjDeviceActions.on:
        if (onOffPin == null) {
          executionMassage = 'Cant turn on this pin: $onOffPin Number';
        }
        resultOfTheWish = _setOn(onOffPin);
        break;
      case CbjDeviceActions.suspend:
        resultOfTheWish = await _suspendComputer();
        break;
      case CbjDeviceActions.shutdown:
        resultOfTheWish = await _shutdownComputer();
        break;
      case CbjDeviceActions.actionNotSupported:
        if (onOffPin == null) {
          executionMassage =
              'Cant change pin to the opposite state: $onOffPin Number';
        }
        resultOfTheWish = _setChangeOppositeToState(onOffPin);
        break;
      default:
        executionMassage = 'Your wish does not exist for this class';
    }

    logger.i(
      'Execution massage: $executionMassage\nResult of the wish:$resultOfTheWish',
    );

    if (resultOfTheWish == 'Turn on successfully' ||
        resultOfTheWish == 'Turn off successfully' ||
        executionMassage == 'Cant turn on this pin: null Number' ||
        executionMassage == 'Cant turn off this pin: null Number') {
      if (deviceState == CbjDeviceStateGRPC.waitingInComp) {
        if (action == CbjDeviceActions.on) {
          final Map<String, String> mapToUpdate = {
            GrpcClientTypes.cbjDeviceActionsTypeString:
                CbjDeviceActions.on.toString(),
            GrpcClientTypes.cbjDeviceStateGRPCTypeString:
                CbjDeviceStateGRPC.ack.toString()
          };
        } else if (action == CbjDeviceActions.off) {
          final Map<String, String> mapToUpdate = {
            GrpcClientTypes.cbjDeviceActionsTypeString:
                CbjDeviceActions.off.toString(),
            GrpcClientTypes.cbjDeviceStateGRPCTypeString:
                CbjDeviceStateGRPC.ack.toString()
          };
        }
      } else if (deviceState == CbjDeviceStateGRPC.ack) {
      } else {}
    } else {}

    return executionMassage;
  }

  ///  Listen to button press
  Future<void> listenToButtonPressed() async {
    ButtonObjectLocalU().buttonPressed(this, onOffButtonPin!, onOffPin!);
  }
}
