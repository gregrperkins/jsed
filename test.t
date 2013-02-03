#
# test the testing environment (contains deliberate errors)
#

=IN This is the input
=OUT This was the expected output

=SED
# This test must fail (it tests the testing environment)
s/.*/deliberately wrong output/
.

=SED
# This test must fail (it tests the testing environment)
d
.


=OUT
.

=SED # This test must fail (it tests the testing environment)

=FAIL # This test must fail (it tests the testing environment)



