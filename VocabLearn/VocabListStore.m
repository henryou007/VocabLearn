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
            instance = [[VocabListStore alloc] init];
            instance.allVocabLists = [NSMutableArray array];
        }
    });
    
    return instance;
}

- (void) addVocabList:(VocabList *)vocabList {
    NSLog(@"adding object");
    [self.allVocabLists addObject:vocabList];
}


@end
