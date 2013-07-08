on *:TEXT:.poll list*:#: {
  if ($3 == $null) {
    if (%poll.  [ $+ [ $chan ] ] > 0) {
      notice $nick There are %poll. [ $+ [ $chan ] ] polls active in $chan $+ !
      notice $nick To view them, simply type .poll list NumberOfPollHere
    }
    else {
      notice $nick There are no active polls in $chan $+ !
    }
  }
  else {
    if ($($+(%,poll,.,$chan,.,$3),2) != $null) {
      notice $nick Poll $3 is: $($+(%,poll,.,$chan,.,$3),2)
      notice $nick Choice 1 is: $($+(%,poll,.,$chan,.,$3,.,choice1),2) with $($+(%,poll,.,$chan,.,$3,.,choice1,.,votes),2) $+ !
      notice $nick Choice 2 is: $($+(%,poll,.,$chan,.,$3,.,choice2),2) with $($+(%,poll,.,$chan,.,$3,.,choice2,.,votes),2) $+ !
      notice $nick The follwing choices are available: $($+(%,poll,.,$chan,.,$3,.,choice1),2) and $($+(%,poll,.,$chan,.,$3,.,$choice2)
      notice $nick $($+(%,poll,.,$chan,.,$3,.,choice1) has $($+(%,poll,.,$chan,.,$3,.,choice1,.,votes) votes.
      notice $nick $($+(%,poll,.,$chan,.,$3,.,choice2) has $($+(%,poll,.,$chan,.,$3,.,choice2,.,votes) votes.
    }
    else {
      notice $nick Sorry, there is no poll called $3
    }
  }
}
on *:TEXT:.poll add*:#: {
  if ($3 != $null) {
    if ($4 != $null) {
      if ($5 != $null) {
        if ($6 != $null) {
          if ($7 != $null) {
            notice $nick Poll added.
            notice $nick Poll content: $5-
            notice $nick Poll choice 1: $3
            notice $nick Poll choice 2: $4
            var %polls $calc(%poll. [ $+ [ $chan ] ] + 1)
            set $+(%,poll,.,$chan,.,%polls) $5-
            set $+(%,poll,.,$chan,.,%polls,.,choice1) $3
            set $+(%,poll,.,$chan,.,%polls,.,choice2) $4
            set $+(%,poll,.,$chan,.,%polls,.,choice1,.,votes) 0
            set $+(%,poll,.,$chan,.,%polls,.,choice2,.,votes) 0
            set %poll. [ $+ [ $chan ] ] $(%polls)
          }
          else {
            notice $nick Usage: .poll add <Choice 1> <Choice 2> <Poll Description>
          }
        }
        else {
          notice $nick Usage: .poll add <Choice 1> <Choice 2> <Poll Description>
        }
      }
      else {
        notice $nick Sorry, your description has to be at least 3 words long. (helps prevent spam :P)
      }
    }
    else {
      notice $nick Sorry, your description has to be at least 3 words long. (helps prevent spam :P)
    }
  }
  else {
    notice $nick Sorry, your description has to be at least 3 words long. (helps prevent spam :P)
  }
}
on *:TEXT:.poll vote*:#: {
  if ($($+(%,poll,.,$chan,.,$3),2) != $null) {
    if ($($+(%,poll,.,$chan,.,$3,.,$nick),2) == $null) {
      if ($4 == $($+(%,poll,.,$chan,.,$3,.,choice1),2)) {
        notice $nick You successfully voted $4 for $($+(%,poll,.,$chan,.,$3),2)
        set $+(%,poll,.,$chan,.,$3,.,choice1,.,votes) $calc($($+(%,poll,.,$chan,.,$3,.,choice1,.,votes),2) + 1)
        set $+(%,poll,.,$chan,.,$3,.,$nick) voted
      }
      if ($4 == $($+(%,poll,.,$chan,.,$3,.,choice2),2)) {
        notice $nick You successfully voted $4 for $($+(%,poll,.,$chan,.,$3),2)
        set $+(%,poll,.,$chan,.,$3,.,choice2,.,votes) $calc($($+(%,poll,.,$chan,.,$3,.,choice2,.,votes),2) + 1)
        set $+(%,poll,.,$chan,.,$3,.,$nick) voted
      }
    }
    else {
      notice $nick Sorry, but you already voted!
    }
  }
  else {
    notice $nick Sorry, that poll doesn't exist. Please do .poll list
  }
}
on *:TEXT:.poll help:#: {
  notice $nick Hi! I'm a poll script coded by Tanmay for the bot on irc.rizon.net called Madness!
  notice $nick There are only 3 commands!
  notice $nick Command: .poll list [poll number]
  notice $nick Description: Lists all active polls in the channel requested in and can display vote counts.
  notice $nick ..................................................................
  notice $nick Command: .poll add <Choice 1> <Choice 2> <Description>
  notice $nick Description: Used to add polls.
  notice $nick Example: .poll add Foo Bar What's better? Foo or bar?
  notice $nick ..................................................................
  notice $nick Command: .poll vote <Poll Number> <Choice>
  notice $nick Used to vote in polls.
  notice $nick Example: .poll vote 1 Foo
  notice $nick ..................................................................
}
