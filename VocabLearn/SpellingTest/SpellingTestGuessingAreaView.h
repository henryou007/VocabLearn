//
//  SpellingTestGuessingAreaView.h
//  VocabLearn
//
//  Created by Tienchai Wirojsaksaree on 11/15/14.
//  Copyright (c) 2014 Henryyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpellingTestGuessingAreaView : UICollectionView

@property (nonatomic, assign, readonly) NSUInteger characterLength;

- (void)setCharacterLengthAndResetCharacters:(NSUInteger)characterLength;

- (void)setCharacter:(unichar)character atIndex:(NSUInteger)index;

@end
