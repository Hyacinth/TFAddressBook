//
//  TFMultiValue.m
//  AddressbookSyncDemo
//
//  Created by Tom Fewster on 29/11/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "TFMultiValue.h"

@implementation TFMultiValue

@synthesize _multiValue;

- (id)initWithRef:(ABMultiValueRef)multiValue {
	if ((self = [super init])) {
		_multiValue = multiValue;
		CFRetain(_multiValue);
	}
		 
	return self;
}

- (void)dealloc {
	if (_multiValue) {
		CFRelease(_multiValue);
	}
}

- (NSUInteger)count {
	return (NSUInteger)ABMultiValueGetCount(_multiValue);
}

- (TFMultiValueIdentifier)identifierAtIndex:(NSUInteger)index {
	return ABMultiValueGetIdentifierAtIndex(_multiValue, index);
}

- (NSUInteger)indexForIdentifier:(TFMultiValueIdentifier)identifier {
	return (NSUInteger)ABMultiValueGetIndexForIdentifier(_multiValue, identifier);
}

- (NSString *)labelAtIndex:(NSUInteger)index {
	return (__bridge_transfer NSString *)ABMultiValueCopyLabelAtIndex(_multiValue, index);
}

- (id)labelForIdentifier:(TFMultiValueIdentifier)identifier {
	NSUInteger index = [self indexForIdentifier:identifier];
	return [self labelAtIndex:index];
}

- (TFPropertyType)propertyType {
	return ABMultiValueGetPropertyType(_multiValue);
}

- (id)valueAtIndex:(NSUInteger)index {
	CFTypeRef result = ABMultiValueCopyValueAtIndex(_multiValue, index);
	if ([self propertyType] & kABMultiValueMask) {
		return [[TFMultiValue alloc] initWithRef:result];
	}
	
	return (__bridge_transfer id)result;
}

- (id)valueForIdentifier:(TFMultiValueIdentifier)identifier {
	NSUInteger index = [self indexForIdentifier:identifier];
	return [self valueAtIndex:index];
}

- (NSString *)primaryIdentifier {
//	error primaryIdentifer isn't supported on iOS
	return nil;
}

@end
