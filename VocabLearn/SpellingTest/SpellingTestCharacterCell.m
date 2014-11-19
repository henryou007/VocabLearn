//
//  SpellingTestCharacterCell.m
//  VocabLearn
//
//  Created by Tienchai Wirojsaksaree on 11/15/14.
//  Copyright (c) 2014 Henryyou. All rights reserved.
//

#import "SpellingTestCharacterCell.h"

#import "SpellingTestCharacterView.h"

#import "UIColor+VocabLean.h"

@interface SpellingTestCharacterCell ()

@property (nonatomic, strong, readonly) SpellingTestCharacterView *characterView;

@end

@implementation SpellingTestCharacterCell

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:(CGRect)frame]) {
    _characterView = [[SpellingTestCharacterView alloc] init];
    self.backgroundColor = [UIColor backgroundColor];
    [self.contentView addSubview:self.characterView];

    [self setNeedsUpdateConstraints];
  }
  return self;
}

- (void)updateConstraints {
  NSDictionary *views = @{@"characterLabel": self.characterView};

  [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[characterLabel]-0-|"
                                                                           options:0
                                                                           metrics:nil
                                                                             views:views]];

  [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[characterLabel]-0-|"
                                                                           options:0
                                                                           metrics:nil
                                                                             views:views]];

  [super updateConstraints];
}

#pragma mark properties

@synthesize character = _character;

- (void)setCharacter:(SpellingTestCharacter *)character {
  _character = character;
  self.characterView.character = self.character;
}

- (void)setSelected:(BOOL)selected {
  [super setSelected:selected];
  if (selected) {
    self.hidden = YES;
  } else {
    self.hidden = NO;
  }
}

@end
