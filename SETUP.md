# Installing and running the simulation

The simulation is designed to run on an Ubuntu server within the Brightbox
cloud, although it should work on Ubuntu anywhere. Patches welcome for
any discrepencies

## Installation

Create an Ubuntu Brightbox server [using the control panel](https://cloud.brightbox.com/login). Use the latest
Ubuntu version you can. If you want the simulation to be available over
IPv4 then map a CloudIP to the server.

Log on to the server and run the setup script directly from Github.

    $ curl https://raw.githubusercontent.com/NeilW/systemd-dining/master/setup.sh | sudo sh

This will install the support software, download the simulation and
setup both a web terminal and a secure socket forwarder protected by a
Let's Encypt TLS certificate.

## Running the simulation container

To start the simulation run

    $ sudo machinectl start philosophers

To stop the simulation run

    $ sudo machinectl stop philosophers

To access the simulation as the adminstrator

    $ sudo machinectl shell philosophers

The adminstrator [starts and stops the simulation](README.md) from the shell.

To remove the simulation so it can be reinstalled

    $ sudo machinectl remove philosophers
    $ sudo machinectl clean

## Reinstallation

Removing the simulation should be enough to allow you to run the setup
script again and pull down the latest version. Be warned it
removes all the data - including any agents or philosophers you've setup.

