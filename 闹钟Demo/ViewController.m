//
//  ViewController.m
//  闹钟Demo
//
//  Created by zhang on 16/8/28.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ZPClockFaceView *clockFace=[[ZPClockFaceView alloc]initWithFrame:CGRectMake(30, 100, [UIScreen mainScreen].bounds.size.width-60, [UIScreen mainScreen].bounds.size.width-60)];
    clockFace.backgroundColor=[UIColor clearColor];
    [clockFace initView];
    [self.view addSubview:clockFace];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
