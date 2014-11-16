//
//  SpellingTestCharacterPickerView.h
//  VocabLearn
//
//  Created by Tienchai Wirojsaksaree on 11/15/14.
//  Copyright (c) 2014 Henryyou. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SpellingTestCharacter.h"

@class SpellingTestCharacterPickerView;

@protocol SpellingTestCharacterPickerViewDelegate <NSObject>

- (void)characterPickerView:(SpellingTestCharacterPickerView *)characterPickerView didSelectCharacter:(SpellingTestCharacter *)character atIndex:(NSUInteger)index;
- (void)characterPickerView:(SpellingTestCharacterPickerView *)characterPickerView didDeselectCharacter:(SpellingTestCharacter *)character atIndex:(NSUInteger)index;

@end

@interface SpellingTestCharacterPickerView : UICollectionView

@property (nonatomic, weak, readwrite) id<SpellingTestCharacterPickerViewDelegate> characterPickerDelegate;

@property (nonatomic, strong, readonly) NSArray *characters;

- (void)setCharactersAndClearSelectionState:(NSArray *)characters;

- (void)deselectCharacter:(SpellingTestCharacter *)character;
- (void)clearSelectionState;

@end
