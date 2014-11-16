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
            sampleList.vocabulary = @{@"horizon": @"(n) the apparent line connecting the earth and the sky",
                                      @"host": @"(n) entertainer, innkeeper, an army, multitude",
                                      @"blur": @"(v) make indistinct, black-out writing",
                                      };

            instance = [[VocabListStore alloc] init];
            instance.allVocabLists = [NSMutableArray arrayWithObject:sampleList];
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
