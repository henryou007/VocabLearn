//
//  SpellingTestWelcomeViewController.m
//  VocabLearn
//
//  Created by Tienchai Wirojsaksaree on 11/15/14.
//  Copyright (c) 2014 Henryyou. All rights reserved.
//

#import "SpellingTestWelcomeViewController.h"

#import "SpellingTestQuestionViewController.h"
#import "SpellingTestTestController.h"
#import "UIColor+VocabLean.h"
#import "VocabListStore.h"

@interface SpellingTestWelcomeViewController ()

@property (nonatomic, strong, readonly) VocabListStore *vocabListStore;

@end

@implementation SpellingTestWelcomeViewController

- (instancetype)init {
  if (self = [super initWithStyle:UITableViewStylePlain]) {
    self.title = @"Spelling Test";
    self.view.backgroundColor = [UIColor backgroundColor];
    self.tableView.separatorColor = [UIColor tableViewSeparatorColor];

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
    cell.backgroundColor = [UIColor backgroundColor];
    cell.textLabel.textColor = [UIColor textColor];
  }
  VocabList *vocabList = self.vocabListStore.allVocabLists[indexPath.row];
  cell.textLabel.text = vocabList.listName;
  return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  VocabList *vocabList = self.vocabListStore.allVocabLists[indexPath.row];
  if (!vocabList.vocabulary.count) {
    [[[UIAlertView alloc] initWithTitle:@"Cannot test with this list" message:@"Please add some words to the list so we have something to test." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    return;
  }
  SpellingTestQuestionViewController *questionVC = [[SpellingTestQuestionViewController alloc] initWithTestController:[[SpellingTestTestController alloc] initWithVocabList:vocabList]];
  [self.navigationController pushViewController:questionVC animated:YES];
}

@end
