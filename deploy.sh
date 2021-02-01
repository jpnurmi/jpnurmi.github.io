#!/bin/bash

path=$(realpath "$(dirname $0)")

pushd $path/src > /dev/null
(flutter build web --release && cp -r build/web/* $path)
popd > /dev/null
