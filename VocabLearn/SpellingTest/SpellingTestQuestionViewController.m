//
//  SpellingTestQuestionViewController.m
//  VocabLearn
//
//  Created by Tienchai Wirojsaksaree on 11/15/14.
//  Copyright (c) 2014 Henryyou. All rights reserved.
//

#import "SpellingTestQuestionViewController.h"

#import "SpellingTestCharacter.h"
#import "SpellingTestCharacterView.h"
#import "SpellingTestCharacterPickerView.h"
#import "SpellingTestGuessingAreaView.h"
#import "UIColor+VocabLean.h"

@interface SpellingTestQuestionViewController () <SpellingTestCharacterPickerViewDelegate, SpellingTestGuessingAreaViewDelegate, UIAlertViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong, readonly) SpellingTestTestController *testController;
@property (nonatomic, strong, readwrite) SpellingTestQuestion *question;

@property (nonatomic, strong, readonly) SpellingTestGuessingAreaView *guessingAreaView;
@property (nonatomic, strong, readonly) UILabel *meaningLabel;
@property (nonatomic, strong, readonly) SpellingTestCharacterPickerView *characterPickerView;
@property (nonatomic, strong, readonly) UIButton *deleteButton;

@property (nonatomic, strong, readwrite) SpellingTestCharacterView *panningCharacterView;
@property (nonatomic, assign, readwrite) BOOL paddingCharacterCameFromPicker;

@end

@implementation SpellingTestQuestionViewController

- (id)initWithTestController:(SpellingTestTestController *)testController {
  if (self = [super init]) {
    _testController = testController;

    _guessingAreaView = [[SpellingTestGuessingAreaView alloc] init];
    self.guessingAreaView.guessingAreaDelegate = self;
    self.guessingAreaView.translatesAutoresizingMaskIntoConstraints = NO;

    _meaningLabel = [[UILabel alloc] init];
    self.meaningLabel.textColor = [UIColor textColor];
    self.meaningLabel.numberOfLines = 0;
    self.meaningLabel.translatesAutoresizingMaskIntoConstraints = NO;

    _characterPickerView = [[SpellingTestCharacterPickerView alloc] init];
    self.characterPickerView.characterPickerDelegate = self;
    self.characterPickerView.translatesAutoresizingMaskIntoConstraints = NO;

    _deleteButton = [[UIButton alloc] init];
    [self.deleteButton setTitle:@"DEL<" forState:UIControlStateNormal];
    [self.deleteButton setTitleColor:[UIColor textColor] forState:UIControlStateNormal];
    [self.deleteButton addTarget:self action:@selector(onDeleteButtonTap) forControlEvents:UIControlEventTouchUpInside];
    self.deleteButton.translatesAutoresizingMaskIntoConstraints = NO;

    [self presentNextQuestion];
  }
  return self;
}

- (void)loadView {
  [super loadView];
  self.view.backgroundColor = [UIColor backgroundColor];

  [self.view addSubview:self.guessingAreaView];
  [self.view addSubview:self.meaningLabel];
  [self.view addSubview:self.characterPickerView];
  [self.view addSubview:self.deleteButton];

  UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPan:)];
  panGestureRecognizer.delegate = self;
  [self.view addGestureRecognizer:panGestureRecognizer];

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

- (void)startPanningCharacter:(SpellingTestCharacter *)character fromPicker:(BOOL)fromPicker{
  self.paddingCharacterCameFromPicker = fromPicker;

  self.panningCharacterView = [[SpellingTestCharacterView alloc] init];
  self.panningCharacterView.character = character;
  self.panningCharacterView.hidden = YES;
  [self.view addSubview:self.panningCharacterView];
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

- (UIView *)referenceView {
  return self.view;
}

- (void)characterPickerView:(SpellingTestCharacterPickerView *)characterPickerView didSelectCharacter:(SpellingTestCharacter *)character atIndex:(NSUInteger)index location:(CGPoint)location {
  [self startPanningCharacter:character fromPicker:YES];
}

#pragma mark - SpellingTestGuessingAreaViewDelegate

- (void)guessingAreaView:(SpellingTestGuessingAreaView *)guessingAreaView didSelectNonEmptyCharacter:(SpellingTestCharacter *)character atIndex:(NSUInteger)index {
  [guessingAreaView removeCharacterAtIndex:index];
  [self startPanningCharacter:character fromPicker:NO];
}

- (void)guessingAreaView:(SpellingTestGuessingAreaView *)guessingAreaView didReachCharacterLengthWithCharacters:(NSArray *)characters {
  BOOL isCorrect = [self.question guessWithCharacters:characters];
  NSString *alertText = isCorrect ? @"Correct!" : @"Wrong!";
  [[[UIAlertView alloc] initWithTitle:nil message:alertText delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
  [self presentNextQuestion];
}

- (void)guessingAreaViewDidHaveNoCharacters:(SpellingTestGuessingAreaView *)guessingAreaView {
  self.deleteButton.enabled = NO;
}

#pragma mark - UIGestureRecognizerDelegate and handle gesture

- (void)onPan:(UIPanGestureRecognizer *)panGestureRecognizer {
  if (self.panningCharacterView) {
    switch (panGestureRecognizer.state) {
      case UIGestureRecognizerStateChanged:
      {
        self.panningCharacterView.center = [panGestureRecognizer locationInView:self.view];
        self.panningCharacterView.hidden = NO;
        break;
      }
      case UIGestureRecognizerStateEnded:
      {
        CGPoint point = [panGestureRecognizer locationInView:self.view];
        if ((self.paddingCharacterCameFromPicker && CGRectContainsPoint(self.guessingAreaView.frame, point)) || (!self.paddingCharacterCameFromPicker && !CGRectContainsPoint(self.characterPickerView.frame, point))) {
          // Give to the guessing view
          [self.guessingAreaView addCharacter:self.panningCharacterView.character];
          self.deleteButton.enabled = YES;
        } else {
          // Return to the picker view
          [self.characterPickerView deselectCharacter:self.panningCharacterView.character];
        }
        [self.panningCharacterView removeFromSuperview];
        self.panningCharacterView = nil;
        break;
      }
      default:
        break;
    }
  }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
  return YES;
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
  NSUInteger wrongCount = self.testController.wrongCount;
  NSUInteger totalCount = correctCount + wrongCount;
  if (totalCount == 0) {
    return;
  }
  NSString *message = [NSString stringWithFormat:@"%lu\tcorrect\n%lu\twrong", (unsigned long)correctCount, (unsigned long)wrongCount];
  [[[UIAlertView alloc] initWithTitle:@"Your Result:" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
  [self.navigationController popViewControllerAnimated:YES];
}

@end
