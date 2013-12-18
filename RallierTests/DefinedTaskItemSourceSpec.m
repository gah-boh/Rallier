#import "Kiwi.h"
#import "DefinedTaskItemSource.h"
#import "TaskItem.h"

SPEC_BEGIN(DefinedTaskItemSourceSpec)
	describe(@"Defined Task Item Source", ^{
		__block DefinedTaskItemSource *sut;

		beforeEach(^{
			sut = [[DefinedTaskItemSource alloc] init];
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
				[items addObject:[[TaskItem alloc] initWithName:@"Get things showing up"]];
				[items addObject:[[TaskItem alloc] initWithName:@"Do more unit tests"]];
				[items addObject:[[TaskItem alloc] initWithName:@"Refactor dammit"]];
				[sut setItems:items];
			});

			it(@"should return 3 when asked for number of rows in section", ^{

				[[theValue([sut tableView:nil numberOfRowsInSection:0]) should] equal:theValue(3)];
			});

			it(@"should return the correct item for the given index path", ^{
				NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
				TaskItem *expected = [sut itemForPosition:indexPath];
				[[expected should] equal:[items objectAtIndex:0]];
			});

			it(@"should delete the data from the given indexPath", ^{
				NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
				[sut removeDataForPosition:indexPath];
				[[theValue([[sut items] count]) should] equal:theValue(2)];
			});

			it(@"should add data for the given task item", ^{
				id taskItemMock = [TaskItem mock];
				NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
				[sut addData:taskItemMock forPosition:indexPath];
				[[theValue([[sut items] count]) should] equal:theValue(4)];
			});
		});
	});
SPEC_END