on $*:TEXT:/^[@](ass)/Si:#: {
  if (!$2) {
    var %number $rand(1, %asses)
    msg $chan [NSFW] $($+(%,ass,.,%number),2) ( $+ $($+(%,ass,.,%number,.,likes),2) likes) ASS $chr(35) $+ $(%number)
  }
  else {
    msg $chan [NSFW] $($+(%,ass,.,$2),2) ( $+ $($+(%,ass,.,$2,.,likes),2) likes)
  }
}
on $*:TEXT:/^[@](addass)/Si:#: {
  if ($($+(%,access,.,$nick),2) > 1) {
    if ($2) {
      notice $nick Ass " $+ $2 $+ " added.
      var %ass $calc(%asses + 1)
      set %asses %ass
      set $+(%,ass,.,%ass) $2
      set $+(%,ass,.,%ass,.,likes) 0
    }
    else {
      notice $nick Usage: @addass <ass image url>
    }
  }
  else {
    notice $nick Permission denied.
  }
}
on $*:TEXT:/^[@](likedatass)/Si:#: {
  if ($2) {
    if ($($+(%,ass,.,$2,.,liked,.,$nick),2) == $null) {
      if ($2 <= %asses) {
        notice $nick You successfully voted for dat ass.
        inc $+(%,ass,.,$2,.,likes)
        set $+(%,ass,.,$2,.,liked,.,$nick) true
      }
      else {
        notice $nick Sorry, I can't find dat ass.
      }
    }
    else {
      notice $nick  Sorry, you already liked for dat ass.
    }
  }
  else {
    notice $nick Usage: @likedatass (number)
  }
}
