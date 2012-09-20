//
//  SFAGenericTableProtocols.h
//  SFA
//
//  Created by Federico Lagarmilla on 5/4/11.
//  Copyright 2011 Globant. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SORT_DICTIONARY_USER_KEY @"user"
#define SORT_DICTIONARY_SORT_KEY @"sort"

@protocol SFASortValuesProtocol

// returns array of dictionaries containing the values to sort the table, and user friendly names to display for the user
- (NSMutableArray *)sortValues;

@end

@protocol SFASearcheableEntityProtocol

// indicates if the entity has the value being searched
- (BOOL)hasSearchingValue:(NSString *)value;

@end
