on $*:TEXT:/^[.!@?]/Si:#: { 
  if ($($+(%,access,.,$nick),2) < 1) {
    if ($($+(%,spam,.,$nick),2) != $null) { 
      if ($($+(%,spam,.,$nick),2) !> 5) {
        inc $+(%,spam,.,$nick)
        .timer 1 30 unset $+(%,spam,.,$nick)
      }
      else {
        notice $nick You have done 5 commands in 30 seconds, you will be put on ignore for 5 minutes.
        ignore -u300 $address($nick, 2)
      }
    }
    else {
      set $+(%,spam,.,$nick) 1
    }
  }
}
