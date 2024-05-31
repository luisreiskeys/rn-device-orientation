import { NativeModules, Platform } from 'react-native';
const LINKING_ERROR = `The package 'rn-device-orientation' doesn't seem to be linked. Make sure: \n\n` + Platform.select({
  ios: "- You have run 'pod install'\n",
  default: ''
}) + '- You rebuilt the app after installing the package\n' + '- You are not using Expo Go\n';
export const RnDeviceOrientation = NativeModules.RnDeviceOrientation ? NativeModules.RnDeviceOrientation : new Proxy({}, {
  get() {
    throw new Error(LINKING_ERROR);
  }
});
export * from './hooks/useDeviceOrientation';
//# sourceMappingURL=index.js.map