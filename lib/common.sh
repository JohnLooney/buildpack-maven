#!/usr/bin/env bash

create_build_log_file() {
  local buildLogFile="maven-build.log"
  echo "" > $buildLogFile
  echo "$buildLogFile"
}

# sed -l basically makes sed replace and buffer through stdin to stdout
# so you get updates while the command runs and dont wait for the end
# e.g. sbt stage | indent
output() {
  local logfile="$1"
  local c='s/^/       /'

  case $(uname) in
    Darwin) tee -a "$logfile" | sed -l "$c";; # mac/bsd sed: -l buffers on line boundaries
    *)      tee -a "$logfile" | sed -u "$c";; # unix/gnu sed: -u unbuffered (arbitrary) chunks of data
  esac
}


steptxt="----->"

# print a warning
warn() {
    echo -e >&2 "${YELLOW} !     $@${NC}"
}

# print a build step
step() {
    echo "$steptxt $@"
}

# print when done
finished() {
    echo "done"
}
