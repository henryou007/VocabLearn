//
//  MultipleChoiceViewController.m
//  VocabLearn
//
//  Created by Patrick Klitzke on 11/16/14.
//  Copyright (c) 2014 Henryyou. All rights reserved.
//

#import "MultipleChoiceViewController.h"

static const CGFloat kBarWidth = 50;
static const CGFloat kBarHeight = 30;
static const CGFloat kBarLeftPadding = 10;;
static const CGFloat kBarTopPadding = 20;;


@interface MultipleChoiceViewController ()
@property (weak, nonatomic) IBOutlet UIView *testView;

@end

@implementation MultipleChoiceViewController
{
  // x postion of the progress bar
  int questionsAnswered;
}

- (CGFloat)_getXPos
{
  return  kBarLeftPadding + kBarWidth * (questionsAnswered%5);
}
- (CGFloat)_getYPos
{
  return  kBarTopPadding + kBarHeight * (questionsAnswered/5);
}


- (void)viewDidLoad {
    [super viewDidLoad];
    questionsAnswered = 0;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)correctClick:(id)sender {
  [self animateResultWithColor:[UIColor greenColor]];
  
}
- (IBAction)wrongClick:(id)sender {
  [self animateResultWithColor:[UIColor redColor]];
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
      
      
      [UIView animateWithDuration:0.5 delay:0.3 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
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
