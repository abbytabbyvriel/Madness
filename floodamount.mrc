on *:TEXT:.floodamount*:#: {
  if ($2 isnum) {
    if (s isin $3) {
      if ($nick isop $chan) { var %rems $remove($3, s)
        set $+(%,floodkick,.,$chan) $2
        set $+(%,floodsec,.,$chan) $(%rems) 
        msg $chan I will now kick if a person says $2 lines in $(%rems) seconds.
      }
      else {
        notice $nick Permission denied.
      }
    }
    else {
      notice $nick Example: .floodamount 10 5s
    }
  }
  else {
    notice $nick Example: .floodamount 10 5s
  }
}
