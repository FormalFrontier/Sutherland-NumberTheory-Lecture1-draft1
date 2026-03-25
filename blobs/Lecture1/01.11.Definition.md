**Definition 1.11.** A *valuation ring* is an integral domain $A$ with fraction field $k$ with the property that for every $x \in k$, either $x \in A$ or $x^{-1} \in A$.

Let us now suppose that the integral domain $A$ is the valuation ring of its fraction field with respect to some discrete valuation $v$ (which we shall see is uniquely determined). Any element $\pi \in A$ for which $v(\pi) = 1$ is called a *uniformizer*. Uniformizers exist, since $v(A) = \mathbb{Z}_{\geq 0}$. If we fix a uniformizer $\pi$, every $x \in k^{\times}$ can be written uniquely as

$$x = u\pi^n$$

where $n = v(x)$ and $u = x/\pi^n \in A^{\times}$ and uniquely determined. It follows that $A$ is a unique factorization domain (UFD), and in fact $A$ is a principal ideal domain (PID). Indeed, every nonzero ideal of $A$ is equal to

$$(\pi^n) = \{a \in A : v(a) \geq n\},$$

for some integer $n \geq 0$. Moreover, the ideal $(\pi^n)$ depends only on $n$, not the choice of uniformizer $\pi$: if $\pi'$ is any other uniformizer its unique representation $\pi' = u\pi^1$ differs from $\pi$ only by a unit. The ideals of $A$ are thus totally ordered, and the ideal

$$\mathfrak{m} = (\pi) = \{a \in A : v(a) > 0\}$$

is the unique maximal ideal of $A$ (and also the only nonzero prime ideal of $A$).

