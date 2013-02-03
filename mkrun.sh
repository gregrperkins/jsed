#! /bin/sh

#usage: mkrun SCRIPTNAME SCRIPTURL SCRIPTPATH INPUTPATH

s='s/[\\"$'\''/]/\\&/g'
scriptname=`echo "$1" | sed "$s"`
scripturl=`echo "$2" | sed "$s"`
scriptpath="$3"
inputpath="$4"

sed '
  s/[\\"$'\'']/\\&/g
  s/.*/"&\\n"/
  $!s/$/ + /
  $s/$/;/
' "$scriptpath" > s

case "x$inputpath" in
  x) foo='s/INPUT/""/' ;;
  *) sed '
      s/[\\"$'\'']/\\&/g
      s/.*/"&\\n"/
      $!s/$/ + /
      $s/$/;/
    ' "$inputpath" > i
    foo='/INPUT;/{s///
      r i
    }'
    ;;
esac

sed '
  s/SCRIPTURL/'"$scripturl"'/g
  s/SCRIPTNAME/'"$scriptname"'/g
  /SCRIPT;/{
    s///
    r s
  }
  '"$foo" run.in

rm -f s i
