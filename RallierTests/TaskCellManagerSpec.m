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

		beforeEach(^{
			cellMock = [TaskCell nullMockWithName:@"TaskCell"];
			estimateFieldMock = [UITextField nullMockWithName:@"estimateTextField"];
			[cellMock stub:@selector(estimate) andReturn:estimateFieldMock];
		});

		it(@"TaskCellManager should conform to the TaskCellDelegateProtocol", ^{
			[[sut should] conformToProtocol:@protocol(TaskCellDelegate)];
		});

		it(@"when manageCell: is called the manager will set itself as the cells delegate", ^{
			[[cellMock should] receive:@selector(setDelegate:) withArguments:sut];
			[sut manageCell:cellMock];
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

		pending_(@"should post a notification for -updateEstimated:", ^{
			// Right now I was thinking to use a notification and key value coding. I'm second
			// guessing myself and maybe should get the cell that's being edited on
			// and update it.
		});
	});
});

SPEC_END
