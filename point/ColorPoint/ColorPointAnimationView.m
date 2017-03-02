//
//  ColorPointAnimationView.m
//  PointAnimation
//
//  Created by 朱煜松 on 16/12/8.
//  Copyright © 2016年 kb210. All rights reserved.
//

#import "ColorPointAnimationView.h"
#import "ColorPoint.h"

#define CenterX self.bounds.size.width/2
#define CenterY self.bounds.size.height/2

@interface ColorPointAnimationView ()
//存放点的数组
@property (nonatomic, strong) NSArray *pointArr;
//判断是否循环
@property (nonatomic, assign) BOOL repeat;
//反转1或-1
@property (nonatomic, assign) int reverse;
//point1 及约束
@property (nonatomic, strong)ColorPoint *point1;
@property (nonatomic, strong)NSLayoutConstraint *centerXLayout1;
@property (nonatomic, strong)NSLayoutConstraint *centerYLayout1;
@property (nonatomic, strong)NSLayoutConstraint *widthLayout1;
@property (nonatomic, strong)NSLayoutConstraint *heightLayout1;
//point2 及约束
@property (nonatomic, strong)ColorPoint *point2;
@property (nonatomic, strong)NSLayoutConstraint *centerXLayout2;
@property (nonatomic, strong)NSLayoutConstraint *centerYLayout2;
//point3 及约束
@property (nonatomic, strong)ColorPoint *point3;
@property (nonatomic, strong)NSLayoutConstraint *centerXLayout3;
@property (nonatomic, strong)NSLayoutConstraint *centerYLayout3;
//point4 及约束
@property (nonatomic, strong)ColorPoint *point4;
@property (nonatomic, strong)NSLayoutConstraint *centerXLayout4;
@property (nonatomic, strong)NSLayoutConstraint *centerYLayout4;
//颜色
@property (nonatomic, strong)UIColor *color1;
@property (nonatomic, strong)UIColor *color2;
@property (nonatomic, strong)UIColor *color3;
@property (nonatomic, strong)UIColor *color4;
//直径
@property (nonatomic, assign)CGFloat mDiameter;
//间距
@property (nonatomic, assign)CGFloat mSpace;
//高度
@property (nonatomic, assign)CGFloat mHeight;
//接下来执行的类型
@property (nonatomic, assign)NSUInteger mType;

@property (nonatomic, assign)int animateIndex;
@end

@implementation ColorPointAnimationView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupPoint];
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        [self setupPoint];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupPoint];
}

- (void)setupPoint {
    [self setupPoint1];
    [self setupPoint2];
    [self setupPoint3];
    [self setupPoint4];
    
    NSArray *pointArr = @[self.point1,self.point2,self.point3,self.point4];
    _pointArr = pointArr;
    
    _repeat = YES;
    _reverse = -1;
    _isRotation = NO;
}

- (void)setupPoint1 {
    _point1 = [[ColorPoint alloc]init];
    _point1.translatesAutoresizingMaskIntoConstraints = NO;
    _point1.layer.cornerRadius = 5.0f;
    [self addSubview:_point1];
    
    _centerXLayout1 = [NSLayoutConstraint constraintWithItem:self.point1 attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    _centerYLayout1 = [NSLayoutConstraint constraintWithItem:self.point1 attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    _widthLayout1 = [NSLayoutConstraint constraintWithItem:self.point1 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:10];
    _heightLayout1 = [NSLayoutConstraint constraintWithItem:self.point1 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:10];
    [self addConstraint:_centerXLayout1];
    [self addConstraint:_centerYLayout1];
    [_point1 addConstraint:_widthLayout1];
    [_point1 addConstraint:_heightLayout1];
}

- (void)setupPoint2 {
    _point2 = [[ColorPoint alloc]init];
    _point2.translatesAutoresizingMaskIntoConstraints = NO;
    _point2.layer.cornerRadius = 5.0f;
    [self addSubview:_point2];
    
    _centerXLayout2 = [NSLayoutConstraint constraintWithItem:self.point2 attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    _centerYLayout2 = [NSLayoutConstraint constraintWithItem:self.point2 attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    NSLayoutConstraint *_widthLayout2 = [NSLayoutConstraint constraintWithItem:self.point2 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.point1 attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
    NSLayoutConstraint *_heightLayout2 = [NSLayoutConstraint constraintWithItem:self.point2 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.point1 attribute:NSLayoutAttributeHeight multiplier:1 constant:0];
    [self addConstraint:_centerXLayout2];
    [self addConstraint:_centerYLayout2];
    [self addConstraint:_widthLayout2];
    [self addConstraint:_heightLayout2];
}

- (void)setupPoint3 {
    _point3 = [[ColorPoint alloc]init];
    _point3.translatesAutoresizingMaskIntoConstraints = NO;
    _point3.layer.cornerRadius = 5.0f;
    [self addSubview:_point3];
    
    _centerXLayout3 = [NSLayoutConstraint constraintWithItem:self.point3 attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    _centerYLayout3 = [NSLayoutConstraint constraintWithItem:self.point3 attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    NSLayoutConstraint *_widthLayout3 = [NSLayoutConstraint constraintWithItem:self.point3 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.point1 attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
    NSLayoutConstraint *_heightLayout3 = [NSLayoutConstraint constraintWithItem:self.point3 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.point1 attribute:NSLayoutAttributeHeight multiplier:1 constant:0];
    [self addConstraint:_centerXLayout3];
    [self addConstraint:_centerYLayout3];
    [self addConstraint:_widthLayout3];
    [self addConstraint:_heightLayout3];
}

- (void)setupPoint4 {
    _point4 = [[ColorPoint alloc]init];
    _point4.translatesAutoresizingMaskIntoConstraints = NO;
    _point4.layer.cornerRadius = 5.0f;
    [self addSubview:_point4];
    
    _centerXLayout4 = [NSLayoutConstraint constraintWithItem:self.point4 attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    _centerYLayout4 = [NSLayoutConstraint constraintWithItem:self.point4 attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    NSLayoutConstraint *_widthLayout4 = [NSLayoutConstraint constraintWithItem:self.point4 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.point1 attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
    NSLayoutConstraint *_heightLayout4 = [NSLayoutConstraint constraintWithItem:self.point4 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.point1 attribute:NSLayoutAttributeHeight multiplier:1 constant:0];
    [self addConstraint:_centerXLayout4];
    [self addConstraint:_centerYLayout4];
    [self addConstraint:_widthLayout4];
    [self addConstraint:_heightLayout4];
}


- (void)setPointColor1:(UIColor *)color1 color2:(UIColor *)color2 color3:(UIColor *)color3 color4:(UIColor *)color4 diameter:(CGFloat)diameter space:(CGFloat)space maxHeight:(CGFloat)maxHeight{
    //重置属性
    _repeat = YES;
    _isRotation = NO;
    //修改直径
    _color1 = color1;
    _color2 = color2;
    _color3 = color3;
    _color4 = color4;
    _mDiameter = diameter;
    _mSpace = space;
    _widthLayout1.constant = diameter;
    _heightLayout1.constant = diameter;
    _mHeight = maxHeight;
    
    //修改point1颜色、位置
    _point1.backgroundColor = color1;
    _point1.layer.cornerRadius = diameter/2;
    _centerXLayout1.constant = -3*space/2;
    _centerYLayout1.constant = 0;
    //修改point2颜色、位置
    _point2.backgroundColor = color2;
    _point2.layer.cornerRadius = diameter/2;
    _centerXLayout2.constant = -space/2;
    _centerYLayout2.constant = 0;
    //修改point3颜色、位置
    _point3.backgroundColor = color3;
    _point3.layer.cornerRadius = diameter/2;
    _centerXLayout3.constant = space/2;
    _centerYLayout3.constant = 0;
    //修改point4颜色、位置
    _point4.backgroundColor = color4;
    _point4.layer.cornerRadius = diameter/2;
    _centerXLayout4.constant = 3*space/2;
    _centerYLayout4.constant = 0;
    [self layoutSubviews];
}

- (void)changePointCenter:(void(^)())block {
    _point1.layer.position = CGPointMake(CenterX, CenterY-_mSpace/2-1);
    _point2.layer.position = CGPointMake(CenterX-_mSpace/2-1, CenterY);
    _point3.layer.position = CGPointMake(CenterX+_mSpace/2+1, CenterY);
    _point4.layer.position = CGPointMake(CenterX, CenterY+_mSpace/2+1);
    _point1.layer.bounds = CGRectMake(_point1.layer.bounds.origin.x,_point1.layer.bounds.origin.y,_mDiameter, _mDiameter);
    _point2.layer.bounds = CGRectMake(_point2.layer.bounds.origin.x,_point2.layer.bounds.origin.y,_mDiameter, _mDiameter);
    _point3.layer.bounds = CGRectMake(_point3.layer.bounds.origin.x,_point3.layer.bounds.origin.y,_mDiameter, _mDiameter);
    _point4.layer.bounds = CGRectMake(_point4.layer.bounds.origin.x,_point4.layer.bounds.origin.y,_mDiameter, _mDiameter);
    block();
}

- (void)resetPointCenter:(void(^)())block {
    _point1.layer.transform = CATransform3DIdentity;
    _point2.layer.transform = CATransform3DIdentity;
    _point3.layer.transform = CATransform3DIdentity;
    _point4.layer.transform = CATransform3DIdentity;
    _point1.layer.position = CGPointMake(CenterX-3*_mSpace/2, CenterY);
    _point2.layer.position = CGPointMake(CenterX-_mSpace/2, CenterY);
    _point3.layer.position = CGPointMake(CenterX+_mSpace/2, CenterY);
    _point4.layer.position = CGPointMake(CenterX+3*_mSpace/2, CenterY);
    _point1.layer.anchorPoint = CGPointMake(0.5, 0.5);
    _point2.layer.anchorPoint = CGPointMake(0.5, 0.5);
    _point3.layer.anchorPoint = CGPointMake(0.5, 0.5);
    _point4.layer.anchorPoint = CGPointMake(0.5, 0.5);
    block();
}

//检查是平移1还是拉伸2
- (void)checkAnimation:(NSUInteger)type {
    _animateIndex = 0;
    switch (type) {
        case 1: {//平移动画
            [self pointMove:_point1 y:_mHeight/10*_reverse];
            [self pointMove:_point2 y:-_mHeight/10*_reverse];
            [self pointMove:_point3 y:_mHeight/10*_reverse];
            [self pointMove:_point4 y:-_mHeight/10*_reverse];
        }
            break;
        case 2: {//拉伸动画
            [self pointChange:_point1 height:_mHeight/4];
            [self pointChange:_point2 height:3*_mHeight/8];
            [self pointChange:_point3 height:_mHeight/2];
            [self pointChange:_point4 height:_mHeight/8];
        }
            break;
        default:
            break;
    }
}

//三段旋转
- (void)prepareRotation {
    _animateIndex = 0;
    for (ColorPoint *point in _pointArr) {
        [self pointRotation:point];
    }
}

- (void)fastRotation {
    _animateIndex = 0;
    for (ColorPoint *point in _pointArr) {
        [self pointFastRotation:point];
    }
}

- (void)slowRotation {
    _animateIndex = 0;
    for (ColorPoint *point in _pointArr) {
        [self pointSlowRotation:point];
    }
}

//平移动画
- (void)moveAnimation {
    if (_isRotation) return;
    _mType = 1;
}

//拉伸动画
- (void)changAnimation {
    if (_isRotation) return;
    _mType = 2;
}

//旋转动画
- (void)rotationAnimation {
    if (_isRotation) return;
    _isRotation = YES;
}

//开始上下平移动画
- (void)beginAnimation {
    if (_isRotation) return;
    [self resetPointCenter:^{
        _repeat = YES;
        _mType = 1;
        [self checkAnimation:1];
    }];
    
}

//停止动画
- (void)stopAnimation {
    _repeat = NO;
    [_point1.layer removeAllAnimations];
    [_point2.layer removeAllAnimations];
    [_point3.layer removeAllAnimations];
    [_point4.layer removeAllAnimations];
    [self resetPointCenter:^{
        
    }];
}

- (void)stopRotationAnimationWithType:(NSUInteger)type {
    if (!_isRotation) return;
    _isRotation = NO;
    _mType = type;
}


#pragma mark 动画代码
- (void)pointMove:(ColorPoint*)point y:(CGFloat)y {
    __weak ColorPointAnimationView *weakSelf = self;
    point.animationCompletion = ^(){
        if (_repeat) {
            _animateIndex++;
            if (_animateIndex==4) {
                if (_isRotation) [weakSelf changePointCenter:^{
                    [weakSelf prepareRotation];
                }];
                else {
                    _reverse = - _reverse;
                    [weakSelf checkAnimation:_mType];
                }
            }
        }
    };
    //动画共计0.8s
    [point moveY:y];
    [point thenAfter:0.4];
    [point moveY:-y];
    [point animate:0.4];
}

- (void)pointChange:(ColorPoint*)point height:(CGFloat)y {
    __weak ColorPointAnimationView *weakSelf = self;
    point.animationCompletion = ^(){
        if (_repeat) {
            _animateIndex++;
            if (_animateIndex==4) {
                if (_isRotation) [weakSelf changePointCenter:^{
                    [weakSelf prepareRotation];
                }];
                else [weakSelf checkAnimation:_mType];
            }
        }
    };
    //动画共计0.8s
    [point addHeight:y];
    [point bounce];
    [point thenAfter:0.1];
    [point addHeight:y];
    [point bounce];
    [point thenAfter:0.15];
    [point addHeight:-y];
    [point bounce];
    [point thenAfter:0.1];
    [point addHeight:y];
    [point bounce];
    [point thenAfter:0.15];
    [point addHeight:-y];
    [point bounce];
    [point thenAfter:0.15];
    [point addHeight:-y];
    [point bounce];
    [point animate:0.1];
}


- (void)pointRotation:(ColorPoint*)point {
    __weak ColorPointAnimationView *weakSelf = self;
    point.animationCompletion = ^(){
        if (_repeat) {
            _animateIndex++;
            if (_animateIndex==4) {
                if (_isRotation) [weakSelf fastRotation];
                else [weakSelf resetPointCenter:^{
                    [weakSelf checkAnimation:_mType];
                }];
                
            }
        }
    };
    //确定四个点角度
    CGFloat scale = (_mSpace/2 + 1)/_mDiameter;
    if (point == _point1) [point makeAnchorFromX:0.5f Y:scale+0.5f];
    else if (point == _point2) [point makeAnchorFromX:scale+0.5f Y:0.5f];
    else if (point == _point3) [point makeAnchorFromX:-scale+0.5f Y:0.5f];
    else [point makeAnchorFromX:0.5f Y:-scale+0.5f];
    //动画共计0.8s
    [point rotationAngle:360];
    [point animate:0.8];
}

- (void)pointFastRotation:(ColorPoint*)point {
    __weak ColorPointAnimationView *weakSelf = self;
    point.animationCompletion = ^(){
        if (_repeat) {
            _animateIndex++;
            if (_animateIndex==4) {
                if (_isRotation) [weakSelf slowRotation];
                else [weakSelf resetPointCenter:^{
                    [weakSelf checkAnimation:_mType];
                }];
            }
        }
    };
    //确定四个点角度
    CGFloat scale = (_mSpace/2 + 1)/_mDiameter;
    CGFloat angle = 0;
    if (point == _point1) {
        [point makeAnchorFromX:0.5f Y:scale+0.5f];
        angle = 360;
    }
    else if (point == _point2) {
        [point makeAnchorFromX:scale+0.5f Y:0.5f];
        angle = 390;
    }
    else if (point == _point3) {
        [point makeAnchorFromX:-scale+0.5f Y:0.5f];
        angle = 450;
    }
    else {
        [point makeAnchorFromX:0.5f Y:-scale+0.5f];
        angle = 420;
    }
    //动画共计0.8s
    [point rotationAngle:angle];
    [point animate:0.8];
}

- (void)pointSlowRotation:(ColorPoint*)point {
    __weak ColorPointAnimationView *weakSelf = self;
    point.animationCompletion = ^(){
        if (_repeat) {
            _animateIndex++;
            if (_animateIndex==4) {
                if (_isRotation) [weakSelf prepareRotation];
                else [weakSelf resetPointCenter:^{
                    [weakSelf checkAnimation:_mType];
                }];
            }
        }
    };
    //确定四个点角度
    CGFloat scale = (_mSpace/2 + 1)/_mDiameter;
    CGFloat angle = 0;
    if (point == _point1) {
        [point makeAnchorFromX:0.5f Y:scale+0.5f];
        angle = 360;
    }
    else if (point == _point2) {
        [point makeAnchorFromX:scale+0.5f Y:0.5f];
        angle = 330;
    }
    else if (point == _point3) {
        [point makeAnchorFromX:-scale+0.5f Y:0.5f];
        angle = 270;
    }
    else {
        [point makeAnchorFromX:0.5f Y:-scale+0.5f];
        angle = 300;
    }

    //动画共计0.8s
    [point rotationAngle:angle];
    [point animate:0.8];

}

@end
