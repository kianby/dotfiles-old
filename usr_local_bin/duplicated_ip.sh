#!bin/sh

for i in {1..254};
do
    arping -D -I p1p1 -c 2 192.168.0.$i;
done
