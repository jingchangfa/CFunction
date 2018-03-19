//
//  UIView+CFScreenShots.m
//  customFunction
//
//  Created by jing on 2018/3/19.
//  Copyright © 2018年 jing. All rights reserved.
//

#import "UIView+CFScreenShots.h"

@implementation UIView (CFScreenShots)
- (UIImage *)toLongImage{
    CGRect r = self.bounds;
    float scale = [UIScreen mainScreen].scale*2.0;
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, scale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if (CGRectEqualToRect(self.bounds, r)){
        return theImage;
    }else{
        CGImageRef imageRef = theImage.CGImage;
        r.origin.x = r.origin.x * scale;
        r.origin.y = r.origin.y * scale;
        r.size.height = r.size.height * scale;
        r.size.width = r.size.width * scale;
        CGImageRef imageRefRect = CGImageCreateWithImageInRect(imageRef, r);
        UIImage *sendImage = [[UIImage alloc] initWithCGImage:imageRefRect];
        return  sendImage;
    }
}
@end
