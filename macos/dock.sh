#!/bin/zsh

dockutil --no-restart --remove all

dockutil --no-restart --add "$HOME/Applications/Outlook.app"
dockutil --no-restart --add "/Applications/Microsoft Teams.app"
dockutil --no-restart --add "/Applications/Microsoft To Do.app"
dockutil --no-restart --add "/Applications/Obsidian.app"
dockutil --no-restart --add "/Applications/Notes.app"
dockutil --no-restart --add "/System/Applications/Launchpad.app"
dockutil --no-restart --add "/Applications/Visual Studio Code.app"
dockutil --no-restart --add "/Applications/iTerm.app"
dockutil --no-restart --add "/Applications/Postman.app"
dockutil --no-restart --add "/Applications/One Markdown.app"
dockutil --no-restart --add "/Applications/Safari.app"
dockutil --no-restart --add "/Applications/Firefox.app"
dockutil --no-restart --add "/Applications/GitUp.app"
dockutil --no-restart --add "/Applications/Fork.app"
dockutil --no-restart --add "/Applications/ChatGPT.app"

killall Dock