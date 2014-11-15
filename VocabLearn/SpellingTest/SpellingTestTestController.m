//
//  SpellingTestTestController.m
//  VocabLearn
//
//  Created by Tienchai Wirojsaksaree on 11/15/14.
//  Copyright (c) 2014 Henryyou. All rights reserved.
//

#import "SpellingTestTestController.h"

@interface SpellingTestTestController ()

@property (nonatomic, strong, readonly) VocabList *vocabList;

@end

@implementation SpellingTestTestController

- (id)initWithVocabList:(VocabList *)vocabList {
  if (self = [super init]) {
    _vocabList = vocabList;
  }
  return self;
}

@end
