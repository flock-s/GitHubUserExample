//
//  ViewController.m
//  GithubUserExample
//
//  Created by Oscar Edward on 26/06/21.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "UserListViewController.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lblPageTitle;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [UserListViewModel new];
    self.lblPageTitle.text = @"User List";
    
}

- (IBAction)btnGitHubOnClick:(id)sender {
    self.viewModel.pageType = @"github";
    NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
    UserListViewController* listViewController = [[UserListViewController alloc] initWithNibName:@"UserListViewController" bundle:[NSBundle bundleWithIdentifier:bundleIdentifier]];
    listViewController.viewModel = self.viewModel;
    listViewController.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:listViewController animated:YES completion:nil];
}
- (IBAction)btnLocalOnclick:(id)sender {
    self.viewModel.pageType = @"local";
    NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
    UserListViewController* listViewController = [[UserListViewController alloc] initWithNibName:@"UserListViewController" bundle:[NSBundle bundleWithIdentifier:bundleIdentifier]];
    listViewController.viewModel = self.viewModel;
    listViewController.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:listViewController animated:YES completion:nil];
}

#pragma mark - Testing Github API
- (void)getGitHubUsers{
    [self.viewModel getGitHubUserListWithCompletion:^(NSString * _Nonnull result) {
        for(int i = 0;i<[self.viewModel.gitHubUserList count];i++){
            NSLog(@"%@",self.viewModel.gitHubUserList[i].userName);
        }
    }];
}
- (void)getUsers{
    NSString *urlString = @"https://api.github.com/search/users?q=zm12hcnns";
    NSURL *url = [NSURL URLWithString:urlString];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary* headerDictionary = [NSMutableDictionary new];
    [headerDictionary setValue:@"application/json" forKey:@"Accept"];
    [headerDictionary setValue:@"application/json" forKey:@"Content-Type"];
    [headerDictionary setValue:@"UTF-8" forKey:@"charset"];
    
    [manager GET:[url absoluteString] parameters:@"" headers:headerDictionary progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* responseDictionary = (NSDictionary*) responseObject;
        NSDictionary* userListDictionary = [responseDictionary objectForKey:@"items"];
        
        for(id userList in userListDictionary){
            NSLog(@"%@",[userList objectForKey:@"login"]);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}
@end
