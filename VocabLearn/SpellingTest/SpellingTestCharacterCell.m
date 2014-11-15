//
//  SpellingTestCharacterCell.m
//  VocabLearn
//
//  Created by Tienchai Wirojsaksaree on 11/15/14.
//  Copyright (c) 2014 Henryyou. All rights reserved.
//

#import "SpellingTestCharacterCell.h"

@interface SpellingTestCharacterCell ()

@property (nonatomic, strong, readonly) UILabel *characterLabel;

@end

@implementation SpellingTestCharacterCell

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:(CGRect)frame]) {
    _characterLabel = [[UILabel alloc] init];
    self.characterLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.characterLabel];

    [self setNeedsUpdateConstraints];
  }
  return self;
}

- (void)updateConstraints {
  NSDictionary *views = @{@"characterLabel": self.characterLabel};

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

- (void)setCharacter:(unichar)character {
  _character = toupper(character);
  self.characterLabel.text = [NSString stringWithCharacters:&_character length:1];
}

@end