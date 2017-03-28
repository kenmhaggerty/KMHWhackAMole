//
//  KMHBoardViewController.h
//  KMHWhackAMole
//
//  Created by Ken M. Haggerty on 12/11/16.
//  Copyright © 2016 Ken M. Haggerty. All rights reserved.
//

#pragma mark - // NOTES //

#pragma mark - // IMPORTS //

#import <UIKit/UIKit.h>

#pragma mark - // KMHBoardViewController //

#pragma mark Imports

#import "BoardUI_Protocols.h"

#pragma mark Public Interface

@interface KMHBoardViewController : UIViewController <BoardUI>
@property (nonatomic) NSUInteger rows;
@property (nonatomic) NSUInteger cols;

// INITS //

- (id)initWithRows:(NSUInteger)rows columns:(NSUInteger)cols;

// GETTERS //

- (UIView *)cellForRow:(NSUInteger)row column:(NSUInteger)col;

@end
