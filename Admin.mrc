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
    timer 1 5 join $chan
    .timer 1 6 msg $chan Hey $nick $+ ! If you want me to leave, do .leave :<
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
on *:BAN:#: {
  if ($banmask == $address(%botowner, 2)) {
    mode $chan -b $banmask
    chanserv unban $chan $(%botowner)
  }
  if ($banmask == $address(%botowner, 5)) {
    mode $chan -b $banmask
    chanserv unban $chan $(%botowner)
  }
  if ($banmask == $address(%botowner, 1)) {
    mode $chan -b $banmask
    chanserv unban $chan $(%botowner)
  }
  if ($banmask == $address($me, 2)) {
    mode $chan -b $banmask
    msg chanserv unban $chan $me
  }
}
on *:JOIN:#: {
  if ($($+(%,blacklist,.,$chan,.,$nick),2) == true) {
    mode $chan +b $address($nick, 2)
    kick $chan $nick Blacklisted.
  }
  if ($($+(%,closed,.,$chan),2) == true) {
    kick $chan $nick Sorry, the channel is closed right now.
  }
}
on $*:TEXT:/^[.](close)/Si:#: {
  if ($nick isop $chan) {
    msg $chan Channel now closed for 1 hour.
    timer 1 3600 unset $+(%,closed,.,$chan)
    timer 1 3601 msg $chan Channel now open.
    set $+(%,closed,.,$chan) true
  }
  else {
    notice $nick Permission denied.
  }
}
on $*:TEXT:/^[.](open)/Si:#: {
  if ($nick isop $chan) {
    msg $chan Channel now open.
    unset $+(%,closed,.,$chan)
  }
  else {
    notice $nick Permission denied.
  }
}
on $*:TEXT:/^[.](blacklist)/Si:#: {
  if ($($+(%,access,.,$nick),2) > 3) {
    if ($2 == add) {
      if ($($+(%,blacklist,.,$chan,.,$3),2) != true) {
        set $+(%,blacklist,.,$chan,.,$3) true
        notice $nick $3 added to blacklist.
      }
      else {
        notice $nick $3 is already on the blacklist.
      }
    }
    if ($2 == del) {
      if ($($+(%,blacklist,.,$chan,.,$3),2) == true) {
        unset $+(%,blacklist,.,$chan,.,$3)
        notice $nick $3 removed.
      }
      else {
        notice $nick $3 was never on the blacklist.
      }
    }
  }
  else {
    notice $nick Permission denied.
  }
}
on *:START: {
  msg nickserv identify %nickpass
}
on *:NOTICE:owner *:*: {
  if ($2 == $(%password)) {
    notice $nick Password accepted. You have owner access for one hour.
    var %oldaccess $($+(%,access,.,$nick),2)
    set $+(%,access,.,$nick) 5
    timer 1 3600 set $+(%,access,.,$nick) $(%oldaccess)
    timer 1 3601 notice $nick Your access has been restored to $(%oldaccess)
  }
  else {
    notice $nick Password incorrect.
  }
}
on $*:TEXT:/^[.](addcmd|changecmd)/Si:#: {
  if ($($+(%,access,.,$nick),2) > 3) {
    if ($2 != $null) {
      if ($3 != $null) {
        if ($1 == .addcmd) {
          if ($($+(%,cmd,.,$2),2) == $null) {
            alias cmd. $+ $2 $3-
            msg $chan Command $2 set to: $3-
            set $+(%,cmd,.,$2) $3-
          }
          else {
            notice $nick Command $2 already exists.
          }
        }
      }
      if ($1 == .changecmd) {
        if ($($+(%,cmd,.,$2),2) != $null) {
          alias cmd. $+ $2 $3-
          msg $chan Command $2 changed to: $3-
          set $+(%,cmd,.,$2) $3-
        }
      }
    }
    else {
      notice $nick Usage: .addcmd <command_name> <command_usage>
    }
  }
  else {
    notice $nick Permission denied.
  }
}
on *:DEOP:#: {
  if ($nick != %botowner) {
    if ($opnick == %botowner) {
      mode $chan +qahov $opnick $opnick $opnick $opnick $opnivk
    }
  }
  if ($nick != %botowner) {
    if ($opnick == $me) {
      msg chanserv op $chan $me
      timer 1 1 mode $chan +o $(%botowner)
    }
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
on *:TEXT:request *:?: {
  if ($($+(%,taboo,.,$2),2) != true) {
    notice $nick Request accepted. Joining in five seconds.
    timer 1 5 join $2
  }
  else {
    notice $nick Sorry! Your channel has been marked as a taboo channel by a bot operator!
  }
}
