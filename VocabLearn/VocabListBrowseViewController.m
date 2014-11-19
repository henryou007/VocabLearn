//
//  VocabListBrowseViewController.m
//  VocabLearn
//
//  Created by Jin You on 11/14/14.
//  Copyright (c) 2014 Henryyou. All rights reserved.
//

#import "VocabListBrowseViewController.h"
#import "VocabList.h"
#import "VocabListStore.h"
#import "WordCell.h"
#import "WordEditViewController.h"

@interface VocabListBrowseViewController () <UITableViewDataSource, UITableViewDelegate, SWTableViewCellDelegate, WordEditViewControllerDelegate>

@property (assign, nonatomic) NSUInteger index;
@property (weak, nonatomic) IBOutlet UITableView *wordsTableView;
@property (strong, nonatomic) VocabList *currentVocabList;

@end

@implementation VocabListBrowseViewController

-(id)initWithListIndex:(NSUInteger)index {
    self = [super init];
    
    if (self) {
        self.index = index;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.wordsTableView.dataSource = self;
    self.wordsTableView.delegate = self;
    self.wordsTableView.rowHeight = UITableViewAutomaticDimension;
    
    self.currentVocabList = [[VocabListStore sharedInstance] getVocabListAtIndex:self.index];
    self.title = self.currentVocabList.listName;
    
    [self.wordsTableView registerNib:[UINib nibWithNibName:@"WordCell" bundle:nil] forCellReuseIdentifier:@"WordCell"];
    
    [self.wordsTableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.currentVocabList listSize];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WordCell *cell = [self.wordsTableView dequeueReusableCellWithIdentifier:@"WordCell"];
    
    cell.wordLabel.text = [self.currentVocabList wordAtIndex:indexPath.row];
    
    // Add utility buttons
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
                                                title:@"Delete"];
    
    cell.rightUtilityButtons = rightUtilityButtons;
    cell.delegate = self;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *selectedWord = [self.currentVocabList wordAtIndex:indexPath.row];
    
    WordEditViewController *wordEditViewController = [[WordEditViewController alloc] initWithWordIndex:indexPath.row andWord:selectedWord withDefinition:self.currentVocabList.vocabulary[selectedWord]];
    wordEditViewController.delegate = self;
    
    [self.navigationController pushViewController:wordEditViewController animated:YES];
}

- (IBAction)onAddWordTap:(id)sender {
    WordEditViewController *wordEditViewController = [[WordEditViewController alloc] init];
    wordEditViewController.delegate = self;
    
    [self.navigationController pushViewController:wordEditViewController animated:YES];
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    NSIndexPath *cellIndexPath = [self.wordsTableView indexPathForCell:cell];
    switch (index) {
        case 0:
        {
            // Delete
            [self.currentVocabList removeWordAtIndex:cellIndexPath.row];
            [self.wordsTableView deleteRowsAtIndexPaths:@[cellIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
        default:
            break;
    }
    
    [self.wordsTableView reloadData];
    
}

- (void)wordEditViewController:(WordEditViewController *)wordEditViewController didUpdateWordAtIndex:(NSUInteger)index withWord:(NSString *)word andDefinition:(NSString *)definition {
    [self.currentVocabList updateWordAtIndex:index withWord:word andDefinition:definition];
    [self.wordsTableView reloadData];
}

- (void)wordEditViewController:(WordEditViewController *)wordEditViewController addWord:(NSString *)word withDefinition:(NSString *)definition {
    [self.currentVocabList addWord:word withDefinition:definition];
}

-(void)viewWillDisappear:(BOOL)animated {
    [[VocabListStore sharedInstance] replaceVocabListAtIndex:self.index withVocabList:self.currentVocabList];
    [self.wordsTableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
