#import "Kiwi.h"
#import "TaskCell.h"

SPEC_BEGIN(TaskCellSpec)

describe(@"Task Cell", ^{
});

describe(@"Task Cell Delegate", ^{

	it(@"should conform to the UITextFieldProtocol", ^{
		id sut = [KWMock mockForProtocol:@protocol(TaskCellDelegate)];
		[[sut should] conformToProtocol:@protocol(UITextFieldDelegate)];
	});
});

SPEC_END