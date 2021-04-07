//
//  NSObject+PropertyListing.h
//  PlayerViewLayer
//
//  Created by xdf_yanqing on 2021/4/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (PropertyListing)
- (NSArray *)getAllProperties;
- (NSDictionary *)properties_aps;
-(void)printMothList;
@end

NS_ASSUME_NONNULL_END
