#import "Kiwi.h"
#import "KanbanTableSource.h"
#import "TaskItem.h"
#import "TaskCell.h"

SPEC_BEGIN(KanbanTableSourceSpec)

NSString * const notificationName = @"KanbanTableSourceSpec";

describe(@"Defined Task Item Source", ^{
	__block KanbanTableSource *sut;

	beforeEach(^{
		sut = [[KanbanTableSource alloc] initWithNotificationName:notificationName];
	});

	afterEach(^{
		sut = nil;
	});

	context(@"construction", ^{

		it(@"should conform to UITableViewDataSourceProtocol", ^{
			[[sut should] conformToProtocol:@protocol(UITableViewDataSource)];
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

	context(@"cells", ^{

		__block NSMutableArray *items;
		__block id taskCellMock;

		beforeEach(^{
			taskCellMock = [TaskCell nullMockWithName:@"taskCellMock"];
			items = [NSMutableArray array];
			[items addObject:[[TaskItem alloc] initWithName:@"Get things showing up" estimate:@0 toDo:@0 ]];
			[items addObject:[[TaskItem alloc] initWithName:@"Do more unit tests" estimate:@0 toDo:@0 ]];
			[items addObject:[[TaskItem alloc] initWithName:@"Refactor dammit" estimate:@0 toDo:@0 ]];
			[sut setItems:items];
		});

		it(@"should tell the cell to configure itself", ^{
			id tableViewMock = [UITableView nullMockWithName:@"tableViewMock"];
			[tableViewMock stub:@selector(dequeueReusableCellWithIdentifier:forIndexPath:) andReturn:taskCellMock];
			[[taskCellMock should] receive:@selector(configureWithTaskItem:indexPath:notificationName:)];
			[sut tableView:tableViewMock cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
		});

	});

});

SPEC_END

























