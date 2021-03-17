#!/bin/sh
# script to start all semaphores for the dining philosophers:

PAKCS=pakcs

$PAKCS :l PhiloExt :eval start_room  &
$PAKCS :l PhiloExt :eval start_fork0 &
$PAKCS :l PhiloExt :eval start_fork1 &
$PAKCS :l PhiloExt :eval start_fork2 &
$PAKCS :l PhiloExt :eval start_fork3 &
$PAKCS :l PhiloExt :eval start_fork4 &

# now you can start the philosophers

$PAKCS :l PhiloExt :eval start_phil 0 &
$PAKCS :l PhiloExt :eval start_phil 1 &
$PAKCS :l PhiloExt :eval start_phil 2 &
$PAKCS :l PhiloExt :eval start_phil 3 &
$PAKCS :l PhiloExt :eval start_phil 4 &
