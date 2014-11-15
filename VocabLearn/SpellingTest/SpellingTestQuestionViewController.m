//
//  SpellingTestQuestionViewController.m
//  VocabLearn
//
//  Created by Tienchai Wirojsaksaree on 11/15/14.
//  Copyright (c) 2014 Henryyou. All rights reserved.
//

#import "SpellingTestQuestionViewController.h"

@interface SpellingTestQuestionViewController ()

@property (nonatomic, strong, readonly) SpellingTestTestController *testController;

@end

@implementation SpellingTestQuestionViewController

- (id)initWithTestController:(SpellingTestTestController *)testController {
  if (self = [super init]) {
    _testController = testController;
  }
  return self;
}

@end
