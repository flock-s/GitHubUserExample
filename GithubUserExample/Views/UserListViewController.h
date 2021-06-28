//
//  UserListViewController.h
//  GithubUserExample
//
//  Created by Oscar Edward on 26/06/21.
//

#import <UIKit/UIKit.h>
#import "UserListViewModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface UserListViewController : UIViewController
@property UserListViewModel* viewModel;
@end

NS_ASSUME_NONNULL_END
