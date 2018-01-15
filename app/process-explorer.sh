#!/usr/bin/env bash

EXPLORER_PATH="/home/$USER/ark-sidechain"
CHAIN_NAME="sidechain"

process_explorer_args()
{
    while getopts p:n: option; do
        case "$option" in
            p)
                EXPLORER_PATH=$OPTARG
            ;;
            n)
                CHAIN_NAME=$OPTARG
            ;;
        esac
    done
}

process_explorer_start()
{
    heading "Starting Explorer..."
    process_explorer_args
    cd $EXPLORER_PATH
    forever start app.js --config "config.$CHAIN_NAME.autoforging.json" --genesis "genesisBlock.$CHAIN_NAME.json"
    success "Start OK!"
}

process_explorer_stop()
{
    heading "Stopping..."
    killall ng
    success "Stop OK!"
}

process_explorer_restart()
{
    heading "Restarting..."
    process_explorer_stop
    process_explorer_start
    success "Restart OK!"
}