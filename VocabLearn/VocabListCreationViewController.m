//
//  VocabListCreationViewController.m
//  VocabLearn
//
//  Created by Jin You on 11/13/14.
//  Copyright (c) 2014 Henryyou. All rights reserved.
//

#import "VocabListCreationViewController.h"
#import "VocabListStore.h"

@interface VocabListCreationViewController ()

@property (weak, nonatomic) IBOutlet UITextField *listNameInput;

@end

@implementation VocabListCreationViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Confirm" style:UIBarButtonItemStylePlain target:self action:@selector(onConfirmButtonClick)];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onConfirmButtonClick {
    VocabList *newList = [[VocabList alloc] initWithListName:self.listNameInput.text];
    [[VocabListStore sharedInstance] addVocabList:newList];
    [self.navigationController popViewControllerAnimated:YES];
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
