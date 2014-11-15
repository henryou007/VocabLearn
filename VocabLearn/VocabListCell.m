//
//  VocabListCell.m
//  VocabLearn
//
//  Created by Jin You on 11/13/14.
//  Copyright (c) 2014 Henryyou. All rights reserved.
//

#import "VocabListCell.h"

@interface VocabListCell ()

@property (weak, nonatomic) IBOutlet UILabel *listNameLabel;

@end


@implementation VocabListCell

- (void)awakeFromNib {
    // Initialization code
    self.listNameLabel.text = self.vocabList.listName;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setVocabList:(VocabList *)vocabList {
    self.listNameLabel.text = vocabList.listName;
}

@end
