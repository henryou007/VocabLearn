//
//  WordEditViewController.h
//  VocabLearn
//
//  Created by Jin You on 11/18/14.
//  Copyright (c) 2014 Henryyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WordEditViewController;

@protocol WordEditViewControllerDelegate <NSObject>

- (void)wordEditViewController:(WordEditViewController *)wordEditViewController didUpdateWordAtIndex:(NSUInteger)index withWord:(NSString *)word andDefinition:(NSString *)definition;

- (void)wordEditViewController:(WordEditViewController *)wordEditViewController addWord:(NSString *)word withDefinition:(NSString *)definition;

@end

@interface WordEditViewController : UIViewController

- (id)initWithWordIndex:(NSUInteger)index andWord:(NSString *)word withDefinition:(NSString *)definition;

@property (nonatomic, weak) id<WordEditViewControllerDelegate> delegate;

@end
