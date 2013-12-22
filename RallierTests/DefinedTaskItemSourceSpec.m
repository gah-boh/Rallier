#import "Kiwi.h"
#import "KanbanTableSource.h"
#import "TaskItem.h"
#import "TaskCellManager.h"

SPEC_BEGIN(DefinedTaskItemSourceSpec)
	describe(@"Defined Task Item Source", ^{
		__block KanbanTableSource *sut;
		__block id taskCellManagerMock;

		beforeEach(^{
			taskCellManagerMock = [TaskCellManager nullMockWithName:@"TaskCellManagerMock"];
			sut = [[KanbanTableSource alloc] initWithCellManager:taskCellManagerMock];
		});

		afterEach(^{
			sut = nil;
		});

		context(@"construction", ^{
			it(@"should conform to UITableViewDataSourceProtocol", ^{
				[[sut should] conformToProtocol:@protocol(UITableViewDataSource)];
			});

			it(@"should have the cellManager property defined", ^{
				[[sut taskCellManager] shouldNotBeNil];
			});
		});

		context(@"items", ^{
			__block NSMutableArray *items;
			beforeEach(^{
				items = [NSMutableArray array];
				[items addObject:[[TaskItem alloc] initWithName:@"Get things showing up"]];
				[items addObject:[[TaskItem alloc] initWithName:@"Do more unit tests"]];
				[items addObject:[[TaskItem alloc] initWithName:@"Refactor dammit"]];
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
				[sut removeDataForPosition:0];
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

			beforeEach(^{
				items = [NSMutableArray array];
				[items addObject:[[TaskItem alloc] initWithName:@"Get things showing up"]];
				[items addObject:[[TaskItem alloc] initWithName:@"Do more unit tests"]];
				[items addObject:[[TaskItem alloc] initWithName:@"Refactor dammit"]];
				[sut setItems:items];
			});

			it(@"should add the cell to the manager", ^{
				id tableViewMock = [UITableView nullMockWithName:@"tableViewMock"];
				id taskCellMock = [TaskCell nullMockWithName:@"taskCellMock"];
				[tableViewMock stub:@selector(dequeueReusableCellWithIdentifier:forIndexPath:) andReturn:taskCellMock];
				[[taskCellManagerMock should] receive:@selector(manageCell:) withArguments:taskCellMock];
				[sut tableView:tableViewMock cellForRowAtIndexPath:nil];
			});

		});
	});
SPEC_END

























