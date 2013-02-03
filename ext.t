#
# test extensions
#

#
# test \xNN quotes
#

=IN foo
=OUT bar

# \x2f interpreted as litteral \/ in RE, RHS and both sides of 'y'
=SED 
s/o/\//
s/\x2f/a/ 
s/o/\x2f/
y/\x2f/r/
y/f/\x2f/
s/\//b/
.

# \x2e interpreted as litteral \. in regexps
=SED s/foo/b.r/; s/\x2e/a/

# \x5e interpreted as litteral \^ outside bracket expressions
=SED s/foo/b^r/; s/\x5e/a/

# \x5e interpreted as litteral [.^.] inside bracket expressions
=SED s/foo/b^r/; s/[\x5e?]/a/

# \x24 interpreted as litteral \$ in regexps
=SED s/foo/b$r/; s/\x24/a/

# \x2a interpreted as litteral \* in regexps
=SED s/foo/b*r/; s/b\x2a/ba/

# \x5b interpreted as litteral \[ outside bracket expressions ...
=SED s/foo/b[r/; s/\x5b/a/

# ... as well as in bracket expressions
=SED s/foo/b:]/; s/[\x5b:alpha:]]/ar/
=SED s/foo/b.]/; s/[\x5b.b.]]/ar/
=SED s/foo/b=]/; s/[\x5b=b=]]/ar/

# \x5d interpreted as a litteral [.].] in bracket expressions
#  outside range
=SED s/oo/ar/; s/[0-9\x5da-z]/b/
#  as beginning of range
=SED s/foo/aar/; s/[0\x5d-b]/b/
#  as end of range
=SED s/foo/Bar/; s/[A-\x5d]/b/

# \x2d interpreted as a litteral [.-.] in bracket expressions
=SED s/foo/b-r/; s/[a\x2dz]/a/

# \x78 interpreted as a litteral x in bracket expressions
=SED s/foo/x78/; s/[\x78]*/b/; s/78/ar/

# \x26 interpreted as a litteral \& in the RHS of a substitution
=SED s/foo/b\x26r/; s/&/a/

# \x5c interpreted as litteral \\
=SED s/foo/\\r/; s/\x5c*/ba/
=SED s/foo/\x5c&/; s/\\foo/bar/
=SED s/\(foo\)/\x5c1/; s/\\1/bar/

=OUT bar\
=SED 
i\
bar\x5c
d
.

#
# \< and \>
#

=IN
abc
,a,b,_,x, y;z,AB,C,X,Y,Z,0_1_!9
=OUT
<abc>
,<a>,<b>,<_>,<x>, <y>;<z>,<AB>,<C>,<X>,<Y>,<Z>,<0_1_>!<9>
=SED s/\</</g; s/\>/>/g

=IN ab, _.0
=OUT |a|b|,| |_|.|0|
=SED s/\(\<\)*/|/g

=IN foo
=OUT bar
=SED s/foo/a**b/; s/\>*//; s/a\*b/bar/


