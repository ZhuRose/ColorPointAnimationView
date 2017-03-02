//
//  ViewController.m
//  point
//
//  Created by 朱煜松 on 16/12/9.
//  Copyright © 2016年 kb210. All rights reserved.
//

#import "ViewController.h"
#import "ColorPointAnimationView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet ColorPointAnimationView *cView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_cView setPointColor1:[UIColor redColor] color2:[UIColor greenColor] color3:[UIColor blueColor] color4:[UIColor yellowColor] diameter:8 space:24 maxHeight:15];
    [_cView beginAnimation];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"消失了");;
}



- (IBAction)btnClick:(UIButton *)sender {
    switch (sender.tag) {
        case 0: {
            if ([sender.titleLabel.text isEqualToString:@"停止动画"]) {
                [_cView stopAnimation];
                [sender setTitle:@"开始动画" forState:UIControlStateNormal];
            } else {
                [_cView beginAnimation];
                [sender setTitle:@"停止动画" forState:UIControlStateNormal];
            }
        }
            break;
        case 1:
            [_cView moveAnimation];
            break;
        case 2:
            [_cView changAnimation];
            break;
        case 3:{
            
            [_cView rotationAnimation];
        }
            break;
        case 4:
            [_cView stopRotationAnimationWithType:1];
            break;
            
        default:
            break;
    }
}

@end
