//
//  BaseAPIResponse.h
//  GithubUserExample
//
//  Created by Oscar Edward on 26/06/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseAPIResponse<ObjectType> : NSObject
@property NSString* responseMessage;
@property NSString* responseCode;
@property ObjectType data;
@end

NS_ASSUME_NONNULL_END
