**Proposition 1.18.** *Let $\alpha, \beta \in B$ be integral over $A \subseteq B$. Then $\alpha + \beta$ and $\alpha\beta$ are integral over $A$.*

*Proof.* Let $f \in A[x]$ and $g \in A[y]$ be such that $f(\alpha) = g(\beta) = 0$, where

$$f(x) = a_0 + a_1 x + \cdots + a_{m-1} x^{m-1} + x^m,$$

$$g(y) = b_0 + b_1 y + \cdots + b_{n-1} y^{n-1} + y^n.$$

It suffices to consider the case

$$A = \mathbb{Z}[a_0, \ldots, a_{m-1}, b_0, \ldots, b_{n-1}], \qquad \text{and} \qquad B = \frac{A[x, y]}{\bigl(f(x), g(y)\bigr)},$$

with $\alpha$ and $\beta$ equal to the images of $x$ and $y$ in $B$, respectively, since given any $A' \subseteq B'$ we have homomorphisms $A \to A'$ defined by $a_i \mapsto a_i$ and $b_i \mapsto b_i$ and $B \to B'$ defined by $x \mapsto \alpha$ and $y \mapsto \beta$, and if $x + y, xy \in B$ are integral over $A$ then $\alpha + \beta, \alpha\beta \in B'$ must be integral over $A'$.

Let $k$ be the algebraic closure of the fraction field of $A$, and let $\alpha_1, \ldots, \alpha_m$ be the roots of $f$ in $k$ and let $\beta_1, \ldots, \beta_n$ be the roots of $g$ in $k$. The polynomial

$$h(z) = \prod_{i,j} \bigl(z - (\alpha_i + \beta_j)\bigr)$$

has coefficients that may be expressed as polynomials in the symmetric functions of the $\alpha_i$ and $\beta_j$, equivalently, the coefficients $a_i$ and $b_j$ of $f$ and $g$, respectively. Thus $h \in A[z]$, and $h(x+y) = 0$, so $x+y$ is integral over $A$. Applying the same argument to $h(z) = \prod_{i,j}(z - \alpha_i \beta_j)$ shows that $xy$ is also integral over $A$. $\square$
