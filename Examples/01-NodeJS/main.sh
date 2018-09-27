#!/usr/bin/env bash.origin.script

# @see https://github.com/datproject/dat

depend {
    "process": "@com.github/bash-origin/bash.origin.process#s1",
    "npm": {
        "@com.github/pinf-it/it.pinf.org.npmjs#s1": {
            "dependencies": {
                "dat-node": "^3.3.2"
            }
        }
    }
}


rm -Rf "source" || true


CALL_process run "bash.origin.dat~01" {
    "share": {
        "env": {
            "NODE_PATH": "$__DIRNAME__/.rt/it.pinf.org.npmjs/node_modules:$NODE_PATH"
        },
        "commands": [
            "node main.js share"
        ]
    }
}

echo "OK"
