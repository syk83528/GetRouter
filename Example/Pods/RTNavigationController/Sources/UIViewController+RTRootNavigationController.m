// Copyright (c) 2016 rickytan <ricky.tan.xin@gmail.com>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <objc/runtime.h>

#import "UIViewController+RTRootNavigationController.h"
#import "RTRootNavigationController.h"
#import "RTNavigationBar.h"
#import "UIImage+TintColor.h"

@implementation UIViewController (RTRootNavigationController)
@dynamic rt_disableInteractivePop;

- (void)setRt_disableInteractivePop:(BOOL)rt_disableInteractivePop
{
    objc_setAssociatedObject(self, @selector(rt_disableInteractivePop), @(rt_disableInteractivePop), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)rt_disableInteractivePop
{
    return [objc_getAssociatedObject(self, @selector(rt_disableInteractivePop)) boolValue];
}

- (Class)rt_navigationBarClass
{
    return [RTNavigationBar class];
}

- (RTNavigationBar *)rt_navigationBar
{
    if (self.navigationController && [self.navigationController.navigationBar isKindOfClass:[RTNavigationBar class]]) {
        return (RTNavigationBar *)self.navigationController.navigationBar;
    }
    return nil;
}

- (RTRootNavigationController *)rt_navigationController
{
    UIViewController *vc = self;
    while (vc && ![vc isKindOfClass:[RTRootNavigationController class]]) {
        vc = vc.navigationController;
    }
    return (RTRootNavigationController *)vc;
}

- (void)dismiss {
    [self dismissWithCompletion:nil animated:YES];
}

- (void)dismissWithCompletion:(void (^)(void))completion animated:(BOOL)animated {
    UIViewController *target = self;
    while (target.parentViewController != nil &&
        ![target.parentViewController isKindOfClass:UINavigationController.class]) {
        target = target.parentViewController;
    }
    if (target.rt_navigationController) {
        if (target.rt_navigationController.rt_viewControllers.count > 1) {
            if (target.rt_navigationController.rt_topViewController != target) {
                [target.rt_navigationController removeViewController:target animated:target.isViewLoaded && target.view.window != nil];
            } else {
                [target.navigationController popViewControllerAnimated:animated];
            }
            if (completion) {
                completion();
            }
        } else {
            [target.navigationController dismissViewControllerAnimated:animated completion:completion];
        }
    } else if ([target.navigationController isKindOfClass:[UINavigationController class]]) {
        if (target.navigationController.viewControllers.count > 1) {
            if (target.navigationController.viewControllers.lastObject != target) {
                NSMutableArray *controllers = [NSMutableArray array];
                for (UIViewController *vc in target.navigationController.viewControllers) {
                    if (vc != self) {
                        [controllers addObject:vc];
                    }
                }
                [target.navigationController setViewControllers:controllers animated:target.isViewLoaded && target.view.window != nil];
            } else {
                [target.navigationController popViewControllerAnimated:animated];
            }
            if (completion) {
                completion();
            }
        } else {
            [target.navigationController dismissViewControllerAnimated:animated completion:completion];
        }
    } else {
        [target dismissViewControllerAnimated:animated completion:completion];
    }
}

- (void)willPopFromNavigationStack { }
- (void)didPopFromNavigationStack { }

- (UIImage *)rt_backIndicatorImage {
    return (UIImage *)objc_getAssociatedObject(self, @selector(rt_backIndicatorImage));
}
- (void)setRt_backIndicatorImage:(UIImage *)rt_backIndicatorImage {
    objc_setAssociatedObject(self, @selector(rt_backIndicatorImage), rt_backIndicatorImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)rt_backIndicatorColor {
    return (UIColor *)objc_getAssociatedObject(self, @selector(rt_backIndicatorColor));
}
- (void)setRt_backIndicatorColor:(UIColor *)rt_backIndicatorColor {
    objc_setAssociatedObject(self, @selector(rt_backIndicatorColor), rt_backIndicatorColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (UINavigationBarAppearance *)standardAppearance API_AVAILABLE(ios(13.0)) {
    UINavigationBarAppearance *appearance = self.navigationController.navigationBar.standardAppearance;
    if (!appearance) {
        appearance = [UINavigationBarAppearance new];
        [appearance configureWithDefaultBackground];
        self.navigationController.navigationBar.standardAppearance = appearance;
    }
    return appearance;
}

- (UINavigationBarAppearance *)scrollEdgeAppearance API_AVAILABLE(ios(13.0)) {
    UINavigationBarAppearance *appearance = self.navigationController.navigationBar.scrollEdgeAppearance;
    if (!appearance) {
        appearance = [UINavigationBarAppearance new];
        [appearance configureWithDefaultBackground];
        self.navigationController.navigationBar.scrollEdgeAppearance = appearance;
    }
    return appearance;
}

//- (UINavigationBarAppearance *)compactScrollEdgeAppearance API_AVAILABLE(ios(15.0)) {
//    UINavigationBarAppearance *appearance = self.navigationController.navigationBar.compactScrollEdgeAppearance;
//    if (!appearance) {
//        appearance = [UINavigationBarAppearance new];
//        [appearance configureWithDefaultBackground];
//    }
//    return appearance;
//}

- (void)rt_setNavigationBarTitleColor:(UIColor *)color {
    if (@available(iOS 13.0, *)) {
        NSMutableDictionary *standardDict = [NSMutableDictionary dictionaryWithDictionary:[self standardAppearance].titleTextAttributes];
        standardDict[NSForegroundColorAttributeName] = color;
        [self standardAppearance].titleTextAttributes = standardDict;
        
        NSMutableDictionary *scrollEdgeDict = [NSMutableDictionary dictionaryWithDictionary:[self scrollEdgeAppearance].titleTextAttributes];
        scrollEdgeDict[NSForegroundColorAttributeName] = color;
        [self scrollEdgeAppearance].titleTextAttributes = scrollEdgeDict;
        
//        NSMutableDictionary *compactScrollEdgeDict = [NSMutableDictionary dictionaryWithDictionary:[self compactScrollEdgeAppearance].titleTextAttributes];
//        compactScrollEdgeDict[NSForegroundColorAttributeName] = color;
//        [self compactScrollEdgeAppearance].titleTextAttributes = compactScrollEdgeDict;
    } else {
        UINavigationBar *bar = [self.navigationController navigationBar];
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:[bar titleTextAttributes]];
        dict[NSForegroundColorAttributeName] = color;
        [bar setTitleTextAttributes:[dict copy]];
    }
}
- (void)rt_setNavigationBarTitleFont:(UIFont *)font {
    if (@available(iOS 13.0, *)) {
        NSMutableDictionary *standardDict = [NSMutableDictionary dictionaryWithDictionary:[self standardAppearance].titleTextAttributes];
        standardDict[NSFontAttributeName] = font;
        [self standardAppearance].titleTextAttributes = [standardDict copy];
        
        NSMutableDictionary *scrollEdgeDict = [NSMutableDictionary dictionaryWithDictionary:[self scrollEdgeAppearance].titleTextAttributes];
        scrollEdgeDict[NSFontAttributeName] = font;
        [self scrollEdgeAppearance].titleTextAttributes = [scrollEdgeDict copy];
        
//        NSMutableDictionary *compactScrollEdgeDict = [NSMutableDictionary dictionaryWithDictionary:[self compactScrollEdgeAppearance].titleTextAttributes];
//        compactScrollEdgeDict[NSFontAttributeName] = font;
//        [self compactScrollEdgeAppearance].titleTextAttributes = [compactScrollEdgeDict copy];
        
    } else {
        UINavigationBar *bar = [self.navigationController navigationBar];
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:[bar titleTextAttributes]];
        dict[NSFontAttributeName] = font;
        [bar setTitleTextAttributes:[dict copy]];
    }
}

- (void)rt_setNavigationBarTitleAttributes:(NSDictionary *)attributes {
    if (@available(iOS 13.0, *)) {
        NSMutableDictionary *standardDict = [NSMutableDictionary dictionaryWithDictionary:[self standardAppearance].titleTextAttributes];
        NSMutableDictionary *scrollEdgeDict = [NSMutableDictionary dictionaryWithDictionary:[self scrollEdgeAppearance].titleTextAttributes];
        for (NSString *key in attributes) {
            [standardDict setValue:attributes[key] forKey:key];
            [scrollEdgeDict setValue:attributes[key] forKey:key];
        }
        [self standardAppearance].titleTextAttributes = [standardDict copy];
        [self scrollEdgeAppearance].titleTextAttributes = [scrollEdgeDict copy];
    } else {
        UINavigationBar *bar = [self.navigationController navigationBar];
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:[bar titleTextAttributes]];
        for (NSString *key in attributes.allKeys) {
            [dict setValue:attributes[key] forKey:key];
        }
        [bar setTitleTextAttributes:[dict copy]];
    }
}
- (void)rt_setNavigationBarBackgroundColor:(UIColor *)color {
    if (@available(iOS 13.0, *)) {
        [self standardAppearance].backgroundColor = color;
        [self scrollEdgeAppearance].backgroundColor = color;
    } else {
        [self.navigationController.navigationBar setBarTintColor:color];
    }
}
- (void)rt_setNavigationBarHidden:(BOOL)isHidden animated:(BOOL)isAnimated {
    [self.navigationController setNavigationBarHidden:isHidden animated:isAnimated];
}

- (void)rt_transparentNavigationBar {
    if (@available(iOS 13.0, *)) {
        [self standardAppearance].backgroundColor = [UIColor clearColor];
        [self scrollEdgeAppearance].backgroundColor = [UIColor clearColor];
    }
    
    if (!self.navigationController || !self.navigationController.navigationBar || self.navigationController.navigationBar.isHidden) {
        return;
    }
    
    if ([self.navigationController.navigationBar isKindOfClass:[RTNavigationBar class]]) {
        [(RTNavigationBar *)self.navigationController.navigationBar setTransparentBar:YES];
        return;
    }
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
}

- (UIImage *)shadowImageWithTransparent {
    UIImage *shadowImage;
#if SWIFT_PACKAGE
    shadowImage = [UIImage imageNamed:@"shadow_image_transparent" inBundle:SWIFTPM_MODULE_BUNDLE compatibleWithTraitCollection:nil];
#else
    shadowImage = [UIImage imageNamed:@"shadow_image_transparent" inBundle:POD_BUNDLE compatibleWithTraitCollection:nil];
#endif
    return shadowImage;
}

- (void)rt_removeNavigationBarBottomLine {
    if (@available(iOS 13.0, *)) {
        [self standardAppearance].shadowImage = [self shadowImageWithTransparent];
        [self scrollEdgeAppearance].shadowImage = [self shadowImageWithTransparent];
    } else {
        if (!self.navigationController || !self.navigationController.navigationBar || self.navigationController.navigationBar.isHidden) {
            return;
        }
        if ([self.navigationController.navigationBar isKindOfClass:[RTNavigationBar class]]) {
            [(RTNavigationBar *)self.navigationController.navigationBar setRemoveBottomLine:YES];
            return;
        }
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    }
}

- (void)rt_setNavigationBarBackIndicatorColor:(UIColor *)color {
    UIButton *backButton = (UIButton *)self.navigationItem.leftBarButtonItem.customView.subviews.lastObject;
    if (!backButton) {
        return;
    }
    UIImage *backImage = [backButton imageForState:UIControlStateNormal];
    if (!backImage) {
        return;
    }
    [backButton setImage:[backImage rt_tintColor:color] forState:UIControlStateNormal];
}

@end

@implementation UIPercentDrivenInteractiveTransition (Conditional)

- (BOOL)canBeInteractive {
    return [objc_getAssociatedObject(self, @selector(canBeInteractive)) boolValue];
}

- (void)setCanBeInteractive:(BOOL)canBeInteractive {
    objc_setAssociatedObject(self, @selector(canBeInteractive), @(canBeInteractive), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
