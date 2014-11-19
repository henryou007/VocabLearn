//
//  VocabList.h
//  VocabLearn
//
//  Created by Jin You on 11/13/14.
//  Copyright (c) 2014 Henryyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VocabList : NSObject

@property (strong, nonatomic) NSString *listName;
@property (strong, nonatomic) NSMutableDictionary *vocabulary;

- (id)initWithListName:(NSString *)listName;

- (NSUInteger)listSize;

- (NSString *)wordAtIndex:(NSUInteger)index;

- (void)removeWordAtIndex:(NSUInteger)index;

- (void)addWord:(NSString *)word withDefinition:(NSString *)definition;

- (void)addWordsWithDefinition:(NSDictionary *)dictionary;

- (void)updateWordAtIndex:(NSUInteger)index withWord:(NSString *)word andDefinition:(NSString *)definition;

@end
