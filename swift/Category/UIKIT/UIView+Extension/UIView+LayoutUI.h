//
//  UIView+LayoutUI.h
//  WLZ
//
//  Created by chen on 15/4/27.
//  Copyright (c) 2015年 chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LayoutUI)

/*
 设置当前view的高度、宽度、x、y
 */
-(void)setFrameWithOriginX:(CGFloat)X;
-(void)setFrameWithOriginY:(CGFloat)Y;
-(void)setFrameWithWidth:(CGFloat)width;
-(void)setFrameWithHeight:(CGFloat)height;

/*
 设置当前view，距离屏幕左边的宽度固定，本身按照固定的大小等比例变化
 传入原图大小cgsize
 */
-(void)setFrameWithLeftSpace:(CGFloat)X Width:(CGFloat)passWidth OriginalSize:(CGSize)passSize;

/*
 获取当前view的属性
 */
- (CGPoint)frameOrigin;
- (CGSize)frameSize;
- (CGFloat)frameX;
- (CGFloat)frameY;
- (CGFloat)frameRight;
- (CGFloat)frameBottom;
- (CGFloat)frameWidth;
- (CGFloat)frameHeight;

/*
 设置圆角
 */
-(void)setCornerRadius:(CGFloat)radius;

#pragma mark - 设置部分圆角
/**
 *  设置部分圆角(绝对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 */
- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii;
/**
 *  设置部分圆角(相对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 *  @param rect    需要设置的圆角view的rect
 */
- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii
                 viewRect:(CGRect)rect;

/*
 设置圆角同时设置阴影
 */
-(void)setShadowAndCornerRadius:(CGFloat)radius;
-(void)setShadowAndCornerRadius:(CGFloat)radius andColor:(UIColor *)passColor;
/*
 设置圆角同时图片可以超出边界
 */
-(void)setSuperCornerRadius:(CGFloat)radius;
/*
 设置边框
 */
-(void)setBorderWithWidth:(CGFloat)width andColor:(UIColor *)color;

/*
 判断传入的view 是否有父子关系
 */
-(BOOL) containsSubView:(UIView *)subView;
-(BOOL) containsSubViewOfClassType:(Class)Class;
//设置渐变色
-(void)jianbianColorWithStartC:(UIColor *)startC endC:(UIColor *)endC direction:(NSInteger)direct;
-(void)removeJianbianColor;
-(void)removeShapeLayer;

@end
