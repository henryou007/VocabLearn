//
//  ColorManager.m
//  VocabLearn
//
//  Created by Tienchai Wirojsaksaree on 11/16/14.
//  Copyright (c) 2014 Henryyou. All rights reserved.
//

#import "ColorManager.h"

@implementation ColorManager

#define RETURN_STATIC_COLOR(redColor, greenColor, blueColor, alphaValue) \
  static UIColor *color; \
  static dispatch_once_t once; \
  dispatch_once(&once, ^{ \
    color = [UIColor colorWithRed:((CGFloat) (redColor)/0xff) green:((CGFloat) (greenColor)/0xff) blue:((CGFloat) (blueColor)/0xff) alpha:alphaValue]; \
  }); \
  return color

+ (UIColor *)backgroundColor {
  RETURN_STATIC_COLOR(0x0b, 0x05, 0x05, 1);
}

+ (UIColor *)textColor {
  RETURN_STATIC_COLOR(0xb0, 0xe2, 0xb1, 1);
}

+ (UIColor *)correctColor {
  RETURN_STATIC_COLOR(0xf8, 0x5c, 0x05, 1);
}

+ (UIColor *)wrongColor {
  RETURN_STATIC_COLOR(0x4f, 0x87, 0x30, 1);
}

@end
