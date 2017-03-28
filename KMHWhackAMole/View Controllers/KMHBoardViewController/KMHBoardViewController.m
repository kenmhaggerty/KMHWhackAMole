//
//  KMHBoardViewController.m
//  KMHWhackAMole
//
//  Created by Ken M. Haggerty on 12/11/16.
//  Copyright © 2016 Ken M. Haggerty. All rights reserved.
//

#pragma mark - // NOTES //

#pragma mark - // IMPORTS //

#import "KMHBoardViewController.h"

#pragma mark - // KMHGridView //

#pragma mark Imports

#include <asl.h>

#pragma mark Public Interface

IB_DESIGNABLE

@interface KMHGridView : UIStackView
@property (nonatomic) IBInspectable NSUInteger rows;
@property (nonatomic) IBInspectable NSUInteger cols;

// INITS //

- (id)initWithFrame:(CGRect)frame rows:(NSUInteger)rows columns:(NSUInteger)cols NS_DESIGNATED_INITIALIZER;
- (id)initWithFrame:(CGRect)frame DEPRECATED_MSG_ATTRIBUTE("use -[initWithFrame:rows:columns:].");

// CUSTOM INDEXED SUBSCRIPTING //

- (NSArray <UIView *> *)objectAtIndexedSubscript:(NSUInteger)idx;
- (void)setObject:(id)obj atIndexedSubscript:(NSUInteger)idx;

@end

#pragma mark Private Interface

@interface KMHGridView ()
+ (UIStackView *)rowWithColumns:(NSUInteger)cols;
@end

#pragma mark Implementation

@implementation KMHGridView

#pragma mark // Setters and Getters (Public) //

@synthesize cols = _cols;

- (void)setRows:(NSUInteger)rows {
    if (rows > self.arrangedSubviews.count) {
        while (self.arrangedSubviews.count < rows) {
            [self addArrangedSubview:[KMHGridView rowWithColumns:self.cols]];
        }
    }
    else if (rows < self.arrangedSubviews.count) {
        while (self.arrangedSubviews.count > rows) {
            [self removeArrangedSubview:self.arrangedSubviews.lastObject];
        }
    }
}

- (NSUInteger)rows {
    return self.arrangedSubviews.count;
}

- (void)setCols:(NSUInteger)cols {
    if (cols == self.cols) {
        return;
    }
    
    _cols = cols;
    
    for (UIStackView *row in self.arrangedSubviews) {
        if (cols > row.arrangedSubviews.count) {
            while (row.arrangedSubviews.count < cols) {
                [row addArrangedSubview:[[UIView alloc] init]];
            }
        }
        else if (cols < row.arrangedSubviews.count) {
            while (row.arrangedSubviews.count > cols) {
                [row removeArrangedSubview:row.arrangedSubviews.lastObject];
            }
        }
    }
}

#pragma mark // Inits and Loads //

- (id)initWithFrame:(CGRect)frame rows:(NSUInteger)rows columns:(NSUInteger)cols {
    self = [super initWithFrame:frame];
    if (self) {
        self.axis = UILayoutConstraintAxisVertical;
        self.distribution = UIStackViewDistributionFillEqually;
        self.alignment = UIStackViewAlignmentFill;
        self.spacing = 8.0f; // temp
        self.translatesAutoresizingMaskIntoConstraints = NO;
        
        while (self.arrangedSubviews.count < rows) {
            [self addArrangedSubview:[KMHGridView rowWithColumns:cols]];
        }
        
        _cols = cols;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame rows:0 columns:0];
}

#pragma mark // Public Methods (Custom Indexed Subscripting) //

- (NSArray <UIView *> *)objectAtIndexedSubscript:(NSUInteger)idx {
    return ((UIStackView *)self.arrangedSubviews[idx]).arrangedSubviews;
}

- (void)setObject:(id)obj atIndexedSubscript:(NSUInteger)idx {
    asl_log(NULL, NULL, 4, "cannot set row after initialization");
}

#pragma mark // Private Methods //

+ (UIStackView *)rowWithColumns:(NSUInteger)cols {
    NSMutableArray <UIView *> *cells = [NSMutableArray arrayWithCapacity:cols];
    UIView *cell;
    while (cells.count < cols) {
        cell = [[UIView alloc] init];
        cell.backgroundColor = [UIColor cyanColor];
        [cells addObject:cell];
    }
    UIStackView *row = [[UIStackView alloc] initWithArrangedSubviews:cells];
    row.axis = UILayoutConstraintAxisHorizontal;
    row.distribution = UIStackViewDistributionFillEqually;
    row.alignment = UIStackViewAlignmentFill;
    row.spacing = 8.0f; // temp
    row.translatesAutoresizingMaskIntoConstraints = NO;
    return row;
}

@end

#pragma mark - // KMHBoardViewController //

#pragma mark Private Interface

@interface KMHBoardViewController ()
@property (nonatomic, strong) IBOutlet KMHGridView *boardView;
@end

#pragma mark Implementation

@implementation KMHBoardViewController

#pragma mark // Setters and Getters (Public) //

- (void)setRows:(NSUInteger)rows {
    self.boardView.rows = rows;
}

- (NSUInteger)rows {
    return self.boardView.rows;
}

- (void)setCols:(NSUInteger)cols {
    self.boardView.cols = cols;
}

- (NSUInteger)cols {
    return self.boardView.cols;
}

#pragma mark // Inits and Loads //

- (id)initWithRows:(NSUInteger)rows columns:(NSUInteger)cols {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.boardView.rows = rows;
        self.boardView.cols = cols;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.boardView.rows = 4;
    self.boardView.cols = 4;
    
    self.boardView.accessibilityLabel = BoardAccessibilityLabel;
}

#pragma mark // Public Methods (Getters) //

- (UIView *)cellForRow:(NSUInteger)row column:(NSUInteger)col {
    return self.boardView[row][col];
}

@end
