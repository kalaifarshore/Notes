//
//  UIImage+customImage.h
//  Note
//
//  Created by dev11 on 4/15/17.
//  Copyright © 2017 dev11. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (customImage)

+ (UIImage *)imageByScalingProportionallyToSize:(UIImage*)sourceImage TargetSize:(CGSize)targetSize;
@end
