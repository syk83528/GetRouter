//
//  RTNavigationBar.h
//  
//
//  Created by iWw on 2021/1/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RTNavigationBar : UINavigationBar

@property (nonatomic, assign, getter=isTransparentBar) BOOL transparentBar;

@property (nonatomic, assign, getter=isRemoveBottomLine) BOOL removeBottomLine;

@end

NS_ASSUME_NONNULL_END
