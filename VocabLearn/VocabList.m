//
//  VocabList.m
//  VocabLearn
//
//  Created by Jin You on 11/13/14.
//  Copyright (c) 2014 Henryyou. All rights reserved.
//

#import "VocabList.h"

@interface VocabList ()

@property (strong, nonatomic) NSMutableArray *wordList;

@end


@implementation VocabList

- (id)initWithListName:(NSString *)listName {
    self = [self init];
    if (self) {
        self.listName = listName;
    }
    return self;
}

- (id)init {
    self = [super init];
    if (self) {
        self.vocabulary = [[NSMutableDictionary alloc] init];
        self.wordList = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSUInteger)listSize {
    return self.wordList.count;
}

- (NSString *)wordAtIndex:(NSUInteger)index {
    return [self.wordList objectAtIndex:index];
}

- (void)removeWordAtIndex:(NSUInteger)index {
    NSString *word = [self wordAtIndex:index];
    [self.vocabulary removeObjectForKey:word];
    [self.wordList removeObjectAtIndex:index];
}

- (void)updateWordAtIndex:(NSUInteger)index withWord:(NSString *)word andDefinition:(NSString *)definition {
    [self.vocabulary removeObjectForKey:[self.wordList objectAtIndex:index]];
    [self.wordList replaceObjectAtIndex:index withObject:word];
    [self.vocabulary setObject:definition forKey:word];
}

- (void)addWord:(NSString *)word withDefinition:(NSString *)definition {
    
    if ([self.vocabulary valueForKey:word] == nil) {
        [self.wordList addObject:word];
    }
    
    [self.vocabulary setObject:definition forKey:word];
}

- (void)addWordsWithDefinition:(NSDictionary *)dictionary {
    for (NSString *word in [dictionary allKeys]) {
        [self addWord:word withDefinition:dictionary[word]];
    }
}

@end
