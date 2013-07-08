on ^*:INPUT: {
  if (/ !isin $1) {
    msg $active $1- test | haltdef
  }
}
