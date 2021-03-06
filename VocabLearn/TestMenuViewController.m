//
//  TestMenuViewController.m
//  VocabLearn
//
//  Created by Jin You on 11/16/14.
//  Copyright (c) 2014 Henryyou. All rights reserved.
//

#import "TestMenuViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface TestMenuViewController ()
@property (weak, nonatomic) IBOutlet UIButton *spellingTestButton;
@property (weak, nonatomic) IBOutlet UIButton *multipleChoiceButton;
@property (weak, nonatomic) IBOutlet UIButton *backButton;

@end

@implementation TestMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.spellingTestButton.layer.cornerRadius = 10;
    self.spellingTestButton.layer.borderWidth=1.0f;
    self.spellingTestButton.layer.borderColor=[[UIColor whiteColor] CGColor];
    self.spellingTestButton.clipsToBounds = YES;

    self.multipleChoiceButton.layer.cornerRadius = 10;
    self.multipleChoiceButton.layer.borderWidth=1.0f;
    self.multipleChoiceButton.layer.borderColor=[[UIColor whiteColor] CGColor];
    self.multipleChoiceButton.clipsToBounds = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    self.spellingTestButton.alpha = 0;
    self.multipleChoiceButton.alpha = 0;
    self.backButton.alpha = 0;
    [UIView animateWithDuration:0.5 animations:^{
        self.spellingTestButton.alpha = 1;
        
    }];
    
    [UIView animateWithDuration:0.6 delay:0.1 options:UIViewAnimationOptionTransitionNone animations:^{
        self.multipleChoiceButton.alpha = 1;
    } completion:nil];
    
    [UIView animateWithDuration:0.8 delay:0.3 options:UIViewAnimationOptionTransitionNone animations:^{
        self.backButton.alpha = 1;
    } completion:nil];
        
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onSpellingTestButtonTap:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        [self.delegate testMenuViewController:self didSelectTest:@"spelling_test"];
    }];
}
- (IBAction)onMultipleTestButtonTap:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        [self.delegate testMenuViewController:self didSelectTest:@"multiple_choice"];
    }];
}

- (IBAction)onBackButtonTap:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
