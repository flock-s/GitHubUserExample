//
//  GitHubServices.m
//  GithubUserExample
//
//  Created by Oscar Edward on 26/06/21.
//

#import "GitHubServices.h"
#import "AFNetworking.h"

@implementation GitHubServices

- (void)getGitHubUserListByUserName:(NSString *)userName Page:(NSNumber *)page onComplete:(void (^)(BaseAPIResponse<NSDictionary *> * _Nonnull))onFinish{
    NSString *urlString = [[[@"https://api.github.com/search/users?q=" stringByAppendingString:userName] stringByAppendingString:@"&per_page=10&page="] stringByAppendingString:[page stringValue]];
    NSURL *url = [NSURL URLWithString:urlString];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary* headerDictionary = [NSMutableDictionary new];
    [headerDictionary setValue:@"application/json" forKey:@"Accept"];
    [headerDictionary setValue:@"application/json" forKey:@"Content-Type"];
    [headerDictionary setValue:@"UTF-8" forKey:@"charset"];
    
    BaseAPIResponse<NSDictionary*>* responseData = [BaseAPIResponse<NSDictionary*> new];
    
    [manager GET:[url absoluteString] parameters:@"" headers:headerDictionary progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        responseData.responseCode = @"200";
        responseData.responseMessage = @"Success";
        responseData.data = responseObject;
        onFinish(responseData);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        responseData.responseCode = @"99";
        responseData.responseMessage = @"Error";
        onFinish(responseData);
    }];
    
}
- (void)getGitHubUserListByUserName:(NSString*)UserName onComplete:(void (^)(BaseAPIResponse<NSDictionary*>* responseData))onFinish{
    NSString *urlString = [@"https://api.github.com/search/users?q=" stringByAppendingString:UserName];
    NSURL *url = [NSURL URLWithString:urlString];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary* headerDictionary = [NSMutableDictionary new];
    [headerDictionary setValue:@"application/json" forKey:@"Accept"];
    [headerDictionary setValue:@"application/json" forKey:@"Content-Type"];
    [headerDictionary setValue:@"UTF-8" forKey:@"charset"];
    
    BaseAPIResponse<NSDictionary*>* responseData = [BaseAPIResponse<NSDictionary*> new];
    
    [manager GET:[url absoluteString] parameters:@"" headers:headerDictionary progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        responseData.responseCode = @"200";
        responseData.responseMessage = @"Success";
        responseData.data = responseObject;
        onFinish(responseData);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        responseData.responseCode = @"99";
        responseData.responseMessage = @"Error";
        onFinish(responseData);
    }];
}
@end
