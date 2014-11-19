//
//  UIColor+VocabLean.m
//  VocabLearn
//
//  Created by Tienchai Wirojsaksaree on 11/16/14.
//  Copyright (c) 2014 Henryyou. All rights reserved.
//

#import "UIColor+VocabLean.h"

@implementation UIColor (VocabLearn)

+ (UIColor *)backgroundColor {
  return [self customBlackColor];
}

+ (UIColor *)navigationBarColor {
  return [self customDarkRedColor];
}

+ (UIColor *)navigationBarTitleColor {
  return [self customOrangeColor];
}

+ (UIColor *)textColor {
  return [self customLightcustomGreenColor];
}

+ (UIColor *)tableViewSeparatorColor {
  return [self darkGrayColor];
}

+ (UIColor *)correctColor {
  return [self customGreenColor];
}

+ (UIColor *)wrongColor {
  return [self customOrangeColor];
}

#pragma mark - Private colors

#define RETURN_STATIC_COLOR(redColor, customGreenColor, blueColor, alphaValue) \
  static UIColor *color; \
  static dispatch_once_t once; \
  dispatch_once(&once, ^{ \
  color = [UIColor colorWithRed:((CGFloat) (redColor)/0xff) green:((CGFloat) (customGreenColor)/0xff) blue:((CGFloat) (blueColor)/0xff) alpha:alphaValue]; \
  }); \
  return color

+ (UIColor *)customBlackColor {
  RETURN_STATIC_COLOR(0x0b, 0x05, 0x05, 1);
}

+ (UIColor *)customDarkRedColor {
  RETURN_STATIC_COLOR(0x5f, 0x14, 0x00, 1);
}

+ (UIColor *)customOrangeColor {
  RETURN_STATIC_COLOR(0xf8, 0x5c, 0x05, 1);
}

+ (UIColor *)customYellowColor {
  RETURN_STATIC_COLOR(0xf7, 0xe4, 0x32, 1);
}

+ (UIColor *)customLightcustomGreenColor {
  RETURN_STATIC_COLOR(0xb0, 0xe2, 0xb1, 1);
}

+ (UIColor *)customGreenColor {
  RETURN_STATIC_COLOR(0x4f, 0x87, 0x30, 1);
}

@end
