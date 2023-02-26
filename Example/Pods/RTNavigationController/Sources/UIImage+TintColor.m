//
//  UIImage+TintColor.m
//  
//
//  Created by iWw on 2020/11/30.
//

#import "UIImage+TintColor.h"

@implementation UIImage (TintColor)

- (UIImage *)rt_tintColor:(UIColor *)tintColor {
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    BOOL isOpq = NO;
    CGImageRef imageRef = self.CGImage;
    CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(imageRef);
    if (alphaInfo) {
        isOpq = (alphaInfo == kCGImageAlphaNoneSkipLast) || (alphaInfo == kCGImageAlphaNoneSkipFirst) || (alphaInfo == kCGImageAlphaNone);
    }
    
    UIGraphicsBeginImageContextWithOptions(self.size, isOpq, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGContextClipToMask(context, rect, self.CGImage);
    CGContextSetFillColorWithColor(context, tintColor.CGColor);
    CGContextFillRect(context, rect);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end
