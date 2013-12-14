#import "Kiwi.h"
#import "KanbanViewController.h"
#import "DefinedTableManager.h"

SPEC_BEGIN(KanbanViewControllerSpec)

describe(@"KanbanViewController", ^{
	__block KanbanViewController *stu;
	
	beforeEach(^{
		stu = [[KanbanViewController alloc] init];
	});
	
	afterEach(^{
		stu = nil;
	});
	
	context(@"construction", ^{
		
		it(@"should have a view defined", ^{
			[[stu view] shouldNotBeNil];
		});
	});

	context(@"View Loading", ^{

		it(@"will create the DefinedTableManager", ^{
			[stu view];
			[[stu definedTableManager] shouldNotBeNil];
		});

	});
});

SPEC_END