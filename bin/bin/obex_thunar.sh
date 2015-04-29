#!/bin/bash
fusermount -u ~/bluetooth
obexfs -b $1 ~/bluetooth
thunar ~/bluetooth
