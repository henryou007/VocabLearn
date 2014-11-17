//
//  MultipleChoiceViewController.m
//  VocabLearn
//
//  Created by Patrick Klitzke on 11/16/14.
//  Copyright (c) 2014 Henryyou. All rights reserved.
//

#import "MultipleChoiceViewController.h"
#import "UIColor+VocabLean.h"

static const CGFloat kBarWidth = 50;
static const CGFloat kBarHeight = 30;
static const CGFloat kBarLeftPadding = 30;;
static const CGFloat kBarTopPadding = 20;;

static const int kElementsPerLine = 5;



@interface MultipleChoiceViewController ()
@property (weak, nonatomic) IBOutlet UIView *testView;
@property (weak, nonatomic) IBOutlet UIButton *answerOneBtn;
@property (weak, nonatomic) IBOutlet UIButton *answerTwoBtn;
@property (weak, nonatomic) IBOutlet UIButton *answerThreeBtn;

@end

@implementation MultipleChoiceViewController
{
  // x postion of the progress bar
  int questionsAnswered;
}

- (CGFloat)_getXPos
{
  return  kBarLeftPadding + kBarWidth * (questionsAnswered % kElementsPerLine);
}
- (CGFloat)_getYPos
{
  return  kBarTopPadding + kBarHeight * (questionsAnswered/kElementsPerLine);
}

- (void)_styleButton:(UIButton *)btn
{
  btn.layer.cornerRadius = 10;
  btn.layer.borderWidth=1.0f;
  btn.layer.borderColor=[[UIColor whiteColor] CGColor];
  btn.clipsToBounds = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    questionsAnswered = 0;
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
  [self correctClick:sender];
}
- (IBAction)twoClick:(id)sender {
  [self wrongClick:sender];
}
- (IBAction)threeClick:(id)sender {
  [self wrongClick:sender];
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
      
      [UIView animateWithDuration:0.5 delay:0.3 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        CGRect helpFrame = _testView.frame;
        helpFrame.origin.x -= self.view.frame.size.width;
        _testView.frame = helpFrame;
        _testView.alpha = 1;
      } completion:nil];
      
        [UIView animateWithDuration:0.5 delay:0.1 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        CGRect frame = myView.frame;
        frame.origin.x = [self _getXPos];
        frame.origin.y = [self _getYPos];
          questionsAnswered += 1;
        myView.frame = frame;
      } completion:^(BOOL finished) {
        
      }];
    }];
  }];
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
