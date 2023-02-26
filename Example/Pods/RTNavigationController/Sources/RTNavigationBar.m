//
//  RTNavigationBar.m
//  
//
//  Created by iWw on 2021/1/25.
//

#import "RTNavigationBar.h"

@interface RTNavigationBar ()

@property (nonatomic, retain) UIColor *rt_barTintColor;

@property (nonatomic, assign) BOOL rt_transparentBar;

@property (nonatomic, assign) BOOL rt_removeBottomLine;

@property (nonatomic, retain) UIImage *rt_backgroundImage;
@property (nonatomic, retain) UIImage *rt_shadowImage;

@end

@implementation RTNavigationBar

- (void)setBackgroundImage:(UIImage *)backgroundImage forBarMetrics:(UIBarMetrics)barMetrics {
    [super setBackgroundImage:backgroundImage forBarMetrics:barMetrics];
    self.rt_backgroundImage = backgroundImage;
}

- (void)setShadowImage:(UIImage *)shadowImage {
    [super setShadowImage:shadowImage];
    self.rt_shadowImage = shadowImage;
}

- (void)setBarTintColor:(UIColor *)barTintColor {
    if (self.rt_barTintColor != barTintColor) {
        self.rt_barTintColor = barTintColor;
    }
    [super setBarTintColor:barTintColor];
}

- (void)setTransparentBar:(BOOL)transparentBar {
    self.rt_transparentBar = transparentBar;
}
- (BOOL)isTransparentBar {
    return self.rt_transparentBar;
}

- (void)setRemoveBottomLine:(BOOL)removeBottomLine {
    self.rt_removeBottomLine = removeBottomLine;
}
- (BOOL)isRemoveBottomLine {
    return self.rt_removeBottomLine;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // reload bar tint color
    if (self.rt_barTintColor) {
        [self setBarTintColor:self.rt_barTintColor];
    }
    if (self.rt_transparentBar || (self.rt_backgroundImage && [self.rt_backgroundImage CGImage] == nil)) {
        [self __transparentBarAction];
    } else {
        [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    }
    
    if (self.removeBottomLine || (self.rt_shadowImage && [self.rt_shadowImage CGImage] == nil)) {
        [self __removeBottomLineAction];
    } else {
        [self setShadowImage:nil];
    }
}

- (void)__transparentBarAction {
    [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    for (UIView *v in self.subviews) {
        if ([v isKindOfClass:NSClassFromString(@"_UIBarBackground")]) {
            v.alpha = 0;
            v.hidden = YES;
            break;
        }
    }
}

- (void)__removeBottomLineAction {
    [self setShadowImage:[UIImage new]];
}

@end
