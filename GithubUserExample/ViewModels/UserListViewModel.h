//
//  UserListViewModel.h
//  GithubUserExample
//
//  Created by Oscar Edward on 26/06/21.
//

#import <Foundation/Foundation.h>
#import "GitHubSearchUserList.h"
#import "GitHubUserList.h"
#import "GitHubServices.h"
NS_ASSUME_NONNULL_BEGIN

@interface UserListViewModel : NSObject
@property GitHubServices *gitHubService;
@property NSString *gitHubUserName;
@property NSString *gitHubUserNameTemp;
@property NSString *pageType;
@property NSNumber *page;
@property NSMutableArray<GitHubUserList*> *gitHubUserList;
@property NSMutableArray<GitHubUserList*> *localUserList;

- (void)getGitHubUserListWithCompletion:(void (^)(NSString *result))onComplete;
- (void)getGitHubUserListPagingWithCompletion:(void (^)(NSString *result))onComplete;
@end

NS_ASSUME_NONNULL_END
