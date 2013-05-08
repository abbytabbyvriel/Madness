on *:TEXT:*:#: {
  if ($1 == .flood) {
    if ($($+(%,access,.,$nick),2) => 2) {
      timer 1 .2 msg $chan $2-
    }
  }
  if ($1 == .oper) {
    oper Madness %operpass
  }
  if ($1 == .r) {
    if ($2 != $null) {
      if ($3 != $null) {
        set %randnum $rand($2, $3)
        msg $chan $($+(%randnum),2) is a random number between $2 $+ - $+ $3
      }
    }
    else {
      set %randnum $rand(1, 100)
      msg $chan $($+(%randnum),2) is a random number between 1-100
    }
  }
  if ($1- == .turn up) {
    timer 1 .2 msg $chan TURN THE
    timer 1 .5 msg $chan FUCK UP
    timer 1 1 msg $chan NIGGA
  }
  if ($$1 == .drink) {
    describe $chan gives $nick a glass of $2-
  } 
  if ($$1 == .blunt) {
    describe $chan gives $nick a fat swisher with some dank-ass weed
  }
  if ($$1 == !k) {
    if ($nick isop $chan) {
      kick $chan $2-
    }
  }
  if ($$1 == .tacos) {
    msg $chan Don't look at me o.o Message Platanito if you want some.
  }
  if ($$1 == .do) {
    if ($nick == Tanmay) {
      $2-
    }
    else {
      notice $nick Permission denied.
    }
  }
  if ($$1 == .info) {
    notice $nick Hi! I'm a bot owned and coded by Tanmay.
    notice $nick The bot runs off of mIRC.
    notice $nick If you have any questions, do .submit (Question) and I'll get back to you ASAP! Thank you!
  }
  if ($$1 == .submit) {
    if ($2 != $null) {
      notice $nick Your submission has been accepted.
      msg MemoServ send Tanmay $nick says: " $+ $2- $+ "
    }
  }
  if ($$1 == .grape) {
    describe $chan grapes $2-
  }
  if ($$1 == .bewbs) {
    if ($($+(%,$chan,.,nsfw),2) == on) {
      msg $chan http://www.reddit.com/r/gonewild/
      msg $chan Don't cum on the screen plz
    }
    else {
      ping
    }
  }
  if ($1 == .nsfw) {
    if ($nick isop $chan) {
      set $+(%,$chan,.,nsfw) $iif($2 == on,on,off)
    }
  }



  if ($$1 == .fluff) {
    describe $chan fluffs up $2- :>
  }
  if ($$1 == .fluffme) {
    describe $chan fluffs $nick :>
  }
  if ($$1 == .stab) {
    describe $chan stabs $2- with a pearl knife >:D
  }
  if ($$1 == .glomp) {
    describe $chan glomps $2-
  }
  if ($$1 == trainz) {
    msg $chan HFS I LOVE TRAINZ
  }
  if ($$1 == Who are you?) {
    msg $chan It's a secret ;) (.info)
  }
  if ($$1 == .kiss) {
    describe $chan kisses $2- :3
  }
  if ($$1 == .fuck) {
    describe $chan fucks $2-
  }
  if ($$1 == .rape) {
    msg $chan Rape isn't funny >:|
  }
  if ($$1 == .hump) {
    describe $chan humps $2- slowly and cautiously
  }
  if ($$1 == .drug) {
    describe $chan gives $nick a gram of $2-
    msg $chan Listen, $nick $+ , whatever you do, you didn't get this from me.
  }
  if ($$1 == .hug) {
    describe $chan hugs $2- :>
  }
  if ($$1 == .id) {
    if ($($+(%,$nick,.,access),2) == op) {
      msg nickserv id %nickpass
    }
  }
  if ($$1 == .leave) {
    if ($nick isop $chan) {
      msg $chan I'm sorry for any inconvenience. Goodbye!
      part $chan Requested.
    }
    else {
      msg $chan You must be a channel operator to do this command.
    }
  }
  if ($$1 == .cum) {
    describe $chan cums $2-
  }
  if ($$1 == .jiakko) {
    msg $chan :> nuff said
  }
  if ($$1 == .say) {
    if ($nick == Tanmay) {
      msg $chan $2-
    }
  }
  if ($$1 == .describe) {
    if ($nick == Tanmay) {
      describe $chan $2- 
    }
  }
  if ($1- == .smoke maize) {
    if ($($+(%,maize,.,$nick),2) >= 1) {
      var %polees $rand(1, 100)
      if (%polees > 15) {
        var %newmaizebagz $calc($($+(%,maize,.,$nick),2) - 1)
        set $+(%,maize,.,$nick) %newmaizebagz
        timer 1 .5 describe $chan gets a bag of maize from $nick $+ 's cellar and hands it to $nick $+ .
        timer 1 .7 msg $chan Here you go, $nick $+ ! Now, you have $(%newmaizebagz) bags of maize.
      }
      else {
        msg $chan OH SHIT THE POLEES ARE HERE!
        msg $chan Fuck, $nick $+ . The polees took all your maize D:
        unset $+(%,maize,.,$nick)
      }
    }
    else {
      msg $chan You don't have any maize o_o Do .maize to get some!
    }
  }
  if ($$1 == .egg) {
  describe $chan gives $nick an egg :3 }
  if ($1- == I want some hoes!) {
    msg $chan http://backpage.com Use protection, $nick
  }
  if ($$1 == .maize) {
    if ($2 == $null) {
      var %maizebagz $rand(2, 100)
      var %newmaizebagz $calc($($+(%,maize,.,$nick),2) + $(%maizebagz))
      set $+(%,maize,.,$nick) %newmaizebagz
      describe $chan gives $nick $(%maizebagz) bags of maize for a total of $($+(%,maize,.,$nick),2) $+ .
    }
    else {
      if ($($+(%,maize,.,$2),2) != $null) {
        msg $chan $2 has $($+(%,maize,.,$2),2) bags of maize!
      }
      else {
        msg $chan $2 has no maize...
      }
    }
  }
  if ($1- == .so mad) {
    msg $chan SO MAD
    msg $chan SO FUCKING MAD
    msg $chan SO MAD
  }
  if ($$1 == .lick) {
    describe $chan licks $2
  }
  if ($$1 == .fap) {
    describe $chan faps $2-
  }
  if ($$1 == .hj) {
    describe $chan gives $2- a handjob
  }
  if ($$1 == .bj) {
    describe $chan gives $2- a blowjob and swallows
  }
  if ($$1 == .squirt) {
    describe $chan squirts all over $2-
  }
  if ($$1 == .anal) {
    describe $chan grabs $2- $+ 's dick and puts it in his anal port
  }
  if ($$1 == .dongs) {
    if ($chan == #Soldado) {
      msg $chan LOLDONGS
    }
  }
  if ($$1 == .french) {
    describe $chan slips his tongue into $2- $+ 's mouth ;)
  }
  if ($$1 == .hi5) {
    if ($2 = me) {
      describe $chan high fives $nick $+ ! :D
    }
    else {
      describe $chan high fives $2- $+ ! :D
    }
  }
  if ($$1 == .low5) {
    if ($2 == me) {
      msg $chan Too slow, $nick $+ !
    }
    else {
      msg $chan Too slow, $2- $+ !
    }
  }
  if ($$1 == .pounce) {
    describe $chan pounces $2- >:3
  }
  if ($$1 == .slap) {
    describe $chan slaps $2- >:|
  }
  if ($$1 == .fart) {
    describe $chan farts $2- :D
  }
  if ($$1 == .cheesecake) {
    describe $chan throws a cheesecake at $nick >:D
  }
  if ($$1 == .potato) {
    describe $chan throws a potato at $2-
  }
  if ($$1 == .sparta) {
    msg $chan THIS
    msg $chan IS
    msg $chan SPARTA!!!!!
  }
  if ($1 == based) {
    if ($2 == god) {
      msg $chan LIL B BASED GOD SWAG SWAG WOOP
    }
  }
  if ($1 == .base) {
    msg $chan Based God Approves
  }
  if ($$1 == .bitch) {
    describe $chan gives $nick two bitches :3
  }
  if ($$1 == ?) {
    if ($nick == Tanmay) {
      $2-
    }

  }
  if ($1 == .tempban) {
    if ($nick isop $chan) {
      mode $chan +b $2 $+ !*@*
      kick $chan $2 You have been kicked for $3 seconds.
      timer 1 $3 unban $chan $2 $+ !*@*
    }
  }
  if ($$1 == .boom) {
    msg $chan ALLAHU AKBAR
    part $chan BOOOOOOOM
    timer 1 10 join $chan
    timer 2 13 msg $chan I fucked my 72 virgins.
  }
  if ($1- == .so gay) {
    msg $chan SO GAY
    msg $chan SO FUCKING GAY
    msg $chan SO GAY
  }
  if ($1- == 2 chainz) {
    msg $chan 2 CHAAAAAAAINZ
    msg $chan MUSTARD ON THAT BEAT HOE
  }
  if ($$1 == .give) {
    describe $chan gives $2 $3-
  }
  if ($$1 == .pet) {
    describe $chan pets $2- :3
  }
  if ($$1 == .gimme) {
    DESCRIBE $chan gives $nick $2-
  }
  if ($$1 == .ping) { msg $chan Pong! }
  if ($1 == .secretlist) { secretlist }
  if ($1 == .halp) { .secretlist }
  if ($1- == .help Madness) { secretlist }
}

alias secretlist {
  notice $nick Available commands: .drink, .blunt, .tacos, .info, .submit,
  notice $nick .grape, !vote, .bewbs, .fluff, .fluffme, .stab, .glomp,
  notice $nick trainz, .kiss, .fuck, .rape, .hump, .drug, .hug, .leave (Must be OP)
  notice $nick .cum, .egg, .maize, .so mad, .lick, .fap, .hj, .bj, .squirt
  notice $nick .french, .pounce, .slap, .hi5, .low5, .fart, .cheesecake
  notice $nick .potato, .sparta, based god, .bitch, .give, .gimme, .boom
  notice $nick .ping, .pet, .tempban (Must be OP), .r, .8ball, .loli, .rr
}
