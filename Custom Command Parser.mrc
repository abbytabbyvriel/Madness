on *:TEXT:.*:#: {
  if (%cmd [ $+ [ $1 ] ] != $null) {
    if ($chr(91) $+ item $+ $chr(93) !isin %cmd [ $+ [ $1 ] ]) {
      cmd $+ $1-
    }
    else {
      var %number $rand(1, %items)
      var %item $($+(%,items,.,%number),2)
      $eval($replace(%cmd [ $+ [ $1 ] ], [item], %item),2)
    }
  }
}
