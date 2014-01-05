#import "Kiwi.h"
#import "KanbanTableFactory.h"

SPEC_BEGIN(KanbanTableFactorySpec)

describe(@"Kanban Table Factory", ^{

	context(@"Table Header View", ^{

		it(@"should create a table header view when a table manager is created", ^{
			[[KanbanTableFactory should] receive:@selector(createHeaderView:name:)];
			[KanbanTableFactory createKanbanTableManager:CGRectZero withName:@"TestName"];
		});

	});

});

SPEC_END