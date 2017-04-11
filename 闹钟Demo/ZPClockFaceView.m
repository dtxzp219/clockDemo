//
//  ZPClockFaceView.m
//  闹钟Demo
//
//  Created by zhang on 16/8/28.
//  Copyright © 2016年 zhang. All rights reserved.
//

//获得当前的年月日 时分秒
#define  CURRENTSEC [[NSCalendar currentCalendar] component:NSCalendarUnitSecond fromDate:[NSDate date]]
#define  CURRENTMIN [[NSCalendar currentCalendar] component:NSCalendarUnitMinute fromDate:[NSDate date]]
#define  CURRENTHOUR [[NSCalendar currentCalendar] component:NSCalendarUnitHour fromDate:[NSDate date]]
#define  CURRENTDAY  [[NSCalendar currentCalendar] component:NSCalendarUnitDay fromDate:[NSDate date]]
#define  CURRENTMONTH [[NSCalendar currentCalendar] component:NSCalendarUnitMonth fromDate:[NSDate date]]
#define  CURRENTYEAR [[NSCalendar currentCalendar] component:NSCalendarUnitYear fromDate:[NSDate date]]

//角度转换成弧度
#define  ANGEL(x) x/180.0 * M_PI

#define kPerSecondA     ANGEL(6)
#define kPerMinuteA     ANGEL(6)
#define kPerHourA       ANGEL(30)
#define kPerHourMinuteA ANGEL(0.5)


#import "ZPClockFaceView.h"

@implementation ZPClockFaceView
{
    CALayer *miaoShape;
    CALayer *minLayer;
    CALayer *hourLayer;
}
-(void)drawRect:(CGRect)rect
{
//    CGContextRef context=UIGraphicsGetCurrentContext();
//    CGContextSetRGBStrokeColor(context, 0.5, 0.5, 0.5, 1);
//    CGContextSetLineWidth(context, 1);

}
-(void)initView
{
    
    UIBezierPath *bezierPath1=[UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2) radius: self.frame.size.width/2 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    
    CAShapeLayer *layer1 = [CAShapeLayer layer];
    layer1.frame         = self.bounds;                // 与showView的frame一致
    layer1.strokeColor   = [UIColor blackColor].CGColor;   // 边缘线的颜色
    layer1.fillColor     = [UIColor grayColor].CGColor;   // 闭环填充的颜色
    layer1.path          = bezierPath1.CGPath;                    // 从贝塞尔曲线获取到形状
    layer1.lineWidth     = 1.0f;                           // 线条宽度
    layer1.strokeStart   = 0.0f;
    layer1.strokeEnd     = 1.0f;
    [self.layer addSublayer:layer1];
    
    
    CABasicAnimation *pathAnimation1 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation1.duration = 3.0;
    pathAnimation1.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];

    pathAnimation1.fromValue = [NSNumber numberWithFloat:0.01];
    pathAnimation1.toValue = [NSNumber numberWithFloat:1.0f];
    [layer1 addAnimation:pathAnimation1 forKey:nil];

    //生成刻度
    UIBezierPath *bezierPath=[UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2) radius: self.frame.size.width/2-2 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame         = self.bounds;                // 与showView的frame一致
    layer.strokeColor   = [UIColor whiteColor].CGColor;   // 边缘线的颜色
    layer.fillColor     = [UIColor clearColor].CGColor;   // 闭环填充的颜色
    //    layer.lineCap       = kCALineCapSquare;               // 边缘线的类型
    layer.path          = bezierPath.CGPath;                    // 从贝塞尔曲线获取到形状
    layer.lineWidth     = 5.0f;                           // 线条宽度
    layer.strokeStart   = 0.0f;
    layer.strokeEnd     = 1.0f;
//    layer.lineDashPhase = ((self.frame.size.width-2)*M_PI)/60;
    layer.lineDashPattern=@[@(0),@(((self.frame.size.width-4)*M_PI)/60)];
    [self.layer addSublayer:layer];
    
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 3.0;
    pathAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.01];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    [layer addAnimation:pathAnimation forKey:nil];

    
    CATextLayer *textLayer=[CATextLayer layer];
    textLayer.frame=CGRectMake((self.frame.size.width-20)/2, 0, 20, 20);
    textLayer.string=@"12";
    textLayer.foregroundColor=[UIColor blackColor].CGColor;
    textLayer.alignmentMode=kCAAlignmentJustified;
    textLayer.fontSize=18;
    textLayer.contentsScale=[UIScreen mainScreen].scale;
    [self.layer addSublayer:textLayer];
    
    CATextLayer *textLayer1=[CATextLayer layer];
    textLayer1.frame=CGRectMake((self.frame.size.width-20), (self.frame.size.width-20)/2, 20, 20);
    textLayer1.string=@"3";
    textLayer1.foregroundColor=[UIColor blackColor].CGColor;
    textLayer1.alignmentMode=kCAAlignmentJustified;
    textLayer1.fontSize=18;
    textLayer1.contentsScale=[UIScreen mainScreen].scale;
    [self.layer addSublayer:textLayer1];

    
    CATextLayer *textLayer2=[CATextLayer layer];
    textLayer2.frame=CGRectMake((self.frame.size.width)/2-10, self.frame.size.height-25, 20, 20);
    textLayer2.string=@"6";
    textLayer2.foregroundColor=[UIColor blackColor].CGColor;
    textLayer2.alignmentMode=kCAAlignmentJustified;
    textLayer2.fontSize=18;
    textLayer2.contentsScale=[UIScreen mainScreen].scale;
    [self.layer addSublayer:textLayer2];

    
    CATextLayer *textLayer3=[CATextLayer layer];
    textLayer3.frame=CGRectMake(5, (self.frame.size.width-20)/2, 20, 20);
    textLayer3.string=@"9";
    textLayer3.foregroundColor=[UIColor blackColor].CGColor;
    textLayer3.alignmentMode=kCAAlignmentJustified;
    textLayer3.fontSize=18;
    textLayer3.contentsScale=[UIScreen mainScreen].scale;
    [self.layer addSublayer:textLayer3];

    UIBezierPath *miaoBezier=[[UIBezierPath alloc]init];
    [miaoBezier moveToPoint:CGPointMake(self.frame.size.width/2, self.frame.size.width/2)];
    [miaoBezier addLineToPoint:CGPointMake(self.frame.size.width/2, 30)];
    
    miaoShape = [CALayer layer];
    miaoShape.bounds = CGRectMake(0, 0, 2, self.frame.size.width/2-20);
    miaoShape.backgroundColor = [UIColor redColor].CGColor;
    miaoShape.cornerRadius = 5;
    miaoShape.anchorPoint = CGPointMake(0.5, 1);
    miaoShape.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    [self.layer addSublayer:miaoShape];
    
    minLayer = [CALayer layer];
    minLayer.bounds = CGRectMake(0, 0, 2, self.frame.size.width/2-60);
    minLayer.backgroundColor = [UIColor yellowColor].CGColor;
    minLayer.cornerRadius = 5;
    minLayer.anchorPoint = CGPointMake(0.5, 1);
    minLayer.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    [self.layer addSublayer:minLayer];

    
    hourLayer = [CALayer layer];
    hourLayer.bounds = CGRectMake(0, 0, 2, self.frame.size.width/2-80);
    hourLayer.backgroundColor = [UIColor blueColor].CGColor;
    hourLayer.cornerRadius = 5;
    hourLayer.anchorPoint = CGPointMake(0.5, 1);
    hourLayer.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    [self.layer addSublayer:hourLayer];

        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
    

//    CABasicAnimation *miaoAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
//    miaoAnimation.duration = 10;
//    
//    miaoAnimation.repeatCount=HUGE;
//    miaoAnimation.fromValue = [NSNumber numberWithFloat:0];
//    miaoAnimation.toValue = [NSNumber numberWithFloat:M_PI];
//    [miaoShape addAnimation:miaoAnimation forKey:nil];
//    miaoShape.transform = CATransform3DMakeRotation(CURRENTSEC * kPerSecondA, 0, 0, 1);
}
- (void)timeChange
{
    [self setAngle:CURRENTSEC * kPerSecondA forHand:miaoShape animated:YES];
    [self setAngle:CURRENTMIN * kPerMinuteA forHand:minLayer animated:YES];
    [self setAngle:CURRENTMIN * kPerHourMinuteA + CURRENTHOUR*kPerHourA forHand:hourLayer animated:YES];

//    miaoShape.transform = CATransform3DMakeRotation(CURRENTSEC * kPerSecondA, 0, 0, 1);
//    minLayer.transform = CATransform3DMakeRotation(CURRENTMIN * kPerMinuteA, 0, 0, 1);
//    
//    hourLayer.transform = CATransform3DMakeRotation(CURRENTHOUR * kPerHourA, 0, 0, 1);
//    hourLayer.transform = CATransform3DMakeRotation(CURRENTMIN * kPerHourMinuteA + CURRENTHOUR*kPerHourA, 0, 0, 1);
}
- (void)setAngle:(CGFloat)angle forHand:(CALayer *)layer animated:(BOOL)animated
{
    //generate transform
    CATransform3D transform = CATransform3DMakeRotation(angle, 0, 0, 1);
    if (animated) {
        //create transform animation
        CABasicAnimation *animation = [CABasicAnimation animation];
        animation.keyPath = @"transform";
        animation.fromValue = [layer.presentationLayer valueForKey:@"transform"];
        animation.toValue = [NSValue valueWithCATransform3D:transform];
        animation.duration = 0.5;
//        animation.delegate = self;
        animation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:1 :0 :0.75 :1];
        //apply animation
        layer.transform = transform;
        [layer addAnimation:animation forKey:nil];
    } else {
        //set transform directly
        layer.transform = transform;
    }
}
@end
