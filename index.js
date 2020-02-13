import React from 'react';
import { NativeModules, requireNativeComponent ,Platform } from 'react-native';

const { AppleSigninModule } = NativeModules;

export const RNSignInWithAppleOutlineButton = requireNativeComponent('RNCSignInWithAppleButton');
export const RNSignInWithAppleBlackButton = requireNativeComponent('RNCSignInWithAppleBlackButton');
export const RNSignInWithAppleWhiteButton = requireNativeComponent('RNCSignInWithAppleWhiteButton');

export const SignInWithAppleWhiteButton = (buttonStyle, nativeStyle, callBack) => {
    if(Platform.OS === 'ios'){
        return <RNSignInWithAppleWhiteButton style={buttonStyle} 
                                             nativeStyle={nativeStyle}
                                             onPress={() => { appleSigninAuthRequest(callBack) }} 
               />
    } else {
        return null
    }
}

export const SignInWithAppleBlackButton = (buttonStyle, nativeStyle, callBack) => {
    if(Platform.OS === 'ios'){
        return <RNSignInWithAppleBlackButton style={buttonStyle} 
                                             nativeStyle={nativeStyle}
                                             onPress={() => { appleSigninAuthRequest(callBack) }} 
               />
    } else {
        return null
    }
}

export const SignInWithAppleOutlineButton = (buttonStyle, nativeStyle, callBack) => {
    if(Platform.OS === 'ios'){
        return <RNSignInWithAppleOutlineButton style={buttonStyle} 
                                               nativeStyle={nativeStyle}
                                               onPress={() => { appleSigninAuthRequest(callBack) }} 
               />
    } else {
        return null
    }
}

const appleSigninAuthRequest = async (callBack) => {
    await AppleSigninModule.requestAsync({ scopes: [AppleSigninModule.Scope.FULL_NAME, AppleSigninModule.Scope.EMAIL],})
    .then((response) => {
        callBack(response) //Display response
    }, (error) => {
        callBack(error) //Display error
    }); 
}

export default AppleSigninModule;
