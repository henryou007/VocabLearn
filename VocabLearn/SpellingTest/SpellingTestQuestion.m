//
//  SpellingTestQuestion.m
//  VocabLearn
//
//  Created by Tienchai Wirojsaksaree on 11/15/14.
//  Copyright (c) 2014 Henryyou. All rights reserved.
//

#import "SpellingTestQuestion.h"

#import <stdlib.h>

@interface SpellingTestQuestion ()

@property (nonatomic, strong, readonly) NSString *word;

@end

@implementation SpellingTestQuestion

static const NSUInteger kExtraPlayableCharacters = 5;

- (instancetype)initWithWord:(NSString *)word meaning:(NSString *)meaning {
  if (self = [super init]) {
    _word = word;
    _playableCharacters = [self.class generatePlayableCharactersWithWord:self.word];
    _meaning = meaning;
  }
  return self;
}

- (BOOL)guessWithCharacters:(NSArray *)guessingCharacters {
  if (guessingCharacters.count != self.word.length) {
    return NO;
  }
  for (int i = 0;i < self.word.length;i++) {
    if (tolower([self.word characterAtIndex:i]) != tolower([guessingCharacters[i] unsignedShortValue])) {
      return NO;
    }
  }
  return YES;
}

#pragma mark - Getters/Setters

- (NSUInteger)wordLength {
  return self.word.length;
}

#pragma mark -

+ (NSArray *)generatePlayableCharactersWithWord:(NSString *)word {
  NSMutableArray *playableCharacters = [NSMutableArray arrayWithCapacity:word.length + kExtraPlayableCharacters];
  for (int i = 0;i < word.length;i++) {
    [playableCharacters addObject:@([word characterAtIndex:i])];
  }
  for (int i = 0;i < kExtraPlayableCharacters;i++) {
    unichar randomChar = arc4random_uniform('z'-'a' + 1) + 'a';
    [playableCharacters addObject:@(randomChar)];
  }
  for (int i = 0;i < playableCharacters.count;i++) {
    [playableCharacters exchangeObjectAtIndex:i withObjectAtIndex:arc4random_uniform((u_int32_t) (playableCharacters.count - i)) + i];
  }
  return playableCharacters;
}

@end
