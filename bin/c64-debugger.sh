#!/usr/bin/env bash
sleep 2 && /Applications/C64Debugger.app/Contents/MacOS/C64Debugger -pass -clearsettings -symbols $2 -prg $1 -breakpoints $3 -watch $4