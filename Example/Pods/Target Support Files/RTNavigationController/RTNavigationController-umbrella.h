#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "RTNavigationBar.h"
#import "RTRootNavigationController.h"
#import "UIImage+TintColor.h"
#import "UIViewController+RTRootNavigationController.h"

FOUNDATION_EXPORT double RTNavigationControllerVersionNumber;
FOUNDATION_EXPORT const unsigned char RTNavigationControllerVersionString[];

