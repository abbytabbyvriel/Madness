
on *:TEXT:*:#: {
  ;  if ($1 == .addop) {
  ;    if ($nick == %botowner) {
  ;      msg $chan $nick has set $2 as a bot operator!
  ;      set $+(%,$2,.,access) 2
  ;    }
  ; }
  ;  if ($1 == .remop) {
  ;    if ($nick == %botowner) {
  ;      msg $chan Sorry, $2 but $nick removed you from the bot operator list!
  ;      unset $+(%,$2,.access)
  ;    }
  ;  }
  if ($1 == .factadd) {
    if ($2 == $null) {
      msg $chan You must enter a name for the fact!
    }
    else {
      if ($3 == $null) {
        msg $chan You must enter a definition for ' $+ $2 $+ '!
      }
      else {
        if ($($+(%,fact,.,$2),2) != $null) {
          msg $chan That fact already exists!
        }
        else {
          if ($($+(%,fact,.,$2,.,lock),2) != true) {
            set $+(%,fact,.,$2) $3-
            msg $chan Fact set successfully!
            set $+(%,fact,.,$2,.,date) $time on $date
          }
          else {
            msg $chan Sorry, that fact is locked.
          }
        }
      }
    }
  }
  if ($1 == .factlock) {
    if ($($+(%,$nick,.,access),2) => 2) {
      set $+(%,fact,.,$2,.,lock) true
      msg $chan Fact ' $+ $2 $+ ' locked successfully.
    }
  }

  if ($1 == .fact) {
    if ($2 == $null) {
      msg $chan Please specify a fact!
    }
    else {
      if ($($+(%,fact,.,$2),2) == $null) {
        msg $chan That fact does not exist!
      }
      else {
        msg $chan $($+(%,fact,.,$2),2)
      }
    }
  }
  if ($1 == .factchange) {
    if ($2 == $null) {
      msg $chan Please specify the fact you want to change!
    }
    else {
      if ($($+(%,fact,.,$2),2) == $null) {
        msg $chan That fact does not exist!
      }
      else {
        if ($3 == $null) {
          msg $chan Please specify what you want to change ' $+ $2 $+ ' to!
        }
        else {
          if ($($+(%,fact,.,$2,.,lock),2) != true) {
            set $+(%,fact,.,$2) $3-
            msg $chan Fact successfully changed!
            set $+(%,fact,.,$2,.,dt) $time on $date
            set $+(%,fact,.,$2,.,$nick) $nick
          }
          else {
            if ($($+(%,$nick,.,access),2) => 2) {
              msg $chan Sorry, ' $+ $2 $+ ' has been locked by a bot operator.
            }
            else {
              set $+(%,fact,.,$2) $3-
              msg $chan Fact successfully changed!
              set $+(%,fact,.,$2,.,dt) $time on $date
              set $+(%,fact,.,$2,.,nick) $nick
            }
          }
        }
      }
    }
  }
  if ($1 == .factremove) {
    if ($($+(%,$nick,.,access),2) =>) {
      msg $chan You must be a bot operator!
    }
    else {
      if ($2 == $null) {
        msg $chan Please specify the fact you would like to remove!
      }
      else {
        if ($($+(%,fact,.,$2),2) == $null) {
          msg $chan That fact doesn't exist!
        }
        else {
          msg $chan Fact ' $+ $2 $+ ' successfully removed!
          unset $+(%,fact,.,$2)
        }
      }
    }
  }
  if ($1 == .factinfo) {
    if ($2 != $null) {
      if ($($+(%,fact,.,$2),2) != $null) {
        if ($($+(%,fact,.,$2,.,lock),2) != true) {
          msg $chan Fact ' $+ $2 $+ ' was set by $($+(%,fact,.,$2,.,nick),2) at $($+(%,fact,.,$2,.,dt),2) $+ .
        }
        else {
          msg $chan Fact ' $+ $2 $+ ' was set by $($+(%,fact,.,$2,.,nick),2) at $($+(%,fact,.,$2,.,dt,2) $+ . This fact has been locked by a bot operator.
        }
        else { msg $chan That fact doesn't exist! }
        else { msg $chan You must specify a fact!
        }
      }
    }
  }
}
