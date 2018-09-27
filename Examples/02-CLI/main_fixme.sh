#!/usr/bin/env bash.origin.script

# @see https://github.com/datproject/dat

depend {
    "dat": "@com.github/bash-origin/bash.origin.dat#s1",
    "process": "@com.github/bash-origin/bash.origin.process#s1"
}

# TODO: Fix the CLI calls which are not working properly.

function EXPORTS_share {

    # @see https://github.com/datproject/dat#sharing-data

    rm -Rf ".source" || true
    mkdir ".source"

    pushd ".source" > /dev/null
        CALL_dat cli create --yes
    popd > /dev/null

    echo "Hello World" > ".source/test.txt"

    rm -f ".source.out.log" || true
    CALL_dat cli share ".source" | tee ".source.out.log"
}

function EXPORTS_receive {

    # @see https://github.com/datproject/dat#downloading-data

    local datUri="$(cat ".source.out.log" | grep -e "^dat:")"

    rm -Rf ".target" || true
    mkdir ".target"

    CALL_dat cli clone "${datUri}" ".target"
}

function EXPORTS_modify {

#    echo "Write to: .source/test.txt"
#    echo "Hello World" > ".source/test.txt"
#    cat ".source/test.txt"

sleep 5

echo "TARGET:"
    cat ".target/test.txt"
}


# TODO: Relocate this pattern into bash.origin.process and use above
if [ -z "$IN_PROCESS" ]; then

    CALL_process run "bash.origin.dat~01" {
        "share": {
            "env": {
                "IN_PROCESS": "1"
            },
            "run": (bash () >>>
                #!/usr/bin/env bash.origin.script

                depend {
                    "example": "./main.sh"
                }

                CALL_example share
            <<<)
        },
        "receive": {
            "depends": [
                "share"
            ],
            "env": {
                "IN_PROCESS": "1"
            },
            "run": (bash () >>>
                #!/usr/bin/env bash.origin.script

                depend {
                    "example": "./main.sh"
                }

                CALL_example receive
            <<<)
        },
        "modify": {
            "depends": [
                "share",
                "receive"
            ],
            "env": {
                "IN_PROCESS": "1"
            },
            "run": (bash () >>>
                #!/usr/bin/env bash.origin.script

                depend {
                    "example": "./main.sh"
                }

                CALL_example modify
            <<<)
        }
    }

fi

echo "OK"
