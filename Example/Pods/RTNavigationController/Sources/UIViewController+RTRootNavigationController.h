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

#import <UIKit/UIKit.h>

@class RTNavigationBar;
@class RTRootNavigationController;

@protocol RTNavigationItemCustomizable <NSObject>

@optional

/*!
 *  @brief Override this method to provide a custom back bar item, default is a normal @c UIBarButtonItem with title @b "Back"
 *
 *  @param target the action target
 *  @param action the pop back action
 *
 *  @return a custom UIBarButtonItem
 */
- (UIBarButtonItem * _Nullable)customBackItemWithTarget:(id _Nonnull)target action:(SEL _Nonnull)action DEPRECATED_MSG_ATTRIBUTE("use rt_customBackItemWithTarget:action: instead!");
- (UIBarButtonItem * _Nullable)rt_customBackItemWithTarget:(id _Nonnull)target action:(SEL _Nonnull)action;

@end

@protocol RTNavigationControllerPopObservable <NSObject>

@optional
- (void)willPopFromNavigationStack;
- (void)didPopFromNavigationStack;

@end

IB_DESIGNABLE
@interface UIViewController (RTRootNavigationController) <RTNavigationItemCustomizable, RTNavigationControllerPopObservable>

/*!
 *  @brief set this property to @b YES to disable interactive pop
 */
@property (nonatomic, assign) IBInspectable BOOL rt_disableInteractivePop;

/*!
 *  @brief @c self\.navigationControlle will get a wrapping @c UINavigationController, use this property to get the real navigation controller
 */
@property (nonatomic, readonly, strong) RTRootNavigationController * _Nullable rt_navigationController;

/*!
 *  @brief Override this method to provide a custom subclass of @c UINavigationBar, defaults return nil
 *
 *  @return new UINavigationBar class
 */
- (Class _Nullable)rt_navigationBarClass;

- (RTNavigationBar * _Nullable)rt_navigationBar;

- (void)dismiss;

- (void)dismissWithCompletion:( void (^ _Nullable)(void))completion animated:(BOOL)animated;

/// replace the back indicator image
@property (nonatomic, retain) IBInspectable UIImage * _Nullable rt_backIndicatorImage;

/// custom back indicaotr(general_back) color
@property (nonatomic, retain) IBInspectable UIColor * _Nullable rt_backIndicatorColor;

/// Set navigation bar's title color
/// @param color the color of navigation bar's
- (void)rt_setNavigationBarTitleColor:(UIColor * _Nonnull)color NS_SWIFT_NAME(rt_setNavigationBar(titleColor:));
/// Set navigation bar's title font
- (void)rt_setNavigationBarTitleFont:(UIFont * _Nonnull)font NS_SWIFT_NAME(rt_setNavigationBar(titleFont:));
/// Set navigation bar's title's attributes
- (void)rt_setNavigationBarTitleAttributes:(NSDictionary * _Nonnull)attributes NS_SWIFT_NAME(rt_setNavigationBar(titleAttributes:));
/// Set navigation bar's backgroundColor
- (void)rt_setNavigationBarBackgroundColor:(UIColor * _Nonnull)color NS_SWIFT_NAME(rt_setNavigationBar(backgroundColor:));

- (void)rt_setNavigationBarHidden:(BOOL)isHidden animated:(BOOL)isAnimated NS_SWIFT_NAME(rt_setNavigationBar(hidden:animated:));

/// Set navigation bar's back indicator color
- (void)rt_setNavigationBarBackIndicatorColor:(UIColor * _Nonnull)color NS_SWIFT_NAME(rt_setNavigationBar(backIndicatorColor:));

- (void)rt_transparentNavigationBar;
- (void)rt_removeNavigationBarBottomLine;

//@property (nonatomic, assign) BOOL rt_removeNavigationBarBottomLine;
//@property (nonatomic, assign) BOOL rt_transparentNavigationBar;

@end

@interface UIPercentDrivenInteractiveTransition (Conditional)

@property (nonatomic, assign) BOOL canBeInteractive;

@end
