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

@interface SpellingTestQuestionViewController () <SpellingTestCharacterPickerViewDelegate, SpellingTestGuessingAreaViewDelegate>

@property (nonatomic, strong, readonly) SpellingTestTestController *testController;
@property (nonatomic, strong, readwrite) SpellingTestQuestion *question;

@property (nonatomic, strong, readonly) SpellingTestGuessingAreaView *guessingAreaView;
@property (nonatomic, strong, readonly) UILabel *meaningLabel;
@property (nonatomic, strong, readonly) SpellingTestCharacterPickerView *characterPickerView;
@property (nonatomic, strong, readonly) UIButton *deleteButton;

@end

@implementation SpellingTestQuestionViewController

- (id)initWithTestController:(SpellingTestTestController *)testController {
  if (self = [super init]) {
    _testController = testController;

    _guessingAreaView = [[SpellingTestGuessingAreaView alloc] init];
    self.guessingAreaView.guessingAreaDelegate = self;
    self.guessingAreaView.translatesAutoresizingMaskIntoConstraints = NO;

    _meaningLabel = [[UILabel alloc] init];
    self.meaningLabel.numberOfLines = 0;
    self.meaningLabel.translatesAutoresizingMaskIntoConstraints = NO;

    _characterPickerView = [[SpellingTestCharacterPickerView alloc] init];
    self.characterPickerView.characterPickerDelegate = self;
    self.characterPickerView.translatesAutoresizingMaskIntoConstraints = NO;

    _deleteButton = [[UIButton alloc] init];
    [self.deleteButton setTitle:@"DEL<" forState:UIControlStateNormal];
    [self.deleteButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.deleteButton addTarget:self action:@selector(onDeleteButtonTap) forControlEvents:UIControlEventTouchUpInside];
    self.deleteButton.translatesAutoresizingMaskIntoConstraints = NO;

    [self presentNextQuestion];
  }
  return self;
}

- (void)loadView {
  [super loadView];
  self.view.backgroundColor = [UIColor whiteColor];

  [self.view addSubview:self.guessingAreaView];
  [self.view addSubview:self.meaningLabel];
  [self.view addSubview:self.characterPickerView];
  [self.view addSubview:self.deleteButton];

  [self.view setNeedsUpdateConstraints];
}

- (void)updateViewConstraints {
  NSDictionary *views = @{@"guessingAreaView": self.guessingAreaView,
                          @"meaningLabel": self.meaningLabel,
                          @"characterPickerView": self.characterPickerView,
                          @"deleteButton": self.deleteButton,
                          };

  [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[guessingAreaView(200)]-5-[meaningLabel]-5-[characterPickerView(200)]-5-[deleteButton]-(>=5)-|"
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

- (void)presentNextQuestion {
  self.question = [self.testController nextQuestion];
}

#pragma mark - Getters/Setters

@synthesize question = _question;

- (void)setQuestion:(SpellingTestQuestion *)question {
  _question = question;

  [self.guessingAreaView setCharacterLengthAndResetCharacters:self.question.wordLength];
  self.meaningLabel.text = self.question.meaning;
  [self.characterPickerView setCharactersAndClearSelectionState:self.question.playableCharacters];
}

#pragma mark - SpellingTestCharacterPickerViewDelegate

- (void)characterPickerView:(SpellingTestCharacterPickerView *)characterPickerView didSelectCharacter:(unichar)character atIndex:(NSUInteger)index {
  [self.guessingAreaView addCharacter:character];
}

- (void)characterPickerView:(SpellingTestCharacterPickerView *)characterPickerView didDeselectCharacter:(unichar)character atIndex:(NSUInteger)index {
  [self.guessingAreaView removeCharacter:character];
}

#pragma mark - SpellingTestGuessingAreaViewDelegate

- (void)guessingAreaView:(SpellingTestGuessingAreaView *)guessingAreaView didSelectNonEmptyCharacter:(unichar)character atIndex:(NSUInteger)index {
  [guessingAreaView removeCharacterAtIndex:index];
  [self.characterPickerView deselectCharacter:character];
}

- (void)guessingAreaView:(SpellingTestGuessingAreaView *)guessingAreaView didReachCharacterLengthWithCharacters:(NSArray *)characters {
  BOOL isCorrect = [self.question guessWithCharacters:characters];
  NSString *alertText = isCorrect ? @"Correct!" : @"Wrong!";
  [[[UIAlertView alloc] initWithTitle:nil message:alertText delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
  if (isCorrect) {
    [self presentNextQuestion];
  } else {
    [self.characterPickerView clearSelectionState];
    [self.guessingAreaView removeAllCharacters];
  }
}

#pragma mark - Delete Button

- (void)onDeleteButtonTap {
  unichar lastCharacter = [self.guessingAreaView removeLastCharacter];
  [self.characterPickerView deselectCharacter:lastCharacter];
}

@end
