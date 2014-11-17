//
//  ColorManager.h
//  VocabLearn
//
//  Created by Tienchai Wirojsaksaree on 11/16/14.
//  Copyright (c) 2014 Henryyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ColorManager : NSObject

+ (UIColor *)backgroundColor;
+ (UIColor *)textColor;

+ (UIColor *)correctColor;
+ (UIColor *)wrongColor;

@end
