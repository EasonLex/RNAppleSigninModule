#import "RNCSignInWithAppleButton.h"

@implementation RNCSignInWithAppleButton

-(instancetype)initWithAuthorizationButtonType:(ASAuthorizationAppleIDButtonType)type authorizationButtonStyle:(ASAuthorizationAppleIDButtonStyle)style {
  RNCSignInWithAppleButton* btn = [super initWithAuthorizationButtonType:ASAuthorizationAppleIDButtonTypeDefault authorizationButtonStyle:style];
  [btn addTarget:self
          action:@selector(onDidPress)
forControlEvents:UIControlEventTouchUpInside];
  return btn;
}

-(void)onDidPress {
  _onPress(nil);
}

@end
