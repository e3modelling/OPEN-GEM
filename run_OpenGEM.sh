#!/usr/bin/env bash

# ==============================
# SETTINGS
# ==============================
MODEL="OPEN_GEM.gms"

# Default GAMS flags
LO=2
PROFILE=0
TRACE=""

# ==============================
# ARGUMENT HANDLING
# ==============================

if [[ "$1" == "clean" ]]; then
    echo "Cleaning log/listing files in MODEL/ ..."
    rm -f MODEL/*.log MODEL/*.lst
    echo "Done."
    exit 0
fi

if [[ "$1" == "debug" ]]; then
    LO=4
    PROFILE=1
    TRACE="trace=trace.txt"
    echo "Running in DEBUG mode"
fi

if [[ "$1" == "quiet" ]]; then
    LO=0
    echo "Running in QUIET mode"
fi

# ==============================
# RUN
# ==============================

echo
echo "--- Starting GAMS run ---"
echo "Model: MODEL/$MODEL"
echo "lo=$LO profile=$PROFILE"
echo

# Move into MODEL so that '.' in GAMS means MODEL/
cd MODEL || exit 1

# Build command
CMD=(gams "$MODEL" lo=$LO gdx=output.gdx)

# Optional flags
[[ $PROFILE == 1 ]] && CMD+=(profile=1)
[[ -n "$TRACE" ]] && CMD+=($TRACE)

# Run
"${CMD[@]}"

echo
echo "--- Done ---"