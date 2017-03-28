//
//  BoardUI_Protocols.h
//  KMHWhackAMole
//
//  Created by Ken M. Haggerty on 12/11/16.
//  Copyright © 2016 Ken M. Haggerty. All rights reserved.
//

#pragma mark - // NOTES //

#pragma mark - // IMPORTS //

#pragma mark - // CONSTANTS //

#pragma mark Accessibility Labels

NSString * const BoardAccessibilityLabel = @"board";

#pragma mark - // BoardUI //

#pragma mark Protocol

@protocol BoardUI <NSObject>
@property (nonatomic, readonly) NSUInteger rows;
@property (nonatomic, readonly) NSUInteger cols;

// GETTERS //

- (UIView *)cellForRow:(NSUInteger)row column:(NSUInteger)col;

@end
