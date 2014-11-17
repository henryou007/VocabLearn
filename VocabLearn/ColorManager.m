//
//  ColorManager.m
//  VocabLearn
//
//  Created by Tienchai Wirojsaksaree on 11/16/14.
//  Copyright (c) 2014 Henryyou. All rights reserved.
//

#import "ColorManager.h"

@implementation ColorManager

+ (UIColor *)backgroundColor {
  return [self blackColor];
}

+ (UIColor *)navigationBarColor {
  return [self darkRedColor];
}

+ (UIColor *)navigationBarTitleColor {
  return [self orangeColor];
}

+ (UIColor *)textColor {
  return [self lightGreenColor];
}

+ (UIColor *)tableViewSeparatorColor {
  return [self yellowColor];
}

+ (UIColor *)correctColor {
  return [self greenColor];
}

+ (UIColor *)wrongColor {
  return [self orangeColor];
}

#pragma mark - Private colors

#define RETURN_STATIC_COLOR(redColor, greenColor, blueColor, alphaValue) \
  static UIColor *color; \
  static dispatch_once_t once; \
  dispatch_once(&once, ^{ \
  color = [UIColor colorWithRed:((CGFloat) (redColor)/0xff) green:((CGFloat) (greenColor)/0xff) blue:((CGFloat) (blueColor)/0xff) alpha:alphaValue]; \
  }); \
  return color

+ (UIColor *)blackColor {
  RETURN_STATIC_COLOR(0x0b, 0x05, 0x05, 1);
}

+ (UIColor *)darkRedColor {
  RETURN_STATIC_COLOR(0x5f, 0x14, 0x00, 1);
}

+ (UIColor *)orangeColor {
  RETURN_STATIC_COLOR(0xf8, 0x5c, 0x05, 1);
}

+ (UIColor *)yellowColor {
  RETURN_STATIC_COLOR(0xf7, 0xe4, 0x32, 1);
}

+ (UIColor *)lightGreenColor {
  RETURN_STATIC_COLOR(0xb0, 0xe2, 0xb1, 1);
}

+ (UIColor *)greenColor {
  RETURN_STATIC_COLOR(0x4f, 0x87, 0x30, 1);
}

@end
