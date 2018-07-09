//
//  UIImage+load.m
//  MiniSales
//
//  Created by sunjun on 13-7-4.
//  Copyright (c) 2013年 sunjun. All rights reserved.
//

#import "UIImage+load.h"
#import "UIDevice+Resolutions.h"
#import <AVFoundation/AVFoundation.h>
@implementation UIImage (load)

#define mainBunbldSourcePath [[NSBundle mainBundle] resourcePath]

+(id) imageLoad:(NSString *)name;
{
    if (([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)) {
        NSString *filePath = [mainBunbldSourcePath stringByAppendingPathComponent:[name stringByAppendingString:@"_ipad.png"]];
         UIImage *img = [UIImage imageWithContentsOfFile:filePath];
        if (!img) {
            filePath = [mainBunbldSourcePath stringByAppendingPathComponent:[name stringByAppendingString:@"@2x.png"]];
            return [UIImage imageWithContentsOfFile:filePath];
        }
        return img;
    }else{
        UIDeviceResolution type = [UIDevice currentResolution];
        if(type == UIDevice_iPhoneHiRes){
            NSString *thumbnailFile = [NSString stringWithFormat:@"%@/%@@2x.png", [[NSBundle mainBundle] resourcePath], name];
            UIImage *img = [UIImage imageWithContentsOfFile:thumbnailFile];
            if(!img){
                NSString *f = [NSString stringWithFormat:@"%@/%@.png", [[NSBundle mainBundle] resourcePath], name];
                return [UIImage imageWithContentsOfFile:f];
            }
            return img;
        }else{
            NSString *f = [NSString stringWithFormat:@"%@/%@.png", [[NSBundle mainBundle] resourcePath], name];
            UIImage *img =  [UIImage imageWithContentsOfFile:f];
            if(!img){
                NSString *f2x = [NSString stringWithFormat:@"%@/%@@2x.png", [[NSBundle mainBundle] resourcePath], name];
                return [UIImage imageWithContentsOfFile:f2x];
            }
            return img;
        }

    }
    return nil;
}

+(id) imageColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect=CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


+(UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize

{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reSizeImage;
}

- (UIImage*)imageRotatedByDegrees:(CGFloat)degrees
{
    BOOL isRetina = FALSE;
	CGSize rotatedSize = self.size;
    if ([UIDevice currentResolution] == UIDevice_iPhoneStandardRes){
        isRetina = YES;
    }
	if (isRetina) {
		rotatedSize.width *= 2;
		rotatedSize.height *= 2;
	}
	UIGraphicsBeginImageContext(rotatedSize);
	CGContextRef bitmap = UIGraphicsGetCurrentContext();
	CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
	CGContextRotateCTM(bitmap, degrees * M_PI / 180);
	CGContextRotateCTM(bitmap, M_PI);
	CGContextScaleCTM(bitmap, -1.0, 1.0);
	CGContextDrawImage(bitmap, CGRectMake(-rotatedSize.width/2, -rotatedSize.height/2, rotatedSize.width, rotatedSize.height), self.CGImage);
	UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return newImage;
}
+(id) imageColor:(UIColor *)scolor end:(UIColor *)endColor size:(CGSize)size
{
   // int numComponents = CGColorGetNumberOfComponents([scolor CGColor]);
  //  int numComponente = CGColorGetNumberOfComponents([endColor CGColor]);
   // if (numComponents == 4 && numComponente== 4)
    {
        const CGFloat *components = CGColorGetComponents([scolor CGColor]);
        const CGFloat *componente = CGColorGetComponents([endColor CGColor]);
        UIGraphicsBeginImageContextWithOptions(size, NO, 0);
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGGradientRef colorGradient = CGGradientCreateWithColorComponents(colorSpace, components, componente, 2);
        CGColorSpaceRelease(colorSpace);
        CGContextDrawLinearGradient(context, colorGradient, (CGPoint){0, 0}, (CGPoint){size.width, 0}, 0);
        CGGradientRelease(colorGradient);
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
        
    }
    return nil;
}

+(UIImage*) grayscale:(UIImage*)anImage type:(char)type {
    CGImageRef  imageRef;
    imageRef = anImage.CGImage;
    
    size_t width  = CGImageGetWidth(imageRef);
    size_t height = CGImageGetHeight(imageRef);

    size_t                  bitsPerComponent;
    bitsPerComponent = CGImageGetBitsPerComponent(imageRef);
    
    size_t                  bitsPerPixel;
    bitsPerPixel = CGImageGetBitsPerPixel(imageRef);
    
    size_t                  bytesPerRow;
    bytesPerRow = CGImageGetBytesPerRow(imageRef);
    
    CGColorSpaceRef         colorSpace;
    colorSpace = CGImageGetColorSpace(imageRef);
    
    CGBitmapInfo            bitmapInfo;
    bitmapInfo = CGImageGetBitmapInfo(imageRef);
    
    bool                    shouldInterpolate;
    shouldInterpolate = CGImageGetShouldInterpolate(imageRef);
    
    CGColorRenderingIntent  intent;
    intent = CGImageGetRenderingIntent(imageRef);
    
    CGDataProviderRef   dataProvider;
    dataProvider = CGImageGetDataProvider(imageRef);

    CFDataRef   data;
    UInt8*      buffer;
    data = CGDataProviderCopyData(dataProvider);
    buffer = (UInt8*)CFDataGetBytePtr(data);
    
    NSUInteger  x, y;
    for (y = 0; y < height; y++) {
        for (x = 0; x < width; x++) {
            UInt8*  tmp;
            tmp = buffer + y * bytesPerRow + x * 4;             UInt8 red,green,blue;
            red = *(tmp + 0);
            green = *(tmp + 1);
            blue = *(tmp + 2);
            
            UInt8 brightness;
            
            switch (type) {
                case 1: //灰度
                    brightness = (77 * red + 28 * green + 151 * blue) / 256;
                    
                    *(tmp + 0) = brightness;
                    *(tmp + 1) = brightness;
                    *(tmp + 2) = brightness;
                    break;
                    
                case 2://反色
                    *(tmp + 0) = red;
                    *(tmp + 1) = green * 0.7;
                    *(tmp + 2) = blue * 0.4;
                    break;
                    
                case 3://深棕色
                    *(tmp + 0) = 255 - red;
                    *(tmp + 1) = 255 - green;
                    *(tmp + 2) = 255 - blue;
                    break;
                    
                default:
                    *(tmp + 0) = red;
                    *(tmp + 1) = green;
                    *(tmp + 2) = blue;
                    break;
            }
            
        }
    }
    
    CFDataRef   effectedData;
    effectedData = CFDataCreate(NULL, buffer, CFDataGetLength(data));

    CGDataProviderRef   effectedDataProvider;
    effectedDataProvider = CGDataProviderCreateWithCFData(effectedData);

    CGImageRef  effectedCgImage;
    UIImage*    effectedImage;
    effectedCgImage = CGImageCreate(
                                    width, height,
                                    bitsPerComponent, bitsPerPixel, bytesPerRow,
                                    colorSpace, bitmapInfo, effectedDataProvider,
                                    NULL, shouldInterpolate, intent);
    effectedImage = [[UIImage alloc] initWithCGImage:effectedCgImage];
    
    CGImageRelease(effectedCgImage);
    CFRelease(effectedDataProvider);
    CFRelease(effectedData);
    CFRelease(data);
    
    return effectedImage;
}

+ (UIImage *)getImage:(NSString *)videoUrl{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL URLWithString:videoUrl] options:nil];
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    gen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    return thumb;
}

@end
