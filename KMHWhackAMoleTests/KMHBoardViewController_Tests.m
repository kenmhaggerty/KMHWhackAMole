//
//  KMHBoardViewController_Tests.m
//  KMHWhackAMole
//
//  Created by Ken M. Haggerty on 12/11/16.
//  Copyright © 2016 Ken M. Haggerty. All rights reserved.
//

#pragma mark - // NOTES //

#pragma mark - // IMPORTS //

#import "Specta.h"
#define EXP_SHORTHAND
#import "Expecta.h"
#import <KIF/KIF.h>

#pragma mark - // KMHBoardViewController_Tests //

#pragma mark Imports

#import "BoardUI_Protocols.h"

#import "KMHBoardViewController.h"

#pragma mark Implementation

SpecBegin(KMHBoardViewController_Tests)

describe(@"KMHBoardViewController_Tests", ^{
    
#pragma mark // Variables //
    
    __block UIViewController <BoardUI> *viewController;
    
#pragma mark // Constants //
    
    NSString *storyboardName = @"Main";
    NSTimeInterval defaultTimeout = 1.0f;
    
    NSUInteger rows = 3;
    NSUInteger cols = 3;
    
#pragma mark // Inits and Loads //
    
    beforeAll(^{
        [KIFUITestActor setDefaultTimeout:defaultTimeout];
        
        UIStoryboard *main = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
        viewController = [main instantiateInitialViewController];
        [UIApplication sharedApplication].keyWindow.rootViewController = viewController;
    });
    
    beforeEach(^{
        viewController = [[KMHBoardViewController alloc] initWithRows:rows columns:cols];
    });
    
    afterEach(^{
        // before each
    });
    
#pragma mark - // TESTS //
    
    describe(@"view controller", ^{
        
        it(@"can be created", ^{
            
            expect(viewController).toNot.beNil();
        });
        
        describe(@"conforms to protocol", ^{
            
            it(@"Board", ^{
                
                expect(viewController).to.conformTo(@protocol(BoardUI));
            });
        });
        
        describe(@"rows", ^{
            
            it(@"were set", ^{
                
                expect(viewController.rows).to.equal(rows);
            });
        });
        
        describe(@"columns", ^{
            
            it(@"were set", ^{
                
                expect(viewController.cols).to.equal(cols);
            });
        });
        
        describe(@"board", ^{
            
            it(@"exists", ^{
                
                UIView *board = [tester waitForViewWithAccessibilityLabel:BoardAccessibilityLabel];
                expect(board).toNot.beNil();
            });
            
            it(@"has appropriate number of cells", ^{
                
                UIView *cell;
                for (int row = 0; row < rows; row++) {
                    for (int col = 0; col < cols; col++) {
                        cell = [viewController cellForRow:row column:col];
                        expect(cell).toNot.beNil();
                    }
                }
            });
        });
    });
});

SpecEnd