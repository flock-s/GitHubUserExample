//
//  GitHubSearchUserList.h
//  GithubUserExample
//
//  Created by Oscar Edward on 26/06/21.
//

#import <Foundation/Foundation.h>
#import "GitHubUserList.h"
NS_ASSUME_NONNULL_BEGIN

@interface GitHubSearchUserList : NSObject
@property NSString *responseCode;
@property NSString *totalCount;
@property BOOL *incompleteResults;
@property NSDictionary *items;

@end

NS_ASSUME_NONNULL_END
