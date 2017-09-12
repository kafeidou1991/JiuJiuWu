//
//  UIView+cate.m
//  MiniSales
//
//  Created by sunjun on 13-7-10.
//  Copyright (c) 2013年 sunjun. All rights reserved.
//

#import "UIView+cate.h"
#import "UIImage+load.h"
@implementation UIView (cate)

-(void) maskBound:(CGFloat) broderWidth radius:(CGFloat) radius brodercolor:(UIColor *)broderColor
{
     self.layer.borderColor = [broderColor CGColor];
     self.layer.borderWidth = broderWidth;
     self.layer.cornerRadius = radius;
     [self.layer setMasksToBounds:YES];
}

-(void) removeAllSubViews
{
    NSArray *subs = [self subviews];
    for (UIView *v in subs) {
        [v removeFromSuperview];
    }
}


-(UIImage *)getImageFromView
{
    UIImage *defimage = [UIImage imageNamed:@"defaultImage"];
    CALayer *sublayer = self.layer;
    sublayer.backgroundColor = self.backgroundColor.CGColor;
    sublayer.borderColor = [UIColor clearColor].CGColor;
    CALayer *imageLayer = [CALayer layer];
    imageLayer.frame = CGRectMake((sublayer.bounds.size.width-defimage.size.width)*0.5f, (sublayer.bounds.size.height-defimage.size.height)*0.5f, defimage.size.width, defimage.size.height);
    imageLayer.contents = (id) defimage.CGImage;
    [sublayer addSublayer:imageLayer];
    UIGraphicsBeginImageContext(self.frame.size);
    [sublayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
}

- (void)dropShadowWithOffset:(CGSize)offset
                      radius:(CGFloat)radius
                       color:(UIColor *)color
                     opacity:(CGFloat)opacity
{
    // Creating shadow path for better performance
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.bounds);
    self.layer.shadowPath = path;
    CGPathCloseSubpath(path);
    CGPathRelease(path);
    
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowRadius = radius;
    self.layer.shadowOpacity = opacity;
    
    // Default clipsToBounds is YES, will clip off the shadow, so we disable it.
    self.clipsToBounds = NO;
    
}

@end
