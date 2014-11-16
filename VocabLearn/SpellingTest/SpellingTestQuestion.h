//
//  SpellingTestQuestion.h
//  VocabLearn
//
//  Created by Tienchai Wirojsaksaree on 11/15/14.
//  Copyright (c) 2014 Henryyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SpellingTestQuestion;

@protocol SpellingTestQuestionDelegate <NSObject>

- (void)questionDidGuessCorrectly:(SpellingTestQuestion *)question;

@end

@interface SpellingTestQuestion : NSObject

@property (nonatomic, weak, readwrite) id<SpellingTestQuestionDelegate> delegate;

@property (nonatomic, strong, readonly) NSArray *playableCharacters;
@property (nonatomic, assign, readonly) NSUInteger wordLength;
@property (nonatomic, strong, readonly) NSString *meaning;

- (instancetype)initWithWord:(NSString *)word meaning:(NSString *)meaning;

- (BOOL)guessWithCharacters:(NSArray *)guessingCharacters;

@end
