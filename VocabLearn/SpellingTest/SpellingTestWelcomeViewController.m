//
//  SpellingTestWelcomeViewController.m
//  VocabLearn
//
//  Created by Tienchai Wirojsaksaree on 11/15/14.
//  Copyright (c) 2014 Henryyou. All rights reserved.
//

#import "SpellingTestWelcomeViewController.h"

#import "ColorManager.h"
#import "SpellingTestQuestionViewController.h"
#import "SpellingTestTestController.h"
#import "VocabListStore.h"

@interface SpellingTestWelcomeViewController ()

@property (nonatomic, strong, readonly) VocabListStore *vocabListStore;

@end

@implementation SpellingTestWelcomeViewController

- (instancetype)init {
  if (self = [super initWithStyle:UITableViewStylePlain]) {
    self.title = @"Spelling Test";
    self.view.backgroundColor = [ColorManager backgroundColor];
    self.tableView.separatorColor = [ColorManager tableViewSeparatorColor];

    _vocabListStore = [VocabListStore sharedInstance];
  }
  return self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.vocabListStore.allVocabLists.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    cell.backgroundColor = [ColorManager backgroundColor];
    cell.textLabel.textColor = [ColorManager textColor];
  }
  VocabList *vocabList = self.vocabListStore.allVocabLists[indexPath.row];
  cell.textLabel.text = vocabList.listName;
  return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  SpellingTestQuestionViewController *questionVC = [[SpellingTestQuestionViewController alloc] initWithTestController:[[SpellingTestTestController alloc] initWithVocabList:self.vocabListStore.allVocabLists[indexPath.row]]];
  [self.navigationController pushViewController:questionVC animated:YES];
}

@end
