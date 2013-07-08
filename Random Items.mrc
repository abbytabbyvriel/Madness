on *:TEXT:.additem *:#: {
  if ($($+(%,access,.,$nick),2) > 2) {
    if ($2 != $null) {
      if ($3 != $null) {
        var %item $calc(%items + 1)
        set %items $(%item)
        set $+(%,items,.,%item) $3-
        msg $chan Item $2 added.
      }
      else {
        notice $nick Incorrect parameters.
      }
    }
    else {
      notice $nick Incorrect parameters.
    }
  }
  else {
    notice $nick Permission denied.
  }
}
