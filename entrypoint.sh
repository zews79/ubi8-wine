#!/bin/bash
Xvnc :0 -SecurityTypes None &
sleep 1
wine /usr/local/bin/server.exe
