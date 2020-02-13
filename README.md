# react-native-apple-signin-package

## Getting started

`$ npm install react-native-apple-signin-package --save`

### Mostly automatic installation if you use react native <= 0.59

`pod 'react-native-apple-signin-package', :path => '../node_modules/react-native-apple-signin-package'`

### Need to insatll to finish the installation.
`pod install`

## Usage
```javascript
import { SignInWithAppleBlackButton,
         SignInWithAppleOutlineButton,
         SignInWithAppleWhiteButton
} from 'react-native-apple-signin-package'

// Support three different styles with white, black, and white with outline.
<View style= {{marginBottom:20}}>
    {SignInWithAppleBlackButton({ height: 45, width: 218 }, 
                                { 'cornerRadius':22.5 }, 
                                appleSignIn)}
</View>
...

appleSignIn = async (result) => {
  // You can check the return result and use what you want to do with your system.
  console.log('Result',result);
};
