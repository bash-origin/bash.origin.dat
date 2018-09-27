#!/usr/bin/env bash.origin.script

depend {
    "npm": {
        "@com.github/pinf-it/it.pinf.org.npmjs#s1": {
            "dependencies": {
                "dat": "^13.6.0"
            }
        }
    }
}

function EXPORTS_cli {
#    export NODE_PATH="$__DIRNAME__/.rt/it.pinf.org.npmjs/node_modules:$NODE_PATH"
    local datBinPath="$__DIRNAME__/.rt/it.pinf.org.npmjs/node_modules/.bin"

    BO_log "$VERBOSE" "Running: ${datBinPath}/dat $@"

    "${datBinPath}/dat" $@
}
