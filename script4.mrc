on $*:TEXT:/^[@](rpic)/Si:#: {
  if (!$2) {
    var %pic $rand(1, %rpics)
    msg $chan [(N)SFW] $($+(%,rpics,.,%pic),2) Random Pic $chr(35) $+ $(%pic)
  }
  else {
    msg $chan [(N)SFW] $($+(%,rpic,.,$2),2)
  }
}
on $*:TEXT:/^[@](addrpic)/Si:#: {
  if ($2) {
    var %number $calc(%rpics + 1)
    notice $nick Random Picture $chr(35) $+ $(%number) added.
    set %rpics %number
    set $+(%,rpics,.,%number) $2
  }
}
