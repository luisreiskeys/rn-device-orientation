"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.useDeviceOrientation = useDeviceOrientation;
var _react = _interopRequireDefault(require("react"));
var _reactNative = require("react-native");
function _interopRequireDefault(e) { return e && e.__esModule ? e : { default: e }; }
function useDeviceOrientation() {
  const [orientation, setOrientation] = _react.default.useState(0);
  _react.default.useEffect(() => {
    const eventEmitter = new _reactNative.NativeEventEmitter(_reactNative.NativeModules.RnDeviceOrientation);
    let eventListener = eventEmitter.addListener('OrientatitionDevicesChanged', event => {
      setOrientation(event.val); // "someValue"
    });

    // Removes the listener once unmounted
    return () => {
      eventListener.remove();
    };
  }, []);
  return orientation;
}
//# sourceMappingURL=useDeviceOrientation.js.map