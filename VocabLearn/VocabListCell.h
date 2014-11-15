//
//  VocabListCell.h
//  VocabLearn
//
//  Created by Jin You on 11/13/14.
//  Copyright (c) 2014 Henryyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VocabList.h"

@interface VocabListCell : UITableViewCell

@property (weak, nonatomic) VocabList *vocabList;

-(void) setVocabList:(VocabList *)vocabList;

@end
