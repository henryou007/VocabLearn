//
//  SpellingTestTestController.m
//  VocabLearn
//
//  Created by Tienchai Wirojsaksaree on 11/15/14.
//  Copyright (c) 2014 Henryyou. All rights reserved.
//

#import "SpellingTestTestController.h"

#import <stdlib.h>

@interface SpellingTestTestController () <SpellingTestQuestionDelegate>

@property (nonatomic, assign, readwrite) NSUInteger correctCount;
@property (nonatomic, strong, readonly) VocabList *vocabList;

@end

@implementation SpellingTestTestController

- (id)initWithVocabList:(VocabList *)vocabList {
  if (self = [super init]) {
    _vocabList = vocabList;
  }
  return self;
}

- (SpellingTestQuestion *)nextQuestion {
  NSDictionary *vocabulary = self.vocabList.vocabulary;

  NSUInteger vocabIndex = arc4random_uniform((u_int32_t) vocabulary.count);
  NSString *word = vocabulary.allKeys[vocabIndex];

  SpellingTestQuestion *question = [[SpellingTestQuestion alloc] initWithWord:word meaning:vocabulary[word]];
  question.delegate = self;
  return question;
}

#pragma mark - SpellingTestQuestionDelegate

- (void)questionDidGuessCorrectly:(SpellingTestQuestion *)question {
  self.correctCount++;
}

@end
