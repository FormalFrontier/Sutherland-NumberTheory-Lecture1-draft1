**Definition 1.10.** A *valuation* on a field $k$ is a group homomorphism $k^{\times} \to \mathbb{R}$ such that for all $x, y \in k$ we have

$$v(x + y) \geq \min\bigl(v(x), v(y)\bigr).$$

We may extend $v$ to a map $k \to \mathbb{R} \cup \{\infty\}$ by defining $v(0) \coloneqq \infty$. For any $0 < c < 1$, defining $\lvert x \rvert_v \coloneqq c^{v(x)}$ yields a nonarchimedean absolute value. The image of $v$ in $\mathbb{R}$ is the
<!-- continued from page 3 -->

*value group* of $v$. We say that $v$ is a *discrete valuation* if its value group is equal to $\mathbb{Z}$ (every discrete subgroup of $\mathbb{R}$ is isomorphic to $\mathbb{Z}$, so we can always rescale a valuation with a discrete value group so that this holds). Given a field $k$ with valuation $v$, the set

$$A := \{x \in k : v(x) \geq 0\},$$

is the *valuation ring* of $k$ (with respect to $v$). A *discrete valuation ring* (DVR) is an integral domain that is the valuation ring of its fraction field with respect to a discrete valuation; such a ring $A$ cannot be a field, since $v(\operatorname{Frac} A) = \mathbb{Z} \neq \mathbb{Z}_{\geq 0} = v(A)$.

It is easy to verify that every valuation ring $A$ is a in fact a ring, and even an integral domain (if $x$ and $y$ are nonzero then $v(xy) = v(x) + v(y) \neq \infty$, so $xy \neq 0$), with $k$ as its fraction field. Notice that for any $x \in k^{\times}$ we have $v(1/x) = v(1) - v(x) = -v(x)$, so at least one of $x$ and $1/x$ has nonnegative valuation and lies in $A$. It follows that $x \in A$ is invertible (in $A$) if and only if $v(x) = 0$, hence the unit group of $A$ is

$$A^{\times} = \{x \in k : v(x) = 0\},$$

We can partition the nonzero elements of $k$ according to the sign of their valuation. Elements with valuation zero are units in $A$, elements with positive valuation are non-units in $A$, and elements with negative valuation do not lie in $A$, but their multiplicative inverses are non-units in $A$. This leads to a more general notion of a valuation ring.

