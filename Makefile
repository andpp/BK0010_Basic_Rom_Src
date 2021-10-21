SOURCE = MONIT.mac COMP.mac TRAP.mac JMP.mac FLOAT.mac 

.PHONY: all clean

all:  basic0010

ASM = ../bin/macro11
LINK = ../bin/link11

ODIR=out

_OBJ = $(SOURCE:.mac=.obj)
OBJ = $(ODIR)/BK.obj $(patsubst %,$(ODIR)/%,$(_OBJ))


$(ODIR)/%.obj: %.mac
	mkdir -p out
	$(ASM) -l $<.lst -ysl 16 -d IS -yus -o $@ $< 

$(ODIR)/BK.obj: BK.mac GRAF.mac
	mkdir -p out
	$(ASM) -l $<.lst -ysl 16 -d IS -yus -o $@ BK.mac GRAF.mac

basic0010: $(OBJ)
	mkdir -p out
	$(LINK) /MAP /STB /BIN /B:120000 /EXECUTE:$(ODIR)/$@ $(OBJ)

full-listing:
	$(ASM) -l basic.lst -ysl 16 -d IS -yus -o out/basic.obj BK.mac GRAF.mac MONIT.mac COMP.mac TRAP.mac JMP.mac FLOAT.mac
	$(LINK) /MAP /STB /BIN /B:120000 /EXECUTE:out/basic.bin out/basic.obj

clean:
	rm -f $(ODIR)/* *.lst
