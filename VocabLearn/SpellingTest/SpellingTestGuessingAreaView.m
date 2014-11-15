//
//  SpellingTestGuessingAreaView.m
//  VocabLearn
//
//  Created by Tienchai Wirojsaksaree on 11/15/14.
//  Copyright (c) 2014 Henryyou. All rights reserved.
//

#import "SpellingTestGuessingAreaView.h"

#import "SpellingTestCharacterCell.h"

@interface SpellingTestGuessingAreaView () <UICollectionViewDataSource>

@property (nonatomic, strong, readonly) NSMutableArray *characters;

@end

@implementation SpellingTestGuessingAreaView

static const unichar kEmptyCharacter = '_';

- (instancetype)init {
  if (self = [super initWithFrame:CGRectZero collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]]) {
    self.backgroundColor = [UIColor whiteColor];
    self.dataSource = self;
    [self registerClass:SpellingTestCharacterCell.class forCellWithReuseIdentifier:@"Cell"];

    _characters = [NSMutableArray array];
  }
  return self;
}

#pragma mark - Getters/Setters

- (NSUInteger)characterLength {
  return self.characters.count;
}

- (void)setCharacterLengthAndResetCharacters:(NSUInteger)characterLength {
  [self.characters removeAllObjects];
  for (int i = 0;i < characterLength;i++) {
    [self.characters addObject:@(kEmptyCharacter)];
  }
  [self reloadData];
}

- (void)setCharacter:(unichar)character atIndex:(NSUInteger)index {
  unichar oldCharacter = [self.characters[index] unsignedShortValue];
  if (oldCharacter != character) {
    self.characters[index] = @(character);
    [self reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:index inSection:0]]];
  }
}

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
