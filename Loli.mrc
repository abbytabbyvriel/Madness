on $*:TEXT:/^[.](loli)/Si:#: {
  if ($2 == $null) {
    if ($($+(%,loli,.,$nick,.,timer),2) != $date) {
      var %loli $rand(1, 10)
      if (%loli >= 5) {
        var %newloli $calc($($+(%,loli,.,$nick),2) + 1)
        set $+(%,loli,.,$nick) %newloli
        msg $chan Good job, $nick $+ ! You got one loli! Now you have $($+(%,loli,.,$nick),2) $+ !
        set $+(%,loli,.,$nick,.,timer) $date
      }
      if (%loli == 4) {
        var %newloli $calc($($+(%,loli,.,$nick),2) + 2)
        set $+(%,loli,.,$nick) %newloli
        msg $chan Good job, $nick $+ ! You got 2 loli! Now you have $(%newloli) $+ !
        set $+(%,loli,.,$nick,.,timer) $date
      }
      if (%loli == 3) {
        var %newloli $calc($($+(%,loli,.,$nick),2) + 5)
        set $+(%,loli,.,$nick) %newloli
        msg $chan CONGRATULATIONS, $nick $+ ! You got /5/ loli today! You now have $(%newloli) $+ !
        set $+(%,loli,.,$nick,.,timer) true
      }
      if (%loli == 2) {
        var %newloli $calc($($+(%,loli,.,$nick),2) - 1)
        set $+(%,loli,.,$nick) %newloli
        msg $chan Sorry, $nick $+ ! But you just lost a loli. You now have $(%newloli) $+ .
        set $+(%,loli,.,$nick,.,timer) $date
      }
      if (%loli == 1) {
        msg $chan No loli today for $nick $+ ! ;D
        set $+(%,loli,.,$nick,.,timer) $date
      }
    }
    else {
      msg $chan $nick $+ , I already gave you loli today, you greedy whore!
    }
  }
  else {
    if ($($+(%,loli,.,$2),2) != $null) {
      msg $chan $2 has $($+(%,loli,.,$2),2) loli!
    }
    else {
      msg $chan $2 has no loli...
    }
  }
}
