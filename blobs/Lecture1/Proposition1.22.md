**Proposition 1.22.** *The ring $\mathbb{Z}$ is integrally closed.*

*Proof.* We apply the rational root test: suppose $r/s \in \mathbb{Q}$ is integral over $\mathbb{Z}$, where $r$ and $s$ are coprime integers. Then

$$\left(\frac{r}{s}\right)^n + a_{n-1} \left(\frac{r}{s}\right)^{n-1} + \cdots a_1 \left(\frac{r}{s}\right) + a_0 = 0$$

for some $a_0, \ldots, a_{n-1} \in \mathbb{Z}$. Clearing denominators yields

$$r^n + a_{n-1} s r^{n-1} + \cdots a_1 s^{n-1} r + a_0 s^n = 0,$$

thus $r^n = -s(a_{n-1} r^{n-1} + \cdots a_1 s^{n-2} r + a_0 s^{n-1})$ is a multiple of $s$. But $r$ and $s$ are coprime, so $s = \pm 1$ and therefore $r/s \in \mathbb{Z}$. $\square$

