//
//  WordEditViewController.m
//  VocabLearn
//
//  Created by Jin You on 11/18/14.
//  Copyright (c) 2014 Henryyou. All rights reserved.
//

#import "WordEditViewController.h"

@interface WordEditViewController ()
@property (weak, nonatomic) IBOutlet UITextView *definitionTextView;
@property (weak, nonatomic) IBOutlet UITextView *wordTextView;

@property (assign, nonatomic) NSUInteger indexInList;
@property (strong, nonatomic) NSString *initialWord;
@property (strong, nonatomic) NSString *initialDefinition;

@property (assign, nonatomic) BOOL isCreation;

@end

@implementation WordEditViewController

- (id)initWithWordIndex:(NSUInteger)index andWord:(NSString *)word withDefinition:(NSString *)definition {
    self = [super init];
    if (self) {
        self.isCreation = false;
        self.indexInList = index;
        self.initialWord = word;
        self.initialDefinition = definition;
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
    
    [[self.wordTextView layer] setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [[self.wordTextView layer] setBorderWidth:1];
    [[self.wordTextView layer] setCornerRadius:5];
    
    [[self.definitionTextView layer] setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [[self.definitionTextView layer] setBorderWidth:1];
    [[self.definitionTextView layer] setCornerRadius:5];
    
    if (!self.isCreation) {
        self.wordTextView.text = self.initialWord;
        self.definitionTextView.text = self.initialDefinition;
    }
    
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Confirm" style:UIBarButtonItemStylePlain target:self action:@selector(onConfirmButtonClick)];
    
}


- (void)onConfirmButtonClick {
    
    if (!self.wordTextView.hasText || !self.definitionTextView.hasText) {
        // warn about empty list name;
        [[[UIAlertView alloc] initWithTitle:@"Empty Field" message:@"Please make sure text fields are none empty." delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil, nil] show];
        return;
    }
    
    if (self.isCreation) {
        [self.delegate wordEditViewController:self addWord:self.wordTextView.text withDefinition:self.definitionTextView.text];
    } else {
        [self.delegate wordEditViewController:self didUpdateWordAtIndex:self.indexInList withWord:self.wordTextView.text andDefinition:self.definitionTextView.text];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
