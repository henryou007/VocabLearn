//
//  VocabList.m
//  VocabLearn
//
//  Created by Jin You on 11/13/14.
//  Copyright (c) 2014 Henryyou. All rights reserved.
//

#import "VocabList.h"

@implementation VocabList

- (id)initWithListName:(NSString *)listName {
    self = [super init];
    if (self) {
        self.listName = listName;
    }
    return self;
}

@end
