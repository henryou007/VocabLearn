//
//  SpellingTestCharacter.h
//  VocabLearn
//
//  Created by Tienchai Wirojsaksaree on 11/16/14.
//  Copyright (c) 2014 Henryyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpellingTestCharacter : NSObject

@property (nonatomic, assign, readonly) unichar character;

+ (instancetype)characterWithCharacter:(unichar)character;

- (instancetype)initWithCharacter:(unichar)character;

- (BOOL)isEqualToUnichar:(unichar)character;
- (BOOL)isEqualToCharacter:(SpellingTestCharacter *)character;
- (NSString *)description;

@end
