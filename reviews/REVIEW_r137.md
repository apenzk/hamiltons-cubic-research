# Gate 2, Reviewer 137: second-order optimality, non-genericity, and the gap theorem

Cold review of commits `18852e4` and `cc47a91` (both touching [findings/second-order.md](../findings/second-order.md)), plus the item-1 target recorded in [plan.md](../plan.md) at `4e56943`. Sources read directly: [Krasnov–Tkachev 2018](https://arxiv.org/abs/1801.00617) and [Tkachev 2019](https://arxiv.org/abs/1801.05724). [scripts/](../scripts/) was not read.

## Verdicts

| claim | verdict |
|---|---|
| **A**, orbit directions are exact $\tfrac12$-eigenvectors, so $\lambda_{\max}\ge\tfrac12$ always | **CONFIRMED**, re-derived independently; the *multiplicity* clause is **OVERSTATED**, $\tfrac12$ can exceed the orbit dimension, and does at $S^3\times S^3$ |
| **B**, Theorem 3.2 forces $\mathrm{Weyl}_n$ non-generic | **CONFIRMED** for the theorem and the contrapositive; the commit's *second half*, the "mild restrictions" rescue and §4.2–4.3 as the concrete task, is **FALSE**, a misattributed quotation |
| **C**, equation (13), every idempotent a singular root | **CONFIRMED in substance, UNDERSTATED in force**, plus a real transcription error ($2^n$ should be $2^{\dim\mathrm{Weyl}_n}$) |
| **D**, the repair is an equivariant Euler–Jacobi, or syzygies on $\mathrm{Weyl}_n/O(n)$ | **FALSE in its premise** ("created entirely by the group action") and **ill-posed as a task**; witness inside this record |
| **E**, the gap theorem target | measurement **CONFIRMED as reported** (not re-run); the target is **UNTESTED** and its framing **OVERSTATED** in three named ways |
| **F**, Tkachev 2019 needs a unit, $\mathrm{Weyl}_n$ has none | **CONFIRMED**, and it predates these commits, [fence post at fence-posts.md](../findings/fence-posts.md) already carries it |

---

## A. The orbit directions

**Re-derived from scratch, and it is three lines.** $Q$ is $O(n)$-equivariant, so $\circ$ is: $(g\cdot X)\circ(g\cdot Y)=g\cdot(X\circ Y)$. Differentiate at $g=\mathrm{id}$ in a direction $A\in\mathfrak{so}(n)$ with $X=Y=e$, using $e\circ e=e$:

$$2\,L_e(A\cdot e)=A\cdot(e\circ e)=A\cdot e\qquad\Longrightarrow\qquad L_e(A\cdot e)=\tfrac12\,A\cdot e .$$

The orbit is inside the sphere, so $A\cdot W\perp W$ and the eigenvector sits in $W^\perp$. Hence $\lambda_{\max}(L_e|_{W^\perp})\ge\tfrac12$ at every critical point with $\theta>0$. This uses nothing about $\mathrm{Weyl}_n$ beyond equivariance and matches the record's own one-liner at [fence-posts.md](../findings/fence-posts.md). **Confirmed.**

**The orbit is never trivial**, which the record leaves implicit: $\mathrm{Weyl}_n$ is an absolutely irreducible nontrivial $O(n)$-module, so it carries no invariant vector, so $\mathrm{Stab}(W)\ne O(n)$ for $W\ne0$ and $\dim(\text{orbit})\ge1$. Without that step the floor argument has a gap at hypothetically invariant $W$.

**The multiplicity clause is where the record overreaches.** The derivation gives $m(\tfrac12)\ \ge\ \dim O(n)-\dim\mathrm{Stab}(W)$ and nothing more. It can be strictly larger, and **this record already contains the witness**: at $S^3\times S^3$ in $\mathrm{Weyl}_6$, $\dim E(\tfrac12)=18$ against an orbit of dimension $9$ ([fence-posts.md](../findings/fence-posts.md), the $(3,3)$ paragraph; $\dim O(6)-\dim(O(3)\times O(3))=15-6=9$, and $\mu=\tfrac12$ exactly there adds $\Lambda^2\otimes\Lambda^2$ of dimension $9$). Nine of the eighteen $\tfrac12$-directions have nothing to do with the group action.

That witness is what breaks claim D below.

**A caveat on what A buys.** The orbit directions are precisely the directions along which $P$ is *constant*. So the "equality to attain" is attained automatically and carries no information; the whole content of Lemma L24 lives on the complement of the orbit tangent inside $W^\perp$. The record's own framing ("detects non-maximality rather than gradedness"), is right, and the gap-theorem target should be stated on the normal slice rather than on $W^\perp$.

## B. Theorem 3.2, and a misattributed quotation

**The citation is verbatim correct.** The source reads: *"Theorem 3.2. If $A$ is a commutative generic algebra then $\tfrac12\notin\sigma(A)$. In the converse direction: if $\tfrac12\notin\sigma(A)$ and $A$ does not contain 2-nilpotents then $A$ is generic."* Genericity is Definition 3.1: $A_{\mathbb C}$ has exactly $2^{\dim A}$ distinct idempotents, Bézout's number. The record uses only the forward direction, contrapositively, which is valid. The converse's "no 2-nilpotents" hypothesis is therefore not load-bearing anywhere in the record, **checked, nothing leans on it.**

**The second half of `18852e4` misreads the source.** The commit says: *"Their §4.2–4.3 note the principal syzygies survive 'with some mild restrictions', and establishing which restrictions hold for $\mathrm{Weyl}_n$ is the concrete literature task standing between the record and a gap theorem."* Three things are wrong with that sentence.

1. **The quote is not from §4.2–4.3.** It occurs once in the paper, in §3 immediately after Remark 3.3.
2. **It is attached to the other branch of the dichotomy.** The full passage: *"the non-generic case is essentially equivalent to the inclusion $\tfrac12\in\sigma(A_{\mathbb C})$ **except for the case when $A_{\mathbb C}$ contains nonzero 2-nilpotents. The latter situation** is still close to the generic case: indeed, one can prove that the syzygies in Theorem 4.1 also valid with some mild restrictions. **But the case $\tfrac12\in\sigma(A_{\mathbb C})$ is really peculiar** because in that case normally $A_{\mathbb C}$ contains multiple or infinite number of idempotents."* The rescue is for algebras non-generic *only* through 2-nilpotents. $\mathrm{Weyl}_n$ is in the branch the authors flag as the peculiar one.
3. **§4.2 is "Syzygies in unital generic algebras."** By claim F, $\mathrm{Weyl}_n$ has no unit, so that section is inapplicable twice over.

So the "concrete literature task" named by `18852e4` rests on a sentence that says the opposite of what it was taken to say. **The claim about Theorem 3.2 stands; the task it recommends does not.**

## C. Equation (13), and what actually fails

**The identity is right and the reading of it is right.** Source, equation (9): $\det(D\Psi_A(c)-I)=2^n\det(\epsilon\circ L_x-\tfrac12 I)=2^n\chi_c(\tfrac12)$, with $f_A(x)=\Psi_A(x)-x$, so $\det Df_A(c)=2^n\chi_c(\tfrac12)$. Equation (13) is that identity carried into the regularity criterion $\det Df_A(c)=2^n\chi_c(\tfrac12)\ne0$. $\chi_c$ is the characteristic polynomial of $L_c$ on the **whole** algebra, and $L_c$ acts on all of $A$, the brief's worry about a subspace is unfounded.

**Three corrections, one of them real.**

- **$2^n$ means $2^{\dim A}$.** In Krasnov–Tkachev, $n=\dim A$ throughout. In this record $n$ is the dimension of the underlying $\mathbb R^n$, and $\dim\mathrm{Weyl}_n=n(n+1)(n+2)(n-3)/12$. The displayed formula in [findings/second-order.md](../findings/second-order.md) is therefore **wrong as written in this record's own notation**, it should read $2^{\dim\mathrm{Weyl}_n}$. The conclusion is unaffected (the exponent never vanishes), but the display is quoted verbatim into a document where $n$ has a fixed and different meaning.
- **The identity is (9); (13) is the criterion.** Harmless.
- **The Euler–Jacobi hypothesis the record cites is only one of two.** The source's statement requires *both* that every root $a\in S_{\mathbb C}(F)$ be simple *and* that $S_{\mathbb C}(\tilde F)=\{0\}$, where $\tilde F=\Psi_A$, i.e. **no nonzero complex 2-nilpotents**. The record names only the first.

**And the first failure is worse than the record says.** "Every idempotent here is a singular root, and the denominator vanishes at all of them" describes an arithmetic accident. The actual situation: since $g\cdot e$ is an idempotent whenever $e$ is, the idempotent set **contains whole $O(n)$-orbits and is positive-dimensional**, so $S_{\mathbb C}(f_A)$ is infinite and the sum $\sum_{a\in S(F)}h(a)/\det[DF(a)]$ has no finite index set to run over. Krasnov–Tkachev say exactly this themselves in the passage quoted above: *"in that case normally $A_{\mathbb C}$ contains multiple or infinite number of idempotents. In fact, it follows from Bézout's theorem that $A_{\mathbb C}$ contains some varieties of idempotents."* The vanishing Jacobian is the infinitesimal shadow; the positive-dimensional idempotent variety is the fact. **This matters for D**, because a device that repairs a vanishing determinant at isolated points is not a device that handles a positive-dimensional zero scheme.

### New: $\mathrm{Weyl}_n^{\mathbb C}$ *does* contain nonzero 2-nilpotents, so the second hypothesis fails too

**Proposition.** For every $n\ge5$ there is a nonzero $y\in\mathrm{Weyl}_n\otimes\mathbb C$ with $y\circ y=0$.

*Proof.* Let $e$ be a nonzero real idempotent (take any maximiser of $P$ on the sphere: $P$ is an odd-degree form, so $\max P>0$, giving $\theta>0$ and $e=W/\theta$). $Q$ is a polynomial identity, so equivariance extends to $O(n,\mathbb C)$ acting on $\mathrm{Weyl}_n^{\mathbb C}$, and the whole complex orbit $O(n,\mathbb C)\cdot e$ consists of idempotents. Its stabiliser subalgebra in $\mathfrak{so}(n,\mathbb C)$ is the complexification of the real one (the condition $A\cdot e=0$ is linear in $A$ with real coefficients), so $\dim_{\mathbb C}O(n,\mathbb C)\cdot e=\dim_{\mathbb R}O(n)\cdot e\ge1$. Its Zariski closure $V$ is a closed algebraic subvariety of $\mathbb C^{D}$ of dimension $\ge1$. A bounded closed positive-dimensional complex analytic subvariety of $\mathbb C^D$ would be compact, and the maximum principle applied to each coordinate function would force it to be a point; hence $V$ is **unbounded**. Take idempotents $x_k\in V$ with $\|x_k\|\to\infty$. Then $\Psi(x_k/\|x_k\|)=\Psi(x_k)/\|x_k\|^2=x_k/\|x_k\|^2\to0$, and passing to a subsequence with $x_k/\|x_k\|\to y$, $\|y\|=1$, continuity gives $\Psi(y)=y\circ y=0$. $\square$

The last step is Krasnov–Tkachev's own compactness argument from the proof of Theorem 3.2, run in the direction they did not need.

**Consequences.** (i) $\mathrm{Weyl}_n$ violates *both* Euler–Jacobi hypotheses, not one. (ii) It is not in the "still close to the generic case" branch under any reading, it fails the 2-nilpotent condition as well as the $\tfrac12$ condition. (iii) The real question "are there real 2-nilpotents", equivalently "are there real critical points with $\theta=0$", is left open by this argument and is worth a line in the record.

## D. The proposed repair, premise false, task ill-posed

**The premise is refuted by this record's own data.** `cc47a91` asserts *"The degeneracy is created entirely by the group action, the $\tfrac12$-eigenspace contains the orbit tangent, of dimension $\dim O(n)-\dim\mathrm{Stab}(W)$, which is exactly the degeneracy a quotient removes."* The containment is right; **"entirely" is false**, and the counterexample is in [fence-posts.md](../findings/fence-posts.md): at $S^3\times S^3$, $\dim E(\tfrac12)=18$ against orbit $9$, and the record itself classifies the excess as *"an eigenvalue coincidence, not representation mixing"*, the $\Lambda^2\otimes\Lambda^2$ summand happens to carry $\mu=\tfrac12$, for the arithmetic reason $\tfrac12-\mu=\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}$. Nothing about the group action produces those nine directions, and **no quotient by $O(n)$ removes them.** Whatever object the repair produces would still have a vanishing determinant at $S^3\times S^3$.

**The task as phrased names no object.** "The syzygies computed on $\mathrm{Weyl}_n/O(n)$" presupposes an algebra there. There is none: the orbit space is not a vector space, and $\circ$ does not descend, the orbit of $X\circ Y$ is not determined by the orbits of $X$ and $Y$. This is a stronger objection than the brief's ("the quotient is singular"), and it is not repairable by passing to a smooth locus.

**Two further obstacles to any honest version.**

- **Stabilisers jump.** $\dim\mathrm{Stab}$ varies across the critical set ($O(p)\times O(q)$ at the sphere products, generically much smaller at the ungraded points) so the components of the idempotent variety have *different dimensions*. Any localisation or excess-intersection formula would have to handle components of mixed dimension, which is where such formulas are hardest.
- **The invariant the syzygies are built from is exactly what vanishes.** Theorem 4.1 is a statement about $\sum_c \chi_c(t)/\chi_c(\tfrac12)$. Here $\chi_c(\tfrac12)\equiv0$, so a repaired formula must replace that denominator with something else, and there is no reason the resulting identities constrain the Peirce spectrum at all.

**The honest version of the task**, if one wants to keep it: replace $\chi_c(\tfrac12)$ by the **normal-slice determinant**

$$\det\!\big(Df_A(c)|_{N_c}\big)\;=\;2^{\dim N_c}\Big[\tfrac{\chi_c(t)}{(t-\tfrac12)^{m}}\Big]_{t=1/2},\qquad m=\dim O(n)\!\cdot\! e,$$

$N_c$ a normal slice to the orbit, and ask whether a global residue theorem holds for a $G$-invariant complete intersection whose zero scheme is a finite union of $G$-orbits. That is a precise question. **I found no such theorem in the literature** (see below) and at $S^3\times S^3$ even this reduced determinant vanishes, so the reformulation does not by itself rescue anything.

## E. The gap theorem target

I did not re-run the $n=6$ sweep and I did not attempt to drive $\lambda_{\max}$ below $1.17$ numerically; the measurement is reported as **CONFIRMED as reported, not independently verified**. What I can settle is the target's logical standing, and there the framing is overstated in three ways.

**1. The target is strictly stronger than the conjecture, and can fail while the conjecture holds.** $\lambda_{\max}\ge c>\tfrac12$ at every ungraded critical point says every ungraded critical point is a **strict saddle**. Conversely, a single ungraded critical point that is a *local* maximum has $\lambda_{\max}=\tfrac12$ and kills the target, while leaving Conjecture A, which is about the *global* maximum, untouched. [plan.md](../plan.md) records the implication "any such $c$ proves (G) outright" and not the converse risk. It should record both.

**2. Local maxima that are not global are abundant in this very record.** [fence-posts.md](../findings/fence-posts.md) proves *"for $p,q\ge3$ with $(p,q)\ne(3,3)$, $\lambda_{\max}(L_e|_{W^\perp})=\tfrac12$, attained exactly on the orbit tangent"*. So **every** two-block sphere product with $p,q\ge3$ sits exactly on the floor, $S^3\times S^9$ at $n=12$ is a local maximum and not the global one. The second-order criterion is therefore known, inside this record, to be satisfied by an infinite family of non-maximisers. Those are all graded, so no contradiction arises; but the inference "the ungraded population contains none" is an assumption about the one population nobody can enumerate, which is precisely the failure mode [plan.md](../plan.md) names in its own diagnosis section.

**3. The evidence base is thin exactly where it needs to be thick.** $155$ points at $n=6$: below the conjecture's threshold $n\ge12$, and at the single dimension this record flags as exceptional ($S^3\times S^3$ is the unique degenerate two-block product, and $n=6$ is the Morse–Bott exception). The target's constant $c$ is written uniform in $n$, while [nondegeneracy.md](../findings/nondegeneracy.md) already fences off exactly that: *"no argument may rest on a spectral gap or a $\theta$-margin uniform in $n$"*, with the padding law $\min|\lambda-\tfrac12|=\frac1{2(n_0-1)}$ as the mechanism. **[plan.md](../plan.md) should state whether $c$ is permitted to depend on $n$**; a per-dimension $c_n>0$ still proves (G) at each $n$, and is consistent with the record's own fence, whereas the uniform version as written contradicts it in spirit.

**4. The "$2.3\times$ of room" tractability argument does not survive the reformulation.** $\lambda_{\max}(L_e|_{W^\perp})=\max_{y\perp W,|y|=1}T(W,y,y)/\theta$, with $T(X,Y,Z)=\langle X,Y\circ Z\rangle$ the symmetric trilinear form. So the target is: for every ungraded critical $W$, produce $y\perp W$ with $T(W,y,y)\ge c\,\theta$. **That is a construction problem on an unenumerated set**, not an inequality with slack to spend; the observed $2.3\times$ is the *value* at points one can already write down, not the margin of any argument. The plan's comparison with branch 1 ("an inequality with that much slack tolerates crude estimation") compares an observed range with a proof margin, which are different things.

### A lever the record does not appear to use, offered as the constructive alternative

Two invariant-theoretic identities, both free:

- $\operatorname{tr}L_x\equiv0$. The record has this and uses it for claim F. It needs no computation: $x\mapsto\operatorname{tr}L_x$ is an $O(n)$-invariant linear functional on the nontrivial irreducible module $\mathrm{Weyl}_n$, hence zero.
- $\operatorname{tr}(L_xL_y)=\kappa_n\langle x,y\rangle$ for a constant $\kappa_n$. Same argument one level up: $B(x,y)=\operatorname{tr}(L_xL_y)$ is a symmetric $O(n)$-invariant bilinear form (because $L_{g\cdot x}=gL_xg^{-1}$) on an **absolutely irreducible** module, so it is a multiple of the metric.

At an idempotent $e=W/\theta$ these read $\sum_i\lambda_i=0$ and $\sum_i\lambda_i^2=\kappa_n/\theta^2$. Now impose second-order optimality, $\lambda=1$ simple, $\lambda=\tfrac12$ with multiplicity $m'\ge m=\dim(\text{orbit})$, all others $\le\tfrac12$. Cauchy–Schwarz on the remaining $D-1-m'$ eigenvalues, which must sum to $-(1+m'/2)$, gives

$$\frac{\kappa_n}{\theta^2}\;=\;\sum_i\lambda_i^2\;\ge\;\Phi(m',D):=1+\frac{m'}4+\frac{(1+m'/2)^2}{D-1-m'},\qquad D=\dim\mathrm{Weyl}_n,$$

and $\Phi$ is increasing in $m'$. Hence, **for any maximiser**,

$$\theta^2\ \le\ \frac{\kappa_n}{\Phi\big(\dim O(n)-\dim\mathrm{Stab}(W),\,D\big)} .$$

**Read the other way round, this is a symmetry-forcing theorem of exactly the shape of (G):** a maximiser's orbit cannot be too large, i.e. $\dim\mathrm{Stab}(W)$ is bounded *below* by an explicit function of $\kappa_n$, $\theta$, $n$. A generic ungraded point has $\dim\mathrm{Stab}=0$ and orbit $n(n-1)/2$, roughly twice the balanced product's $n^2/4$; the bound is strictly stronger there. Whether it bites is one number, $\kappa_n$, and **the record can compute it from data it already has**: $\kappa_n=\theta^2\sum_i\lambda_i^2$ at any single idempotent, and the full $S^p\times S^q$ spectrum is in closed form at [fence-posts.md](../findings/fence-posts.md).

**Two consistency checks I ran on that closed form, by hand, both passing.** With $s_m=(m+2)(m-1)/2$, $c_m=m(m-1)/2$, $\lambda_m=\frac{m-2}{2(m-1)}$, $\mu=\tfrac12-\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}$, eigenvalue $-\mu$ at multiplicity $s_ps_q$ and $+\mu$ at $c_pc_q$, $\tfrac12$ at $pq$, $1$ simple, $0$ on the rest: $\sum\lambda_i=0$ **exactly** at $(3,3)$ and at $(2,4)$. That is an independent confirmation of $\operatorname{tr}L_x\equiv0$ from the record's own spectrum, and of the spectrum from the identity.

**And a falsifiable prediction, one line to check.** $\theta^2\sum\lambda_i^2$ must be the *same* for every idempotent at fixed $n$. The spectra give $\sum\lambda_i^2=\tfrac{99}8$ at $(3,3)$ and $\tfrac{44}3$ at $(2,4)$, so with $\theta(3,3)=\theta_0(6)=\sqrt{40}/6$,

$$\theta(S^2\times S^4)\ \overset{!}{=}\ \theta_0(6)\sqrt{\tfrac{99/8}{44/3}}\ =\ 0.9682458\ldots$$

Likewise at $n=8$: $\sum\lambda_i^2=20$ at $(4,4)$ and $\tfrac{675}{32}$ at $(3,5)$, predicting $\theta(S^3\times S^5)=\theta_0(8)\sqrt{20\cdot32/675}=1.115\,55\ldots$ **If either fails, the Schur step or the recorded spectrum is wrong and the lever above collapses**; if both hold, $\kappa_n$ is in hand and the maximiser bound can be evaluated immediately. I state this as a derived prediction, unverified here.

## F. No unit

**Confirmed, and it predates these commits.** Tkachev 2019's abstract opens *"If $V$ is a finite-dimensional unital commutative (maybe nonassociative) algebra…"*, Definition 1.1 says *"A unital Euclidean metrised algebra such that the equality in (5) attains…"*, and the conjugation $c\mapsto\bar c:=e-c$ that drives (3)–(5) needs the unit outright. A unit $u$ in $\mathrm{Weyl}_n$ would give $L_u=\mathrm{Id}$ and $\operatorname{tr}L_u=D>0$ against $\operatorname{tr}L_x\equiv0$. The record already carries this as a fence post in [fence-posts.md](../findings/fence-posts.md), with the same argument; the brief presents it as a claim of these commits, and it is not.

The one improvement available: the trace identity itself needs no numerics, by the irreducibility argument in §E above. The recorded least-squares fit of $L_u$ to $\mathrm{Id}$ is corroboration, not the proof.

## Literature check

Numbered, with what each does and does not give.

1. **[Krasnov–Tkachev, *Variety of idempotents in nonassociative algebras*](https://arxiv.org/abs/1801.00617)**, Theorem 3.2, equations (9)/(12)/(13), Theorem 4.1 (the $n-1$ syzygies, generic algebras only), §4.2 (unital generic algebras). Their Euler–Jacobi is quoted from Arnold–Gusein-Zade–Varchenko and requires both simple roots and $S_{\mathbb C}(\tilde F)=\{0\}$. **No version for group-invariant systems appears anywhere in the paper.**
2. **[Tkachev, *On an extremal property of Jordan algebras of Clifford type*](https://arxiv.org/abs/1801.05724)**, the $|c|^2\le\tfrac12|e|^2$ bound and its equality case; **unital throughout**, so inapplicable here. What transfers without a unit: existence of extremal idempotents, and $\sigma(L_c|_{c^\perp})\subseteq(-\infty,\tfrac12]$ with $1$ simple, which is this project's Lemma L24.
3. **[Tkachev, *The universality of one half in commutative nonassociative algebras with identities*](https://arxiv.org/abs/1808.03808)**, *any* finite-dimensional commutative algebra satisfying a polynomial identity has $\tfrac12$ in its Peirce spectrum, and the $\tfrac12$-Peirce module then satisfies Jordan-type fusion laws. **Relevant and uncited here**: it supplies a mechanism for the universal $\tfrac12$ that is independent of the group action, so `18852e4`'s "*the* cause is $O(n)$-equivariance" is at best one of two candidate causes. Given that [Fox 2019](../references/fox-2019-nonassociative-curvature-algebra/) already treats $\mathrm{Weyl}_n$ as a nonassociative algebra, **whether $\circ$ satisfies a nontrivial identity is a cheap and worthwhile question**, and if it does, it also predicts the extra $\tfrac12$-directions at $(3,3)$ that the group action fails to explain.
4. **[Tkachev, *Medial and isospectral algebras*](https://arxiv.org/abs/2210.08245)**, isospectral algebras are *generic* commutative algebras whose idempotents share one Peirce spectrum. Generic again; does not reach this case.
5. **Global residue / Euler–Jacobi beyond the simple-root case**, [Cattani–Dickenstein–Sturmfels, *A global view of residues in the torus*](https://www.sciencedirect.com/science/article/pii/S002240499700008X) and [*Global residues for sparse polynomial systems*](https://arxiv.org/abs/math/0511684) extend the vanishing theorem to toric/sparse settings, and local Grothendieck residues handle **isolated but degenerate** zeros. **None of them handles a positive-dimensional zero scheme**, which is the situation here.
6. **Equivariant localisation**, Berline–Vergne / Atiyah–Bott and the Hamiltonian residue formulas ([lecture notes](https://www.math.toronto.edu/~jeffrey/mat1312/lec10.eqcoh.pdf)) localise to fixed-point sets of a *torus* action on a compact manifold. They are the nearest genuine relative of "an equivariant Euler–Jacobi", but the transfer would need a compact ambient, a torus rather than $O(n)$, and components of equal dimension. **I found no statement of an equivariant Euler–Jacobi formula, and no syzygy theory for Peirce spectra of algebras with a group action.** The task named in `cc47a91` is not a known open problem with a literature to consult; it is an unposed one.

---

## The single most load-bearing defect, and what would fix it

**Defect.** `cc47a91`'s premise, *"the degeneracy is created entirely by the group action … which is exactly the degeneracy a quotient removes"*, is **false**, refuted by this record's own $S^3\times S^3$ datum ($\dim E(\tfrac12)=18$, orbit $9$). Everything the commit builds on it falls with it: the quotient does not remove the degeneracy, "syzygies on $\mathrm{Weyl}_n/O(n)$" names no algebra, and the newly proved existence of complex 2-nilpotents means Euler–Jacobi's *other* hypothesis fails as well, independently of the group. The commit's closing sentence, *"a well-posed literature question rather than an open-ended search, and it is what stands between this record and a gap theorem"*, is the part to withdraw: the question is neither well-posed nor answered in the literature, and it is not what stands between the record and the gap theorem.

**Fix, in three parts.**

1. **Withdraw the "entirely" and the quotient task.** Replace with the accurate statement: $E(\tfrac12)\supseteq$ orbit tangent, with strict containment at $(3,3)$ and possibly elsewhere; the idempotent set is a positive-dimensional variety; $\mathrm{Weyl}_n^{\mathbb C}$ additionally has 2-nilpotents, so both Euler–Jacobi hypotheses fail. Correct $2^n$ to $2^{\dim\mathrm{Weyl}_n}$, and correct the "mild restrictions" attribution, that sentence is about the 2-nilpotent branch, and the source calls this record's branch "really peculiar".
2. **Restate the item-1 target.** Say explicitly (a) that it is equivalent to "no ungraded critical point is a local maximum mod $O(n)$", hence strictly stronger than (G) and falsifiable without touching Conjecture A; (b) whether $c$ may depend on $n$, since a uniform $c$ contradicts the record's own fence at [nondegeneracy.md](../findings/nondegeneracy.md); (c) that the $[1.17,96.3]$ range is $n=6$ evidence, below the threshold and at the record's exceptional dimension.
3. **Run the two-line check in §E and, if it passes, evaluate $\kappa_n$.** The invariant bound $\theta^2\le\kappa_n/\Phi(m,D)$ turns second-order optimality into a *lower bound on the maximiser's stabiliser dimension* (the shape (G) actually needs) and unlike the syzygy route it needs no genericity, no unit, and no quotient.
