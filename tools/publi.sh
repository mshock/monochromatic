#!/bin/bash

# Re-generate the RSS feed
tools/feeds.sh

# Check HTML / CSS / RSS
tools/check.sh

# Check what have changed
git status
