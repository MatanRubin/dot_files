#!/bin/bash

base=$(dirname ${BASH_SOURCE[0]})
pkgs=( $( < ${base}/devpkgs.list ) )
yum install ${pkgs[@]}

