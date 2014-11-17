//
//  MultipleChoiceQuestion.m
//  VocabLearn
//
//  Created by Patrick Klitzke on 11/16/14.
//  Copyright (c) 2014 Henryyou. All rights reserved.
//

#import "MultipleChoiceQuestion.h"
#import "VocabList.h"
#include <stdlib.h>

@implementation MultipleChoiceQuestion
{
  NSArray *questions;
  NSArray *solutions;
  int round;
  
  int correctAnswers;
  int wrongAnswers;

  NSMutableArray* answers;
  NSUInteger correctAnswer;
}

- (NSString *)getResultMessage
{
  return [NSString stringWithFormat:@"%d of %d questions correct answered", correctAnswers, wrongAnswers];
}


- (instancetype)initWithVocabList:(VocabList *)vocabularyList
{
  if (self = [super init]) {
    round = -1;
    questions = [[vocabularyList vocabulary] allKeys];
    solutions = [[vocabularyList vocabulary] allValues];
  }
  return self;
}

- (void)calculateNextRound {
  round += 1;
  if (round == [self getNumberOfQuestions]) {
    return;
  }
  correctAnswer = arc4random_uniform(3);
  
  answers = [[NSMutableArray alloc] init];
  
  NSUInteger firstWrong = -1;
  
  for (int n=0; n < 3;) {
    if (n == correctAnswer) {
      [answers addObject:solutions[round]];
      n++;
    } else {
      NSUInteger ran = arc4random_uniform([self getNumberOfQuestions]);
      
      if (ran != firstWrong && ran != round) {
        firstWrong = ran;
        [answers addObject:solutions[ran]];
        n++;
      }
    }
  }
}

- (NSString *)getAnswerForInt:(int)num
{
  return answers[num];
}

- (BOOL)answerWithInt:(int)num
{
  if (num == correctAnswer) {
    correctAnswers += 1;
    return YES;
  } else {
    wrongAnswers += 1;
    return NO;
  }
}

- (NSString *)getQuestion
{
  return questions[round];
}


- (NSUInteger)getNumberOfQuestions {
  if (questions.count > 18) {
    return 18;
  }
  return questions.count;
}



@end
