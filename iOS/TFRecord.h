

@class TFAddressBook;

@interface TFRecord : NSObject {
	ABRecordRef _record;
}

@property (readonly, getter=nativeObject) ABRecordRef _record;

- (id)initWithRef:(ABRecordRef)record;

- (id)initWithAddressBook:(TFAddressBook *)addressbook;
- (TFRecordID)uniqueId;
- (BOOL)isReadOnly;
- (BOOL)removeValueForProperty:(TFPropertyID)property;
- (BOOL)setValue:(id)value forProperty:(TFPropertyID)property;
- (BOOL)setValue:(id)value forProperty:(TFPropertyID)property error:(NSError **)error;
- (id)valueForProperty:(TFPropertyID)property;

- (NSString *)compositeName;

@end
