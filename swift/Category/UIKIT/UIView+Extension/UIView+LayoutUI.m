//
//  UIView+LayoutUI.m
//  WLZ
//
//  Created by chen on 15/4/27.
//  Copyright (c) 2015年 chen. All rights reserved.
//

#import "UIView+LayoutUI.h"

@implementation UIView (LayoutUI)
/*
 设置当前view的高度、宽度、x、y
 */
-(void)setFrameWithOriginX:(CGFloat)X
{
    self.frame=CGRectMake(X, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

-(void)setFrameWithOriginY:(CGFloat)Y
{
    self.frame=CGRectMake(self.frame.origin.x, Y, self.frame.size.width, self.frame.size.height);
}

-(void)setFrameWithWidth:(CGFloat)width
{
    self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, width, self.frame.size.height);
}

-(void)setFrameWithHeight:(CGFloat)height
{
    self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
}

/*
 设置当前view，距离屏幕左边的宽度固定，本身按照固定的大小等比例变化
 传入原图大小cgsize
 */
-(void)setFrameWithLeftSpace:(CGFloat)X Width:(CGFloat)passWidth OriginalSize:(CGSize)passSize
{
    self.frame=CGRectMake(X, 0, passWidth, passWidth/passSize.width*passSize.height);
}

/*
 获取当前view的属性
 */
- (CGPoint)frameOrigin {
    return self.frame.origin;
}

- (CGSize)frameSize {
    return self.frame.size;
}

- (CGFloat)frameX {
    return self.frame.origin.x;
}

- (CGFloat)frameY {
    return self.frame.origin.y;
}

- (CGFloat)frameRight {
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)frameBottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (CGFloat)frameWidth {
    return self.frame.size.width;
}

- (CGFloat)frameHeight {
    return self.frame.size.height;
}
/*
 设置圆角
 */
-(void)setCornerRadius:(CGFloat)radius
{
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds=YES;
}

/*
 设置圆角同时设置阴影
 */
-(void)setShadowAndCornerRadius:(CGFloat)radius
{
    self.layer.shadowColor= [UIColor darkGrayColor].CGColor;
    self.layer.shadowOffset= CGSizeMake(0, 3);
    self.layer.shadowOpacity = 0.8;
    self.layer.cornerRadius = radius;
}

/*
 设置圆角同时设置阴影
 */
-(void)setShadowAndCornerRadius:(CGFloat)radius andColor:(UIColor *)passColor
{
    self.layer.shadowColor= passColor.CGColor;
    self.layer.shadowOffset= CGSizeMake(0, 3);
    self.layer.shadowOpacity = 0.8;
    self.layer.cornerRadius = radius;
}

/*
 设置圆角同时图片可以超出边界
 */
-(void)setSuperCornerRadius:(CGFloat)radius
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:(UIRectCornerAllCorners) cornerRadii:CGSizeMake(radius, radius)];//圆角大小
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

#pragma mark - 设置部分圆角
/**
 *  设置部分圆角(绝对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 */
- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii {
    
    UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:radii];
    CAShapeLayer* shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    
    self.layer.mask = shape;
}

/**
 *  设置部分圆角(相对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 *  @param rect    需要设置的圆角view的rect
 */
- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii
                 viewRect:(CGRect)rect {
    
    UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radii];
    CAShapeLayer* shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    self.layer.mask = shape;
}

/*
 设置边框
 */
-(void)setBorderWithWidth:(CGFloat)width andColor:(UIColor *)color
{
    self.layer.borderWidth = width;
    self.layer.borderColor = [color CGColor];
}

//设置渐变色
-(void)jianbianColorWithStartC:(UIColor *)startC endC:(UIColor *)endC direction:(NSInteger)direct{
    /*
     colors 渐变的颜色
     locations 颜色变化位置的取值范围
     startPoint 颜色渐变的起始位置:取值范围在(0,0)~(1,1)之间
     endPoint 颜色渐变的终点位置,取值范围也是在(0,0)~(1,1)之间
     补充下:startPoint & endPoint设置为(0,0)(1.0,0)代表水平方向渐变,(0,0)(0,1.0)代表竖直方向渐变
     */
    if(self.layer.sublayers.count>0){
        NSLog(@"layer:%@",self.layer.sublayers);
        for(NSInteger i=0;i<self.layer.sublayers.count;i++){
            if([[self.layer.sublayers objectAtIndex:i] isKindOfClass:[CAGradientLayer class]]==YES){
                [[self.layer.sublayers objectAtIndex:i] removeFromSuperlayer];
            }
        }
    }
    
    CAGradientLayer * gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.bounds;
    gradientLayer.colors = @[(__bridge id)startC.CGColor,(__bridge id)endC.CGColor];
    //渐变方向
    if(direct==0){
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1, 0);
    }else{
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(0, 1);
    }
    gradientLayer.locations = @[@0,@1];
    [self.layer addSublayer:gradientLayer];
}

-(void)removeJianbianColor{
    if(self.layer.sublayers.count>0){
        for(NSInteger i=0;i<self.layer.sublayers.count;i++){
            if([[self.layer.sublayers objectAtIndex:i] isKindOfClass:[CAGradientLayer class]]==YES){
                [[self.layer.sublayers objectAtIndex:i] removeFromSuperlayer];
            }
        }
    }
}

-(void)removeShapeLayer{
    if(self.layer.sublayers.count>0){
        for(NSInteger i=0;i<self.layer.sublayers.count;i++){
            if([[self.layer.sublayers objectAtIndex:i] isKindOfClass:[CAShapeLayer class]]==YES){
                [[self.layer.sublayers objectAtIndex:i] removeFromSuperlayer];
            }
        }
    }
}

/*
 判断传入的view 是否有父子关系
 */
-(BOOL) containsSubView:(UIView *)subView
{
    for (UIView *view in [self subviews]) {
        if ([view isEqual:subView]) {
            return YES;
        }
    }
    return NO;
}

-(BOOL) containsSubViewOfClassType:(Class)class1 {
    for (UIView *view in [self subviews]) {
        if ([view isMemberOfClass:class1]) {
            return YES;
        }
    }
    return NO;
}
@end
