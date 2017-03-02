//
//  ColorPointAnimationView.h
//  PointAnimation
//
//  Created by 朱煜松 on 16/12/8.
//  Copyright © 2016年 kb210. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColorPointAnimationView : UIView

@property (nonatomic, assign) BOOL isRotation;

- (void)moveAnimation;
- (void)changAnimation;
- (void)rotationAnimation;
- (void)beginAnimation;
- (void)stopAnimation;
- (void)stopRotationAnimationWithType:(NSUInteger)type;

//设置圆点颜色、直径和间距
- (void)setPointColor1:(UIColor*)color1 color2:(UIColor*)color2 color3:(UIColor*)color3 color4:(UIColor*)color4 diameter:(CGFloat)diameter space:(CGFloat)space maxHeight:(CGFloat)maxHeight;

@end
