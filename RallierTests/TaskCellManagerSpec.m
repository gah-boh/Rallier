#import "Kiwi.h"
#import "TaskCellManager.h"

@interface MockObserver : NSObject
- (void)modelChanged:(UIView *)viewChanged;
@end
@implementation MockObserver
- (void)modelChanged:(UIView *)viewChanged
{}
@end

SPEC_BEGIN(TaskCellManagerSpec)

NSString * const notificationName = @"testTasksCellManagerSpec";

describe(@"Task Cell Manager", ^{

	__block TaskCellManager *sut;

	beforeEach(^{
		sut = [[TaskCellManager alloc] initWithNotification:notificationName];
	});

	context(@"Adding a cell", ^{

		__block id cellMock;
		__block id estimateFieldMock;
		__block id toDoFieldMock;

		beforeEach(^{
			cellMock = [TaskCell nullMockWithName:@"TaskCell"];
			estimateFieldMock = [UITextField nullMockWithName:@"estimateTextField"];
			toDoFieldMock = [UITextField nullMockWithName:@"toDoTextFieldMock"];
			[cellMock stub:@selector(estimate) andReturn:estimateFieldMock];
			[cellMock stub:@selector(toDo) andReturn:toDoFieldMock];
		});

		it(@"TaskCellManager should conform to the TaskCellDelegateProtocol", ^{
			[[sut should] conformToProtocol:@protocol(TaskCellDelegate)];
		});

		it(@"when manageCell: is called the manager will set itself as the cells delegate", ^{
			[[cellMock should] receive:@selector(setDelegate:) withArguments:sut];
			[sut manageCell:cellMock];
		});

		it(@"when manageCell: is called the manager will set itself as the estimate field delegate", ^{
			[[estimateFieldMock should] receive:@selector(setDelegate:) withArguments:sut];
			[sut manageCell:cellMock];
		});

		pending_(@"when manageCell: is called the manager will set itself as the toDo field delegate", ^{
			[[toDoFieldMock should] receive:@selector(setDelegate:) withArguments:sut];
			[sut manageCell:cellMock];
		});

		it(@"textFieldShouldReturn: should tell the text field to resign first responder", ^{
			[[toDoFieldMock should] receive:@selector(resignFirstResponder)];
			[sut textFieldShouldReturn:toDoFieldMock];
		});

		it(@"will not add the same cell twice", ^{
			[sut manageCell:cellMock];
			[sut manageCell:cellMock];
			[[theValue([[sut managedCells] count]) should] equal:theValue(1)];
		});

		it(@"will add cell if it hasn't been added yet", ^{
			id differentCell = [TaskCell nullMock];
			[sut manageCell:cellMock];
			[sut manageCell:cellMock];
			[sut manageCell:differentCell];
			[[theValue([[sut managedCells] count]) should] equal:theValue(2)];
		});

		it(@"stop managing cell will remove a cell from managedCells", ^{
			id differentCell = [TaskCell nullMock];
			[sut manageCell:differentCell];
			[sut manageCell:cellMock];
			[sut stopManagingCell:cellMock];
			[[theValue([[sut managedCells] count]) should] beLessThan:theValue(2)];
		});

	});

	context(@"updating cells", ^{
		pending_(@"-updateEstimated: should send notification with correct property value", ^{

		});
	});

	context(@"notifications", ^{

		__block id mockReceiver;

		beforeEach(^{
			mockReceiver = [MockObserver nullMockWithName:@"mockReceiver"];
			[mockReceiver stub:@selector(modelChanged:)];
			[[NSNotificationCenter defaultCenter] addObserver:mockReceiver
													 selector:@selector(modelChanged:)
														 name:notificationName
													   object:nil];
		});

		afterEach(^{
			[[NSNotificationCenter defaultCenter] removeObserver:mockReceiver];
		});

		it(@"should post a notification for -updateEstimated:", ^{
			id mockTextField = [UITextField nullMockWithName:@"mockTestField"];
			[mockTextField stub:@selector(text) andReturn:@"testing"];
			[[mockReceiver shouldEventually] receive:@selector(modelChanged:)];
			[sut updateEstimated:mockTextField];
		});
	});
});

SPEC_END
