//
//  SpellingTestCharacterView.m
//  VocabLearn
//
//  Created by Tienchai Wirojsaksaree on 11/18/14.
//  Copyright (c) 2014 Henryyou. All rights reserved.
//

#import "SpellingTestCharacterView.h"

#import "UIColor+VocabLean.h"

@implementation SpellingTestCharacterView

- (instancetype)init {
  if (self = [super init]) {
    self.textColor = [UIColor textColor];
    self.textAlignment = NSTextAlignmentCenter;
    self.translatesAutoresizingMaskIntoConstraints = NO;
  }
  return self;
}

#pragma mark character

@synthesize character = _character;

- (void)setCharacter:(SpellingTestCharacter *)character {
  _character = character;
  self.text = self.character.description;
}

@end
