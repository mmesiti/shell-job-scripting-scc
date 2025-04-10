#!/usr/bin/env python3
from matplotlib import pyplot as plt
from numpy import loadtxt
from sys import argv

# Not a real workflow!
data = loadtxt(sys.argv[1])
plt.plot(data)

