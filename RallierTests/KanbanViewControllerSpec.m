#import "Kiwi.h"
#import "KanbanViewController.h"
#import "KanbanTableManager.h"

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

		it(@"will create the KanbanTableManager", ^{
			[stu view];
			[[stu definedTableManager] shouldNotBeNil];
		});

		it(@"will create the inProgressTableManager", ^{
			[stu view];
			[[stu inProgressTableManager] shouldNotBeNil];
		});

	});
});

SPEC_END