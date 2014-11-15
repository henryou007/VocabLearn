//
//  SpellingTestCharacterPickerView.m
//  VocabLearn
//
//  Created by Tienchai Wirojsaksaree on 11/15/14.
//  Copyright (c) 2014 Henryyou. All rights reserved.
//

#import "SpellingTestCharacterPickerView.h"

#import "SpellingTestCharacterCell.h"

@interface SpellingTestCharacterPickerView () <UICollectionViewDataSource>

@end

@implementation SpellingTestCharacterPickerView

- (instancetype)init {
  if (self = [super initWithFrame:CGRectZero collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]]) {
    self.backgroundColor = [UIColor whiteColor];
    self.dataSource = self;
    [self registerClass:SpellingTestCharacterCell.class forCellWithReuseIdentifier:@"Cell"];
  }
  return self;
}

#pragma mark - Getters/Setters

@synthesize characters = _characters;

- (void)setCharactersAndClearSelectionState:(NSArray *)characters {
  _characters = characters;
  [self reloadData];
}

//#pragma mark - selection
//
//- (void)setSelected:(BOOL)selected forCharacterAtIndex:(NSUInteger)index {
//  // TODO:
//}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return self.characters.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  SpellingTestCharacterCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
  cell.character = [self.characters[indexPath.row] unsignedShortValue];
  return cell;
}

@end
