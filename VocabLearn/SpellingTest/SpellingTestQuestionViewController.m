//
//  SpellingTestQuestionViewController.m
//  VocabLearn
//
//  Created by Tienchai Wirojsaksaree on 11/15/14.
//  Copyright (c) 2014 Henryyou. All rights reserved.
//

#import "SpellingTestQuestionViewController.h"

#import "SpellingTestCharacterPickerView.h"
#import "SpellingTestGuessingAreaView.h"

@interface SpellingTestQuestionViewController ()

@property (nonatomic, strong, readonly) SpellingTestTestController *testController;
@property (nonatomic, strong, readwrite) SpellingTestQuestion *question;

@property (nonatomic, strong, readonly) SpellingTestGuessingAreaView *guessingAreaView;
@property (nonatomic, strong, readonly) UILabel *meaningLabel;
@property (nonatomic, strong, readonly) SpellingTestCharacterPickerView *characterPickerView;

@end

@implementation SpellingTestQuestionViewController

- (id)initWithTestController:(SpellingTestTestController *)testController {
  if (self = [super init]) {
    _testController = testController;

    _guessingAreaView = [[SpellingTestGuessingAreaView alloc] init];
    self.guessingAreaView.translatesAutoresizingMaskIntoConstraints = NO;

    _meaningLabel = [[UILabel alloc] init];
    self.meaningLabel.numberOfLines = 0;
    self.meaningLabel.translatesAutoresizingMaskIntoConstraints = NO;

    _characterPickerView = [[SpellingTestCharacterPickerView alloc] init];
    self.characterPickerView.translatesAutoresizingMaskIntoConstraints = NO;

    self.question = [self.testController nextQuestion];
  }
  return self;
}

- (void)loadView {
  [super loadView];
  self.view.backgroundColor = [UIColor whiteColor];

  [self.view addSubview:self.guessingAreaView];
  [self.view addSubview:self.meaningLabel];
  [self.view addSubview:self.characterPickerView];

  [self.view setNeedsUpdateConstraints];
}

- (void)updateViewConstraints {
  NSDictionary *views = @{@"guessingAreaView": self.guessingAreaView,
                          @"meaningLabel": self.meaningLabel,
                          @"characterPickerView": self.characterPickerView,
                          };

  [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[guessingAreaView(200)]-5-[meaningLabel]-5-[characterPickerView(300)]-(>=5)-|"
                                                                    options:NSLayoutFormatAlignAllCenterX
                                                                    metrics:nil
                                                                      views:views]];

  [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[guessingAreaView]-5-|"
                                                                    options:0
                                                                    metrics:nil
                                                                      views:views]];

  [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[meaningLabel]-5-|"
                                                                    options:0
                                                                    metrics:nil
                                                                      views:views]];

  [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[characterPickerView]-5-|"
                                                                    options:0
                                                                    metrics:nil
                                                                      views:views]];
  
  [super updateViewConstraints];
}

#pragma mark - Getters/Setters

@synthesize question = _question;

- (void)setQuestion:(SpellingTestQuestion *)question {
  _question = question;

  [self.characterPickerView setCharactersAndClearSelectionState:self.question.playableCharacters];
  self.meaningLabel.text = self.question.meaning;
  [self.guessingAreaView setCharacterLengthAndResetCharacters:self.question.wordLength];
}

@end
