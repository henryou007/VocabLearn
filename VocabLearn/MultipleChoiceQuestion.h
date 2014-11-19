//
//  MultipleChoiceQuestion.h
//  VocabLearn
//
//  Created by Patrick Klitzke on 11/16/14.
//  Copyright (c) 2014 Henryyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  VocabList;

@interface MultipleChoiceQuestion : NSObject

- (instancetype)initWithVocabList:(VocabList *)vocabularyList;

- (NSString *)getAnswerForInt:(int)num;
- (NSUInteger)getNumberOfQuestions;
- (void)calculateNextRound;
- (NSString *)getQuestion;
- (BOOL)answerWithInt:(int)num;
- (NSString *)getResultMessage;

@end
