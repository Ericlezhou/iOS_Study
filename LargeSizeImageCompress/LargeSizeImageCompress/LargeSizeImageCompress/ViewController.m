//
//  ViewController.m
//  LargeSizeImageCompress
//
//  Created by Eric on 2018/5/25.
//  Copyright © 2018年 nexus. All rights reserved.
//

#import "ViewController.h"
#import <ImageIO/ImageIO.h>
#define URL_Str_L   @"http://puui.qpic.cn/fans_admin/0/1_2513314909_1526957742827/0"   //@"http://upload.wikimedia.org/wikipedia/commons/f/fb/Wikisource-logo.png"
#define URL_Str_S @"http://puui.qpic.cn/fans_admin/0/1_2513314909_1527164368471/0"
#define Maximum_Bitmap_Memory_Cost (50*1024*1024)


static const size_t kBytesPerPixel = 4;
static const CGFloat kDestImageSizeMB = 60.0f;
static const CGFloat kBytesPerMB = 1024.0f * 1024.0f;
static const CGFloat kPixelsPerMB = kBytesPerMB / kBytesPerPixel;
static const CGFloat kDestTotalPixels = kDestImageSizeMB * kPixelsPerMB;


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
//            self.image = [[self class] compressImageDefinationForData:self.imageData];
//            self.image = [[self class] compressImageDefinationForImage:self.originImage];
            self.image = [[self class] compressImageDefinationForDataV2:self.imageData];
//            self.image = [[self class] compressImageDefinationForDataV3:self.imageData];
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
//    if (self.originImage) {
//        [self.imageView setImage:self.originImage];
//        [self appendTextViewWithStr:@"image 渲染完成"];
//    }
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

+ (UIImage *)compressImageDefinationForImage:(UIImage *)image {
    CGSize imageSize = image.size;
    CGSize targetSize = imageSize;
    NSLog(@"%f",imageSize.width * imageSize.height);
    if (imageSize.width * imageSize.height > Maximum_Bitmap_Memory_Cost / 4.0) {
        int scale = imageSize.width * imageSize.height / (Maximum_Bitmap_Memory_Cost / 4.0);
        targetSize = CGSizeMake(imageSize.width / (scale * 1.0), imageSize.height / (scale * 1.0));
    }
    UIGraphicsBeginImageContext(CGSizeMake(targetSize.width, targetSize.height));
    [image drawInRect:CGRectMake(0, 0, targetSize.width, targetSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reSizeImage;
}

+ (UIImage *) lowCompressionQualityWithImage:(UIImage *)image {
    //分辨率过大的话 会导致内存峰值暴涨
    CGDataProviderRef provider = CGImageGetDataProvider(image.CGImage);
    NSData* imageData = (id)CFBridgingRelease(CGDataProviderCopyData(provider));
    // 图片太大时需要做压缩，否则内存暴涨会crash
    CGFloat compressionQuality = 1.f;
    CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(image.CGImage);
    while (
           (alphaInfo == kCGImageAlphaNone || alphaInfo == kCGImageAlphaNoneSkipLast || alphaInfo == kCGImageAlphaNoneSkipFirst) &&
           g_MaxImageSize < imageData.length && compressionQuality > 0.4) {
        compressionQuality -= 0.2;
        imageData = UIImageJPEGRepresentation(image, MAX(compressionQuality, 0.3));
        image = [UIImage imageWithData:imageData];
    }
    
    return image;
}

+ (UIImage *) compressImageDefinationForData:(NSData *)data{
    UIImage *decodedImage = nil;
    //内存不暴涨 cpu峰值暴涨
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


+ (UIImage *) compressImageDefinationForDataV2:(NSData *)data{
    UIImage *image = [UIImage imageWithData:data];
    
    BOOL shouldScaleDown = YES;
    CGImageRef sourceImageRef = image.CGImage;
    CGSize sourceResolution = CGSizeZero;
    sourceResolution.width = CGImageGetWidth(sourceImageRef);
    sourceResolution.height = CGImageGetHeight(sourceImageRef);
    float sourceTotalPixels = sourceResolution.width * sourceResolution.height;
    float imageScale = kDestTotalPixels / sourceTotalPixels;
    if (imageScale < 1) {
        shouldScaleDown = YES;
    } else {
        shouldScaleDown = NO;
    }

    if (shouldScaleDown) {
        UIImage *decodedImage = nil;
        CGSize targetSize = CGSizeMake(ceilf(sourceResolution.width * imageScale), ceilf(sourceResolution.height * imageScale));
        UIGraphicsBeginImageContext(CGSizeMake(targetSize.width, targetSize.height));
        [image drawInRect:CGRectMake(0, 0, targetSize.width, targetSize.height)];
        decodedImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return decodedImage ? decodedImage : image;
    } else {
        return image;
    }
}


+ (UIImage *) compressImageDefinationForDataV3:(NSData *)data{
    UIImage *image = [UIImage imageWithData:data];
    
    BOOL shouldScaleDown = YES;
    CGImageRef sourceImageRef = image.CGImage;
    CGSize sourceResolution = CGSizeZero;
    sourceResolution.width = CGImageGetWidth(sourceImageRef);
    sourceResolution.height = CGImageGetHeight(sourceImageRef);
    float sourceTotalPixels = sourceResolution.width * sourceResolution.height;
    float imageScale = kDestTotalPixels / sourceTotalPixels;
    if (imageScale < 1) {
        shouldScaleDown = YES;
    } else {
        shouldScaleDown = NO;
    }
    if (shouldScaleDown) {
        CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(sourceImageRef) & kCGBitmapAlphaInfoMask;
        UIImage *decodedImage = nil;
        CGSize targetSize = CGSizeMake(ceilf(sourceResolution.width * imageScale), ceilf(sourceResolution.height * imageScale));
        
        BOOL hasAlpha = NO;
        if (alphaInfo == kCGImageAlphaPremultipliedLast ||
            alphaInfo == kCGImageAlphaPremultipliedFirst ||
            alphaInfo == kCGImageAlphaLast ||
            alphaInfo == kCGImageAlphaFirst) {
            hasAlpha = YES;
        }
        
        // BGRA8888 (premultiplied) or BGRX8888
        // same as UIGraphicsBeginImageContext() and -[UIView drawRect:]
        CGBitmapInfo bitmapInfo = kCGBitmapByteOrder32Host;
        bitmapInfo |= hasAlpha ? kCGImageAlphaPremultipliedFirst : kCGImageAlphaNoneSkipFirst;
        
        CGContextRef context = CGBitmapContextCreate(NULL, targetSize.width, targetSize.height, 8, 0, CGColorSpaceCreateDeviceRGB(), bitmapInfo);
        if (!context) return NULL;
        
        CGContextDrawImage(context, CGRectMake(0, 0, targetSize.width, targetSize.height), sourceImageRef); // decode
        CGImageRef newImage = CGBitmapContextCreateImage(context);
        decodedImage = [UIImage imageWithCGImage:newImage];
        CFRelease(context);
        CGImageRelease(newImage);
        return decodedImage ? decodedImage : image;
    } else {
        return image;
    }
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
    double imageMemory = CGImageGetHeight(imageRef) * CGImageGetBytesPerRow(imageRef);
    NSLog(@"%f", imageMemory);
    if (imageMemory > Maximum_Bitmap_Memory_Cost) {
        int scale = imageMemory / Maximum_Bitmap_Memory_Cost;
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
