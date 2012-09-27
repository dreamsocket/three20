//
// Copyright 2009-2011 Facebook
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#import "Three20UI/TTNavigationController.h"

// UI Navigator
#import "Three20UINavigator/TTGlobalNavigatorMetrics.h"

// Network
#import "Three20Network/TTURLRequestQueue.h"


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTNavigationController


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UIViewController


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
  UIViewController *vc = self.visibleViewController;
  if ([vc respondsToSelector:@selector(preferredInterfaceOrientationForPresentation)]) {
    return [vc preferredInterfaceOrientationForPresentation];
  }

  return TTInterfaceOrientation();
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)shouldAutorotate {
  BOOL shouldAutorotate = YES;
  if ([self respondsToSelector:@selector(shouldAutorotateToInterfaceOrientation:)]) {
    NSUInteger mask = 0;
    if ([self shouldAutorotateToInterfaceOrientation:UIInterfaceOrientationPortrait]) {
      mask |= UIInterfaceOrientationMaskPortrait;
    }
    if ([self shouldAutorotateToInterfaceOrientation:UIInterfaceOrientationLandscapeLeft]) {
      mask |= UIInterfaceOrientationMaskLandscapeLeft;
    }
    if ([self shouldAutorotateToInterfaceOrientation:UIInterfaceOrientationLandscapeRight]) {
      mask |= UIInterfaceOrientationMaskLandscapeRight;
    }
    if ([self shouldAutorotateToInterfaceOrientation:UIInterfaceOrientationPortraitUpsideDown]) {
      mask |= UIInterfaceOrientationMaskPortraitUpsideDown;
    }
    if (mask == 0) {
      shouldAutorotate = NO;
    }

  } else {
    shouldAutorotate = [super shouldAutorotate];
  }

  return shouldAutorotate;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSUInteger)supportedInterfaceOrientations {
  return [self.visibleViewController supportedInterfaceOrientations];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Public


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)pushAnimationDidStop {
  [TTURLRequestQueue mainQueue].suspended = NO;

  [super pushAnimationDidStop];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)pushViewController: (UIViewController*)controller
    animatedWithTransition: (UIViewAnimationTransition)transition {
  [TTURLRequestQueue mainQueue].suspended = YES;

  [super pushViewController:controller animatedWithTransition:transition];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIViewController*)popViewControllerAnimatedWithTransition:(UIViewAnimationTransition)transition {
  [TTURLRequestQueue mainQueue].suspended = YES;

  return [super popViewControllerAnimatedWithTransition:transition];
}


@end

