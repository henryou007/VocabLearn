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
@property (strong, nonatomic) NSDictionary *vocabulary;

- (id)initWithListName:(NSString *)listName;

@end
