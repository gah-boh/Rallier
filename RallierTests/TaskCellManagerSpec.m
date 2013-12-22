#import "Kiwi.h"
#import "TaskCellManager.h"

SPEC_BEGIN(TaskCellManagerSpec)

describe(@"Task Cell Manager", ^{
	context(@"Adding a cell", ^{

		__block TaskCellManager *sut;
		__block id cellMock;
		__block id estimateFieldMock;
		__block id toDoFieldMock;

		beforeEach(^{
			sut = [[TaskCellManager alloc] init];
			cellMock = [TaskCell nullMockWithName:@"TaskCell"];
			estimateFieldMock = [UITextField nullMockWithName:@"estimateTextField"];
			toDoFieldMock = [UITextField nullMockWithName:@"toDoTextFieldMock"];
			[cellMock stub:@selector(estimate) andReturn:estimateFieldMock];
			[cellMock stub:@selector(toDo) andReturn:toDoFieldMock];
		});

		it(@"TaskCellManager should conform to the TaskCellDelegateProtocol", ^{
			[[sut should] conformToProtocol:@protocol(TaskCellDelegate)];
		});

		it(@"when manageCell: is called the manager will set itself as the estimate field delegate", ^{
			[[estimateFieldMock should] receive:@selector(setDelegate:) withArguments:sut];
			[sut manageCell:cellMock];
		});

		it(@"when manageCell: is called the manager will set itself as the toDo field delegate", ^{
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

	});
});

SPEC_END