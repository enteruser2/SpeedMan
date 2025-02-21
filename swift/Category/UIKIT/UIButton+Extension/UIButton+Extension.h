//
//  UIButton+Extension.h
//  BasicFramework
//
//  Created by Rainy on 16/10/26.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extension)



-(dispatch_source_t )startTime:(NSInteger )timeout title:(NSString *)tittle waitTittle:(NSString *)waitTittle finished:(void(^)(UIButton *button))finished;
-(void)cancelTimer:(dispatch_source_t)timer;

-(UIImageView *)addImg:(UIImage *)img withIMGframe:(CGRect )IMGframe;

-(void)setFrame:(CGRect)frame Title:(NSString *)title font:(UIFont *)font fontColor:(UIColor *)fontColor State:(UIControlState)state;



/**
 *  图片在上边
 *  文字在下边
 */
- (void)refreshTopBottom;
/**
 *  图片在下边
 *  文字在上边
 */
- (void)refreshBottomTop;
/**
 *  图片在右边
 *  文字在左边
 */
- (void)refreshRightLeft;
/**
 *  已经用refresh刷新过不满意，可以调用此方法在原来基础上再次增加
 *
 *  @param top    上边
 *  @param bottom 下边
 *  @param left   左边
 *  @param right  右边
 */
- (void)refreshImageViewWithTop:(CGFloat)top andBottom:(CGFloat)bottom andLeft:(CGFloat)left andRight:(CGFloat)right;

- (void)refreshTitleLabelWithTop:(CGFloat)top andBottom:(CGFloat)bottom andLeft:(CGFloat)left andRight:(CGFloat)right;

//竖直排列 设置图片和文字的距离
- (void)verticalImageAndTitle:(CGFloat)spacing;


@end
