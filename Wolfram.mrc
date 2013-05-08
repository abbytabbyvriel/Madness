;Wolfram|Alpha Script v1.0
;Made by nick1
;Last edit June 26 2012
;EDITS -- Initial version
;2DO -- Fix subpod titles, clean up text with colors, comparison queries, max length
;NOTE -- [[Unfinished Version]] I am aware this is a very rough script and needs a lot of work, but since it is working
;for the basic stuff I am just putting it up as is for now

alias APIKey {
  ;Important you MUST put in your own API Key here, get one FREE from http://developer.wolframalpha.com/portal/apisignup.html
  return 39TEKR-RHLPG29VXX
}

alias -l urlencode {
  return $replacex($regsubex($$1-,/([^\w\s])/Sg,$+(%,$base($asc(\t),10,16,2))),$chr(32),+,$chr(43),%2B)
}

;raw 408:*: msg $2 $remove($strip($13-),$chr(9))

alias nohtml { return $regsubex($$1-,/^[^<]*>|<[^>]*>|<[^>]*$/g,) }

alias shorten {
  inc %shortens
  if ($1 isnum) {
    set %_bq.ticks $1
    set %_bq.wolfram $urlencode($2-)
    sockopen bq ou.gs 80
  }
  elseif ($2) {
    set %_bq.nick $1
    set %_bq.msgtype $iif((!%_bq.msgtype),msg $active,%_bq.msgtype)
    set %_bq.url $2-
    sockopen bq ou.gs 80
  }
  elseif ($2 == $null) {
    set %_bq.msgtype echo -ac info
    set %_bq.url $1-
    sockopen bq ou.gs 80
  }
}

on *:sockopen:bq: {
  if (%_bq.lmgtfy) {
    sockwrite -nt $sockname GET $+(/index.php?url=,%_bq.url,&alias=,%_bq.nick,-,G0,-,%shortens) HTTP/1.1
  }
  elseif (%_bq.wolfram) {
    sockwrite -nt $sockname GET $+(/index.php?url=,%_bq.wolfram,&alias=,%_bq.ticks) HTTP/1.1
  }
  elseif (%_bq.url) {
    sockwrite -nt $sockname GET $+(/index.php?url=,$urlencode(%_bq.url)) HTTP/1.1
  }
  sockwrite -nt $sockname Host: ou.gs
  sockwrite -nt $sockname $crlf
}

on *:SOCKREAD:bq: {
  if ($sockerr) { echo -a SOCKET ERROR: $sockerr | halt }
  else {
    var %sockreader
    sockread %sockreader
    if (*Short URL:* iswm %sockreader) {
      if (%_bq.lmgtfy) {
        tokenize 32 $nohtml(%sockreader)
        %_bq.msgtype %_bq.nick $+ : 12[4Helpful Link12] $3
        unset %_bq.*
        sockclose $sockname
        halt
      }
      else {
        if (!%_bq.wolfram) {
          %_bq.msgtype 10 $+ Long URL: $iif($left(%_bq.url,7) == http://,%_bq.url,http:// $+ %_bq.url) ( $+ $len($iif($left(%_bq.url,7) == http://,%_bq.url,http:// $+ %_bq.url)) Characters) Is4 $nohtml(%sockreader)
          if (%_bq.msgtype == echo -ac info) {
            tokenize 32 $nohtml(%sockreader)
            clipboard $3
          }    
        }
      }
      unset %_bq.*
      sockclose $sockname
    }
  }
}


alias wolf {
  if ($1 != $null) {
    var %ticks $ticks
    shorten %ticks $+(http://www.wolframalpha.com/input/?i=,$urlencode($1-))
    set $+(%,wa.,%ticks,.msgtype) echo @wolfram
    set $+(%,wa.,%ticks,.text) $1-
    set $+(%,wa.,%ticks,.input) $urlencode($1-)
    sockopen $+(wa.,%ticks) api.wolframalpha.com 80
  }
  else if ($1 == $null) {
    echo -ac info Incorrect Syntax: /wolf <search query>
  }
}

on $*:text:/^[!@](wolfram|wra|wolframalpha|alpha|wa|wolf|wfa|calc)/Si:*: {
  $iif($istok(%youtubefetch,$chan,44),halt,noop)
  $iif($istok(%nolinks,$nick,44),halt,noop)
  if ($($+(%,botflood.,$nick),2)) {
    if ($($+(%,botflood.,$nick),2) >= 50) {
      ignore -u60 $address($nick,0)
      msg $chan $+($nick,$chr(44)) You Have Been Put On Ignore For 60secs For Abusing The Bot.
      halt
    }
    elseif ($($+(%,botflood.,$nick),2) >= 40) {
      msg $chan $+($nick,$chr(44)) Please Do Not Abuse The Bot.
      inc -z $+(%,botflood.,$nick) 20
      halt
    }
    else {
      inc -z $+(%,botflood.,$nick) 25
    }
  }
  else {
    inc -z $+(%,botflood.,$nick) 25
  }
  var %ticks $ticks
  if ($2) {
    var %i $2-
    shorten %ticks $+(http://www.wolframalpha.com/input/?i=,$urlencode(%i))
    set $+(%,wa.,%ticks,.msgtype) $iif($left($strip($1),1) == @,msg $chan,notice $nick)
    set $+(%,wa.,%ticks,.text) %i
    set $+(%,wa.,%ticks,.input) $urlencode(%i)
    sockopen $+(wa.,%ticks) api.wolframalpha.com 80
  }
  elseif ($2 == $null) {
    $iif($left($strip($1),1) == @,msg $chan,notice $nick) $+(4,$nick,,$chr(44)) 10Incorrect Syntax: Try $+(4,$1,10) <search term>
  }
}

on *:input:*: {
  if ($left($1,1) != /) {
    if (($right($1,-1) == wolfram) || ($right($1,-1) == wa) || ($right($1,-1) == wra) || ($right($1,-1) == wolframalpha) || ($right($1,-1) == wolf) || ($right($1,-1) == wfa) || ($right($1,-1) == calc)) {
      if ($2) {
        var %ticks $ticks
        var %i $2-
        shorten %ticks $+(http://www.wolframalpha.com/input/?i=,$urlencode(%i))
        set $+(%,wa.,%ticks,.msgtype) msg $active
        set $+(%,wa.,%ticks,.text) %i
        set $+(%,wa.,%ticks,.input) $urlencode(%i)
        sockopen $+(wa.,%ticks) api.wolframalpha.com 80
      }
      elseif ($2 == $null) {
        halt
      }
    }
  }
}

on *:SOCKOPEN:wa*: {  
  $iif(!$window(@Wolfram),window -evn @Wolfram,noop)
  sockwrite -nt $sockname GET $+(/v2/query?input=,$($+(%,wa.,$remove($sockname,wa.),.input),2),&appid=,$apikey,&format=plaintext) HTTP/1.1
  sockwrite -nt $sockname Host: api.wolframalpha.com
  sockwrite -nt $sockname $crlf
}

alias NotTextValues {
  return scanner,id,position,error,numsubpods,input,text,value,desc,current,valid,word,template,suggestion
}

on *:SOCKREAD:wa*: {
  if ($sockerr) { echo -a SOCKET ERROR: $sockerr | halt }
  sockread %sockreader
  if (*numpods='* iswm %sockreader) {
    tokenize 39 %sockreader
    set $+(%,wa.,$remove($sockname,wa.),.pods) $2
  }
  elseif (*<subpod title='* iswm %sockreader) {
    tokenize 39 %sockreader
    if (($2 != $null) && ($2 != $chr(62))) {
      set $+(%,wa.,$remove($sockname,wa.),.title.,$($+(%,wa.,$remove($sockname,wa.),.titles),2)) 12 $+ $2
    }
  }
  elseif (*<pod title='* iswm %sockreader) {
    inc $+(%,wa.,$remove($sockname,wa.),.titles)
    tokenize 39 %sockreader
    set $+(%,wa.,$remove($sockname,wa.),.title.,$($+(%,wa.,$remove($sockname,wa.),.titles),2)) 4 $+ $2
  }
  elseif (*<plaintext>* iswm %sockreader) {
    inc $+(%,wa.,$remove($sockname,wa.),.texts)
    if ($nohtml(%sockreader) != $null) {
      if ($($+(%,wa.,$remove($sockname,wa.),.titles),2) == $($+(%,wa.,$remove($sockname,wa.),.texts),2)) {
        set $+(%,wa.,$remove($sockname,wa.),.title.,$($+(%,wa.,$remove($sockname,wa.),.titles),2)) $addtok($($+(%,wa.,$remove($sockname,wa.),.title.,$($+(%,wa.,$remove($sockname,wa.),.titles),2)),2),$chr(32) $+ $replace($nohtml(%sockreader),&apos;,'),58)
        set $+(%,wa.,$remove($sockname,wa.),.result) $addtok($($+(%,wa.,$remove($sockname,wa.),.result),2),$($+(%,wa.,$remove($sockname,wa.),.title.,$($+(%,wa.,$remove($sockname,wa.),.titles),2)),2),32)
      }
      elseif ($($+(%,wa.,$remove($sockname,wa.),.titles),2) != $($+(%,wa.,$remove($sockname,wa.),.texts),2)) {
        set $+(%,wa.,$remove($sockname,wa.),.result) $addtok($($+(%,wa.,$remove($sockname,wa.),.result),2),$chr(32) $replace($nohtml(%sockreader),&apos;,'),124) $+ $chr(32)
      }
    }
  }
  elseif (($($+(%,wa.,$remove($sockname,wa.),.taxts),2) == $($+(%,wa.,$remove($sockname,wa.),.pods),2)) && ($($+(%,wa.,$remove($sockname,wa.),.pods),2) != $null)) {
    set $+(%,wa.,$remove($sockname,wa.),.result) $replace($($+(%,wa.,$remove($sockname,wa.),.result),2),$chr(58),4 $+ $chr(58) $+ 10)
    $($+(%,wa.,$remove($sockname,wa.),.msgtype),2) 4Wolfram5|7Alpha $($+(%,wa.,$remove($sockname,wa.),.result),2)
    unset $+(%,wa.,$remove($sockname,wa.),*)
    sockclose $sockname
  }
  elseif (($($+(%,wa.,$remove($sockname,wa.),.texts),2) >= 1) && ($mid(%sockreader,2,1) != $chr(60))) {
    tokenize 61 %sockreader
    if ((!$istok($NotTextValues,$1,44)) && ($left($1,1) != $chr(60))) {
      set $+(%,wa.,$remove($sockname,wa.),.result) $addtok($($+(%,wa.,$remove($sockname,wa.),.result),2),$chr(32) $replace($nohtml(%sockreader),&apos;,') $+ $chr(32),124)
    }
  }
  elseif (*<queryresult success='false'* iswm %sockreader) {
    if ($($+(%,wa.,$remove($sockname,wa.),.msgtype),2) == echo @Wolfram) {
      echo -a  4Wolfram5|7Alpha10 Could not find an answer to this query (please try again!) or 4View5|7It10 $+(http://ou.gs/,$remove($sockname,wa.))
    }
    else {
      $($+(%,wa.,$remove($sockname,wa.),.msgtype),2) 4Wolfram5|7Alpha10 Could not find an answer to this query (please try again!) or 4View5|7It10 $+(http://ou.gs/,$remove($sockname,wa.))
    }
    unset $+(%,wa.,$remove($sockname,wa.),*)
    sockclose $sockname
  }
}
on *:SOCKCLOSE:wa*: {
  set $+(%,wa.,$remove($sockname,wa.),.result) $replace($($+(%,wa.,$remove($sockname,wa.),.result),2),$chr(58),$chr(58) $+ 10,$chr(124),3 $+ $chr(124) $+ 10,&quot;,",&lt;,<,&gt;,>,&amp;,&,^2,$chr(178),^3,$chr(179),theta,$chr(952),<=,≤,>=,≥,(script capital l),$chr(8467))
  if ($($+(%,wa.,$remove($sockname,wa.),.result),2) != $null) {
    if ($($+(%,wa.,$remove($sockname,wa.),.msgtype),2) == echo @Wolfram) {
      echo -a  4Wolfram5|7Alpha $($+(%,wa.,$remove($sockname,wa.),.result),2) 4View5|7It10 $+(http://ou.gs/,$remove($sockname,wa.))
    }
    else {
      $($+(%,wa.,$remove($sockname,wa.),.msgtype),2) 4Wolfram5|7Alpha $($+(%,wa.,$remove($sockname,wa.),.result),2) 4View5|7It10 $+(http://ou.gs/,$remove($sockname,wa.))
    }
  }
  elseif ($($+(%,wa.,$remove($sockname,wa.),.result),2) == $null) {
    if ($($+(%,wa.,$remove($sockname,wa.),.msgtype),2) == echo @Wolfram) {
      echo -a  4Wolfram5|7Alpha10 Could not find an answer to this query (please try again!) or 4View5|7It10 $+(http://ou.gs/,$remove($sockname,wa.))
    }
    else {
      $($+(%,wa.,$remove($sockname,wa.),.msgtype),2) 4Wolfram5|7Alpha10 Could not find an answer to this query (please try again!) or 4View5|7It10 $+(http://ou.gs/,$remove($sockname,wa.))
    }    
  }
  echo @Wolfram Query: $($+(%,wa.,$remove($sockname,wa.),.text),2) Request: $($+(%,wa.,$remove($sockname,wa.),.msgtype),2) 4Wolfram5|7Alpha $($+(%,wa.,$remove($sockname,wa.),.result),2) 4View5|7It10 $+(http://ou.gs/,$remove($sockname,wa.))
  unset $+(%,wa.,$remove($sockname,wa.),*)
  sockclose $sockname
}
