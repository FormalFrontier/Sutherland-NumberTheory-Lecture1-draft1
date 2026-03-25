**Proposition 1.25.** *Every valuation ring is integrally closed.*

*Proof.* Let $A$ be a valuation ring with fraction field $k$ and let $\alpha \in k$ be integral over $A$. Then

$$\alpha^n + a_{n-1} \alpha^{n-1} + a_{n-2} \alpha^{n-2} + \cdots + a_1 \alpha + a_0 = 0$$

for some $a_0, a_1, \ldots, a_{n-1} \in A$. Suppose $\alpha \notin A$. Then $\alpha^{-1} \in A$, since $A$ is a valuation ring. Multiplying the equation above by $\alpha^{-(n-1)} \in A$ and moving all but the first term on the LHS to the RHS yields

$$\alpha = -a_{n-1} - a_{n-1} \alpha^{-1} - \cdots - a_1 \alpha^{2-n} - a_0 \alpha^{1-n} \in A,$$

contradicting our assumption that $\alpha \notin A$. It follows that $A$ is integrally closed. $\square$
