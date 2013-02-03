# this does certainly exist already, but just for fun here is the
# lousy man to HTML convertor in sed.

1i\
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"\
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">\
<html xmlns="http://www.w3.org/1999/xhtml">\
<head><meta name="generator" content="man2html.sed" />


# macro definition
/^\.de/,/^\.\./d

s/&/&amp;/g
s/</\&lt;/g
s/>/\&gt;/g

# character entities
# \| - small space, \& - no wide space ?
s/\\|//g
s/\\&amp;//g
s/\\-/-/g
# \  - space
s/\\ /\&nbsp;/g
# \e - backslash
s/\\e/\\/g

s/ *$//

s/~/~a/g
s/_/~b/g
s/!/~c/g
s/^\./_/

# get parser state from the hold buffer
G
s/\(.*\)\n\(.*\)/!\2 \1/


s/! _TH  *\([^ ]*\) .*/<title>\1<\/title><\/head><body>! /

# .B, .I
s/_B \(.*\)/<b>\1<\/b>/
s/_I \(.*\)/<i>\1<\/i>/

# .BI .BR .RB .RI .IB .IR
:loop
s/_BR \([^" ][^ ]*\)/<b>\1<\/b>_RB/
s/_BI \([^" ][^ ]*\)/<b>\1<\/b>_IB/
s/_IR \([^" ][^ ]*\)/<i>\1<\/i>_RI/
s/_IB \([^" ][^ ]*\)/<i>\1<\/i>_BI/
s/_RI \([^" ][^ ]*\)/\1_IR/
s/_RB \([^" ][^ ]*\)/\1_BR/
s/_BR "\([^"]*\)"/<b>\1<\/b>_RB/
s/_BI "\([^"]*\)"/<b>\1<\/b>_IB/
s/_IR "\([^"]*\)"/<i>\1<\/i>_RI/
s/_IB "\([^"]*\)"/<i>\1<\/i>_BI/
s/_RI "\([^"]*\)"/\1_IR/
s/_RB "\([^"]*\)"/\1_BR/
s/_[BRI][BRI] *$//
/_[BRI][BRI]/b loop

# states: 
# a after <blockquote> .SH
# b after <p> .P
# c after <dl> .TP
# d after <dt> .TP
# e after <dd> .TP
# f after .RS
# g after <ul><li>

:l

# .SH
s/!e\([^ ]* _SH\)/<\/dd>!\1/
s/!c\([^ ]* _SH\)/<\/dl>!\1/
s/!b\([^ ]* _SH\)/<\/p>!\1/
s/!a\( _SH\)/<\/blockquote>!\1/
s/! _SH \(.*\)/<h2>\1<\/h2><blockquote>!a /

# .SS
s/!e\([^ ]* _SS\)/<\/dd>!\1/
s/!c\([^ ]* _SS\)/<\/dl>!\1/
s/!b\([^ ]* _SS\)/<\/p>!\1/
s/!a\( _SS\)/<\/blockquote>!\1/
s/! _SS \(.*\)/<h3>\1<\/h3><blockquote>!a /


# no macro
s/\(!g[^ ]* \)\([^_].*\)/\2\1/
s/\(!e[^ ]* \)\([^_].*\)/\2\1/
s/!d\([^ ]* \)\([^_].*\)/\2!D\1/
s/!\(c[^ ]* \)\([^_].*\)/<dt>\2!d\1/
s/\(!b[^ ]* \)\([^_].*\)/\2\1/
s/!\(a [^_]\)/<p>!b\1/

# .P
s/!g\([^ ]* _P\)$/<\/li><\/ul>!\1/
s/!e\([^ ]* _P\)$/<\/dd>!\1/
s/!c\([^ ]* _P\)$/<\/dl>!\1/
s/!b\([^ ]* \)_P$/<\/p>!\1/
s/!\(a \)_P$/<p>!b\1/
s/!\(f[^ ]* \)_P$/<p>!b\1/

# .IP

s/!\(e[^ ]* *\)_IP.*/<br \/>!\1/
s/!\(b[^ ]* \)_IP \\(bu.*/<\/p><ul><li>!g\1/
s/!a _IP \\(bu.*/<ul><li>!ga /
s/!\(g[^ ]* \)_IP \\(bu.*/<\/li><li>!\1/
s/!\(b[^ ]* \)_IP.*/<\/p><p>!\1/

# .RS .RE
#s/!\([^ ]* \)_RS/<blockquote>!f\1/
#s/!ecf\([^ ]* \)_RE/<\/dd><\/dl><\/blockquote>!\1/
#s/!bf\([^ ]* \)_RE/<\/p><\/blockquote>!\1/

s/!\([^ ]* \)_RS/!f\1/
s/!ecf\([^ ]* \)_RE/<\/dd><\/dl>!\1/
s/!bf\([^ ]* \)_RE/<\/p>!\1/


# .TP
s/!e\([^ ]* \)_TP$/<\/dd><dt>!d\1/
s/!b\([^ ]* \)_TP$/<\/p><dl><dt>!dc\1/
s/!a _TP$/<dl><dt>!dca /
s/!\(f[^ ]* \)_TP$/<dl><dt>!dc\1/

# .TQ (not handled currently)
s/!D\([^ ]* \)_TQ$/<br \/>!d\1/
s/^!D/<\/dt><dd>!e/

# end of file
$s/!b\([^ ]* \)$/<\/p>!\1/
$s/!a $/<\/blockquote><\/body><\/html>!/

/![^ ]* $/!t l

h
s/[^!]*!\([^ ]*\) /\1/
/[ _]/{
  x
  q
}
x
s/!.*//


s/~c/!/g
s/~b/_/g
s/~a/~/g

s/<b>/&<code>/g
s/<\/b>/<\/code>&/g

