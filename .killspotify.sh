#!/bin/bash

for i in $(ps -a | grep spotify | awk '{print $1'}); do
	kill $i
done

