"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
var _exportNames = {
  RnDeviceOrientation: true
};
exports.RnDeviceOrientation = void 0;
var _reactNative = require("react-native");
var _useDeviceOrientation = require("./hooks/useDeviceOrientation");
Object.keys(_useDeviceOrientation).forEach(function (key) {
  if (key === "default" || key === "__esModule") return;
  if (Object.prototype.hasOwnProperty.call(_exportNames, key)) return;
  if (key in exports && exports[key] === _useDeviceOrientation[key]) return;
  Object.defineProperty(exports, key, {
    enumerable: true,
    get: function () {
      return _useDeviceOrientation[key];
    }
  });
});
const LINKING_ERROR = `The package 'rn-device-orientation' doesn't seem to be linked. Make sure: \n\n` + _reactNative.Platform.select({
  ios: "- You have run 'pod install'\n",
  default: ''
}) + '- You rebuilt the app after installing the package\n' + '- You are not using Expo Go\n';
const RnDeviceOrientation = exports.RnDeviceOrientation = _reactNative.NativeModules.RnDeviceOrientation ? _reactNative.NativeModules.RnDeviceOrientation : new Proxy({}, {
  get() {
    throw new Error(LINKING_ERROR);
  }
});
//# sourceMappingURL=index.js.map