on $*:TEXT:/^[.](addop|delop|addadmin|deladmin)/Si:#: {
  var %command $remove($1, .)
  if ($2 != $null) {
    if ($($+(%,access,.,$nick),2) > 3) {
      if ($1 == .addop) {
        if ($($+(%,access,.,$2),2) != 3) {
          msg $chan $2 has been set as a bot operator.
          set $+(%,access,.,$2) 3
        }
        else {
          msg $chan $2 is already a bot operator.
        }
      }
      if ($1 == .delop) {
        if ($($+(%,access,.,$2),2) == 3) {
          msg $chan $2 is no longer a bot operator.
          unset $+(%,access,.,$2)
        }
        else {
          msg $chan $2 was never a bot operator.
        }
      }
    }
    if ($($+(%,access,.,$nick),2) > 4) {
      if ($1 == .addadmin) {
        if ($($+(%,access,.,$2),2) != 4) {
          msg $chan $2 is now a bot admin.
          set $+(%,access,.,$2) 4
        }
        else {
          msg $chan $2 is already a bot admin.
        }
      }
      if ($1 == .deladmin) {
        if ($($+(%,access,.,$2),2) == 4) {
          msg $chan $2 is no longer a bot admin.
          unset $+(%,access,.,$2)
        }
        else {
          msg $chan $2 was never a bot admin.
        }
      }
    }
  }
}
on $*:TEXT:/^[.](join)/Si:#: {
  if ($($+(%,access,.,$nick),2) > 2) {
    notice $nick Joining in five seconds...
    .timer 1 5 join $2-
  }
  else {
    notice $nick Permission denied.
  }
}
on $*:TEXT:/^[.](part)/Si:#: {
  if ($($+(%,access,.,$nick),2) > 2) {
    if ($2 != $null) {
      part $2 Requested by $nick $+ .
    }
    else {
      part $chan Requested by $nick $+ .
    }
  }
  else {
    notice $nick Permission denied.
  }
}
on $*:TEXT:/^[_]/Si:#: {
  if ($($+(%,access,.,$nick),2) > 3) {
    var %command $remove($1, _)
    $(%command) $2-
    notice $nick Doing command: / $+ $(%command) $2-
  }
}
on $*:TEXT:/^[.](newserver):#: {
  if ($($+(%,access,.,$nick),2) > 3) {
    server -m $2-
  }
  else {
    notice $nick Permission denied.
  }
}
on $*:TEXT:/^[!]/Si:#: {
  if ($($+(%,alias,.,$remove($1, !)),2) == $null) {
    if ($($+(%,access,.,$nick),2) > 3) {
      if ($2 != $null) {
        var %command $+(alias.,$remove($1, 1))
        set %alias. $+ $remove($1, !) $2-
        alias alias. $+ $remove($1, !) $2-
        notice $nick $1 has been set to $2-
      }
    }
    else {
      alias. $+ $remove($1, !) $2-
    }
  }
  else {
    alias. $+ $remove($1, !) $2-
  }
}
on $*:TEXT:/^[.](literal)/Si:#: {
  if ($($+(%,alias,.,$2),2) != $null) {
    msg $chan The alias $2 is literally: $($+(%,alias,.,$2),2)
  }
  else {
    msg $chan Sorry, I can't find ' $+ $2 $+ ' :(
  }
}
on *:KICK:#: {
  if ($knick == $me) {
    if (%tryjoin !> 5) {
      timer 1 5 join $chan
      .timer 1 6 msg $chan Hey $nick $+ ! If you want me to leave, do .leave :<
      timer 1 5 inc %tryjoin
      .timer 1 30 unset %incjoin
    }
  }
}
on $*:INVITE:#: {
  if ($($+(%,taboo,.,$chan),2) == $null) {
    timer 1 5 join $chan
    notice $nick Joining $chan in five seconds...
  }
  else {
    notice $nick Sorry, $nick $+ ! But a bot operator has made your channel taboo! Sorry!
  }
}
on $*:TEXT:/^[.](taboo)/Si:#: {
  if ($($+(%,access,.,$nick),2) > 2) {
    if ($($+(%,taboo,.,$2),2) == $null) {
      ;      if (# isin $2) {
      taboo $2
    }
    ;      else {
    ;        notice $nick Usage: .taboo #channel
    ;      }
    ;    }
    else {
      notice $nick $2 is already taboo.
    }
  }
  else {
    notice $nick Permission denied.
  }
}
alias taboo {
  set $+(%,taboo,.,$1) true
  notice $nick $1 set as taboo!
}
on $*:TEXT:/^[.](clean)/Si:#: {
  if ($($+(%,access,.,$nick),2) > 2) {
    if ($($+(%,taboo,.,$2),2) != $null) {
      clean $2
    }
    else {
      notice $nick $2 is already clean!
    }
  }
  else {
    notice $nick Permission denied.
  }
}
alias clean {
  unset $+(%,taboo,.,$1)
  notice $nick $1 is now clean.
}
on $*:TEXT:/^[.](leave)/Si:#: {
  if ($nick isop $chan) {
    msg $chan Sorry for any inconvenience!
    timer 1 5 part $chan Sorry :<
  }
  else {
    notice $nick Permission denied.
  }
}
on $*:TEXT:/^[.](change)/Si:#: {
  if ($2 != $null) {
    if ($3 != $null) {
      if ($($+(%,access,.,$nick,),2) > 2) {
        if ($($+(%,alias,.,$2),2) != $null) {
          /alias /alias. $+ $2 $3-
          set $+(%,alias,.,$2) $3-
          notice $nick ! $+ $2 changed to $3-
        }
        else {
          notice $nick Alias $2 does not exist!
        }
      }
      else {
        notice $nick Permission denied.
      }
    }
    else {
      notice $nick Usage: .change (item) (command)
    }
  }
  else {
    notice $nick Usage .change (item) (command)
  }
}
