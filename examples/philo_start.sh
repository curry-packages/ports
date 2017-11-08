#!/bin/sh
# script to start all semaphores for the dining philosophers:

pakcs :l philo_ext :eval start_room  &
pakcs :l philo_ext :eval start_fork0 &
pakcs :l philo_ext :eval start_fork1 &
pakcs :l philo_ext :eval start_fork2 &
pakcs :l philo_ext :eval start_fork3 &
pakcs :l philo_ext :eval start_fork4 &

# now you can start the philosophers

pakcs :l philo_ext :eval start_phil 0 &
pakcs :l philo_ext :eval start_phil 1 &
pakcs :l philo_ext :eval start_phil 2 &
pakcs :l philo_ext :eval start_phil 3 &
pakcs :l philo_ext :eval start_phil 4 &
