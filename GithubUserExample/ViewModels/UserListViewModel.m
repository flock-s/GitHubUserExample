//
//  UserListViewModel.m
//  GithubUserExample
//
//  Created by Oscar Edward on 26/06/21.
//

#import "UserListViewModel.h"

@implementation UserListViewModel
-(id)init {
    if (self = [super init] ) {
        self.gitHubService = [GitHubServices new];
        self.gitHubUserList = [NSMutableArray<GitHubUserList*> new];
        self.localUserList = [NSMutableArray<GitHubUserList*> new];
        self.gitHubUserName = @"";
        self.gitHubUserNameTemp = @"";
        self.pageType = @"";
        self.page = @1;
        [self populateLocalUser];
    }
    return self;
}
- (void)getGitHubUserListWithCompletion:(void (^)(NSString * _Nonnull))onComplete{
    [self.gitHubService getGitHubUserListByUserName:self.gitHubUserName onComplete:^(BaseAPIResponse<NSDictionary *> * result) {
        if([result.responseCode isEqualToString:@"200"]){
            if([result.data objectForKey:@"total_count"] == 0){
                onComplete(@"No Data");
            }else{
                for(id userList in [result.data objectForKey:@"items"]){
                    GitHubUserList* gitHubUserList = [GitHubUserList new];
                    gitHubUserList.userName = [userList objectForKey:@"login"];
                    gitHubUserList.userProfilePicture = [userList objectForKey:@"avatar_url"];
                    gitHubUserList.userType = [userList objectForKey:@"type"];
                    [self.gitHubUserList addObject:gitHubUserList];
                }
                onComplete(@"Success");
            }
        }else{
            onComplete(@"Fail");
        }
    }];
}
- (void)getGitHubUserListPagingWithCompletion:(void (^)(NSString * _Nonnull))onComplete{
    [self.gitHubService getGitHubUserListByUserName:self.gitHubUserName Page:self.page onComplete:^(BaseAPIResponse<NSDictionary *> * result) {
        if([result.responseCode isEqualToString:@"200"]){
            if([result.data objectForKey:@"total_count"] == 0){
                onComplete(@"No Data");
            }else{
                for(id userList in [result.data objectForKey:@"items"]){
                    GitHubUserList* gitHubUserList = [GitHubUserList new];
                    gitHubUserList.userName = [userList objectForKey:@"login"];
                    gitHubUserList.userProfilePicture = [userList objectForKey:@"avatar_url"];
                    gitHubUserList.userType = [userList objectForKey:@"type"];
                    [self.gitHubUserList addObject:gitHubUserList];
                }
                onComplete(@"Success");
            }
        }else{
            onComplete(@"Fail");
        }
    }];
}

-(void) populateLocalUser{
    GitHubUserList* localUserList = [GitHubUserList new];
    localUserList.userName = @"Oscar";
    localUserList.userProfilePicture = @"";
    localUserList.userType = @"iOS Developer";
    [self.localUserList addObject:localUserList];
    
    localUserList = [GitHubUserList new];
    localUserList.userName = @"Edward";
    localUserList.userProfilePicture = @"";
    localUserList.userType = @"Android Developer";
    [self.localUserList addObject:localUserList];
    
    localUserList = [GitHubUserList new];
    localUserList.userName = @"Guijaya";
    localUserList.userProfilePicture = @"";
    localUserList.userType = @"Back-End Developer";
    [self.localUserList addObject:localUserList];
}
@end
