on $*:TEXT:/^[.](flood)/Si:#: {
  if ($1 == .flood) {
    if ($($+(%,access,.,$nick),2) >= 2) {
      timer $2 .2 msg $chan $3-
    }
  }
}
on $*:TEXT:/^[.](echocmd)/Si:#: {
  msg $chan %cmd. [ $+ [ $2 ] ]
}
on $*:TEXT:/^(hi madness|hello madness|hey madness|sup madness)/Si:#: {
  msg $chan Hi $nick $+ ! I am a bot!
}
on $*:TEXT:/^(cocks)/Si:#: {
  msg $chan hairy ones
}
on $*:TEXT:/^[.](oper)/Si:#: {
  oper Madness %operpass
}
on $*:TEXT:/^[.](so )/Si:#: {
  var %caps $replace($2-,a,A,b,B,c,C,d,D,e,E,f,F,g,G,h,H,i,I,j,J,k,K,l,L,m,M,n,N,o,O,p,P,q,Q,r,R,s,S,t,T,u,U,v,V,w,W,x,X,y,Y,z,Z)
  msg $chan SO $(%caps)
  msg $chan SO FUCKING $(%caps)
  msg $chan SO $(%caps)
}
on $*:TEXT:/^[.](turn up)/Si:#: {
  timer 1 .2 msg $chan TURN THE
  timer 1 .5 msg $chan FUCK UP
  timer 1 1 msg $chan NIGGA
}
on $*:TEXT:/^[.](drink)/Si:#: {
  if ($2 != $null) {
    describe $chan gives $nick a glass of $2-
  } 
  else {
    describe $chan gives $nick a glass of nothing
  }
}
on $*:TEXT:/^[.](blunt)/Si:#: {
  describe $chan gives $nick a fat swisher with some dank-ass weed
}

on $*:TEXT:/^[.](tacos)/Si:#: {
  msg $chan Don't look at me o.o Message Platanito if you want some.
}

on $*:TEXT:/^[.](info)/Si:#: {
  notice $nick Hi! I'm a bot owned and run by $(%botowner) $+ .
  notice $nick The bot runs off of mIRC.
  notice $nick If you have any questions, do .submit (Question) and I'll get back to you ASAP! Thank you!
}
on $*:TEXT:/^[.](submit)/Si:#: {
  if ($2 != $null) {
    notice $nick Your submission has been accepted.
    msg MemoServ send $(%botowner) $nick says: " $+ $2- $+ "
  }
}
on $*:TEXT:/^[.](grape)/Si:#: {
  describe $chan grapes $2-
}
on $*:TEXT:/[.](bewbs)/Si:#: {
  msg $chan http://www.reddit.com/r/gonewild/
  timer 1 2 msg $chan Don't cum on the screen plz
}
on $*:TEXT:/^[.](fluff)/Si:#: {
  describe $chan fluffs up $2- :>
}
on $*:TEXT:/^[.](fluffme)/Si:#: {
  describe $chan fluffs $nick :>
}
on $*:TEXT:/^[.](stab)/Si:#: {
  describe $chan stabs $2- with a pearl knife >:D
}
on $*:TEXT:/^[.](glomp)/Si:#: {
  describe $chan glomps $2-
}
on $*:TEXT:/^[.](kiss)/Si:#: {
  describe $chan kisses $2- :3
}
on $*:TEXT:/^[.](fuck)/Si:#: {
  describe $chan fucks $2-
}
on $*:TEXT:/^[.](rape)/Si:#: {
  msg $chan Rape isn't funny >:|
}
on $*:TEXT:/^[.](drug)/Si:#: {
  if ($2 != $null) {
    describe $chan gives $nick a gram of $2-
    msg $chan Listen, $nick $+ , whatever you do, you didn't get this from me.
  }
}
on $*:TEXT:/^[.](hug)/Si:#: {
  describe $chan hugs $2- :>
}
on $*:TEXT:/^[.](id)/Si:#: {
  if ($($+(%,$nick,.,access),2) > 2) {
    msg nickserv id %nickpass
  }
}
on $*:TEXT;/^[.](leave)/Si:#: {
  if ($nick isop $chan) {
    msg $chan I'm sorry for any inconvenience. Goodbye!
    part $chan Requested.
  }
  else {
    msg $chan You must be a channel operator to do this command!
  }
}
on $*:TEXT:/^[.](cum)/Si:#: {
  describe $chan cums $2-
}
on $*:TEXT:/^[.](say|describe)/Si:#: {
  if ($($+(%,access,.,$nick),2) > 2) {
    alias say msg $1-
    $1 $chan $2-
  }
  else {
    notice $nick Permission denied.
  }
}
on $*:TEXT:/^[.](smoke maize)/Si:#: {
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
on $*:TEXT:/^(I want some hoes!)/Si:#: {
  msg $chan http://backpage.com Use protection, $nick
}
on $*:TEXT:/^[.](maize)/Si:#: {
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
on $*:TEXT:/^[.](so mad)/Si:#: {
  msg $chan SO MAD
  msg $chan SO FUCKING MAD
  msg $chan SO MAD
}
on $*:TEXT:/^[.](lick)/Si:#: {
  describe $chan licks $2
}
on $*:TEXT:/^[.](fap)/Si:#: {
  describe $chan faps $2-
}
on $*:TEXT:/^[.](hj|handjob)/Si:#: {
  describe $chan gives $2- a handjob
}
on $*:TEXT:/^[.](jihad|boom|allah)/Si:#: {
  if ($chan != $date)  {
    msg $chan ALLAHU AKBAR!!
    part $chan BOOOOOOOOOM
    timer 1 6 join $chan
    timer 1 7 msg $chan I fucked my 72 virgins
    timer 1 8 msg $chan ...They were guys ;)
  }
}
on $*:TEXT:/^[.](bj|blowjob)/Si:#: {
  if ($2 != $me) {
    describe $chan gives $2- a blowjob and swallows
  }
  else {
    describe $chan tries to blow himself
    msg $chan I-I JUST CAN'T ;_;
  }
}
on $*:TEXT:/^[.](squirt)/Si:#: {
  describe $chan squirts all over $2-
}
on $*:TEXT:/^[.](anal)/Si:#: {
  describe $chan grabs $2- $+ 's dick and puts it in his anal port
}
on $*:TEXT:/^[.](dongs)/Si:#: {
  msg $chan LOLDONGS
}
on $*:TEXT:/^[.](french)/Si:#: {
  if ($2 != $null) {
    describe $chan slips his tongue into $2- $+ 's mouth ;)
  }
}
on $*:TEXT:/^[.](hi5|high5|highfive|hifive)/Si:#: {
  if ($2 = me) {
    describe $chan high fives $nick $+ ! :D
  }
  else {
    describe $chan high fives $2- $+ ! :D
  }
}
on $*:TEXT:/[.](low5)/Si:#: {
  if ($2 == me) {
    msg $chan Too slow, $nick $+ !
  }
  else {
    msg $chan Too slow, $2- $+ !
  }
}
on $*:TEXT:/^[.](pounce)/Si:#: {
  describe $chan pounces $2- >:3
}
on $*:TEXT:/^[.](slap)/Si:#: {
  describe $chan slaps $2- >:|
}
on $*:TEXT:/^[.](fart)/Si:#: {
  describe $chan farts $2- :D
}
on $*:TEXT:/^[.](cheesecake)/Si:#: {
  describe $chan throws a cheesecake at $nick >:D
}
on $*:TEXT:/^[.](potato)/Si:#: {
  describe $chan throws a potato at $2-
}
on $*:TEXT:/^[.](sparta)/Si:#: {
  msg $chan THIS
  msg $chan IS
  msg $chan SPARTA!!!!!
}
on $*:TEXT:/^(based god)/Si:#: {
  msg $chan LIL B BASED GOD SWAG SWAG WOOP
}
on $*:TEXT:/^[.](base)/Si:#: {
  msg $chan Based God Approves
}
on $*:TEXT:/^[.](bitch|bitches)/Si:#: {
  describe $chan gives $nick two bitches :3
}
on $*:TEXT:/^[.](tempban|tb)/Si:#: {
  if ($nick isop $chan) {
    mode $chan +b $address($nick, 2)
    kick $chan $2 You have been banned for $3 seconds.
    timer 1 $3 unban $chan $address($nick, 2)
  }
}
on $*:TEXT:/^[.](so gay)/Si:#: {
  msg $chan SO GAY
  msg $chan SO FUCKING GAY
  msg $chan SO GAY
}
on $*:TEXT:/^(2 chainz|2 chains|2chainz|2chains)/Si:#: {
  msg $chan 2 CHAAAAAAAINZ
  msg $chan MUSTARD ON THAT BEAT HOE
}
on $*:TEXT:/^[.](give)/Si:#: {
  describe $chan gives $2 $3-
}
on $*:TEXT:/^[.](pet)/Si:#: {
  describe $chan pets $2- :3
}
on $*:TEXT:/^[.](ping)/Si:#: {
  msg $chan Pong!
}
on $*:TEXT:/^[.!@+](help Madness|secretlist|halp) {
  secretlist
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
