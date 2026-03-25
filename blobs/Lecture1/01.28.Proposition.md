**Proposition 1.28.** *Let $A$ be an integrally closed domain with fraction field $K$. Let $\alpha$ be an element of a finite extension $L/K$, and let $f \in K[x]$ be its minimal polynomial over $K$. Then $\alpha$ is integral over $A$ if and only if $f \in A[x]$.*

*Proof.* The reverse implication is immediate: if $f \in A[x]$ then certainly $\alpha$ is integral over $A$. For the forward implication, suppose $\alpha$ is integral over $A$ and let $g \in A[x]$ be a monic polynomial for which $g(\alpha) = 0$. In $\overline{K}[x]$ we may factor $f(x)$ as

$$f(x) = \prod_i (x - \alpha_i).$$

For each $\alpha_i$ we have a field embedding $K(\alpha) \to \overline{K}$ that sends $\alpha$ to $\alpha_i$ and fixes $K$. As elements of $\overline{K}$ we have $g(\alpha_i) = 0$ (since $f(\alpha_i) = 0$ and $f$ must divide $g$), so each $\alpha_i \in \overline{K}$ is integral over $A$ and lies in the integral closure $\tilde{A}$ of $A$ in $\overline{K}$. Each coefficient of $f \in K[x]$ can be expressed as a sum of products of the $\alpha_i$, and is therefore an element of the ring $\tilde{A}$ that also lies in $K$. But $A = \tilde{A} \cap K$, since $A$ is integrally closed in its fraction field $K$. $\square$

