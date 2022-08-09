#!/usr/bin/env bash
COMPONENT=mongodb

source Common.sh
NodeJs
mongo < catalogue.js
mongo < users.js

