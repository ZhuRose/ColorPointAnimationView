//
//  ColorPoint.h
//  PointAnimation
//
//  Created by 朱煜松 on 16/12/8.
//  Copyright © 2016年 kb210. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColorPoint : UIView
typedef void (^AnimationCalculationAction)(ColorPoint *weakSelf);
typedef void (^AnimationCompletionAction)(ColorPoint *weakSelf);
typedef void (^AnimationCompletion)();

//动画完成后回调
@property (nonatomic, copy)AnimationCompletion animationCompletion;

- (void)delay:(NSTimeInterval)t;

- (void)makeConstraints:(NSLayoutConstraint*)constraint constant:(CGFloat)f;

- (void)moveX:(CGFloat)x Y:(CGFloat)y;
//垂直移动
- (void)moveY:(CGFloat)f;
//拉长
- (void)addHeight:(CGFloat)f;
//弹性
- (void)bounce;
//旋转
- (void)rotation:(CGPoint)center startAngle:(CGFloat)startAngle radius:(CGFloat)radius;
- (void)rotation:(CGPoint)center startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle radius:(CGFloat)radius;
- (void)rotationAngle:(CGFloat)angle;
- (void) makeAnchorFromX:(CGFloat) x Y:(CGFloat)y;
//中间动画时间
- (void)thenAfter:(NSTimeInterval)t;
//结束动画时间
- (void)animate:(NSTimeInterval)duration;

@end
