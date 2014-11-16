//
//  SpellingTestGuessingAreaView.m
//  VocabLearn
//
//  Created by Tienchai Wirojsaksaree on 11/15/14.
//  Copyright (c) 2014 Henryyou. All rights reserved.
//

#import "SpellingTestGuessingAreaView.h"

#import "SpellingTestCharacterCell.h"

@interface SpellingTestGuessingAreaView () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong, readonly) NSMutableArray *characters;
@property (nonatomic, assign, readwrite) NSUInteger nextCharacterIndex;

@end

@implementation SpellingTestGuessingAreaView

static const unichar kEmptyCharacter = '_';

- (instancetype)init {
  if (self = [super initWithFrame:CGRectZero collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]]) {
    self.backgroundColor = [UIColor whiteColor];
    self.dataSource = self;
    self.delegate = self;
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
  self.nextCharacterIndex = 0;
  for (int i = 0;i < characterLength;i++) {
    [self.characters addObject:@(kEmptyCharacter)];
  }
  [self reloadData];
}

#pragma mark - Add/Remove Characters

- (void)addCharacter:(unichar)character {
  NSAssert(self.nextCharacterIndex < self.characterLength, @"Cannot add more character.");
  [self setCharacter:character atIndex:self.nextCharacterIndex++];
  if (self.nextCharacterIndex == self.characterLength) {
    dispatch_after(0, dispatch_get_main_queue(), ^{
      [self.guessingAreaDelegate guessingAreaView:self didReachCharacterLengthWithCharacters:self.characters];
    });
  }
}

- (void)removeCharacter:(unichar)character {
  NSUInteger index = [self.characters indexOfObject:@(character)];
  NSAssert(index != NSNotFound, @"Could not find '%c' so cannot remove it.", character);
  [self removeCharacterAtIndex:index];
}

- (void)removeCharacterAtIndex:(NSUInteger)index {
  NSAssert(index < self.nextCharacterIndex, @"Index out of bounds");
  for (NSUInteger i = index;i < self.nextCharacterIndex - 1;i++) {
    [self setCharacter:[self.characters[i + 1] unsignedShortValue] atIndex:i];
  }
  [self removeLastCharacter];
}

- (unichar)removeLastCharacter {
  NSAssert(self.nextCharacterIndex > 0, @"No character to delete");
  unichar lastCharacter = [self.characters[--self.nextCharacterIndex] unsignedShortValue];
  [self setCharacter:kEmptyCharacter atIndex:self.nextCharacterIndex];
  if (!self.nextCharacterIndex) {
    dispatch_after(0, dispatch_get_main_queue(), ^{
      [self.guessingAreaDelegate guessingAreaViewDidHaveNoCharacters:self];
    });
  }
  return lastCharacter;
}

- (void)removeAllCharacters {
  while (self.nextCharacterIndex > 0) {
    [self removeLastCharacter];
  }
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

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  [self deselectItemAtIndexPath:indexPath animated:YES];
  NSUInteger index = indexPath.row;
  if (index < self.nextCharacterIndex) {
    [self.guessingAreaDelegate guessingAreaView:self didSelectNonEmptyCharacter:[self.characters[index] unsignedShortValue] atIndex:index];
  }
}

@end
