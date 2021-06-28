//
//  UserListViewController.m
//  GithubUserExample
//
//  Created by Oscar Edward on 26/06/21.
//

#import "UserListViewController.h"
#import "UserListTableViewCell.h"

@interface UserListViewController ()<UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UILabel *lblPageTitle;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBarUser;
@property (weak, nonatomic) IBOutlet UITableView *tblViewUser;
@property (weak, nonatomic) IBOutlet UIButton *btnAddUser;

@property (nonatomic, strong) NSURLSessionConfiguration *sessionConfig;
@property (nonatomic, strong) NSURLSession *session;
@property NSMutableArray<GitHubUserList*> *dataSource;
@end

@implementation UserListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ////URL Session
    self.sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    self.session = [NSURLSession sessionWithConfiguration:self.sessionConfig];
    
    //// Intitialize View Model
    if(self.viewModel == nil){
        self.viewModel = [UserListViewModel new];
    }
    //// Search Bar
    self.searchBarUser.delegate = self;
    
    //// Table View
    self.tblViewUser.dataSource = self;
    self.tblViewUser.delegate = self;
    [self.tblViewUser registerNib:[UINib nibWithNibName:@"UserListTableViewCell" bundle:nil] forCellReuseIdentifier:@"UserCell"];
    
    //// Tap Gesture For Closing Keyboard
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    self.dataSource =[NSMutableArray<GitHubUserList*> new];
    if([self.viewModel.pageType isEqualToString:@"github"]){
        self.lblPageTitle.text = @"GitHub User List";
        self.dataSource = self.viewModel.gitHubUserList;
        self.btnAddUser.hidden = YES;
    }else{
        self.lblPageTitle.text = @"Local User List";
        self.searchBarUser.hidden = YES;
        self.dataSource = self.viewModel.localUserList;
    }
}

#pragma mark - Search Bar View Delegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    self.viewModel.gitHubUserName = searchText;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    if(![self.viewModel.gitHubUserName isEqualToString:self.viewModel.gitHubUserNameTemp]){
        self.viewModel.gitHubUserList = [NSMutableArray<GitHubUserList*> new];
        self.viewModel.page = @0;
    }
    [self.viewModel getGitHubUserListWithCompletion:^(NSString * _Nonnull result) {
        self.viewModel.gitHubUserNameTemp = self.viewModel.gitHubUserName;
        self.dataSource = self.viewModel.gitHubUserList;
        [self.tblViewUser reloadData];
    }];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    searchBar.showsCancelButton = NO;
    [searchBar resignFirstResponder];
}

#pragma mark - Table View Delegate
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UserListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserCell" forIndexPath:indexPath];
    if (!cell){
        cell = [[UserListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                            reuseIdentifier:@"UserCell"];
    }
    if([self.viewModel.pageType isEqualToString:@"github"]){
        cell.btnEditUser.hidden = YES;
    }
    cell.lblUserName.text = [self.dataSource objectAtIndex:indexPath.row].userName;
    cell.lblUserType.text = [self.dataSource objectAtIndex:indexPath.row].userType;
    
    if (cell.imageDownloadTask) {
        [cell.imageDownloadTask cancel];
    }
    NSURL *imageURL = [NSURL URLWithString:[self.dataSource objectAtIndex:indexPath.row].userProfilePicture];
    if (imageURL) {
        cell.imageDownloadTask = [self.session dataTaskWithURL:imageURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (error) {
                NSLog(@"ERROR: %@", error);
            } else {
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                if (httpResponse.statusCode == 200) {
                    UIImage *image = [UIImage imageWithData:data];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        cell.imgViewUserProfilePicture.image = image;
                    });
                } else {
                    NSLog(@"Couldn't load image at URL: %@", imageURL);
                    NSLog(@"HTTP %ld", (long)httpResponse.statusCode);
                }
            }
        }];
        [cell.imageDownloadTask resume];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if([self.viewModel.pageType isEqualToString:@"github"]){
        if(indexPath.row == self.viewModel.gitHubUserList.count-1){
            int value = [self.viewModel.page intValue];
            self.viewModel.page = [NSNumber numberWithInt:value + 1];
            [self.viewModel getGitHubUserListPagingWithCompletion:^(NSString * _Nonnull result) {
                self.dataSource = self.viewModel.gitHubUserList;
                [self.tblViewUser reloadData];
            }];
        }
    }
}


#pragma mark - Dismiss Keyboard
-(void)dismissKeyboard{
    [self.searchBarUser resignFirstResponder];
}

#pragma mark - Go Back
- (IBAction)btnBackOnClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
