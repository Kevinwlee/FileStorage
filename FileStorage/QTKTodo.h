//
//  QTKTodo.h
//  FileStorage
//
//  Created by Kevin Lee on 7/28/12.
//  Copyright (c) 2012 Q Technology Company. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QTKTodo : NSObject
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) NSDate *modifiedAt;
@property (nonatomic, strong) NSNumber *seconds;

@end
