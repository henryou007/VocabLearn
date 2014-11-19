//
//  VocabListCreationViewController.m
//  VocabLearn
//
//  Created by Jin You on 11/13/14.
//  Copyright (c) 2014 Henryyou. All rights reserved.
//

#import "VocabListCreationViewController.h"
#import "VocabListStore.h"
#import "UIColor+VocabLean.h"

@interface VocabListCreationViewController ()

@property (weak, nonatomic) IBOutlet UITextField *listNameInput;
@property (assign, nonatomic) NSUInteger vocabListIndex;
@property (assign, nonatomic) BOOL isCreation; // Is this a creation operation or editing operation

@end

@implementation VocabListCreationViewController

- (id)initWithVocabListIndex: (NSUInteger) index {
    self = [super init];
    if (self) {
        self.isCreation = false;
        self.vocabListIndex = index;
    }
    return self;
}

- (id)init {
    self = [super init];
    
    if (self) {
        self.isCreation = true;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Confirm" style:UIBarButtonItemStylePlain target:self action:@selector(onConfirmButtonClick)];
    
    self.view.backgroundColor = [UIColor backgroundColor];
    
    if (!self.isCreation) {
        self.listNameInput.text = [[VocabListStore sharedInstance] getVocabListAtIndex:self.vocabListIndex].listName;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onConfirmButtonClick {
    
    if (!self.listNameInput.hasText) {
        // warn about empty list name;
        [[[UIAlertView alloc] initWithTitle:@"Empty List Name" message:@"Please enter a name for the list." delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil, nil] show];
        return;
    }
    
    if (self.isCreation) {
        VocabList *newList = [[VocabList alloc] initWithListName:self.listNameInput.text];
        [[VocabListStore sharedInstance] addVocabList:newList];
    } else {
        // Renaming the list
        VocabList *existinglist = [[VocabListStore sharedInstance] getVocabListAtIndex:self.vocabListIndex];
        existinglist.listName = self.listNameInput.text;
        [[VocabListStore sharedInstance] replaceVocabListAtIndex:self.vocabListIndex withVocabList:existinglist];
    }

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
