//
//  UIButton+Extension.m
//  BasicFramework
//
//  Created by Rainy on 16/10/26.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import "UIButton+Extension.h"

@interface UIImage (MiddleAligning)

@end

@implementation UIImage (MiddleAligning)

- (UIImage *)MiddleAlignedButtonImageScaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0.0, size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, size.width, size.height), self.CGImage);
    
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

@end


@implementation UIButton (Extension)
-(dispatch_source_t )startTime:(NSInteger )timeout title:(NSString *)tittle waitTittle:(NSString *)waitTittle finished:(void(^)(UIButton *button))finished
{
    __block NSInteger timeOut = timeout; //The countdown time
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //To perform a second
    dispatch_source_set_event_handler(_timer, ^{
        if(timeOut<=0){ //it is time to
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //it is time to  set title
                [self setTitle:tittle forState:UIControlStateNormal];
                self.userInteractionEnabled = YES;
                finished(self);
            });
        }else{
            
            NSString *strTime = [NSString stringWithFormat:@"%ld", timeOut];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self setTitle:[NSString stringWithFormat:@"%@%@",strTime,waitTittle] forState:UIControlStateNormal];
                self.userInteractionEnabled = NO;
                
            });
            timeOut--;
            
        }
    });
    dispatch_resume(_timer);
    return _timer;
}
-(void)cancelTimer:(dispatch_source_t)timer
{
    if (!timer) return;
    dispatch_source_cancel(timer);
}-(UIImageView *)addImg:(UIImage *)img withIMGframe:(CGRect )IMGframe
{
    UIImageView *img_VC = [[UIImageView alloc]initWithFrame:IMGframe];
    img_VC.image = img;
    img_VC.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:img_VC];
    
    return img_VC;
}
-(void)setFrame:(CGRect)frame Title:(NSString *)title font:(UIFont *)font fontColor:(UIColor *)fontColor State:(UIControlState)state
{
    self.frame = frame;
    [self setTitle:title forState:state];
    [self setTitleColor:fontColor forState:state];
    [self.titleLabel setFont:font];
}



- (void)refreshTopBottom{
        CGFloat btnH=self.frame.size.height;
        CGFloat btnW=self.frame.size.width;
        
        CGFloat ivX=self.imageView.frame.origin.x;
        CGFloat ivY=self.imageView.frame.origin.y;
        CGFloat ivW=self.imageView.frame.size.width;
        
        CGFloat titX=self.titleLabel.frame.origin.x;
        CGFloat titY=self.titleLabel.frame.origin.y;
        CGFloat titW=self.titleLabel.frame.size.width;
        CGFloat titH=self.titleLabel.frame.size.height;
        
        //top
        CGFloat t1=-ivY;
        CGFloat l1=btnW*0.5-(ivX+ivW*0.5);
        CGFloat b1=-t1;
        CGFloat r1=-l1;
        self.imageEdgeInsets=UIEdgeInsetsMake(t1,l1,b1,r1);
        
        CGFloat t2=btnH-titY-titH;
        CGFloat l2=btnW*0.5-(titX+titW*0.5);
        CGFloat b2=-t2;
        CGFloat r2=-l2;
        
        self.titleEdgeInsets=UIEdgeInsetsMake(t2,l2,b2,r2);
    

}

- (void)refreshRightLeft{
    CGFloat ivW=self.imageView.frame.size.width;
    CGFloat titW=self.titleLabel.frame.size.width;
    
    CGFloat t1=0;
    CGFloat l1=titW+5;
    CGFloat b1=-t1;
    CGFloat r1=-l1;
    self.imageEdgeInsets=UIEdgeInsetsMake(t1,l1,b1,r1);
    
    CGFloat t2=0;
    CGFloat l2=-ivW;
    CGFloat b2=-t2;
    CGFloat r2=-l2;
    self.titleEdgeInsets=UIEdgeInsetsMake(t2,l2,b2,r2);
}

- (void)refreshBottomTop{
    
    
}

- (void)refreshImageViewWithTop:(CGFloat)top andBottom:(CGFloat)bottom andLeft:(CGFloat)left andRight:(CGFloat)right{
    UIEdgeInsets edg=self.imageEdgeInsets;
    edg.top+=top;
    edg.bottom+=bottom;
    edg.left+=left;
    edg.right+=right;
    self.imageEdgeInsets=edg;
}

- (void)refreshTitleLabelWithTop:(CGFloat)top andBottom:(CGFloat)bottom andLeft:(CGFloat)left andRight:(CGFloat)right{
    UIEdgeInsets edg=self.titleEdgeInsets;
    edg.top+=top;
    edg.bottom+=bottom;
    edg.left+=left;
    edg.right+=right;
    self.titleEdgeInsets=edg;
}

- (void)verticalImageAndTitle:(CGFloat)spacing
{
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    CGSize textSize = [self.titleLabel.text sizeWithFont:self.titleLabel.font];
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;
    }
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height), 0);

}




@end
