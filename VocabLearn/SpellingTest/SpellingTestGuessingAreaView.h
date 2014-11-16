//
//  SpellingTestGuessingAreaView.h
//  VocabLearn
//
//  Created by Tienchai Wirojsaksaree on 11/15/14.
//  Copyright (c) 2014 Henryyou. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SpellingTestCharacter.h"

@class SpellingTestGuessingAreaView;

@protocol SpellingTestGuessingAreaViewDelegate <NSObject>

- (void)guessingAreaView:(SpellingTestGuessingAreaView *)guessingAreaView didSelectNonEmptyCharacter:(SpellingTestCharacter *)character atIndex:(NSUInteger)index;
- (void)guessingAreaView:(SpellingTestGuessingAreaView *)guessingAreaView didReachCharacterLengthWithCharacters:(NSArray *)characters;
- (void)guessingAreaViewDidHaveNoCharacters:(SpellingTestGuessingAreaView *)guessingAreaView;

@end

@interface SpellingTestGuessingAreaView : UICollectionView

@property (nonatomic, weak, readwrite) id<SpellingTestGuessingAreaViewDelegate> guessingAreaDelegate;

@property (nonatomic, assign, readonly) NSUInteger characterLength;

- (void)setCharacterLengthAndResetCharacters:(NSUInteger)characterLength;

- (void)addCharacter:(SpellingTestCharacter *)character;
- (void)removeCharacter:(SpellingTestCharacter *)character;
- (void)removeCharacterAtIndex:(NSUInteger)index;
- (SpellingTestCharacter *)removeLastCharacter;
- (void)removeAllCharacters;

@end
