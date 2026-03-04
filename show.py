import matplotlib.pyplot as plt
import pandas as pd

scdf = pd.read_csv("sc.csv")
mcdf = pd.read_csv("mc.csv")

plt.figure(figsize=(10, 5))
plt.subplot(1, 2, 1)
plt.plot(mcdf["n"], mcdf["mean"], label="Monte Carlo")
plt.plot(scdf["n"], scdf["mean"], label="Stochastic Collocation")
plt.xscale("log")
plt.xlabel("# of samples")
plt.ylabel("E[f]")
plt.grid(True)

plt.subplot(1, 2, 2)
plt.plot(mcdf["n"], mcdf["var"], label="Monte Carlo")
plt.plot(scdf["n"], scdf["var"], label="Stochastic Collocation")
plt.xscale("log")
plt.xlabel("# of samples")
plt.ylabel("Var[f]")
plt.legend()
plt.grid(True)

plt.savefig("test.png")