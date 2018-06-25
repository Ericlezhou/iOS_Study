//
//  ViewController.m
//  LargeSizeImageCompress
//
//  Created by Eric on 2018/5/25.
//  Copyright © 2018年 nexus. All rights reserved.
//

#import "ViewController.h"
#import <ImageIO/ImageIO.h>
#define URL_Str_L  @"http://puui.qpic.cn/fans_admin/0/1_2513314909_1526957742827/0"
#define URL_Str_S @"http://puui.qpic.cn/fans_admin/0/1_2513314909_1527164368471/0"
#define Maximum_Bitmap_Memory_Cost (40*1024*1024)
#define Bytes_Per_Pixel  4
#define Maximum_Bitmap_Pixel  (Maximum_Bitmap_Memory_Cost / Bytes_Per_Pixel * 1.0)
static const NSInteger g_MaxImageSize = (819200);//800*1024，根据批量1280x720的jpg壁纸统计，区间100KB-500KB之间，自然风景图片偏大一些，最大可以到700多KB

@interface ViewController ()
@property (nonatomic, strong) NSData *imageData;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImage *originImage;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *downloadBtn;
@property (weak, nonatomic) IBOutlet UIButton *compressBtn;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *renderBtn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)downloadAction:(id)sender {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        self.imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:URL_Str_L]];
        self.originImage = [UIImage imageWithData:self.imageData];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self appendTextViewWithStr:@"data 下载完成"];
        });
    });
}
- (IBAction)compressAction:(id)sender {
    if (self.imageData) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            self.image = [[self class] compressImageForData:self.imageData]; //version 1
            self.image = [[self class] compressImageForImage:self.originImage];   //version 2
            self.image = [[self class] lowCompressionQualityWithImage:self.image];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self appendTextViewWithStr:@"image 压缩完成"];
            });
        });
    }
}

- (IBAction)renderAction:(id)sender {
    if (self.image) {
        [self.imageView setImage:self.image];
        [self appendTextViewWithStr:@"image 渲染完成"];
    }
}

- (void)appendTextViewWithStr:(NSString *)str {
    if (!str.length) {
        return;
    }
    if (![[NSThread currentThread] isMainThread]) {
        __typeof(&*self) __weak weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf appendTextViewWithStr:str];
        });
        return;
    }
    NSString *showedText = [self.textView text];
    showedText = [showedText stringByAppendingString:@"\n"];
    showedText = [showedText stringByAppendingString:str];
    [self.textView setText:showedText];
}

+ (UIImage *) compressImageForImage:(UIImage *)image {
    CGSize imageSize = image.size;
    CGSize targetSize = imageSize;
    NSLog(@"%f",imageSize.width * imageSize.height);
    if (imageSize.width * imageSize.height > Maximum_Bitmap_Pixel) {
        int scale = imageSize.width * imageSize.height / Maximum_Bitmap_Pixel;
        targetSize = CGSizeMake(imageSize.width / (scale * 1.0), imageSize.height / (scale * 1.0));
    }
    UIGraphicsBeginImageContext(CGSizeMake(targetSize.width, targetSize.height));
    [image drawInRect:CGRectMake(0, 0, targetSize.width, targetSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reSizeImage;
}

+ (UIImage *) lowCompressionQualityWithImage:(UIImage *)image {
    CGDataProviderRef provider = CGImageGetDataProvider(image.CGImage);
    NSData* imageData = (id)CFBridgingRelease(CGDataProviderCopyData(provider));
    // 图片太大时需要做压缩，否则内存暴涨会crash
    CGFloat compressionQuality = 1.f;
    CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(image.CGImage);
    while ((alphaInfo == kCGImageAlphaNone || alphaInfo == kCGImageAlphaNoneSkipLast || alphaInfo == kCGImageAlphaNoneSkipFirst) &&
           g_MaxImageSize < imageData.length && compressionQuality > 0.4) {
        compressionQuality -= 0.2;
        imageData = UIImageJPEGRepresentation(image, MAX(compressionQuality, 0.3));
        image = [UIImage imageWithData:imageData];
    }
    
    return image;
}


+ (UIImage *) compressImageForData:(NSData *)data{
    UIImage *decodedImage = nil;
    CGImageSourceRef imageSourceRef = CGImageSourceCreateWithData((CFDataRef)data, NULL);
    if (imageSourceRef) {
        CGImageRef imageRef = CGImageSourceCreateImageAtIndex(imageSourceRef, 0, (CFDictionaryRef)@{(NSString *)kCGImageSourceShouldCache : (NSNumber *)kCFBooleanFalse});
        if (imageRef) {
            UIImageOrientation orientation = [[self class] getUIImageOrientationFromImageSource:imageSourceRef];
            decodedImage = [UIImage imageWithCGImage:[self decodedImageRefWithCGImageRef:imageRef] scale:1.0 orientation:orientation];
            CGImageRelease(imageRef);
        }
        CFRelease(imageSourceRef);
    }
    return decodedImage;
}


+ (CGImageRef)decodedImageRefWithCGImageRef:(CGImageRef)imageRef {
    BOOL opaque = YES;
    CGImageAlphaInfo alpha = CGImageGetAlphaInfo(imageRef);
    if (alpha == kCGImageAlphaFirst || alpha == kCGImageAlphaLast || alpha == kCGImageAlphaOnly || alpha == kCGImageAlphaPremultipliedFirst || alpha == kCGImageAlphaPremultipliedLast) {
        opaque = NO;
    }
    
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imageRef), CGImageGetHeight(imageRef));
    
    CGBitmapInfo info = opaque ? (kCGImageAlphaNoneSkipFirst | kCGBitmapByteOrder32Host) : (kCGImageAlphaPremultipliedFirst | kCGBitmapByteOrder32Host);
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    
    //Use UIGraphicsBeginImageContext parameters from docs: https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIKitFunctionReference/#//apple_ref/c/func/UIGraphicsBeginImageContextWithOptions
    CGSize targetSize = imageSize;
    if (imageSize.width * imageSize.height > Maximum_Bitmap_Pixel) {
        int scale = imageSize.width * imageSize.height / Maximum_Bitmap_Pixel;
        targetSize = CGSizeMake(imageSize.width / (scale * 1.0), imageSize.height / (scale * 1.0));
    }
    CGContextRef ctx = CGBitmapContextCreate(NULL, targetSize.width, targetSize.height,
                                             8,
                                             0,
                                             colorspace,
                                             info);
    
    CGColorSpaceRelease(colorspace);
    
    if (ctx) {
        CGContextSetBlendMode(ctx, kCGBlendModeCopy);
        CGContextDrawImage(ctx, CGRectMake(0, 0, targetSize.width, targetSize.height), imageRef);
        
        CGImageRef decodedImageRef = CGBitmapContextCreateImage(ctx);
        if (decodedImageRef) {
            CFAutorelease(decodedImageRef);
        }
        CGContextRelease(ctx);
        return decodedImageRef;
    }
    return imageRef;
}

+ (UIImageOrientation)getUIImageOrientationFromImageSource:(CGImageSourceRef)imageSourceRef {
    UIImageOrientation orientation = UIImageOrientationUp;
    
    if (imageSourceRef != nil) {
        NSDictionary *dict = (NSDictionary *)CFBridgingRelease(CGImageSourceCopyPropertiesAtIndex(imageSourceRef, 0, NULL));
        
        if (dict != nil) {
            
            NSNumber* exifOrientation = dict[(id)kCGImagePropertyOrientation];
            if (exifOrientation != nil) {
                
                switch (exifOrientation.intValue) {
                    case 1: /*kCGImagePropertyOrientationUp*/
                        orientation = UIImageOrientationUp;
                        break;
                        
                    case 2: /*kCGImagePropertyOrientationUpMirrored*/
                        orientation = UIImageOrientationUpMirrored;
                        break;
                        
                    case 3: /*kCGImagePropertyOrientationDown*/
                        orientation = UIImageOrientationDown;
                        break;
                        
                    case 4: /*kCGImagePropertyOrientationDownMirrored*/
                        orientation = UIImageOrientationDownMirrored;
                        break;
                    case 5: /*kCGImagePropertyOrientationLeftMirrored*/
                        orientation = UIImageOrientationLeftMirrored;
                        break;
                        
                    case 6: /*kCGImagePropertyOrientationRight*/
                        orientation = UIImageOrientationRight;
                        break;
                        
                    case 7: /*kCGImagePropertyOrientationRightMirrored*/
                        orientation = UIImageOrientationRightMirrored;
                        break;
                        
                    case 8: /*kCGImagePropertyOrientationLeft*/
                        orientation = UIImageOrientationLeft;
                        break;
                        
                    default:
                        break;
                }
            }
        }
    }
    return orientation;
}
@end
