//
// Created by Danny Thibaudeau on 15-08-02.
// Copyright (c) 2015 Danny Thibaudeau. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KOTreeViewDelegate

- (NSMutableArray *)listItemsAtPath:(NSString *)path;

@end

