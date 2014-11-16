//
//  VocabListCreationViewController.h
//  VocabLearn
//
//  Created by Jin You on 11/13/14.
//  Copyright (c) 2014 Henryyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VocabListCreationViewController;

@interface VocabListCreationViewController : UIViewController

// This supports a rename operation for the existing vocab list
- (id)initWithVocabListIndex: (NSUInteger) index;

@end
