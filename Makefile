
#
# Makefile for Jsed
#

BUILT = manual.html runsedcheck.html rundc.html check.html

all: $(BUILT)

TTESTS = test.t addr.t buffers.t match.t error.t interval.t misc.t \
	gnutests.t # ext.t 

match.t: match.txt
	sed -f txttot.sed match.txt > match.t

check.html: Makefile jsed.js ttojs.sed $(TTESTS)
	sed -f ttojs.sed $(TTESTS) > check.html

manual.html: jsed.1 man2html.sed
	sed -f man2html.sed jsed.1 > manual.html

runsedcheck.html: mkrun.sh run.in
	sh mkrun.sh sedcheck.sed http://lvogel.free.fr/sed/sedcheck.sed \
	  $$HOME/Sed/scripts/sedcheck.sed "" > $@

rundc.html: mkrun.sh run.in gnutests/dc.sed
	sh mkrun.sh dc.sed http://sed.sf.net/dc.sed \
	  gnutests/dc.sed easter.dc > $@

clean:
	rm -f ? *~ core *.stackdump a.out *.exe tmp.* *.tmp log
	rm -f $(BUILT) match.t

distclean: clean

