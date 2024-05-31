import React from 'react';
import { NativeEventEmitter, NativeModules } from 'react-native';

export function useDeviceOrientation() {
  const [orientation, setOrientation] = React.useState(0);

  React.useEffect(() => {
    const eventEmitter = new NativeEventEmitter(
      NativeModules.RnDeviceOrientation
    );
    let eventListener = eventEmitter.addListener(
      'OrientatitionDevicesChanged',
      (event) => {
        setOrientation(event.val); // "someValue"
      }
    );

    // Removes the listener once unmounted
    return () => {
      eventListener.remove();
    };
  }, []);

  return orientation;
}
