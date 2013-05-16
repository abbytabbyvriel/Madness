on $*:TEXT:/^[.](loadmod)/Si:#: {
  var %loadcmd load -rs
  if ($($+(%,access,.,$nick),2) > 2) {
    if ($2 == Misc) {
      if !$script(Misc.mrc) {
        msg $chan Misc module has been loaded!
        $(%loadcmd) Z:/home/tanmay/Madness/Misc.mrc
      }
      else {
        msg $chan Misc module is already loaded!
      }
    }
    if ($2 == Facts) {
      if !$script(Facts.mrc) {
        msg $chan Facts module has been loaded!
        $(%loadcmd) Z:/home/tanmay/Madness/Facts.mrc
      }
      else {
        msg $chan Facts module is already loaded!
      }
    }
    if ($2 == Admin) {
      if !$script(Admin.mrc) {
        msg $chan Admin has been loaded!
        $(%loadcmd) Z:/home/tanmay/Madness/Admin.mrc
      }
      else {
        msg $chan Admin module has been loaded!
      }
    }
    if ($2 == YouTube) {
      if !$script(YouTube.mrc) {
        msg $chan YouTube module has been loaded!
        $(%loadcmd) Z:/home/tanmay/Madness/YouTube.mrc
      }
      else {
        msg $chan YouTube module is already loaded!
      }
    }
    if ($2 == Wolfram) {
      if !$script(Wolfram.mrc) {
        msg $chan Wolfram module has been loaded!
        load -rs Z:/home/tanmay/Madness/Wolfram.mrc
      }
      else {
        msg $chan Wolfram module is already loaded!
      }
    }
    if ($2 == 8ball) {
      if !$script(8ball.mrc) {
        msg $chan 8ball module has been loaded!
        load -rs Z:/home/tanmay/Madness/8ball.mrc
      }
      else {
        msg $chan 8ball module is already loaded!
      }
    }
    if ($2 == Loli) {
      if !$script(Loli.mrc) {
        msg $chan Loli module has been loaded!
        $(%loadcmd) Z:/home/tanmay/Madness/Loli.mrc
      }
      else {
        msg $chan Loli module is already loaded!
      }
    }
    if ($2 == AntiSpam) {
      if !$script(spam.mrc) {
        if !$script(floodamount.mrc) {
          msg $chan Antispam module has been loaded!
          $(%loadcmd) Z:/home/tanmay/Madness/spam.mrc
          $(%loadcmd) Z:/home/tanmay/Madness/flooadamount.mrc
        }
      }
      else {
        msg $chan Antispam module is already loaded!
      }
    }
    if ($2 == XOP) {
      if !$script(XOP.mrc) {
        msg $chan XOP module has been loaded!
        $(%loadcmd) Z:/home/tanmay/Madness/XOP.mrc
      }
      else {
        msg $chan XOP module is not loaded!
      }
    }
  }
  else {
    msg $chan Permission denied.
  }
}
on $*:TEXT:/^[.](unloadmod)/Si:#: {
  var %loadcmd unload -rs
  if ($($+(%,access,.,$nick),2) > 2) {
    if ($2 == Misc) {
      if $script(Misc.mrc) {
        msg $chan Misc module has been unloaded!
        $(%loadcmd) Z:/home/tanmay/Madness/Misc.mrc
      }
      else {
        msg $chan Misc module is not loaded!
      }
    }
    if ($2 == Facts) {
      if $script(Facts.mrc) {
        msg $chan Facts module has been unloaded!
        $(%loadcmd) Z:/home/tanmay/Madness/Facts.mrc
      }
      else {
        msg $chan Facts module is not loaded!
      }
    }
    if ($2 == Admin) {
      if $script(Admin.mrc) {
        msg $chan Admin has been unloaded!
        $(%loadcmd) Z:/home/tanmay/Madness/Admin.mrc
      }
      else {
        msg $chan Admin module is not loaded!
      }
    }
    if ($2 == YouTube) {
      if $script(YouTube.mrc) {
        msg $chan YouTube module has been unloaded!
        $(%loadcmd) Z:/home/tanmay/Madness/YouTube.mrc
      }
      else {
        msg $chan YouTube module is not loaded!
      }
    }
    if ($2 == Loli) {
      if $script(Loli.mrc) {
        msg $chan Loli module has been unloaded!
        $(%loadcmd) Z:/home/tanmay/Madness/Loli.mrc
      }
      else {
        msg $chan Loli module is not loaded!
      }
    }
    if ($2 == Wolfram) {
      if $script(Wolfram.mrc) {
        msg $chan Wolfram module has been unloaded!
        $(%loadmod) Wolfram.mrc
      }
      else {
        msg $chan Wolfram module is not loaded!
      }
    }
    if ($2 == 8ball) {
      if $script(8ball.mrc) {
        msg $chan 8ball module has been unloaded!
        $(%loadmod) 8ball.mrc
      }
      else {
        msg $chan 8ball module is not loaded!
      }
    }
    if ($2 == AntiSpam) {
      if $script(spam.mrc) {
        if !$script(floodamount.mrc) {
          msg $chan Antispam module has been unloaded!
          $(%loadcmd) Z:/home/tanmay/Madness/spam.mrc
          $(%loadcmd) Z:/home/tanmay/Madness/flooadamount.mrc
        }
      }
      else {
        msg $chan Antispam module is not loaded!
      }
    }
    if ($2 == XOP) {
      if $script(XOP.mrc) {
        msg $chan XOP module has been unloaded.
        $(%loadcmd) Z:/home/tanmay/Madness/XOP.mrc
      }
      else {
        msg $chan XOP module is not loaded!
      }
    }
  }
  else {
    msg $chan Permission denied.
  }
}
