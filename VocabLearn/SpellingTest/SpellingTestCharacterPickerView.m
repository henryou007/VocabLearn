//
//  SpellingTestCharacterPickerView.m
//  VocabLearn
//
//  Created by Tienchai Wirojsaksaree on 11/15/14.
//  Copyright (c) 2014 Henryyou. All rights reserved.
//

#import "SpellingTestCharacterPickerView.h"

#import "SpellingTestCharacterCell.h"
#import "UIColor+VocabLean.h"

@interface SpellingTestCharacterPickerView () <UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation SpellingTestCharacterPickerView

- (instancetype)init {
  if (self = [super initWithFrame:CGRectZero collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]]) {
    self.backgroundColor = [UIColor backgroundColor];
    self.dataSource = self;
    [self registerClass:SpellingTestCharacterCell.class forCellWithReuseIdentifier:@"Cell"];

    [self addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPan:)]];
  }
  return self;
}

- (void)onPan:(UIPanGestureRecognizer *)gestureRecognizer {
  if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
    CGPoint point = [gestureRecognizer locationInView:self];
    NSIndexPath *indexPath = [self indexPathForItemAtPoint:point];
    if (indexPath) {
      UICollectionViewCell *cell = [self cellForItemAtIndexPath:indexPath];
      if (!cell.selected) {
        cell.selected = YES;
        NSUInteger index = indexPath.row;
        [self.characterPickerDelegate characterPickerView:self
                                       didSelectCharacter:self.characters[index]
                                                  atIndex:index
                                                 location:[gestureRecognizer locationInView:[self.characterPickerDelegate referenceView]]];
      }
    }
  }
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
  [self cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]].selected = NO;
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

@end
