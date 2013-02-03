
1i\
<html><head>\
<script src="jsed.js">\
</script>\
</head><body>\
<script>\
var npassed=0;\
var nfailed=0;\
function pr(s)\
{\
  s = s.replace(/&/g, "&amp;");\
  s = s.replace(/</g, "&lt;");\
  s = s.replace(/>/g, "&gt;");\
  s = s.replace(/\\n$/, "");\
  s = s.replace(/\\n/g, "<br>   ");\
  s = s.replace(/ /g, "&nbsp;");\
  document.write("<br><code>&nbsp;&nbsp;&nbsp;"+s+"</code><br>");\
}\
var outstr;\
var errstr;\
function out(s) { outstr += s; }\
function err(s) { errstr += s; }\
function test_sed()\
{\
  outstr = errstr = "";\
  sed.out = out;\
  sed.err = err;\
  sed.nflag = false;\
  sed.pflag = true;\
  sed(SED.replace(/\\n$/,""), IN.replace(/\\n$/,""));\
  npassed++;\
  if (outstr != OUT || errstr != "") {\
    document.write("<p>executing:");\
    pr(SED);\
    document.write("on input:");\
    pr(IN);\
    if (errstr != "") {\
      document.write("gave the following error:");\
      pr(errstr);\
      if (outstr != OUT) document.write("and ");\
    }\
    if (outstr != OUT) {\
      if (outstr == "") {\
        document.write("gave no output ");\
      } else {\
        document.write("gave output:");\
        pr(outstr);\
      }\
      if (OUT == "") {\
        document.write("but none was expected.");\
      } else {\
        document.write("instead of the following output:");\
        pr(OUT);\
      }\
    }\
    document.write("</p>");\
    nfailed++;\
  }\
}\
function test_fail()\
{\
  outstr = errstr = "";\
  sed(FAIL.replace(/\\n$/,""), "foo");\
  npassed++;\
  if (errstr == "") {\
    document.write("<p>executing:");\
    pr(FAIL);\
    document.write("didn\\'t fail as expected.</p>");\
    nfailed++;\
  }\
}

$a\
document.write("<p>" + nfailed + " / " + npassed);\
document.write(" tests failed.</p>");\
</script>\
</body></html>


/^%/d

s/[\\"$']/\\&/g

x
/./p
s/.*//
x

/^=SED/{
  h
  s/.*/test_sed();/
  x
}
/^=FAIL/{
  h
  s/.*/test_fail();/
  x
}
/^=[A-Z][A-Z]* *$/{
  N
  /\n\. *$/b a
  /\n=/{
    :a
    s/^=\([A-Z][A-Z]*\) */\1 = "";/
    P
    D
  }
  s/[\\"$']/\\&/g
  s/^=\([A-Z][A-Z]*\) *\n\(.*\)/\1 = "\2\\n"/
  :loop
  N
  /\n\. *$/b b
  /\n=/{
    :b
    s/\n/;&/
    P
    D
  }
  P
  s/.*\n//
  s/[\\"$']/\\&/g
  s/.*/  + "&\\n"/
  b loop
}
s/^=\([A-Z][A-Z]*\) *\([^ ].*\)/\1 = "\2\\n";/p

d


