@echo off
setlocal

rem ReplicatedStateMachineDemo

rem Get the directory of the current script
set BIN_DIR=%~dp0
echo BIN_DIR=%BIN_DIR%

rem Run the command with the given arguments
call "%BIN_DIR%run.cmd" org.jgroups.raft.demos.ReplicatedStateMachineDemo -props raft.xml %*

endlocal
