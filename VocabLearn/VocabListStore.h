//
//  VocabListStore.h
//  VocabLearn
//
//  Created by Jin You on 11/14/14.
//  Copyright (c) 2014 Henryyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VocabList.h"

@interface VocabListStore : NSObject

+ (VocabListStore *)sharedInstance;

- (void) addVocabList:(VocabList *)vocabList;

- (void) removeVocabListAtIndex: (NSUInteger)index;

- (void) replaceVocabListAtIndex: (NSUInteger)index withVocabList: (VocabList *) vocabList;

- (VocabList *) getVocabListAtIndex: (NSUInteger)index;

@property (strong, nonatomic) NSMutableArray *allVocabLists;

@end
