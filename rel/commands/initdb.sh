#!/bin/sh
"$RELEASE_ROOT_DIR/bin/ewallet" command Elixir.LocalLedgerDB.ReleaseTasks initdb
"$RELEASE_ROOT_DIR/bin/ewallet" command Elixir.EWalletDB.ReleaseTasks initdb
