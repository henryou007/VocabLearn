//
//  MainViewController.m
//  VocabLearn
//
//  Created by Jin You on 11/13/14.
//  Copyright (c) 2014 Henryyou. All rights reserved.
//

#import "MainViewController.h"
#import "SpellingTestWelcomeViewController.h"
#import "VocabListCell.h"
#import "VocabListCreationViewController.h"
#import "VocabList.h"
#import "VocabListStore.h"
#import "VocabListBrowseViewController.h"

@interface MainViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *vocabListTableView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.vocabListTableView.dataSource = self;
    self.vocabListTableView.delegate = self;
    self.vocabListTableView.rowHeight = UITableViewAutomaticDimension;
    self.title = @"VoacbLearn";
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Spelling Test" style:UIBarButtonItemStylePlain target:self action:@selector(onSpellingTestButtonTap)];

    [self.vocabListTableView registerNib:[UINib nibWithNibName:@"VocabListCell" bundle:nil] forCellReuseIdentifier:@"VocabListCell"];
    
    [self.vocabListTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"%lu", (unsigned long)[[[VocabListStore sharedInstance] allVocabLists] count]);
    
    return [[[VocabListStore sharedInstance] allVocabLists] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VocabListCell *cell = [self.vocabListTableView dequeueReusableCellWithIdentifier:@"VocabListCell"];
    
    cell.vocabList = [[VocabListStore sharedInstance] allVocabLists][indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.navigationController pushViewController:[[VocabListBrowseViewController alloc] init] animated:YES];
}

- (IBAction)onCreateListButtonClick:(id)sender {
    [self.navigationController pushViewController:[[VocabListCreationViewController alloc] init] animated:YES];
}

- (void)onSpellingTestButtonTap {
  [self.navigationController pushViewController:[[SpellingTestWelcomeViewController alloc] init] animated:YES];
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
