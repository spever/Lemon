//
//  Student.h
//  Lemon
//
//  Created by luo on 2023/6/19.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN


@protocol StudentDelegate <NSObject>

- (void)work:(int) age andName: (NSString *) name;

@end

@interface Student : NSObject<StudentDelegate>

@end

NS_ASSUME_NONNULL_END
