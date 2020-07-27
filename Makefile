# CL_65 := vendor/cc65/bin/cl65
# rwildcard:=$(foreach d,$(wildcard $(1:=/*)),$(call rwildcard,$d,$2) $(filter $(subst *,%,$2),$d))
# TEST_CASES:=$(call rwildcard,tests/test-cases,*.asm)


# .PHONY: deps
# deps: vendor/cc65/bin/ca65 

# .PHONY: clean
# clean:
# 	rm -rf tests/build/*.prg
# 	rm -rf build/*.prg

# .PHONY: test
# test: build/test-suite.prg
# 	x64sc build/test-suite.prg

# vendor:
# 	mkdir vendor

# vendor/cc65: vendor
# 	git clone https://github.com/cc65/cc65.git vendor/cc65

# vendor/cc65/bin/ca65: vendor/cc65
# 	pushd vendor/cc65; make; popd

# vendor/c64Unit: vendor
# 	./bin/c64Unit-dependency.sh

# build/test-suite.prg: $(TEST_CASES)
# 	${CL_65} -Oir -t c64 \
# 		-I vendor/c64unit/cross-assemblers/ca65 \
# 		-I tests/test-cases \
# 		-I src \
# 		-C tests/c64unit.cfg tests/test-suite.asm -o build/test-suite.prg

# build/main.prg: main.asm $(wildcard src/*.asm)
# 	${CL_65} -Oir -t c64 \
# 		-I src \
# 		-C /c64unit.cfg tests/test-suite.asm -o build/main.prg

CPU = 6502
C1541 = c1541
# Also pass symbols to VICE monitor
X64 = x64 -moncommands symbols
OUTPUT = "diskcontents/myprg.prg"

DISKFILENAME = my.d64
DISKNAME = myprg
ID = 17

AS = ca65
# Add defines, if needed (-DWHATEVER)
ASFLAGS = -g --cpu $(CPU) --include-dir src/

LD = ld65
#Define segments & files in config.cfg
LDFLAGS = -m labels.txt -Ln symbols -o $(OUTPUT) -C config.cfg

OBJS = \
	src/main.o \
	src/irq.o

all: d64

myprg: $(OBJS)
	$(LD) $(LDFLAGS) $(OBJS)

d64: myprg
	$(C1541) -format $(DISKNAME),$(ID) d64 $(DISKFILENAME)
	$(C1541) -attach $(DISKFILENAME) -write $(OUTPUT)
	$(C1541) -attach $(DISKFILENAME) -list

run: d64
	$(X64) $(DISKFILENAME)

clean:
	rm -f src/*.o diskcontents/* labels.txt symbols $(DISKFILENAME)
