//
//  TestMenuViewController.h
//  VocabLearn
//
//  Created by Jin You on 11/16/14.
//  Copyright (c) 2014 Henryyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TestMenuViewController;

@protocol TestMenuViewControllerDelegate <NSObject>

- (void)testMenuViewController:(TestMenuViewController *)testMenuViewController didSelectTest:(NSString *) testChoice;

@end

@interface TestMenuViewController : UIViewController

@property (nonatomic, weak) id<TestMenuViewControllerDelegate> delegate;

@end
