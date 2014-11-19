//
//  MultipleChoiceViewController.m
//  VocabLearn
//
//  Created by Patrick Klitzke on 11/16/14.
//  Copyright (c) 2014 Henryyou. All rights reserved.
//

#import "MultipleChoiceViewController.h"
#import "UIColor+VocabLean.h"
#import "VocabList.h"
#import "MultipleChoiceQuestion.h"
#import "AppDelegate.h"

static const CGFloat kBarWidth = 50;
static const CGFloat kBarHeight = 30;
static const CGFloat kBarLeftPadding = 30;;
static const CGFloat kBarTopPadding = 20;;

static const int kElementsPerLine = 5;

@interface MultipleChoiceViewController ()
@property (weak, nonatomic) IBOutlet UIView *testView;
@property (weak, nonatomic) IBOutlet UIButton *answerOneBtn;
@property (weak, nonatomic) IBOutlet UIButton *answerTwoBtn;
@property (weak, nonatomic) IBOutlet UILabel *meaningLabel;
@property (weak, nonatomic) IBOutlet UIButton *answerThreeBtn;
@end

@interface MultipleChoiceQuestion() <UIAlertViewDelegate>

@end

@implementation MultipleChoiceViewController
{
  // x postion of the progress bar
  int questionsAnswered;
  __weak IBOutlet UILabel *questionLabel;
  __weak IBOutlet UILabel *titleLabel;
  MultipleChoiceQuestion *_multipleChoiceQuestion;
  BOOL lastRound;
  
}

- (id)initWithVocabList:(VocabList *)vocabularyList {
  if (self = [super init]) {
    _multipleChoiceQuestion = [[MultipleChoiceQuestion alloc] initWithVocabList:vocabularyList];
  }
  return self;
}

- (NSUInteger)_getMaxNumberOfQuestions
{
  return [_multipleChoiceQuestion getNumberOfQuestions];
}


- (void)_updateRound
{
  [_multipleChoiceQuestion calculateNextRound];
  if (questionsAnswered < [self _getMaxNumberOfQuestions]) {
    titleLabel.text = [NSString stringWithFormat:@"Question %d of %ld:", questionsAnswered+1, [self _getMaxNumberOfQuestions]];
    questionLabel.text = [NSString stringWithFormat:@"'%@'", [_multipleChoiceQuestion getQuestion]];
    
    [_answerOneBtn setTitle:[NSString stringWithFormat:@"1. %@", [_multipleChoiceQuestion getAnswerForInt:0]] forState:UIControlStateNormal];
    
       [_answerTwoBtn setTitle:[NSString stringWithFormat:@"2. %@", [_multipleChoiceQuestion getAnswerForInt:1]] forState:UIControlStateNormal];
    
       [_answerThreeBtn setTitle:[NSString stringWithFormat:@"3. %@", [_multipleChoiceQuestion getAnswerForInt:2]] forState:UIControlStateNormal];
    
  } else {
    lastRound = YES;
  }
}



- (CGFloat)_getXPos
{
  return  kBarLeftPadding + kBarWidth * ((questionsAnswered-1) % kElementsPerLine);
}
- (CGFloat)_getYPos
{
  return  kBarTopPadding + kBarHeight * ((questionsAnswered-1)/kElementsPerLine);
}


- (void)_styleButton:(UIButton *)btn
{
  btn.layer.cornerRadius = 10;
  btn.layer.borderWidth=1.0f;
  btn.layer.borderColor=[[UIColor textColor] CGColor];
  btn.clipsToBounds = YES;
  btn.titleLabel.adjustsFontSizeToFitWidth = YES;
  btn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
  btn.titleLabel.textAlignment=UITextAlignmentCenter;
  
  btn.titleLabel.textColor = [UIColor textColor];
  btn.titleLabel.tintColor = [UIColor textColor];
  [btn setTitleColor:[UIColor textColor] forState:UIControlStateNormal];
}


- (void)viewDidLoad {
    [super viewDidLoad];
  questionLabel.textColor = [UIColor textColor];
  titleLabel.textColor = [UIColor textColor];
  self.view.backgroundColor = [UIColor backgroundColor];
  self.meaningLabel.textColor = [UIColor textColor];
  
  _testView.layer.borderWidth=1.0f;
  _testView.layer.borderColor=[[UIColor textColor] CGColor];
  _testView.backgroundColor = [UIColor backgroundColor];
  

    questionsAnswered = 0;
  [self _updateRound];
  [self _styleButton:_answerOneBtn];
  [self _styleButton:_answerTwoBtn];
  [self _styleButton:_answerThreeBtn];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)correctClick:(id)sender {
    [self animateResultWithColor:[UIColor correctColor]];
  
}
- (IBAction)wrongClick:(id)sender {
  [self animateResultWithColor:[UIColor wrongColor]];
}
- (IBAction)oneClick:(id)sender {
  [self _answerWithInt:0];
}
- (IBAction)twoClick:(id)sender {
  [self _answerWithInt:1];

}
- (IBAction)threeClick:(id)sender {
  [self _answerWithInt:2];
}

- (void)_answerWithInt:(int)num
{
  if ([_multipleChoiceQuestion answerWithInt:num]) {
    [self correctClick:self];
  } else {
    [self wrongClick:self];
  }
}

- (void)animateResultWithColor:(UIColor *)color {
  UIView *myView =[[UIView alloc] initWithFrame:_testView.frame];
  
  myView.backgroundColor = color;
  myView.alpha = 0;
  [self.view addSubview:myView];
  
  CGFloat middleY = _testView.bounds.origin.y + _testView.frame.size.height / 2;
  CGFloat middleX = _testView.bounds.origin.x + _testView.frame.size.width / 2;
  
  [UIView animateWithDuration:0.5 animations:^{
    myView.alpha = 1;
    _testView.alpha = 0;
    
  } completion:^(BOOL finished) {
    [UIView animateWithDuration:0.5 animations:^{
      CGRect frame = myView.bounds;
      frame.size.width = kBarWidth;
      frame.size.height = kBarHeight;
      frame.origin.x = middleX;
      frame.origin.y = middleY;
      myView.bounds = frame;
    } completion:^(BOOL finished) {
      
      // move the card from the right to the left
      CGRect helpFrame = _testView.frame;
      helpFrame.origin.x += self.view.frame.size.width;
      _testView.frame = helpFrame;
      
      questionsAnswered += 1;
      [self _updateRound];
    
      if (!lastRound) {
        [UIView animateWithDuration:0.5 delay:0.3 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
          CGRect helpFrame = _testView.frame;
          helpFrame.origin.x -= self.view.frame.size.width;
          _testView.frame = helpFrame;
          _testView.alpha = 1;
        } completion:nil];
      }
      
        [UIView animateWithDuration:0.5 delay:0.1 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        CGRect frame = myView.frame;
        frame.origin.x = [self _getXPos];
        frame.origin.y = [self _getYPos];
        myView.frame = frame;
      } completion:^(BOOL finished) {
        if (lastRound) {
          NSString *resultMessage = [_multipleChoiceQuestion getResultMessage];
          [[[UIAlertView alloc] initWithTitle:@"Your Result:" message:resultMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }
      }];
    }];
  }];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
[appDelegate showMainRootController];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
