#import "Kiwi.h"
#import "TaskCell.h"
#import "TaskCell_Testing.h"
#import "TaskItem.h"

@interface MockObserver : NSObject
- (void)receiverStub:(NSNotification *)notification;
@end
@implementation MockObserver
- (void)receiverStub:(NSNotification *)notification
{}
@end

NSString * const notificationName = @"TaskCellSpec";

SPEC_BEGIN(TaskCellSpec)

describe(@"Task Cell", ^{

	__block TaskCell *sut;
	__block id taskNameMock;
	__block id toDoFieldMock;
	__block id estimateFieldMock;

	beforeEach(^{
		taskNameMock = [UILabel nullMockWithName:@"taskNameMock"];
		toDoFieldMock = [UITextField nullMockWithName:@"toDoTextFieldMock"];
		estimateFieldMock = [UITextField nullMockWithName:@"estimateFieldMock"];
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

	context(@"Configuration", ^{
		__block TaskItem *taskItem;
		__block NSIndexPath *indexPath;

		beforeEach(^{
			[sut setTaskName:taskNameMock];
			[sut setToDo:toDoFieldMock];
			[sut setEstimate:estimateFieldMock];
			taskItem = [[TaskItem alloc] initWithName:@"test name"
											 estimate:@4
												 toDo:@2];
			indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
		});

		void (^configureSUT)(void) = ^{
			[sut configureWithTaskItem:taskItem
							 indexPath:indexPath
					  notificationName:notificationName];
		};

		it(@"should set the notification name", ^{
			configureSUT();
			[[[sut notificationName] should] equal:notificationName];
		});

		it(@"should set the task name text", ^{
			[[taskNameMock should] receive:@selector(setText:) withArguments:@"test name"];
			configureSUT();
		});

		it(@"should set the estimate text already formmated", ^{
			[[estimateFieldMock should] receive:@selector(setText:) withArguments:@"4.00"];
			configureSUT();
		});

		it(@"should set the toDo text already formatted", ^{
			[[toDoFieldMock should] receive:@selector(setText:) withArguments:@"2.00"];
			configureSUT();
		});

		it(@"should set the tag for the taskName according to the indexPath", ^{
			[[taskNameMock should] receive:@selector(setTag:)];
			configureSUT();
		});

		it(@"should set the tag for the estimateField according to the indexPath", ^{
			[[estimateFieldMock should] receive:@selector(setTag:)];
			configureSUT();
		});

		it(@"should set the tag for the toDoField according to the indexPath", ^{
			[[toDoFieldMock should] receive:@selector(setTag:)];
			configureSUT();
		});

		context(@"calculating tags", ^{

			it(@"should return a value of 2 for section 0 row 2", ^{
				NSInteger expected = [sut calculateTagWithSection:0 row:2];
				[[theValue(expected) should] equal:theValue(2)];
			});

			it(@"should return a value of 1004 for section 1 row 4", ^{
				NSInteger expected = [sut calculateTagWithSection:1 row:4];
				[[theValue(expected) should] equal:theValue(1004)];
			});

		});

	});

	context(@"decyphering tags", ^{

		it(@"should return an index path with section 1 for 1002", ^{
			NSIndexPath *expected = [sut decypherTag:1002];
			[[theValue([expected section]) should] equal:theValue(1)];
		});

		it(@"should return an index path with row 2 for 1002", ^{
			NSIndexPath *expected = [sut decypherTag:1002];
			[[theValue([expected row]) should] equal:theValue(2)];
		});

		it(@"should return an index path with section 0 for 20", ^{
			NSIndexPath *expected = [sut decypherTag:20];
			[[theValue([expected section]) should] equal:theValue(0)];
		});

		it(@"should return an index path with row 20 for 20", ^{
			NSIndexPath *expected = [sut decypherTag:20];
			[[theValue([expected row]) should] equal:theValue(20)];
		});

	});

	context(@"Done editing", ^{

		__block id observerMock;

		beforeEach(^{
			[sut setNotificationName:notificationName];
			observerMock = [MockObserver nullMockWithName:@"observerMock"];
			[[NSNotificationCenter defaultCenter] addObserver:observerMock
													 selector:@selector(receiverStub:)
														 name:notificationName
													   object:nil];
		});

		afterEach(^{
			[[NSNotificationCenter defaultCenter] removeObserver:observerMock];
		});

		it(@"-textFieldDidEndEditing: should send a notification with correct name", ^{
			id textFieldMock = [UITextField nullMockWithName:@"textFieldMock"];
			[[observerMock should] receive:@selector(receiverStub:)];
			[sut textFieldDidEndEditing:textFieldMock];
		});

		pending(@"-textFieldDidEndEditing: should send the correct index path from its tag with the notification", ^{
			id textFieldMock = [UITextField nullMockWithName:@"textFieldMock"];
			[textFieldMock stub:@selector(tag) andReturn:theValue(1002)];

		});

	});

});


SPEC_END