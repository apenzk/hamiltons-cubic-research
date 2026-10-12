# Diagonality, the three instruments, their domains, and what each decides

Route R6 would prove *every maximiser of $P$ is coordinate-diagonalisable*, whereupon [Jäger's Theorem A](../references/jaeger-2016-diagonal-case/) closes Conjecture A. **It never estimates $\theta$**, which is why the fence posts, all of which fence *bounds on $\theta$*, do not reach it.

D1 states the instruments with the domain of each, per the rule that a route names where every borrowed quantity is defined.

## The three instruments

| instrument | decides | direction | domain |
|---|---|---|---|
| **Plücker obstruction** | non-diagonalisability | **sufficient**, certified | every $W\in\mathrm{Weyl}_n$; no criticality, no unit norm |
| **frame-minimal off-diagonal mass** $\min_{O(n)}$ | diagonalisability | **exact** ($=0$ iff diagonalisable) | every $W$; but it is an $O(n)$-minimisation, so *computing* it is a global search |
| **unitary isotropy** | non-diagonalisability | **sufficient, never necessary** | native dimension $4$ only |

> **THE OBSTRUCTION HAS A CLOSED FORM, AND IT IS A FOURTH MOMENT.** *At every skew $\omega$ and every $n$, $\lVert\omega\wedge\omega\rVert_\perp^2=2\langle\omega,\omega\rangle^2-\operatorname{tr}(\omega^4)$, in the multi-index-orthonormal norm named in [conventions.md](conventions.md).* **So on a unit sphere the certificate reads $\min\lVert\omega\wedge\omega\rVert_\perp^2=2-\max\operatorname{tr}(\omega^4)$**, and the search for a decomposable element in an eigenspace is a MAXIMISATION OF THE FOURTH MOMENT over that plane rather than a wedge computation. *The criterion falls out rather than being imposed alongside it: $\operatorname{tr}(\omega^4)=2\sum\sigma_i^4$ is maximal exactly when one singular value carries the mass, which is decomposability.*

> **THE NUMERALS ABOVE DO NOT USE THE IDENTITY'S INNER PRODUCT.** *At padded $W_{\mathbb{CP}^2}$ the eigenspace gives $\sum\sigma_i^4=\tfrac12$, and $0.875$ is unattainable there* ([r830](../reviews/REVIEW_r830.md), [r831](../reviews/REVIEW_r831.md), agreeing). **The non-diagonalisability verdicts do not depend on it**, the criterion being a vanishing rather than a value.

**Plücker.** $W$ is non-diagonalisable when some eigenspace of $W$ contains **no decomposable bivector**, a plane in $\Lambda^2$ meeting the Grassmann cone only at $0$. Certified by $\min\lVert\omega\wedge\omega\rVert>0$ over the eigenspace's unit sphere: $0.61$, $0.63$, $0.50$ at $\mathbb{CP}^4$, $\mathbb{CP}^5$, padded $W_{\mathbb{CP}^2}$.

**Frame-minimal mass.** The off-diagonal Frobenius mass minimised over $O(n)$, *not* the largest entry in whichever frame the constructor used; **the two statistics disagree even on ordering.** Values: $0$ at $S^p\times S^q$, the $C_5$ blow-up and padded sphere products; $0.837$, $0.866$, $0.707$ at $\mathbb{CP}^4$, $\mathbb{CP}^5$, padded $W_{\mathbb{CP}^2}$.

**Unitary isotropy is the one to distrust.** It is sufficient and **never necessary**, and its domain is narrower than it looks: padded $W_{\mathbb{CP}^2}$ is non-diagonalisable while its isotropy is *not* unitary, the $U(m)$ argument applying only in native dimension $4$; $\mathbb{CP}^m$ at odd $m$ fails likewise.

## What D2 must do, and the lever already on file

**D2:** *a maximiser cannot carry a Plücker-obstructed eigenspace.*

The lever is a tension the record already records ([stratum-two-negative.md](stratum-two-negative.md)). The chain's dominant term $(+--)\le6\lambda_1ab$ is tight only when $\lVert[v_{N-1},v_N]\rVert^2=2$, and that cap is attained **with both bivectors of matrix rank $4$**, at $n=6,8,12$ alike, so the structure does not vary with dimension. Simple bivectors do not attain it: $[\varphi_{12},\varphi_{13}]=\pm\varphi_{23}$ has norm $1$.

> **So equality pins the two negative eigenvectors to a $2$-plane of rank-$4$ bivectors, a plane containing no decomposable element, which is exactly the Plücker certificate for non-diagonalisability.** *An estimate cannot be tight and the point coordinate-diagonal at once.*

**That is a statement about where estimates are tight, not about the value of $\theta$**, which is why it survives the fence posts.

### But the lever points the wrong way, and D2 cannot use it as stated

Write the tension as an implication:

$$\text{(+--) estimate tight}\;\Longrightarrow\;\text{rank-}4\text{ }2\text{-plane}\;\Longrightarrow\;\text{Plücker-obstructed}\;\Longrightarrow\;\text{non-diagonalisable}.$$

**D2 needs *maximiser $\Rightarrow$ diagonalisable*, and this implication cannot deliver it.** Composing them gives only *maximiser $\Rightarrow$ estimate not tight*, which says nothing about diagonality; and if a maximiser *did* make the chain tight, the implication would give **maximiser $\Rightarrow$ non-diagonalisable, the opposite of D2's goal.**

*Its contrapositive, diagonalisable $\Rightarrow$ not tight, is a fact about diagonal points and not about maximisers.*

**So D2 needs a different mechanism.** What would serve is an implication running *from* maximality *to* the absence of an obstructed eigenspace, a second-order argument at the maximiser, not a tightness observation about an estimate. *The tension is real and stays on file as a fact about the estimate; it is the wrong tool for this route, and recording it as D2's lever was an error of direction rather than of content.*

## What the closure leaves behind, a mechanism worth having

**A positive result comes from the same material.** [stratum-two-negative.md](stratum-two-negative.md) caps the $k\le2$ stratum at $\sqrt{3/2}<\theta_0(n)$ from $n=12$, **so no maximiser lies in it**, which answers the first question this file listed as owed. And the cap **saturates identically** there, giving an unrecorded theorem:

> **Every one-positive/two-negative element is Plücker-obstructed.**

**The implication built on it does not follow**: a perturbed balanced sphere product at $n=12$ has every eigenline obstructed, $\lVert\omega\wedge\omega\rVert\ge0.44$, with $\theta$ up to $1.2360>\sqrt{3/2}$. *The obstruction is generic, so it cannot cap $\theta$, and reading "sufficient for non-diagonalisability" as a bound on $\theta$ was a converse error.*

*So the implication D2 needed all along is not a second-order argument but*

$$\text{Plücker-obstructed}\;\Longrightarrow\;\theta\le\sqrt{3/2},$$

**which is the record's own live target** and would close the conjecture from $n=12$ directly, the non-diagonal locus being exactly where the obstruction lives. *That is a bound on $\theta$ and therefore subject to the fence posts, which is the honest price, and it is what route R6 was avoiding by proving diagonality instead.*

**And D1 omitted the one test that is necessary and sufficient**: $\ker\Phi_W$, which the plan names as the third instrument and this file replaced with unitary isotropy.

## Route R6 is CLOSED

**The replacement mechanism cannot exist.** D2 was respecified as *a second-order argument at the maximiser*. Padded $W_{\mathbb{CP}^2}$ refutes that outright: at $n=8$ and $n=12$ it is a **local maximum**, $\max\operatorname{spec}(L_e|_{W^\perp})=0.5$ exactly, **no** eigenvalue above $\tfrac12$, criticality residual $\sim10^{-15}$, and the $\tfrac12$-eigenspace is exactly the orbit ($18$ and $34$, matching $\binom n2-\dim\mathfrak k(W)$), **and it is Plücker-obstructed**, its $2$-dimensional $(-0.408248)$ eigenspace having $\min\lVert\omega\wedge\omega\rVert=0.5$.

*So local second-order data at a non-diagonalisable point is indistinguishable from a maximiser's.* Only the **value** separates them, $\sqrt{3/2}<\theta_0(12)$, which makes D2 a bound on $\theta$ over the non-diagonal locus, **the exact activity route R6 claimed to escape**. [Post F22](fence-posts.md) fences it.

**And route R6 is the record's lifting lemma under a new name**, three closed attacks in [ATTEMPTS.md](../ATTEMPTS.md), named open in [problem.md](problem.md) item 11, cited by neither the plan nor this file when the route was proposed.

**What it would have bought, for the record:** Conjecture A at every even $n\ge12$, and it is *equivalent* to the conjecture there, not a reduction of it.

## The unitary-isotropy row above is wrong

$\mathfrak k(\text{padded }W_{\mathbb{CP}^2})=\mathfrak u(2)\oplus\mathfrak{so}(n-4)$ exactly, block-diagonal, commuting with $J$ to $10^{-15}$: **its isotropy IS unitary**, and it is [ATTEMPTS.md](../ATTEMPTS.md)'s first *application* of the proposition rather than a failure of it. $\mathbb{CP}^m$ at odd $m$ has isotropy exactly $\mathfrak u(m)$ too. *The row's "sufficient, never necessary, native dimension 4 only" was a misreading of the source it cites.*

## What is owed before D2 can be attempted

- **Whether a maximiser must make that chain tight.** The tension binds only where the $(+--)$ estimate is an equality; a maximiser that leaves slack there is untouched by it.
- **The converse direction.** Plücker certifies non-diagonalisability; D2 needs its negation at a maximiser, so the argument must run *from* maximality *to* the absence of an obstructed eigenspace.
- **The $n$ range.** Jäger's Theorem A is even $n\ge16$, and [Lemma L1](problem.md) addresses $n=12,14$ conditionally. **The range this route rests on is [result 57](INDEX-results.md)'s**, which carries the diagonal case at every $n\ge4$ and both parities, *citing L1 here rested the route on the weaker of the two.*
