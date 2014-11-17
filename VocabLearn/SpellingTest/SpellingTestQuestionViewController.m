//
//  SpellingTestQuestionViewController.m
//  VocabLearn
//
//  Created by Tienchai Wirojsaksaree on 11/15/14.
//  Copyright (c) 2014 Henryyou. All rights reserved.
//

#import "SpellingTestQuestionViewController.h"

#import "ColorManager.h"
#import "SpellingTestCharacter.h"
#import "SpellingTestCharacterPickerView.h"
#import "SpellingTestGuessingAreaView.h"

@interface SpellingTestQuestionViewController () <SpellingTestCharacterPickerViewDelegate, SpellingTestGuessingAreaViewDelegate, UIAlertViewDelegate>

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
    self.meaningLabel.textColor = [ColorManager textColor];
    self.meaningLabel.numberOfLines = 0;
    self.meaningLabel.translatesAutoresizingMaskIntoConstraints = NO;

    _characterPickerView = [[SpellingTestCharacterPickerView alloc] init];
    self.characterPickerView.characterPickerDelegate = self;
    self.characterPickerView.translatesAutoresizingMaskIntoConstraints = NO;

    _deleteButton = [[UIButton alloc] init];
    [self.deleteButton setTitle:@"DEL<" forState:UIControlStateNormal];
    [self.deleteButton setTitleColor:[ColorManager textColor] forState:UIControlStateNormal];
    [self.deleteButton addTarget:self action:@selector(onDeleteButtonTap) forControlEvents:UIControlEventTouchUpInside];
    self.deleteButton.translatesAutoresizingMaskIntoConstraints = NO;

    [self presentNextQuestion];
  }
  return self;
}

- (void)loadView {
  [super loadView];
  self.view.backgroundColor = [ColorManager backgroundColor];

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

  [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-60-[guessingAreaView(40)]-60-[meaningLabel]-5-[characterPickerView(200)]-5-[deleteButton]-(>=5)-|"
                                                                    options:NSLayoutFormatAlignAllCenterX
                                                                    metrics:nil
                                                                      views:views]];

  [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[guessingAreaView]-10-|"
                                                                    options:0
                                                                    metrics:nil
                                                                      views:views]];

  [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[meaningLabel]-10-|"
                                                                    options:0
                                                                    metrics:nil
                                                                      views:views]];

  [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[characterPickerView]-10-|"
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
  self.deleteButton.enabled = NO;
  self.meaningLabel.text = self.question.meaning;
  [self.characterPickerView setCharactersAndClearSelectionState:self.question.playableCharacters];
}

#pragma mark - SpellingTestCharacterPickerViewDelegate

- (void)characterPickerView:(SpellingTestCharacterPickerView *)characterPickerView didSelectCharacter:(SpellingTestCharacter *)character atIndex:(NSUInteger)index {
  [self.guessingAreaView addCharacter:character];
  self.deleteButton.enabled = YES;
}

- (void)characterPickerView:(SpellingTestCharacterPickerView *)characterPickerView didDeselectCharacter:(SpellingTestCharacter *)character atIndex:(NSUInteger)index {
  [self.guessingAreaView removeCharacter:character];
}

#pragma mark - SpellingTestGuessingAreaViewDelegate

- (void)guessingAreaView:(SpellingTestGuessingAreaView *)guessingAreaView didSelectNonEmptyCharacter:(SpellingTestCharacter *)character atIndex:(NSUInteger)index {
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
    self.deleteButton.enabled = NO;
  }
}

- (void)guessingAreaViewDidHaveNoCharacters:(SpellingTestGuessingAreaView *)guessingAreaView {
  self.deleteButton.enabled = NO;
}

#pragma mark - Delete Button

- (void)onDeleteButtonTap {
  SpellingTestCharacter * lastCharacter = [self.guessingAreaView removeLastCharacter];
  [self.characterPickerView deselectCharacter:lastCharacter];
}

#pragma mark - Results

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  NSUInteger correctCount = self.testController.correctCount;
  if (correctCount == 0) {
    return;
  }
  NSString *message = [NSString stringWithFormat:@"You got %lu question%@ right.", (unsigned long)correctCount, correctCount == 1 ? @"" : @"s"];
  [[[UIAlertView alloc] initWithTitle:@"Result" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
  [self.navigationController popViewControllerAnimated:YES];
}

@end
