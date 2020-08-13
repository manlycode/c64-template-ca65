#!/usr/bin/env bash
echo $1
echo $2
sleep 2 && /Applications/C64Debugger.app/Contents/MacOS/C64Debugger -pass -clearsettings -symbols $2 -prg $1 -breakpoints $3