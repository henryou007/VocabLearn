//
//  VocabListStore.m
//  VocabLearn
//
//  Created by Jin You on 11/14/14.
//  Copyright (c) 2014 Henryyou. All rights reserved.
//

#import "VocabListStore.h"

@interface VocabListStore()

@end

@implementation VocabListStore

+ (VocabListStore *)sharedInstance {
    static VocabListStore *instance = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            VocabList *sampleList = [[VocabList alloc] initWithListName:@"Sample"];
            // Examples taken from http://www.english-for-students.com/
            [sampleList addWordsWithDefinition:@{
                                                 @"horizon": @"(n) the apparent line connecting the earth and the sky",
                                                 @"host": @"(n) entertainer, innkeeper, an army, multitude",
                                                 @"blur": @"(v) make indistinct, black-out writing",
                                                 @"fad": @"(n) fashion, interest, enthusiasm, preference, etc…that is not likely to last",
                                                 @"fade": @"(v) Lose color, freshness or vigor",
                                                 @"cattle": @"(n) animals with horns and cloven hoofs auch as cows, bulls and bullocks",
                                                 @"kettle": @"(n) container with a spout, lid and handle, used for boiling water or milk",
                                                 @"cede": @"(v) give up one's rights to or possession of something",
                                                 @"seed": @"(n) part of a plant from which a new plant of the same kind can grow",
                                                 @"click": @"(n) short sharp sound like that of a key turning in a lock",
                                                 @"clique": @"(n) small group of people often with shared interets who associate closely and exclude others from their group"
                                                 }];
            
            instance = [[VocabListStore alloc] init];
            instance.allVocabLists = [NSMutableArray arrayWithObject:sampleList];
            NSLog(@"%lu", [sampleList listSize]);
        }
    });
    
    return instance;
}

- (void) addVocabList:(VocabList *)vocabList {
    NSLog(@"adding object");
    [self.allVocabLists addObject:vocabList];
}

- (void) removeVocabListAtIndex: (NSUInteger)index {
    [self.allVocabLists removeObjectAtIndex:index];
}

- (void) replaceVocabListAtIndex: (NSUInteger)index withVocabList: (VocabList *) vocabList {
    [self.allVocabLists replaceObjectAtIndex:index withObject:vocabList];
}

- (VocabList *) getVocabListAtIndex: (NSUInteger)index {
    return [self.allVocabLists objectAtIndex:index];
}

@end
