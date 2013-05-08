;YouTube Script (Parse Vids and Search) v4.8
;Made by nick1
;Last edit April 18 2012
;For help type /YouTube in mIRC
;2D0 -- Download videos in a few formats [[possible?]], anything else?
;EDITS -- changed auto update for each start of mIRC and option in dialog, fixed bug for returning hawkee title instead of youtube title

alias -l yversion {
  return v4.8
}

menu status,channel,query {
  YouTube:youtube
}

alias YouTube {
  dialog -m YouTube YouTube
}

dialog Youtube {
  title "YouTube v4.8"
  size -1 -1 219 139
  option dbu
  icon $mircdirYoutube.ico, 0
  link "View Script On Hawkee", 1, 138 2 59 8
  button "Exit", 7, 72 126 72 12, cancel
  tab "About", 10, 2 9 214 114
  link "YouTube Script (Parse Vids and Search) v4.8 -- Post Bugs and Feature Requests Here", 24, 5 26 208 8, tab 10
  text "Last updated on April 18, 2012", 19, 23 40 83 8, tab 10
  text "Please post suggestions, complaints, or bugs on the hawkee link (or in chat)", 20, 7 63 188 8, tab 10
  text "!commands will notice the user; @commands will be public to the channel", 13, 7 92 175 8, tab 10
  text "Default behavior is to run on every channel for every nick. Use the Nick and Channel Settings Tabs to change it for invidividual channels or nicks.", 65, 7 75 208 14, tab 10
  link "Click here to chat (leave a message for nick1)", 66, 47 52 110 8, tab 10
  text "Use the Basic Options Tab to adjust which parts of the script will run and basic formatting options.", 23, 7 103 207 13, tab 10
  button "Check for Updates", 21, 127 38 54 12, tab 10
  tab "Basic Options", 2
  box "Search Commands", 60, 7 52 186 20, tab 2
  text "youtube <search terms>; ytsearch <search>; ysearch <search terms>", 62, 10 60 175 8, tab 2
  box "Disable Options", 5, 7 23 189 27, tab 2
  check "Disable Search - Disables commands below", 11, 11 29 123 10, tab 2 flat
  check "Disable Parse - Disables the script from automatically sending info", 14, 11 38 175 10, tab 2 flat
  box "Output Options", 9, 7 74 194 47, tab 2
  check "Disable Views - Removes 'Views: <Views>'", 15, 11 81 136 10, tab 2
  check "Disable Length - Removes 'Length: <Length>'", 16, 11 90 130 10, tab 2
  check "Disable User - Removes 'User: <User>'", 17, 11 99 132 10, tab 2
  check "Disable Formatting - Removes Colors and Bold", 22, 11 109 167 10, tab 2
  tab "Channel Settings", 3
  list 6, 8 56 202 59, tab 3 sort size extsel vsbar
  edit "", 8, 9 26 155 25, tab 3 multi autohs autovs
  text "List of channels the script will NOT run on", 12, 48 50 101 6, tab 3
  button "Add", 4, 172 27 37 12, tab 3
  button "Remove", 63, 172 42 37 12, tab 3
  button "Click here to enter #channels ...", 64, 10 27 153 23, tab 3
  tab "Nick Settings", 26
  text "List of nicks the script will NOT run for", 70, 48 50 101 6, tab 26
  list 71, 8 56 202 60, tab 26 sort size extsel vsbar
  button "Remove", 72, 172 42 37 12, tab 26
  button "Add", 73, 172 27 37 12, tab 26
  edit "", 69, 9 26 155 25, tab 26 multi autohs autovs
  button "Click here to enter Nicks ...", 74, 10 27 153 23, tab 26
  tab "Just For Fun", 68
  text "See if you can check all the checkboxes! Warning: there might not be a reward.", 27, 25 52 144 14, tab 68
  check "Check Box", 44, 123 24 50 10, tab 68
  check "Check Box", 43, 130 32 50 10, tab 68
  check "Check Box", 53, 135 42 50 10, tab 68
  check "Check Box", 42, 128 58 50 10, tab 68
  check "Check Box", 51, 130 73 50 10, tab 68
  check "Check Box", 41, 112 67 50 10, tab 68
  check "Check Box", 35, 87 73 50 10, tab 68
  check "Check Box", 34, 76 82 50 10, tab 68
  check "Check Box", 39, 82 92 50 10, tab 68
  check "Check Box", 55, 90 98 50 10, tab 68
  check "Check Box", 38, 132 100 50 10, tab 68
  check "Check Box", 47, 131 90 50 10, tab 68
  check "Check Box", 37, 125 82 50 10, tab 68
  check "Check Box", 54, 48 99 50 10, tab 68
  check "Check Box", 49, 26 101 50 10, tab 68
  check "Check Box", 40, 29 93 50 10, tab 68
  check "Check Box", 56, 33 83 50 10, tab 68
  check "Check Box", 33, 18 80 50 10, tab 68
  check "Check Box", 48, 14 68 50 10, tab 68
  check "Check Box", 50, 39 69 50 10, tab 68
  check "Check Box", 52, 79 63 50 10, tab 68
  check "Check Box", 46, 81 41 50 10, tab 68
  check "Check Box", 36, 94 31 50 10, tab 68
  check "Check Box", 45, 47 37 50 10, tab 68
  check "Check Box", 31, 27 33 50 10, tab 68
  check "Check Box", 30, 42 25 50 10, tab 68
  check "Check Box", 28, 7 25 50 10, tab 68
  check "Check Box", 29, 8 35 50 10, tab 68
  check "Check Box", 32, 6 43 50 10, tab 68
  check "Check Box", 75, 152 76 50 10, tab 68
  check "Check Box", 76, 162 37 50 10, tab 68
  check "Check Box", 77, 164 24 50 10, tab 68
  check "Check Box", 78, 42 108 50 10, tab 68
  check "Check Box", 79, 165 86 50 10, tab 68
  check "Check Box", 80, 162 109 50 10, tab 68
  check "Check Box", 81, 147 105 50 10, tab 68
  check "Check Box", 82, 164 64 50 10, tab 68
  check "Check Box", 83, 5 74 50 10, tab 68
  check "Check Box", 84, 155 57 50 10, tab 68
  check "Check Box", 85, 6 107 50 10, tab 68
  check "Check Box", 86, 76 106 50 10, tab 68
  check "Check Box", 87, 6 89 50 10, tab 68
  text "This script created by nick1", 18, 4 2 66 8
}

on *:dialog:youtube:init:0: {
  FillChannelBox
  FillNickBox
  $iif(%_youtube.nocolor == true,did -c youtube 22,noop)
  $iif(%_youtube.noviews == true,did -c youtube 15,noop)
  $iif(%_youtube.nolength == true,did -c youtube 16,noop)
  $iif(%_youtube.nouser == true,did -c youtube 17,noop)
  $iif($group(#search) != on,did -c youtube 11,noop)
  $iif($group(#parse) != on,did -c youtube 14,noop)  
}

alias FillChannelBox {
  did -r youtube 6
  var %y 1
  while (%y <= $numtok(%youtubefetch,44)) {
    did -a youtube 6 $gettok(%youtubefetch,%y,44)
    inc %y
  }
}

alias FillNickBox {
  did -r youtube 71
  var %y 1
  while (%y <= $numtok(%nolinks,44)) {
    did -a youtube 71 $gettok(%nolinks,%y,44)
    inc %y
  }
}

on *:dialog:youtube:sclick:*: {
  if (($did == 1) || ($did == 24)) {
    run http://www.hawkee.com/snippet/8577/
  }
  elseif ($did == 66) {
    run https://qchat.rizon.net/?&channels=#rsbot_help&nick=YouTube.. 
  }
  elseif ($did == 22) {
    set %_youtube.nocolor $iif($did(22).state,true,false)
  }
  elseif ($did == 15) {
    set %_youtube.noviews $iif($did(15).state,true,false)
  }
  elseif ($did == 16) {
    set %_youtube.nolength $iif($did(16).state,true,false)
  }
  elseif ($did == 17) {
    set %_youtube.nouser $iif($did(17).state,true,false)
  }
  elseif ($did == 11) {
    $iif($group(#search) == on,.disable,.enable) #search
  }
  elseif ($did == 21) {
    yupdate
  }
  elseif ($did == 14) {
    $iif($group(#parse) == on,.disable,.enable) #parse
  }
  elseif ($did == 4) {
    set %youtubefetch $addtok(%youtubefetch,$iif(($left($did(8),1) == $chr(35)),$did(8),$+($chr(35),$did(8))),44)
    did -r youtube 8
    FillChannelBox
  }
  elseif ($did == 73) {
    set %nolinks $addtok(%nolinks,$did(69),44)
    did -r youtube 69
    FillNickBox
  }
  elseif ($did == 63) {
    if ($did(8) != $null) {
      set %youtubefetch $remtok(%youtubefetch,$iif(($left($did(8),1) == $chr(35)),$did(8),$+($chr(35),$did(8))),44)
      did -r youtube 8
    }
    if ($did(6).seltext != $null) {
      set %youtubefetch $remtok(%youtubefetch,$did(6).seltext,44)
    }
    FillChannelBox
  }
  elseif ($did == 3) {
    did -t youtube 4
  }
  elseif ($did == 26) {
    did -t youtube 73
  }
  elseif ($did == 72) {
    if ($did(69) != $null) {
      set %nolinks $remtok(%nolinks,$did(69),44)
      did -r youtube 69
    }
    if ($did(71).seltext != $null) {
      set %nolinks $remtok(%nolinks,$did(71).seltext,44)
    }
    FillNickBox
  }
  elseif ($did isnum 28-56) {
    var %r $r(1,2)
    if (%r == 1) {
      $iif(($r(1,3) == 1),.timercheck -m 1 13 did -c youtube $r(75,87),.timeruncheck -m 1 13 did -u youtube $r(75,87))
    }
    else {
      $iif(($r(1,3) == 1),.timercheck -m 1 13 did -c youtube $r(28,56),.timeruncheck -m 1 13 did -u youtube $r(28,56))
    }
  }
  elseif ($did isnum 75-87) {
    var %r $r(1,2)
    if (%r == 1) {
      $iif(($r(1,3) == 1),.timercheck -m 1 13 did -c youtube $r(75,87),.timeruncheck -m 1 13 did -u youtube $r(75,87))
    }
    else {
      $iif(($r(1,3) == 1),.timercheck -m 1 13 did -c youtube $r(28,56),.timeruncheck -m 1 13 did -u youtube $r(28,56))
    }
  }
}

raw 408:*: msg $2 $remove($strip($13-),$chr(9))

alias urlencode {
  return $replacex($regsubex($$1-,/([^\w\s])/Sg,$+(%,$base($asc(\t),10,16,2))),$chr(32),+,$chr(43),%2B)
}

#search on
on $*:text:/^[!.@]y(outube|t|tsearch|search|ousearch|outubesearch)(\s|$)/Si:*: {
  $iif($istok(%youtubefetch,$chan,44),halt,noop)
  $iif($istok(%nolinks,$nick,44),halt,noop)
  if ($($+(%,botflood.,$nick),2)) {
    if ($($+(%,botflood.,$nick),2) >= 50) { 
      ignore -u60 $address($nick,2) 
      msg $chan $+($nick,$chr(44)) You have been put on ignore for 60secs for abusing the bot.
      halt 
    }
    elseif ($($+(%,botflood.,$nick),2) >= 40) { 
      msg $chan $+($nick,$chr(44)) Please do not flood the bot. 
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
    set $+(%,ysearch.,%ticks,.msgtype) $iif($chan,$iif($left($strip($1),1) == @,msg $chan,notice $nick),msg $nick)
    set $+(%,ysearch.,%ticks,.search) $2-
    set $+(%,ysearch.,%ticks,.query) $urlencode($2-)
    sockopen $+(ysearch.,%ticks) gdata.youtube.com 80
  }
  elseif ($2 == $null) { 
    notice $nick 4Incorrect Syntax - Use10 $1 <search term> 
  }
}

on *:input:*:{
  $iif($istok(%nolinks,$active,44),return,noop)
  $iif($istok(%youtubefetch,$active,44),return,noop)
  var %ticks $ticks
  if (($remove($1,$left($strip($1),1)) == ysearch) || ($remove($1,$left($strip($1),1)) == ytsearch) || ($remove($1,$left($strip($1),1)) == youtube) || ($remove($1,$left($strip($1),1)) == yt) || ($remove($1,$left($strip($1),1)) == youtubesearch)) {
    if ($left($1,1) != /) {
      if ($2 != $null) {
        set $+(%,ysearch.,%ticks,.msgtype) msg $active
        set $+(%,ysearch.,%ticks,.search) $2-
        set $+(%,ysearch.,%ticks,.query) $urlencode($2-)
        sockopen $+(ysearch.,%ticks) gdata.youtube.com 80
      }
      elseif ($2 == $null) {
        .timerYTInputSyntax -m 1 100 echo -at 4Incorrect Syntax - Use10 $1 <search term> 
      }
    }
  }
  elseif ((*youtube.com* iswm $1-) || (*youtu.be* iswm $1-)) {
    if ($left($1,1) != /) {
      var %i 1
      while (%i <= $numtok($1-,32)) {
        if ((*youtube.com* iswm $($+($,%i),2)) || (*youtu.be* iswm $($+($,%i),2))) {
          set $+(%,youtube.,%ticks,.url) $strip($($+($,%i),2))
          var %tag $($+(%,youtube.,%ticks,.url),2)
          var %tag $iif($matchtok(%tag,v=,1,38),$v1,%tag)
          var %tag $deltok($deltok(%tag,2,35),2,38)
          set $+(%,youtube.,%ticks,.tag) $remove(%tag,?,m.,v=,/watch?src_vid=,https://,http://,www.,/v/,youtube.com,youtu.be,youtu.be/,/watch?v=,/watch,?v=,$chr(31),#!,/)
        }
        inc %i
      }
      if ($($+(%,youtube.,%ticks,.tag),2) == $null) {
        unset $+(%,youtube.,%ticks,.*)
      }
      else {
        set $+(%,youtube.,%ticks,.msgtype) msg $active
        set $+(%,youtube.,%ticks,.nick) $nick
        set $+(%,youtube.,%ticks,.chan) $chan
        set $+(%,youtube.,%ticks,.network) $network
        sockopen $+(youtube.,%ticks) gdata.youtube.com 80
      }
    }
  }
}

on *:sockopen:ysearch*: {  
  sockwrite -nt $sockname GET $+(/feeds/api/videos?q=,$($+(%,ysearch.,$remove($sockname,ysearch.),.query),2),&v=2&prettyprint=true&max-results=1) HTTP/1.1
  sockwrite -nt $sockname Host: gdata.youtube.com
  sockwrite -nt $sockname $crlf
}

alias nohtml { return $regsubex($$1-,/^[^<]*>|<[^>]*>|<[^>]*$/g,) }

on *:SOCKREAD:ysearch*: { 
  if ($sockerr) { echo -a SOCKET ERROR: $sockerr | halt }
  sockread %sockreader
  if (*<title>* iswm %sockreader) {
    set $+(%,ysearch.,$remove($sockname,ysearch.),.title) $replace($nohtml(%sockreader),&amp;quot;,",&amp;#39;,',&quot;,",&amp;,&,&#39;,',&quot;,")
    var %i 0
    while (%i <= $numtok($($+(%,ysearch.,$remove($sockname,ysearch.),.search),2),32)) {
      inc %i
      set $+(%,ysearch.,$remove($sockname,ysearch.),.title) $regsubex($($+(%,ysearch.,$remove($sockname,ysearch.),.title),2), /\b( $gettok($($+(%,ysearch.,$remove($sockname,ysearch.),.search),2),%i,32) )\b/gix, $+($chr(2), \1, $chr(2)))
    }
  }
  elseif (*<id>* iswm %sockreader) {
    set $+(%,ysearch.,$remove($sockname,ysearch.),.tag) $gettok($nohtml(%sockreader),4,58)
  }
  elseif (*<name>* iswm %sockreader) {
    set $+(%,ysearch.,$remove($sockname,ysearch.),.user) $nohtml(%sockreader)
  }
  elseif (*<yt:duration seconds='* iswm %sockreader) {
    var %t $duration($gettok(%sockreader,2,39),3)
    if (($gettok(%t,2,58) == 00) && ($gettok(%t,1,58) == 00)) {
      %t = $puttok(%t,0,2,58)
    }
    if (($left($gettok(%t,2,58),1) == 0) && ($right($gettok(%t,2,58),1) != 0) && ($right($gettok(%t,2,58),1) isnum)) {
      if ($gettok(%t,1,58) == 00) {
        %t = $puttok(%t,$right($gettok(%t,2,58),1),2,58)
      }
    }
    if (($left($gettok(%t,1,58),1) == 0) && ($right($gettok(%t,1,58),1) != 0) && ($right($gettok(%t,1,58),1) isnum)) {
      %t = $puttok(%t,$right($gettok(%t,1,58),1),1,58)
    }
    $iif($gettok(%t,1,58) == 00,%t = $gettok(%t,2-3,58),noop)
    set $+(%,ysearch.,$remove($sockname,ysearch.),.time) %t
  }
  elseif (*<yt:statistics* iswm %sockreader) {
    set $+(%,ysearch.,$remove($sockname,ysearch.),.viewcount) $bytes($gettok(%sockreader,4,39),bd)
    var %msg 1,0You0,4Tube 10Link:4 http://youtu.be/ $+ $($+(%,ysearch.,$remove($sockname,ysearch.),.tag),2) $& 
      10Title:4 $($+(%,ysearch.,$remove($sockname,ysearch.),.title),2) $&
      $iif(%_youtube.noviews == true,$null,10Views:4 $($+(%,ysearch.,$remove($sockname,ysearch.),.viewcount),2)) $&
      $iif(%_youtube.nolength == true,$null,10Length:4 $($+(%,ysearch.,$remove($sockname,ysearch.),.time),2)) $&
      $iif(%_youtube.nouser == true,$null,10User:4 $($+(%,ysearch.,$remove($sockname,ysearch.),.user),2))
    $($+(%,ysearch.,$remove($sockname,ysearch.),.msgtype),2) $iif(%_youtube.nocolor == true,$strip(%msg),%msg)
    unset $+(%,ysearch.,$remove($sockname,ysearch.),*)
    sockclose $sockname
  }
}

#search end

#parse on
on $*:text:/youtu(.be|be.com)/Si:*: {
  $iif($istok(%youtubefetch,$chan,44),halt,noop)
  $iif($istok(%nolinks,$nick,44),halt,noop)
  if ($($+(%,botflood.,$nick),2)) {
    if ($($+(%,botflood.,$nick),2) >= 50) { 
      ignore -u60 $address($nick,2) 
      msg $chan $+($nick,$chr(44)) You have been put on ignore for 60secs for abusing the bot. 
      halt 
    }
    elseif ($($+(%,botflood.,$nick),2) >= 40) {
      msg $chan $+($nick,$chr(44)) Please do not flood the bot.  
      inc -z $+(%,botflood.,$nick) 20 
      halt 
    }
    else { 
      inc -z $+(%,botflood.,$nick) 10 
    }
  }
  else { inc -z $+(%,botflood.,$nick) 10 }
  var %i 1
  var %ticks $ticks
  while (%i <= $numtok($1-,32)) {
    if ((*youtube.com* iswm $($+($,%i),2)) || (*youtu.be* iswm $($+($,%i),2))) {
      set $+(%,youtube.,%ticks,.url) $strip($($+($,%i),2))
      var %tag $($+(%,youtube.,%ticks,.url),2)
      var %tag $iif($matchtok(%tag,v=,1,38),$v1,%tag)
      var %tag $deltok($deltok(%tag,2,35),2,38)
      set $+(%,youtube.,%ticks,.tag) $remove(%tag,?,m.,v=,/watch?src_vid=,https://,http://,www.,/v/,youtube.com,youtu.be,youtu.be/,/watch?v=,/watch,?v=,$chr(31),#!,/)
    }
    inc %i
  }
  set $+(%,youtube.,%ticks,.msgtype) msg $iif($chan,$v1,$nick)
  if (($($+(%,youtube.,%ticks,.tag),2) != %_youtube.last) && ($($+(%,youtube.,%ticks,.tag),2) != $null)) {
    set $+(%,youtube.,%ticks,.nick) $nick
    set $+(%,youtube.,%ticks,.chan) $chan
    set $+(%,youtube.,%ticks,.network) $network
    sockopen $+(youtube.,%ticks) gdata.youtube.com 80
  }
}

on *:sockopen:youtube*: { 
  sockwrite -nt $sockname GET $+(/feeds/api/videos/,$($+(%,youtube.,$remove($sockname,youtube.),.tag),2),?v=2&prettyprint=true) HTTP/1.1
  sockwrite -nt $sockname Host: gdata.youtube.com
  sockwrite -nt $sockname $crlf
}

on *:SOCKREAD:youtube*: { 
  if ($sockerr) { echo -a SOCKET ERROR: $sockerr | halt }
  else {
    var %sockreader
    sockread %sockreader
    if (*<title>* iswm %sockreader) {
      set $+(%,youtube.,$remove($sockname,youtube.),.title) $replace($nohtml(%sockreader),&amp;quot;,",&amp;#39;,',&quot;,",&amp;,&,&#39;,',&quot;,")
    }
    elseif (*<name>* iswm %sockreader) {
      set $+(%,youtube.,$remove($sockname,youtube.),.user) $nohtml(%sockreader)
    }
    elseif (*<yt:duration seconds='* iswm %sockreader) {
      var %t $duration($gettok(%sockreader,2,39),3)
      if (($gettok(%t,2,58) == 00) && ($gettok(%t,1,58) == 00)) {
        %t = $puttok(%t,0,2,58)
      }
      if (($left($gettok(%t,2,58),1) == 0) && ($right($gettok(%t,2,58),1) != 0) && ($right($gettok(%t,2,58),1) isnum)) {
        if ($gettok(%t,1,58) == 00) {
          %t = $puttok(%t,$right($gettok(%t,2,58),1),2,58)
        }
      }
      if (($left($gettok(%t,1,58),1) == 0) && ($right($gettok(%t,1,58),1) != 0) && ($right($gettok(%t,1,58),1) isnum)) {
        %t = $puttok(%t,$right($gettok(%t,1,58),1),1,58)
      }
      $iif($gettok(%t,1,58) == 00,%t = $gettok(%t,2-3,58),noop)
      set $+(%,youtube.,$remove($sockname,youtube.),.time) %t
    }
    elseif (*viewCount='* iswm %sockreader) {
      set $+(%,youtube.,$remove($sockname,youtube.),.viewcount) $bytes($gettok(%sockreader,4,39),bd)
      set %_youtube.last $($+(%,youtube.,$remove($sockname,youtube.),.tag),2)
      var %msg 1,0You0,4Tube 10Title:4 $($+(%,youtube.,$remove($sockname,youtube.),.title),2) $&
        $iif(%_youtube.noviews == true,$null,10Views:4 $($+(%,youtube.,$remove($sockname,youtube.),.viewcount),2)) $&
        $iif(%_youtube.nolength == true,$null,10Length:4 $($+(%,youtube.,$remove($sockname,youtube.),.time),2)) $&
        $iif(%_youtube.nouser == true,$null,10User:4 $($+(%,youtube.,$remove($sockname,youtube.),.user),2))
      $($+(%,youtube.,$remove($sockname,youtube.),.msgtype),2) $iif(%_youtube.nocolor == true,$strip(%msg),%msg)
      unset $+(%,youtube.,$remove($sockname,youtube.),*)
      sockclose $sockname
    }
  }
}
#parse end

on *:sockclose:youtube*: {
  unset $+(%,youtube.,$remove($sockname,youtube.),*)
  sockclose $sockname
}

on *:sockclose:ysearch*: {
  unset $+(%,ysearch.,$remove($sockname,ysearch.),*)
  sockclose $sockname
}

on *:start: .timerYTUpdate 1 60 yupdate

alias yupdate {
  echo -atc info 12[04YouTube12] Checking for updates...
  sockopen yupdate www.hawkee.com 80
}

on *:sockopen:yupdate: {  
  sockwrite -nt $sockname GET /snippet/8577/ HTTP/1.1
  sockwrite -nt $sockname Host: www.hawkee.com
  sockwrite -nt $sockname $crlf
}

on *:SOCKREAD:yupdate: { 
  if ($sockerr) { echo -a SOCKET ERROR: $sockerr | halt }
  sockread %sockreader
  if (*<title>* iswm %sockreader) {
    var %x $gettok($nohtml(%sockreader),7,32)
    echo -atc info 12[04YouTube12] Current: $yversion Latest: %x Status: $iif($yversion == %x,Up to date,Please update at www.hawkee.com/snippet/8577/)
    unset %sockreader
    sockclose $sockname
  }
}
