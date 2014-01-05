#import "Kiwi.h"
#import "TaskCell.h"
#import "TaskItem.h"
#import "TaskCell_Testing.h"

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
			[sut configureWithTaskItem:taskItem];
		};

		it(@"should configure the cell when task item is set", ^{
			[[sut should] receive:@selector(configureWithTaskItem:)];
			[sut setTaskItem:taskItem];
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

		context(@"Done editing", ^{

			it(@"should strip any non numerical characters", ^{
				NSString *wrongInput = @"0.a2b5";
				NSNumber *expected = [sut convertNumericFieldText:wrongInput];
				[[theValue([expected floatValue]) should] equal:theValue(0.25)];
			});

			it(@"should strip any non numerical characters again", ^{
				NSString *wrongInput = @"3.a2b5";
				NSNumber *expected = [sut convertNumericFieldText:wrongInput];
				[[theValue([expected floatValue]) should] equal:theValue(3.25)];
			});

			it(@"-textFieldDidEndEditing: should change the estimate on the taskItem", ^{
				[estimateFieldMock stub:@selector(text) andReturn:@"2.50"];
				[sut setTaskItem:taskItem];
				[sut textFieldDidEndEditing:nil];
				[[theValue([[taskItem estimate] floatValue]) should] equal:theValue(2.50)];
			});

			it(@"-textFieldDidEndEditing: should change the toDo", ^{
				[toDoFieldMock stub:@selector(text) andReturn:@"1.00"];
				[sut setTaskItem:taskItem];
				[sut textFieldDidEndEditing:nil];
				[[theValue([[taskItem toDo] floatValue]) should] equal:theValue(1.00)];
			});

		});

	});


});


SPEC_END