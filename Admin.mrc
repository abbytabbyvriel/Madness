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
      var %command $+(alias.,$remove($1, !))
      set %alias. $+ $remove($1, !) set
      alias alias. $+ $remove($1, !) $2-
      notice $nick $1 has been set to $2-
    }
    else {
      alias. $+ $remove($1, !)
    }
  }
  else {
    alias. $+ $remove($1, !)
  }
}
