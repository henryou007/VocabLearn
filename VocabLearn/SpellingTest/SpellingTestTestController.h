//
//  SpellingTestTestController.h
//  VocabLearn
//
//  Created by Tienchai Wirojsaksaree on 11/15/14.
//  Copyright (c) 2014 Henryyou. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SpellingTestQuestion.h"
#import "VocabList.h"

@interface SpellingTestTestController : NSObject

- (instancetype)initWithVocabList:(VocabList *)vocabList;

- (SpellingTestQuestion *)nextQuestion;

@end
