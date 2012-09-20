//
//  SFACustomRoundedTableBackground.h
//  SFA
//
//  Created by Federico Lagarmilla on 4/28/11.
//  Copyright 2011 Globant. All rights reserved.
//

#import <UIKit/UIKit.h>
#define GENERIC_TABLE_TITLE_HEIGHT 40

@protocol SFAGenericTableSearchBarDelegate

// search generic table with typed text
- (void)searchText:(NSString *)text;

// tells the Generic table to display sort options and receives the key selected to display on title
- (void)sortKeysOptionDisplay:(id)sender;

@end

@interface SFACustomRoundedTableBackground : UIView <UITextFieldDelegate> {
    NSString *_title;
    UILabel *_lblOrderValue;
    UITextField *_txtSearchField;
    NSObject <SFAGenericTableSearchBarDelegate> *_delegate;
    UIButton *_btnSort;
}

- (id)initWithTitle:(NSString *)tableTitle delegate:(NSObject <SFAGenericTableSearchBarDelegate> *)searchDelegate frame:(CGRect)frame;
- (void)updateSortValue:(NSString *)sortValue;

@end
