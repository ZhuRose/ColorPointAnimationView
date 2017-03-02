//
//  ColorPoint.m
//  PointAnimation
//
//  Created by 朱煜松 on 16/12/8.
//  Copyright © 2016年 kb210. All rights reserved.
//

#import "ColorPoint.h"
#import "ZhuKeyframeAnimation.h"


//两点间距离
CGFloat distanceBetweenPoints (CGPoint first, CGPoint second) {
    CGFloat deltaX = second.x - first.x;
    CGFloat deltaY = second.y - first.y;
    return sqrt(deltaX*deltaX + deltaY*deltaY );
};

//两点间角度
CGFloat angleBetweenPoints(CGPoint first, CGPoint second) {
    CGFloat height = second.y - first.y;
    CGFloat width = first.x - second.x;
    CGFloat rads = atan(height/width);
    return rads;
    //degs = degrees(atan((top - bottom)/(right - left)))
}
/** Degrees to Radian **/
#define degreesToRadians( degrees ) ( ( degrees ) / 180.0 * M_PI )

@interface ColorPoint ()

//存放执行动画的数组
@property (nonatomic, strong)NSMutableArray *animationCalculationActions;
//存放完成动画的数组
@property (nonatomic, strong)NSMutableArray *animationCompletionActions;
//当前执行的动画数组
@property (nonatomic, strong)NSMutableArray *animations;
//存放CAAnimationGroup的数组
@property (nonatomic, strong)NSMutableArray *animationGroups;
@end

@implementation ColorPoint

- (void)delay:(NSTimeInterval)t {
    for (CAAnimation *aGroup in self.animationGroups) {
        t+=aGroup.duration;
    }
    CAAnimationGroup *group = [self.animationGroups lastObject];
    group.beginTime = CACurrentMediaTime() + t;
}

- (void)makeConstraints:(NSLayoutConstraint*)constraint constant:(CGFloat)f {
    [self addAnimationCalculationAction:^(UIView *weakSelf) {
        if ([weakSelf.constraints containsObject:constraint]) {
            constraint.constant = f;
            [weakSelf setNeedsUpdateConstraints];
        }
    }];

}

- (void)moveY:(CGFloat)f{
    [self addAnimationCalculationAction:^(ColorPoint *weakSelf) {
        ZhuKeyframeAnimation *positionAnimation = [weakSelf basicAnimationForKeyPath:@"position.y"];
        positionAnimation.fromValue = @(weakSelf.layer.position.y);
        positionAnimation.toValue = @(weakSelf.layer.position.y+f);
        [weakSelf addAnimationFromCalculationBlock:positionAnimation];
    }];
    [self addAnimationCompletionAction:^(ColorPoint *weakSelf) {
        CGPoint position = weakSelf.layer.position;
        position.y += f;
        weakSelf.layer.position = position;
    }];
    
}

- (void)moveX:(CGFloat)x Y:(CGFloat)y {
    [self addAnimationCalculationAction:^(ColorPoint *weakSelf) {
        ZhuKeyframeAnimation *positionAnimation = [weakSelf basicAnimationForKeyPath:@"position"];
        CGPoint oldOrigin = weakSelf.layer.frame.origin;
        CGPoint newPosition = [weakSelf newPositionFromNewOrigin:CGPointMake(oldOrigin.x+x, oldOrigin.y+y)];
        positionAnimation.fromValue = [NSValue valueWithCGPoint:weakSelf.layer.position];
        positionAnimation.toValue = [NSValue valueWithCGPoint:newPosition];
        [weakSelf addAnimationFromCalculationBlock:positionAnimation];
    }];
    [self addAnimationCompletionAction:^(UIView *weakSelf) {
        CGPoint position = weakSelf.layer.position;
        position.x +=x; position.y += y;
        weakSelf.layer.position = position;
    }];

}

- (void)addHeight:(CGFloat)f {
    [self addAnimationCalculationAction:^(ColorPoint *weakSelf) {
        ZhuKeyframeAnimation *sizeAnimation = [weakSelf basicAnimationForKeyPath:@"bounds.size"];
        sizeAnimation.fromValue = [NSValue valueWithCGSize:weakSelf.layer.bounds.size];
        sizeAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(weakSelf.bounds.size.width, MAX(weakSelf.bounds.size.height+f, 0))];
        [weakSelf addAnimationFromCalculationBlock:sizeAnimation];
    }];
    [self addAnimationCompletionAction:^(UIView *weakSelf) {
        CGRect bounds = CGRectMake(0, 0, weakSelf.bounds.size.width, MAX(weakSelf.bounds.size.height+f, 0));
        weakSelf.layer.bounds = bounds;
        weakSelf.bounds = bounds;
    }];
}

- (void)bounce {
    [self addAnimationKeyframeCalculation:^double(double t, double b, double c, double d) {
        return NSBKeyframeAnimationFunctionEaseOutBounce(t, b, c, d);
    }];

}

- (void)rotation:(CGPoint)center startAngle:(CGFloat)startAngle radius:(CGFloat)radius{
    //    CGFloat radius = distanceBetweenPoints(center, self.center);
    //    CGFloat startAngle = angleBetweenPoints(center, self.center);
    
    [self rotation:center startAngle:startAngle endAngle:2*M_PI radius:radius];
}

- (void)rotation:(CGPoint)center startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle radius:(CGFloat)radius {
    UIBezierPath *path=[UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle + startAngle clockwise:YES];
    [self addAnimationCalculationAction:^(ColorPoint *weakSelf) {
        ZhuKeyframeAnimation *pathAnimation = [weakSelf basicAnimationForKeyPath:@"position"];
        pathAnimation.path = path.CGPath;
        pathAnimation.rotationMode = kCAAnimationRotateAuto;
        [weakSelf addAnimationFromCalculationBlock:pathAnimation];
    }];
    [self addAnimationCompletionAction:^(UIView *weakSelf) {
        CGPoint endPoint = path.currentPoint;
        weakSelf.layer.position = endPoint;
    }];
}

- (void)rotationAngle:(CGFloat)angle {
    [self addAnimationCalculationAction:^(ColorPoint *weakSelf) {
        ZhuKeyframeAnimation *rotationAnimation = [weakSelf basicAnimationForKeyPath:@"transform.rotation.z"];
        CATransform3D transform = weakSelf.layer.transform;
        CGFloat originalRotation = atan2(transform.m12, transform.m11);
        rotationAnimation.fromValue = @(originalRotation);
        rotationAnimation.toValue = @(originalRotation+degreesToRadians(angle));
        [weakSelf addAnimationFromCalculationBlock:rotationAnimation];
    }];
    [self addAnimationCompletionAction:^(UIView *weakSelf) {
        CATransform3D transform = weakSelf.layer.transform;
        CGFloat originalRotation = atan2(transform.m12, transform.m11);
        CATransform3D zRotation = CATransform3DMakeRotation(degreesToRadians(angle)+originalRotation, 0, 0, 1.0);
        weakSelf.layer.transform = zRotation;
    }];

}


- (void)thenAfter:(NSTimeInterval)t {
    CAAnimationGroup *group = [self.animationGroups lastObject];
    group.duration = t;
    CAAnimationGroup *newGroup = [CAAnimationGroup animation];
    [self.animationGroups addObject:newGroup];
    [self.animations addObject:[NSMutableArray array]];
    [self.animationCompletionActions addObject:[NSMutableArray array]];
    [self.animationCalculationActions addObject:[NSMutableArray array]];

}

- (void)animate:(NSTimeInterval)duration {
    CAAnimationGroup *group = [self.animationGroups lastObject];
    group.duration = duration;
    [self animateChain];
}


//开始动画链，调用animate时调用
-(void) animateChain {
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    [CATransaction setCompletionBlock:^{
        [self.layer removeAnimationForKey:@"AnimationChain"];
        [self chainLinkDidFinishAnimating];
    }];
    
    [self animateChainLink];
    
    [CATransaction commit];
    
    [self executeCompletionActions];
}

//完成动画的回调
-(void) chainLinkDidFinishAnimating {
    [self.animationCompletionActions removeObjectAtIndex:0];
    [self.animationCalculationActions removeObjectAtIndex:0];
    [self.animations removeObjectAtIndex:0];
    [self.animationGroups removeObjectAtIndex:0];
    if (self.animationGroups.count == 0) {
        [self clear];
        if (self.animationCompletion) {
            AnimationCompletion completion = self.animationCompletion;
            self.animationCompletion = nil;
            completion();
        }
    }
    else {
        [self animateChain];
    }
}

//执行动画
-(void) animateChainLink {
    [self makeAnchorFromX:0.5 Y:0.5];
    NSMutableArray *actionCluster = [self.animationCalculationActions firstObject];
    for (AnimationCalculationAction action in actionCluster) {
        __weak ColorPoint *weakSelf = self;
        action(weakSelf);
    }
    CAAnimationGroup *group = [self.animationGroups firstObject];
    NSMutableArray *animationCluster = [self.animations firstObject];
    for (ZhuKeyframeAnimation *animation in animationCluster) {
        animation.duration = group.duration;
        [animation calculate];
    }
    group.animations = animationCluster;
    [self.layer addAnimation:group forKey:@"AnimationChain"];
    
    // For constraints
    NSTimeInterval delay = MAX(group.beginTime - CACurrentMediaTime(), 0.0);
    [self.class animateWithDuration:group.duration
                              delay:delay
                            options:0
                         animations:^{
                             [self updateConstraints];
                         } completion:nil];
}

//将下一段执行动画添加进执行动画数组
-(void) executeCompletionActions {
    CAAnimationGroup *group = [self.animationGroups firstObject];
    NSTimeInterval delay = MAX(group.beginTime - CACurrentMediaTime(), 0.0);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSMutableArray *actionCluster = [self.animationCompletionActions firstObject];
        for (AnimationCompletionAction action in actionCluster) {
            __weak ColorPoint *weakSelf = self;
            action(weakSelf);
        }
    });
}



//清除所有数组
-(void) clear {
    [self.animations removeAllObjects];
    [self.animationGroups removeAllObjects];
    [self.animationCompletionActions removeAllObjects];
    [self.animationCalculationActions removeAllObjects];
    [self.animations addObject:[NSMutableArray array]];
    [self.animationCompletionActions addObject:[NSMutableArray array]];
    [self.animationCalculationActions addObject:[NSMutableArray array]];
    [self.animationGroups addObject:[CAAnimationGroup animation]];
}


#pragma mark 动画组合
-(CGPoint) newPositionFromNewOrigin:(CGPoint) newOrigin {
    CGPoint anchor = self.layer.anchorPoint;
    CGSize size = self.bounds.size;
    CGPoint newPosition;
    newPosition.x = newOrigin.x + anchor.x*size.width;
    newPosition.y = newOrigin.y + anchor.y*size.height;
    return newPosition;
}

-(void) makeAnchorFromX:(CGFloat) x Y:(CGFloat)y {
    AnimationCalculationAction action = ^void(UIView *weakSelf){
        CGPoint anchorPoint = CGPointMake(x, y);
        if (CGPointEqualToPoint(anchorPoint, weakSelf.layer.anchorPoint)) {
            return;
        }
        CGPoint newPoint = CGPointMake(weakSelf.bounds.size.width * anchorPoint.x,
                                       weakSelf.bounds.size.height * anchorPoint.y);
        CGPoint oldPoint = CGPointMake(weakSelf.bounds.size.width * weakSelf.layer.anchorPoint.x,
                                       weakSelf.bounds.size.height * weakSelf.layer.anchorPoint.y);
        
        newPoint = CGPointApplyAffineTransform(newPoint, weakSelf.transform);
        oldPoint = CGPointApplyAffineTransform(oldPoint, weakSelf.transform);
        
        CGPoint position = weakSelf.layer.position;
        
        position.x -= oldPoint.x;
        position.x += newPoint.x;
        
        position.y -= oldPoint.y;
        position.y += newPoint.y;
        
        weakSelf.layer.position = position;
        weakSelf.layer.anchorPoint = anchorPoint;
    };
    NSMutableArray *lastCalculationActions = [self.animationCalculationActions lastObject];
    [lastCalculationActions insertObject:action atIndex:0];
}

-(ZhuKeyframeAnimation *) basicAnimationForKeyPath:(NSString *) keypath {
    ZhuKeyframeAnimation * animation = [ZhuKeyframeAnimation animationWithKeyPath:keypath];
    animation.repeatCount = 0;
    animation.autoreverses = NO;
    return animation;
}

#pragma mark 添加数组
-(void) addAnimationKeyframeCalculation:(NSBKeyframeAnimationFunctionBlock) functionBlock {
    [self addAnimationCalculationAction:^(ColorPoint *weakSelf) {
        NSMutableArray *animationCluster = [weakSelf.animations firstObject];
        ZhuKeyframeAnimation *animation = [animationCluster lastObject];
        animation.functionBlock = functionBlock;
    }];
}

-(void) addAnimationFromCalculationBlock:(ZhuKeyframeAnimation *) animation {
    NSMutableArray *animationCluster = [self.animations firstObject];
    [animationCluster addObject:animation];
}

-(void) addAnimation:(ZhuKeyframeAnimation *) animation {
    NSMutableArray *animationCluster = [self.animations lastObject];
    [animationCluster addObject:animation];
}

- (void)addAnimationCalculationAction:(AnimationCalculationAction)action {
    NSMutableArray *actions = [self.animationCalculationActions lastObject];
    [actions addObject:action];
}

- (void)addAnimationCompletionAction:(AnimationCompletionAction)action {
    NSMutableArray *actions = [self.animationCompletionActions lastObject];
    [actions addObject:action];
}

#pragma mark 懒加载
-  (NSMutableArray *)animationCalculationActions {
    if (!_animationCalculationActions) {
        _animationCalculationActions = [NSMutableArray arrayWithObject:[NSMutableArray array]];
    }
    return _animationCalculationActions;
}

- (NSMutableArray *)animationCompletionActions {
    if (!_animationCompletionActions) {
        _animationCompletionActions = [NSMutableArray arrayWithObject:[NSMutableArray array]];
    }
    return _animationCompletionActions;
}

- (NSMutableArray *)animations {
    if (!_animations) {
        _animations = [NSMutableArray arrayWithObject:[NSMutableArray array]];
    }
    return _animations;
}

- (NSMutableArray *)animationGroups {
    if (!_animationGroups) {
        _animationGroups = [NSMutableArray arrayWithObject:[CAAnimationGroup animation]];
    }
    return _animationGroups;
}
@end
