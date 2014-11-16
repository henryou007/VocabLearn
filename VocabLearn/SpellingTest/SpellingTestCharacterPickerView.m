//
//  SpellingTestCharacterPickerView.m
//  VocabLearn
//
//  Created by Tienchai Wirojsaksaree on 11/15/14.
//  Copyright (c) 2014 Henryyou. All rights reserved.
//

#import "SpellingTestCharacterPickerView.h"

#import "SpellingTestCharacterCell.h"

@interface SpellingTestCharacterPickerView () <UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation SpellingTestCharacterPickerView

- (instancetype)init {
  if (self = [super initWithFrame:CGRectZero collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]]) {
    self.backgroundColor = [UIColor whiteColor];
    self.dataSource = self;
    self.delegate = self;
    self.allowsSelection = YES;
    self.allowsMultipleSelection = YES;
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

- (void)deselectCharacter:(SpellingTestCharacter *)character {
  NSUInteger index = [self.characters indexOfObject:character];
  NSAssert(index != NSNotFound, @"Could not find the character");
  [self deselectCharacterAtIndex:index];
}

- (void)clearSelectionState {
  for (int i = 0;i < self.characters.count;i++) {
    [self deselectCharacterAtIndex:i];
  }
}

- (void)deselectCharacterAtIndex:(NSUInteger)index {
  [self deselectItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] animated:YES];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return self.characters.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  SpellingTestCharacterCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
  cell.character = self.characters[indexPath.row];
  return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  NSUInteger index = indexPath.row;
  [self.characterPickerDelegate characterPickerView:self didSelectCharacter:self.characters[index] atIndex:index];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
  NSUInteger index = indexPath.row;
  [self.characterPickerDelegate characterPickerView:self didDeselectCharacter:self.characters[index] atIndex:index];
}

@end
