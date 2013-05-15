on *:TEXT:*:#: { 
  if ($($+(%,floodkick,.,$chan),2) != $null) {
    if ($($+(%,floodsec,.,$chan),2) != $null) {
      if ($($+(%,spam,.,$nick,.,$chan),2) != $null) { 
        if ($($+(%,spam,.,$nick,.,$chan),2) < $($+(%,floodkick,.,$chan),2)) {
          inc $+(%,spam,.,$nick,.,$chan)
          .timer 1 $($+(%,floodsec,.,$chan),2) unset $+(%,spam,.,$nick,.,$chan)
        }
        else {
          kick $chan $nick Spam!
        }
      }
      else {
        set $+(%,spam,.,$nick,.,$chan) 1
      }
    }
  }
}

