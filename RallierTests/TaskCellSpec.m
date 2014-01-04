#import "Kiwi.h"
#import "TaskCell.h"

SPEC_BEGIN(TaskCellSpec)

describe(@"Task Cell", ^{

	__block TaskCell *sut;
	__block id toDoFieldMock;

	beforeEach(^{
		toDoFieldMock = [UITextField nullMockWithName:@"toDoTextFieldMock"];
		sut = [[TaskCell alloc] init];
	});

	it(@"it conform to the UITextFieldDelegate protocol", ^{
		[[sut should] conformToProtocol:@protocol(UITextFieldDelegate)];
	});

	it(@"should respond to the -textFieldShouldReturn: selector to manage text fields", ^{
		[[sut should] respondToSelector:@selector(textFieldShouldReturn:)];
	});

	it(@"-textFieldShouldReturn: should tell the text field to resign first responder", ^{
		[[toDoFieldMock should] receive:@selector(resignFirstResponder)];
		[sut textFieldShouldReturn:toDoFieldMock];
	});

	pending_(@"should be the estimate fields delegate", ^{
//		UITextField *estimate = [sut estimate];
//		[[[estimate delegate] should] equal:sut];
	});

	pending_(@"Task Cell should be the toDo field's delegate", ^{
		// Until you figure out the estimate field test leave this alone.
	});

	context(@"Delegate Communication", ^{

		pending_(@"-textFieldShouldReturn: should tell its delegate to update the information", ^{

		});

	});

});


SPEC_END