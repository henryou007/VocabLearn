//
//  SpellingTestCharacterPickerView.h
//  VocabLearn
//
//  Created by Tienchai Wirojsaksaree on 11/15/14.
//  Copyright (c) 2014 Henryyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SpellingTestCharacterPickerView;

@protocol SpellingTestCharacterPickerViewDelegate <NSObject>

- (void)characterPickerView:(SpellingTestCharacterPickerView *)characterPickerView character:(unichar)character didSelectetAtIndex:(NSUInteger *)index;

@end

@interface SpellingTestCharacterPickerView : UICollectionView

@property (nonatomic, weak, readwrite) id<SpellingTestCharacterPickerViewDelegate> characterPickerDelegate;

@property (nonatomic, strong, readonly) NSArray *characters;

- (void)setCharactersAndClearSelectionState:(NSArray *)characters;

//- (void)setSelected:(BOOL)selected forCharacterAtIndex:(NSUInteger)index;

@end
