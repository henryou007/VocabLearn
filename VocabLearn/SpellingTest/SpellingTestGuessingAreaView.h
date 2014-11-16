//
//  SpellingTestGuessingAreaView.h
//  VocabLearn
//
//  Created by Tienchai Wirojsaksaree on 11/15/14.
//  Copyright (c) 2014 Henryyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SpellingTestGuessingAreaView;

@protocol SpellingTestGuessingAreaViewDelegate <NSObject>

- (void)guessingAreaView:(SpellingTestGuessingAreaView *)guessingAreaView didSelectNonEmptyCharacter:(unichar)character atIndex:(NSUInteger)index;
- (void)guessingAreaView:(SpellingTestGuessingAreaView *)guessingAreaView didReachCharacterLengthWithCharacters:(NSArray *)characters;
- (void)guessingAreaViewDidHaveNoCharacters:(SpellingTestGuessingAreaView *)guessingAreaView;

@end

@interface SpellingTestGuessingAreaView : UICollectionView

@property (nonatomic, weak, readwrite) id<SpellingTestGuessingAreaViewDelegate> guessingAreaDelegate;

@property (nonatomic, assign, readonly) NSUInteger characterLength;

- (void)setCharacterLengthAndResetCharacters:(NSUInteger)characterLength;

- (void)addCharacter:(unichar)character;
- (void)removeCharacter:(unichar)character;
- (void)removeCharacterAtIndex:(NSUInteger)index;
- (unichar)removeLastCharacter;
- (void)removeAllCharacters;

@end
