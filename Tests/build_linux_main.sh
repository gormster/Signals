array_contains () {
    local seeking=$1; shift
    local in=1
    for element; do
        if [[ $element == $seeking ]]; then
            in=0
            break
        fi
    done
    return $in
}

swift build &> /dev/null &&
swift test -l | 
sed -e '/[ ]/ d' -e 's/\([^.]*\)\.\([^\/]*\)\/\(.*\)/\1 \2 \3/' |
{
    declare -a MODULES
    declare BODY=''

    while read MODULE CASE TEST
    do
        if ! array_contains "$MODULE" "${MODULES[@]}";
            then MODULES+=("$MODULE")
        fi
        if [ "$LASTCASE" -a "$CASE" != "$LASTCASE" ]
            then BODY+="]),\ntestCase([\n"
        fi
        LASTCASE=$CASE
        BODY+="(\"$TEST\", $CASE.$TEST),\n"
    done

    echo '// Generated by build_linux_main.sh'
    echo 'import XCTest'

    for i in "${MODULES[@]}"
    do
        echo "@testable import $i"
    done

    echo ''

    echo 'XCTMain(['
    echo 'testCase(['
    echo -e $BODY
    echo '])])'
}
