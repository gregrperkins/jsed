s/^TRY *\([^ ]*\) *\(.*\)<\(.*\)>\([^ ]*\) */=IN \2\3\4\
=OUT \2<\3>\4\
=SED s\/\1\/<\&>\//

s/^TRY *\([^ ]*\) *\([^ <>]*\) */=IN \2\
=OUT \2\
=SED s\/\1\/<\&>\//

s/^FAIL *\([^ ]*\) */=FAIL \/\1\/d/

