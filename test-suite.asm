
	.debuginfo +

	.include "vendor/c64unit/cross-assemblers/ca65/core2000.asm"
  
	; Init
	c64unit

	; Examine test cases
	examineTest testSumToZeroPage
	examineTest testSumToZeroPageWithDataSet
	examineTest testCopyMap
	examineTest testCopyColumn
	; If this point is reached, there were no assertion fails
	c64unitExit
	
	; Include domain logic, i.e. classes, methods and tables
	.include "src/memory.asm"
	.include "src/sum-to-zero-page.asm"
	.include "src/pointer-macros.asm"
	.include "src/vic.asm"
	.include "src/vchar.asm"
	.include "src/map.asm"
	.segment "MAP"
        .include "tests/assets/commando-map.s"
.segment "CHAR"
        .include "tests/assets/commando-charset.s"
.segment "HIRAM"
        .include "tests/assets/commando-colors.s"
.CODE
	; Testsuite with all test cases
	.include "tests/test-cases/sum-to-zero-page/test.asm"
	.include "tests/test-cases/sum-to-zero-page-with-data-set/test.asm"
	.include "tests/test-cases/map/test-copy-map.asm"
	.include "tests/test-cases/map/test-copy-column.asm"
