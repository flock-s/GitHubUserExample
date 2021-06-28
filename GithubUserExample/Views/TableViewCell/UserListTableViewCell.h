//
//  UserListTableViewCell.h
//  GithubUserExample
//
//  Created by Oscar Edward on 26/06/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UILabel *lblUserType;
@property (weak, nonatomic) IBOutlet UIImageView *imgViewUserProfilePicture;
@property (weak, nonatomic) IBOutlet UIButton *btnEditUser;

@property (nonatomic, strong) NSURLSessionDataTask *imageDownloadTask;
@end

NS_ASSUME_NONNULL_END
