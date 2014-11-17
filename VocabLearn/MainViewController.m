//
//  MainViewController.m
//  VocabLearn
//
//  Created by Jin You on 11/13/14.
//  Copyright (c) 2014 Henryyou. All rights reserved.
//

#import "MainViewController.h"
#import "VocabListCell.h"
#import "VocabListCreationViewController.h"
#import "VocabList.h"
#import "VocabListStore.h"
#import "VocabListBrowseViewController.h"
#import "MultipleChoiceViewController.h"
#import "SpellingTestWelcomeViewController.h"
#import "TestMenuViewController.h"

@interface MainViewController () <UITableViewDataSource, UITableViewDelegate, SWTableViewCellDelegate, TestMenuViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *vocabListTableView;
@property (weak, nonatomic) IBOutlet UIButton *testButton;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.testButton setBackgroundImage:[UIImage imageNamed:@"main_page_background"] forState:UIControlStateNormal];
    [self.testButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    self.vocabListTableView.dataSource = self;
    self.vocabListTableView.delegate = self;
    self.vocabListTableView.rowHeight = UITableViewAutomaticDimension;
    self.title = @"VocabLearn";
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                    [UIColor whiteColor], NSForegroundColorAttributeName,
                                                                    [UIFont fontWithName:@"System" size:30.0], NSFontAttributeName, nil]];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Spelling Test" style:UIBarButtonItemStylePlain target:self action:@selector(onSpellingTestButtonTap)];
//    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Multiple Test" style:UIBarButtonItemStylePlain target:self action:@selector(onMultipleTestButtonTap)];
    
    [self.vocabListTableView registerNib:[UINib nibWithNibName:@"VocabListCell" bundle:nil] forCellReuseIdentifier:@"VocabListCell"];
    
    [self.vocabListTableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.vocabListTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[VocabListStore sharedInstance] allVocabLists] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VocabListCell *cell = [self.vocabListTableView dequeueReusableCellWithIdentifier:@"VocabListCell"];
    
    cell.vocabList = [[VocabListStore sharedInstance] allVocabLists][indexPath.row];
    
    
    // Add utility buttons
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:0.78f green:0.78f blue:0.8f alpha:1.0]
                                                title:@"Rename"];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
                                                title:@"Delete"];
    
    cell.rightUtilityButtons = rightUtilityButtons;
    cell.delegate = self;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.navigationController pushViewController:[[VocabListBrowseViewController alloc] init] animated:YES];
}

- (IBAction)onTestButtonTap:(id)sender {
    TestMenuViewController *testMenuViewController = [[TestMenuViewController alloc] init];
    testMenuViewController.delegate = self;
    
    [self presentViewController:testMenuViewController animated:YES completion:nil];
}

- (void)testMenuViewController:(TestMenuViewController *)testMenuViewController didSelectTest:(NSString *) testChoice {
    if ([testChoice isEqualToString:@"spelling_test"]) {
        
        [self.navigationController pushViewController:[[SpellingTestWelcomeViewController alloc] init] animated:YES];
    } else if ([testChoice isEqualToString:@"multiple_choice"]) {
        [self.navigationController pushViewController:[[MultipleChoiceViewController alloc] init] animated:YES];
    }
    
}

- (IBAction)onCreateListButtonClick:(id)sender {
    [self.navigationController pushViewController:[[VocabListCreationViewController alloc] init] animated:YES];
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    NSIndexPath *cellIndexPath = [self.vocabListTableView indexPathForCell:cell];
    switch (index) {
        case 0:
        {
            // Rename
            [self.navigationController pushViewController:[[VocabListCreationViewController alloc] initWithVocabListIndex:cellIndexPath.row] animated:YES];
            break;
        }
        case 1:
        {
            // Delete
            [[VocabListStore sharedInstance] removeVocabListAtIndex:cellIndexPath.row];
            [self.vocabListTableView deleteRowsAtIndexPaths:@[cellIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
        default:
            break;
    }
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
