#import "Kiwi.h"
#import "KanbanTableSource.h"
#import "TaskItem.h"

SPEC_BEGIN(KanbanTableSourceSpec)


describe(@"Defined Task Item Source", ^{
	__block KanbanTableSource *sut;

	beforeEach(^{
		sut = [[KanbanTableSource alloc] init];
	});

	afterEach(^{
		sut = nil;
	});

	context(@"construction", ^{
		it(@"should conform to UITableViewDataSourceProtocol", ^{
			[[sut should] conformToProtocol:@protocol(UITableViewDataSource)];
		});

		it(@"should have the cellManager property defined", ^{
		});
	});

	context(@"items", ^{
		__block NSMutableArray *items;
		beforeEach(^{
			items = [NSMutableArray array];
			[items addObject:[[TaskItem alloc] initWithName:@"Get things showing up" estimate:nil toDo:nil ]];
			[items addObject:[[TaskItem alloc] initWithName:@"Do more unit tests" estimate:nil toDo:nil ]];
			[items addObject:[[TaskItem alloc] initWithName:@"Refactor dammit" estimate:nil toDo:nil ]];
			[sut setItems:items];
		});

		it(@"should return 3 when asked for number of rows in section", ^{

			[[theValue([sut tableView:nil numberOfRowsInSection:0]) should] equal:theValue(3)];
		});

		it(@"should return the correct item for the given index path", ^{
			TaskItem *expected = [sut itemForPosition:0];
			[[expected should] equal:[items objectAtIndex:0]];
		});

		it(@"should delete the data from the given indexPath", ^{
			[sut removeCell:nil path:[NSIndexPath indexPathForRow:0 inSection:0]];
			[[theValue([[sut items] count]) should] equal:theValue(2)];
		});

		it(@"should add data for the given task item", ^{
			id taskItemMock = [TaskItem mock];
			[sut addData:taskItemMock];
			[[theValue([[sut items] count]) should] equal:theValue(4)];
		});
	});

	context(@"Getting cells", ^{

		__block NSMutableArray *items;
		__block id taskCellMock;

		beforeEach(^{
			items = [NSMutableArray array];
			[items addObject:[[TaskItem alloc] initWithName:@"Get things showing up" estimate:@0 toDo:@0 ]];
			[items addObject:[[TaskItem alloc] initWithName:@"Do more unit tests" estimate:@0 toDo:@0 ]];
			[items addObject:[[TaskItem alloc] initWithName:@"Refactor dammit" estimate:@0 toDo:@0 ]];
			[sut setItems:items];
		});

	});

});

SPEC_END

























