on $*:TEXT:/^[@](boobs)/Si:#: {
  if (!$2) {
    var %number $rand(1, %boobs)
    msg $chan [NSFW] $($+(%,boobs,.,%number),2) ( $+ $($+(%,boobs,.,%number,.,likes),2) likes) BOOBS $chr(35) $+ $(%number)
  }
  else {
    msg $chan [NSFW] $($+(%,boobs,.,$2),2) ( $+ $($+(%,boobs,.,$2,.,likes),2) likes)
  }
}
on $*:TEXT:/^[@](addboobs)/Si:#: {
  if ($($+(%,access,.,$nick),2) > 1) {
    if ($2) {
      notice $nick Boobs " $+ $2 $+ " added.
      var %boobies $calc(%boobs + 1)
      set %boobs %boobies
      set $+(%,boobs,.,%boobs) $2
      set $+(%,boobs,.,%boobs,.,likes) 0
    }
    else {
      notice $nick Usage: @addboobs <boobs image url>
    }
  }
  else {
    notice $nick Permission denied.
  }
}
on $*:TEXT:/^[@](likedemboobs)/Si:#: {
  if ($2) {
    if ($($+(%,boobs,.,$2,.,liked,.,$nick),2) == $null) {
      if ($2 <= %boobs) {
        notice $nick You successfully voted for dem boobs.
        inc $+(%,boobs,.,$2,.,likes)
        set $+(%,boobs,.,$2,.,liked,.,$nick) true
      }
      else {
        notice $nick Sorry, I can't find dat ass.
      }
    }
    else {
      notice $nick  Sorry, you already liked for dem boobs.
    }
  }
  else {
    notice $nick Usage: @likedemboobs (number)
  }
}
