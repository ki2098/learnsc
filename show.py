import matplotlib.pyplot as plt
import pandas as pd

scdf = pd.read_csv("sc.csv")
mcdf = pd.read_csv("mc.csv")
pcdf = pd.read_csv("pce.csv")

plt.figure(figsize=(10, 5))
plt.subplot(1, 2, 1)
plt.plot(mcdf["n"], mcdf["mean"], label="Monte Carlo", marker=".")
plt.scatter(scdf["n"], scdf["mean"], label="Stochastic Collocation", marker="o", c="green")
plt.plot(pcdf["n"], pcdf["mean"], label="Polynomial Chaos", marker=".")
plt.xscale("log")
plt.xlabel("# of samples")
plt.ylabel("E[f]")
plt.grid(True)

plt.subplot(1, 2, 2)
plt.plot(mcdf["n"], mcdf["var"], label="Monte Carlo", marker=".")
plt.scatter(scdf["n"], scdf["var"], label="Stochastic Collocation", marker="o", c="green")
plt.plot(pcdf["n"], pcdf["var"], label="Polynomial Chaos", marker=".")
plt.xscale("log")
plt.xlabel("# of samples")
plt.ylabel("Var[f]")
plt.legend()
plt.grid(True)

plt.suptitle("$f=x^3+sin(x)$")
plt.savefig("test.png")