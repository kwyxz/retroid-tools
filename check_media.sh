#!/usr/bin/env sh

for doss in *; do
  rm -f $doss/*.txt
  if test -d ${doss}; then
    echo -n "*** checking DAT "
    if ! ls ${doss}/DAT/*.dat; then echo "MISSING (${doss})"; fi
    if ls ${doss}/*.zip >/dev/null 2>/dev/null; then
      GAMEEXT=".zip"
    elif ls ${doss}/*.chd >/dev/null 2>/dev/null; then
      GAMEEXT=".chd"
    elif ls ${doss}/*.iso > /dev/null 2>/dev/null; then
      GAMEEXT=".iso"
    elif ls ${doss}/*.rvz > /dev/null 2>/dev/null; then
      GAMEEXT=".rvz"
    elif ls ${doss}/*.3ds > /dev/null 2>/dev/null; then
      GAMEEXT=".3ds"
    else
      echo "${doss}: no valid file extension found"
    fi
    for fich in ${doss}/*.*; do
      GAMENAME=$(basename "${fich}" "${GAMEEXT}")
      for mediadoss in ${doss}/media/*; do
        if ! test -f "${mediadoss}/${GAMENAME}.png"; then
          if ! test -f "${mediadoss}/${GAMENAME}.jpg"; then
            if echo "${GAMENAME}" | grep -qv "Disc [2-9]"; then
              echo "MISSING: ${mediadoss}/${GAMENAME} media"
            fi
          fi
        fi
      done
    done 
  fi
done
