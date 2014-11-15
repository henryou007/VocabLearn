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
#import "VocabListStore.h"

@interface SpellingTestWelcomeViewController ()

@property (nonatomic, strong, readonly) VocabListStore *vocabListStore;

@end

@implementation SpellingTestWelcomeViewController

static const CGFloat kHeaderViwePadding = 5;

- (instancetype)init {
  if (self = [super initWithStyle:UITableViewStylePlain]) {
    self.title = @"Spelling Test";

    _vocabListStore = [VocabListStore sharedInstance];
  }
  return self;
}

- (void)loadView {
  [super loadView];
  self.tableView.tableHeaderView = [self createHeaderView];
}

- (UIView *)createHeaderView {
  CGRect bounds = self.tableView.bounds;

  UILabel *headerLabel = [[UILabel alloc] init];
  headerLabel.text = @"Please choose the list below to start the Spelling Test.";
  headerLabel.numberOfLines = 0;

  CGFloat width = CGRectGetWidth(bounds) - 2 * kHeaderViwePadding;
  CGFloat height = CGRectGetHeight(bounds) - 2 *kHeaderViwePadding;
  CGSize headerLabelSize = [headerLabel sizeThatFits:CGSizeMake(width, height)];
  headerLabel.frame = CGRectMake(CGRectGetMinX(bounds) + kHeaderViwePadding, CGRectGetMinY(bounds) + kHeaderViwePadding, headerLabelSize.width, headerLabelSize.height);

  return headerLabel;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.vocabListStore.allVocabLists.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
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
