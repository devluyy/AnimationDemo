//
//  ViewController.m
//  AnimationDemo
//
//  Created by Lyy on 15/7/7.
//  Copyright (c) 2015年 Lyy. All rights reserved.
//

#define kViewWidth (50)

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    [self drawMyLayer];
    [self drawMyLayerByDelegate];
}

#pragma mark - 绘制图层
- (void)drawMyLayer {
    
    CGSize size = [UIScreen mainScreen].bounds.size;
    
    CALayer *layer = [[CALayer alloc] init];
    layer.backgroundColor = [UIColor greenColor].CGColor;
    layer.position = CGPointMake(size.width/2, size.height/2);
    layer.bounds = CGRectMake(0, 0, kViewWidth, kViewWidth);
    layer.cornerRadius = kViewWidth/2;
    layer.shadowColor = [UIColor yellowColor].CGColor;
    layer.shadowOffset = CGSizeMake(kViewWidth/20, kViewWidth/50);
    layer.shadowOpacity = 0.9;
    layer.anchorPoint = CGPointMake(0, 0); 
    [self.view.layer addSublayer:layer];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CALayer *layer = [self.view.layer.sublayers lastObject];
    CGFloat width = layer.bounds.size.width;
    
    width = (width == kViewWidth) ? (kViewWidth*4):kViewWidth;
    
    layer.bounds = CGRectMake(0, 0, width, width);
    layer.cornerRadius = width/2;
    layer.position = [touch locationInView:self.view];
    layer.shadowOffset = CGSizeMake(width/20, width/50);

}

#pragma mark - 使用代理方法绘图
- (void)drawMyLayerByDelegate {
    CGSize size = [UIScreen mainScreen].bounds.size;
    
    CALayer *shadowLayer = [[CALayer alloc] init];
//    shadowLayer.backgroundColor = [UIColor whiteColor].CGColor;
    shadowLayer.position = CGPointMake(size.width/2, size.height/2);
    shadowLayer.bounds = CGRectMake(0, 0, kViewWidth, kViewWidth);
    shadowLayer.cornerRadius = kViewWidth/2;
    shadowLayer.shadowColor = [UIColor grayColor].CGColor;
    shadowLayer.shadowOffset = CGSizeMake(0, 0);
    shadowLayer.shadowRadius = 3;
    shadowLayer.shadowOpacity = 1;
//    layer.delegate = self;
    [self.view.layer addSublayer:shadowLayer];
    //设置边框
    shadowLayer.borderColor=[UIColor whiteColor].CGColor;
    shadowLayer.borderWidth=2;

    CALayer *layer = [[CALayer alloc] init];
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.position = CGPointMake(size.width/2, size.height/2);
    layer.bounds = CGRectMake(0, 0, kViewWidth, kViewWidth);
    layer.cornerRadius = kViewWidth/2;
    layer.masksToBounds = YES;
    //设置边框
    layer.borderColor=[UIColor whiteColor].CGColor;
    layer.borderWidth=2;
    
    layer.delegate = self;
    [self.view.layer addSublayer:layer];
    
    //调用图层setNeedDisplay,否则代理方法不会被调用
    [layer setNeedsDisplay];
}

#pragma mark 绘制图形、图像到图层，注意参数中的ctx是图层的图形上下文，其中绘图位置也是相对图层而言的
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    CGContextSaveGState(ctx);
    //图形上下文形变，解决图片倒立的问题
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -kViewWidth);
    UIImage *image = [UIImage imageNamed:@"photo.png"];
    
    CGContextDrawImage(ctx, CGRectMake(0, 0, kViewWidth, kViewWidth), image.CGImage);
    
    CGContextRestoreGState(ctx);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
