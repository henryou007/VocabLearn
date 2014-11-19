//
//  WordCell.m
//  VocabLearn
//
//  Created by Jin You on 11/18/14.
//  Copyright (c) 2014 Henryyou. All rights reserved.
//

#import "WordCell.h"
#import "UIColor+VocabLean.h"

@interface WordCell ()
@property (weak, nonatomic) IBOutlet UILabel *wordCell;

@end


@implementation WordCell

- (void)awakeFromNib {
    // Initialization code
    self.wordCell.textColor = [UIColor textColor];
    self.backgroundColor = [UIColor backgroundColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
