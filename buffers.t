#
# test buffers.
#

=IN foo
=OUT
foo

=SED G

=OUT

foo
=SED H;x

=OUT
bar
foo
=SED h;s/foo/bar/;G

=OUT
foo
bar
=SED h;s/foo/bar/;H;x

=OUT a
=SED
s/foo/a\
b/;P;d
.

=OUT
a
a
b
=SED 
s/foo/a\
b/;P
.

=OUT
a
b$
b$
=SED
s/foo/a\
b/;l;D
.

=IN
foo
bar
=OUT
foo$
foo
bar$
=SED l;n;l;d

=OUT
foo$
foo
bar$
=SED l;N;l;d

#
# n, N at last line
#

=IN foo
=OUT foo
=SED n;l
=SED p;N;l
=SED p;d
=SED p;D

#
# check that appends are output after 'q'
#

=OUT
foo
bar
=SED 
a\
bar
q
.

#
# check that D does not increase the line number, and does not quit
# when last line is reached
# 

=OUT
foo
1
boo
1
moo
1
=SED p; =; y/fbm/bmz/; G; s/\(.*\)\(\n\)/\2\1/; /z/!D; d

# end.
