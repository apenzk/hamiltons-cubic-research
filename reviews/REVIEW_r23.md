### Reviewer 23: the repaired regularity, and whether it closes the ungraded half

**The claim survives every attack and still closes nothing.** No counterexample exists among roughly 1500 verified critical points (no ungraded point with $\theta>1$) and $1$ is approached strictly from below, never attained. But three separate findings block the closure.

**The multi-block family, closed in form.** Derived symbolically for $k=2,3,4$ with symbolic block sizes and checked against the full $Q$ at residual $10^{-16}$:

$$\theta^2=\frac{2(n-1)^2}{(k-1)n^2+\sum_a\frac{(n-n_a)^2}{n_a-1}},\qquad S=\frac{3\theta^2e_3(n_1,\dots,n_k)}{(n-1)^2}.$$

Hence $\theta^2<2/(k-1)$ strictly, so $k\ge3$ forces $\theta<1$ for **every** partition and every $n$ (the counterexample hunted for cannot exist inside this family) and graded $\iff k\le2$, reproducing the empirical split exactly. Every recorded number follows: $161/192$ at $(S^8)^3$, $253/144$ at $S^{12}\times S^{12}$, the four two-block rationals at $n=12$, $\theta_0(n)^2$, and $\mathrm{RHS}=\theta(4m-1)/(3m-1)$.

**The RHS was computed wrongly.** The script omitted $\sqrt{1-e^2}$, measured between $0.575$ and $0.996$, so its $\mathrm{RHS}$ is too large: $(6,6,6)$ printed $1.322183$ against a true $1.200263$, and the file was inconsistent with the rest of the repository, which records the with-$e^2$ values. Under the correct $\mathrm{RHS}$ the trigger fraction falls from $100\%$ to $0.6\%$, the side condition does no filtering in its own test, and the "14 ungraded triggers" are **2**.

**Gradedness and $\theta$ are perfectly confounded.** On the only supporting family, ungraded means $k\ge3$ and $\theta$ depends on $k$ alone; the constant $1$ is precisely $\sqrt{2/(k-1)}$ at $k=3$. So what was shown is "$k\ge3\Rightarrow\theta\le1$", a block-count statement, with zero independent variation to separate it from the claim about gradedness.

**The complementary branch is the open grant.** At every witness $\delta^2=0$, $J_4=0$ and the cap vanishes, so $\mathrm{RHS}-\theta=J_5/r^2$ identically, measured $0.242$–$0.316$. The whole margin of $\theta\le\mathrm{RHS}$ at these points **is** $J_5\ge0$.

**New constructions, all below $1$.** Blocks carrying $U(m)$ or $Sp(m)$ structure (where $Q$ closes because $U(m_a)\times O(n_b)$ acts irreducibly on the mixed part), give ungraded points at $\theta=0.8367,0.8519,0.8577,0.8700$, with $\mathbb{CP}^2$ reproduced at $\sqrt{3/2}$ as a validation gate. The quaternionic family decreases: $\mathbb{HP}^2$ at $1.1155$ graded, then $0.8529$, $0.7454$, $0.6857$ ungraded.

**A sampling gap, now closed.** The vertex solver's 60 seeds missed the uniform $(6,6,6,6)$ point at $\theta=0.729670$ and the $(12,12)$ coarsening at $n=24$, so the enumeration was never a census; the closed form makes it one.
