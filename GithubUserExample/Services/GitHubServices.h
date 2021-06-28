//
//  GitHubServices.h
//  GithubUserExample
//
//  Created by Oscar Edward on 26/06/21.
//

#import <Foundation/Foundation.h>
#import "GitHubSearchUserList.h"
#import "BaseAPIResponse.h"
NS_ASSUME_NONNULL_BEGIN

@interface GitHubServices : NSObject
-(void)getGitHubUserListByUserName:(NSString*) UserName onComplete:(void (^)(BaseAPIResponse<NSDictionary*>*))onFinish;
-(void)getGitHubUserListByUserName:(NSString*) userName Page:(NSNumber*)page onComplete:(void (^)(BaseAPIResponse<NSDictionary*>*))onFinish;
@end

NS_ASSUME_NONNULL_END
