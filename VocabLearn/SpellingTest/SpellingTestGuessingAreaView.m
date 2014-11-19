//
//  SpellingTestGuessingAreaView.m
//  VocabLearn
//
//  Created by Tienchai Wirojsaksaree on 11/15/14.
//  Copyright (c) 2014 Henryyou. All rights reserved.
//

#import "SpellingTestGuessingAreaView.h"

#import "UIColor+VocabLean.h"
#import "SpellingTestCharacterCell.h"

@interface SpellingTestGuessingAreaView () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong, readonly) NSMutableArray *characters;
@property (nonatomic, assign, readwrite) NSUInteger nextCharacterIndex;

@end

@implementation SpellingTestGuessingAreaView

- (instancetype)init {
  if (self = [super initWithFrame:CGRectZero collectionViewLayout:[self.class createViewLayout]]) {
    self.backgroundColor = [UIColor backgroundColor];
    self.dataSource = self;
    [self registerClass:SpellingTestCharacterCell.class forCellWithReuseIdentifier:@"Cell"];

    _characters = [NSMutableArray array];

    [self addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPan:)]];
  }
  return self;
}

- (void)onPan:(UIPanGestureRecognizer *)panGestureRecognizer {
  if (panGestureRecognizer.state == UIGestureRecognizerStateBegan) {
    CGPoint point = [panGestureRecognizer locationInView:self];
    NSIndexPath *indexPath = [self indexPathForItemAtPoint:point];
    if (indexPath && indexPath.row < self.nextCharacterIndex) {
      NSUInteger index = indexPath.row;
      [self.guessingAreaDelegate guessingAreaView:self didSelectNonEmptyCharacter:self.characters[index] atIndex:index];
    }
  }
}

#pragma mark - Getters/Setters

- (NSUInteger)characterLength {
  return self.characters.count;
}

- (void)setCharacterLengthAndResetCharacters:(NSUInteger)characterLength {
  // It's a bug that reloadData does not refresh the existing cells. This will do the job.
  [self removeAllCharacters];
  [self.characters removeAllObjects];
  for (int i = 0;i < characterLength;i++) {
    [self.characters addObject:[self.class emptyCharacter]];
  }
  [self reloadData];
}

+ (SpellingTestCharacter *)emptyCharacter {
  static SpellingTestCharacter *emptyCharacter;
  static dispatch_once_t once;
  dispatch_once(&once, ^{
    emptyCharacter = [SpellingTestCharacter characterWithCharacter:'_'];
  });
  return emptyCharacter;
}

+ (UICollectionViewLayout *)createViewLayout {
  UICollectionViewFlowLayout *viewLayout = [[UICollectionViewFlowLayout alloc] init];
  viewLayout.minimumInteritemSpacing = 0;
  viewLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
  viewLayout.itemSize = CGSizeMake(30, 30);
  return viewLayout;
}

#pragma mark - Add/Remove Characters

- (void)addCharacter:(SpellingTestCharacter *)character {
  NSAssert(self.nextCharacterIndex < self.characterLength, @"Cannot add more character.");
  [self setCharacter:character atIndex:self.nextCharacterIndex++];
  if (self.nextCharacterIndex == self.characterLength) {
    dispatch_after(0, dispatch_get_main_queue(), ^{
      [self.guessingAreaDelegate guessingAreaView:self didReachCharacterLengthWithCharacters:self.characters];
    });
  }
}

- (void)removeCharacter:(SpellingTestCharacter *)character {
  NSUInteger index = [self.characters indexOfObject:character];
  NSAssert(index != NSNotFound, @"Could not find '%@' so cannot remove it.", character);
  [self removeCharacterAtIndex:index];
}

- (void)removeCharacterAtIndex:(NSUInteger)index {
  NSAssert(index < self.nextCharacterIndex, @"Index out of bounds");
  for (NSUInteger i = index;i < self.nextCharacterIndex - 1;i++) {
    [self setCharacter:self.characters[i + 1] atIndex:i];
  }
  [self removeLastCharacter];
}

- (SpellingTestCharacter *)removeLastCharacter {
  NSAssert(self.nextCharacterIndex > 0, @"No character to delete");
  SpellingTestCharacter * lastCharacter = self.characters[--self.nextCharacterIndex];
  [self setCharacter:[self.class emptyCharacter] atIndex:self.nextCharacterIndex];
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

- (void)setCharacter:(SpellingTestCharacter *)character atIndex:(NSUInteger)index {
  SpellingTestCharacter * oldCharacter = self.characters[index];
  if (![oldCharacter isEqualToCharacter:character]) {
    self.characters[index] = character;
    [self reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:index inSection:0]]];
  }
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
