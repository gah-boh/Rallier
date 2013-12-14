#import "Kiwi.h"
#import "KanbanViewController.h"

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
});

SPEC_END