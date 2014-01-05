#import "Kiwi.h"
#import "TaskItem.h"
#import "TaskCell.h"
#import "KanbanTableSource_Testing.h"

SPEC_BEGIN(KanbanTableSourceSpec)

describe(@"Defined Task Item Source", ^{
	__block KanbanTableSource *sut;
	__block NSMutableArray *items;

	beforeEach(^{
		sut = [[KanbanTableSource alloc] init];
		items = [NSMutableArray array];
		[items addObject:[[TaskItem alloc] initWithName:@"Get things showing up" estimate:@0 toDo:@0 ]];
		[items addObject:[[TaskItem alloc] initWithName:@"Do more unit tests" estimate:@0 toDo:@0 ]];
		[items addObject:[[TaskItem alloc] initWithName:@"Refactor dammit" estimate:@0 toDo:@0 ]];
		[sut setItems:items];
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
		__block id taskCellMock;

		beforeEach(^{
			taskCellMock = [TaskCell nullMockWithName:@"taskCellMock"];
		});

		it(@"should pass the taskItem to the cell", ^{
			id tableViewMock = [UITableView nullMockWithName:@"tableViewMock"];
			[tableViewMock stub:@selector(dequeueReusableCellWithIdentifier:forIndexPath:) andReturn:taskCellMock];
			[[taskCellMock should] receive:@selector(setTaskItem:)];
			[sut tableView:tableViewMock cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
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

});

SPEC_END

























