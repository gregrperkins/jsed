

#
# error cases
#

=IN foo

=FAIL 1,garbled address
=FAIL unknown command
=FAIL pextra chars after cmd
# unbalanced
=FAIL }
=FAIL {
# wrong number of addresses
=FAIL {/foo/}
=FAIL 1,2q
=FAIL 1,$=
=FAIL $:label
=FAIL 1,2r file
=FAIL
1,2i\
foo
=FAIL
1,2a\
foo
=FAIL i
=FAIL c\
=FAIL s/a/b/12g
=FAIL s/a/b/g1
=FAIL s/a/b/1p2
=FAIL s/a/b/0




=FAIL w
=FAIL s/a/b/w


=FAIL 0p
=FAIL 1,0p
=FAIL
i\
trailing backlash\
=FAIL y/fo
=FAIL y/fo/ba
=FAIL y/fo/b/
=FAIL y/fo/bar/

# no last RE at runtime

