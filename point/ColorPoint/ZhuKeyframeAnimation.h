//
//  ZhuKeyframeAnimation.h
//  PointAnimation
//
//  Created by 朱煜松 on 16/12/8.
//  Copyright © 2016年 kb210. All rights reserved.
//

/*!
 * NSBKeyframeAnimationFunctions是一个基于block的CA动画，这一部分我是抄别人的。。。
 */

#import <QuartzCore/QuartzCore.h>
#import "NSBKeyframeAnimationFunctions.h"

@interface ZhuKeyframeAnimation : CAKeyframeAnimation
typedef double(^NSBKeyframeAnimationFunctionBlock)(double t, double b, double c, double d);
@property (nonatomic, copy) NSBKeyframeAnimationFunctionBlock functionBlock;

@property(strong, nonatomic) id fromValue;
@property(strong, nonatomic) id toValue;

-(void) calculate;
@end
