on *:LOAD: {
  if (%firstrun == $null) {
    echo Hi!Thank you for using the Madness bot script!
    echo I am made by Tanmay on Rizon.
    echo For assistance, /server -m irc.rizon.net -j #me
    echo Then ask me for help!
    echo .
    echo Please do /botowner (your nick)
    .load -rs Madness/Admin.mrc
    .load -rs Madness/Modules.mrc
    .load -rs Madness/antispam.mrc
    .load -rs Madness/spam.mrc
    .load -rs Madness/floodamount.mrc
    set %firstrun true
  }
}
alias /botowner {
  if ($2 != $null) {
    if (%botowner == $null) {
      set %botowner $2
      echo Bot owner set to $2 $+ .
    }
    else {
      echo Bot owner changed from $(%botowner) to $2 $+ .
      set %botowner $2
    }
  }
  else {
    echo Usage: /botowner <your nick>
  }
}
