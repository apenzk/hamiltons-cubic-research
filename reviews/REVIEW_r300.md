# Reviewer 300, the two V3 closures, the trace identity behind them, and the subspace that breaks one

Cold adversarial audit of G1–G5. Every number below comes from [scripts/reviewers/r300/core300.py](../scripts/reviewers/r300/core300.py), written from the definitions in the brief and sharing no code with [review_r30_core.py](../scripts/lib/review_r30_core.py) or [g1_le_machinery.py](../scripts/lib/g1_le_machinery.py). Independent controls: $\dim\mathrm{Weyl}_n=n(n+1)(n+2)(n-3)/12$ at $n=5,\dots,10$; the four test points rebuilt from their own definitions (Ricci-flat diagonal ansatz for sphere pairs, the Fubini–Study $4$-tensor projected into $\mathrm{Weyl}_{2m}$ for $\mathbb{CP}^m$, the graph rule for the $C_5$ blow-up) and each verified critical to $\le1.5\times10^{-15}$, Ricci-flat to $\le8\times10^{-16}$, Bianchi to $\le3\times10^{-16}$; $\theta=0.670820393$ and $\Delta=12$ of $4(n-1)=36$ at the $C_5$ blow-up; $\lambda_{\max}=0.500000000$, $0.600000000$, $0.625000000$, $1.206011330$ at $S^3\times S^5$, $\mathbb{CP}^4$, $\mathbb{CP}^3$ and the $C_5$ blow-up.

| claim | verdict |
|---|---|
| **G1**, the averaging attempt over symmetric deformations fails | **REFUTED.** The three numbers are exact ($7/17$, $3/5$, $0.446362$) and the narrow sentence about $V=\mathrm{Sym}_0$ stands. The headline does not: averaging over the **$C_5$-edge** sub-collection of the same $H_A$ gives **exactly $2/3$** at the $C_5$ blow-up, which proves non-maximality there by averaging alone |
| **G2**, the Weyl projection is load-bearing | **CONFIRMED.** $0.571429=4/7$ reproduced, $35.36\%$ of $\lVert H_A\rVert$ lies outside $\mathrm{Weyl}_8$. The projection **order** provably does not matter: the two projectors commute because $e\in\mathrm{Weyl}_n$ |
| **G3**, the symmetric-deformation lead is narrower than reported | **PLAUSIBLE.** Both numbers exact; but "the violating direction" is undefined at both points (top eigenvalue has multiplicity $15$ at $\mathbb{CP}^4$ and $2$ at the $C_5$ blow-up), and the inference "a proof of V3 needs directions outside it too" does not follow, $0.820541>\tfrac12$ already closes the point |
| **G4**, the global first moment is inert | **CONFIRMED**, with a derivation and a strengthening: $\operatorname{tr}_{\mathrm{Weyl}_n}(L_Y)=0$ for **every** symmetric $Y$ on $\Lambda^2$, needing neither criticality, nor unit norm, nor $Y\in\mathrm{Weyl}_n$. It is Fox's Theorem 1.3 for the fourth time |
| **G5**, the reconciliation | **CONFIRMED.** The misread premise is in the record verbatim at commit `7ee03c0`, and the contradiction with Observation L25 is real, not a scoping artefact. One caveat: the orbit component $1.1\times10^{-15}$ is a **tautology**, forced by $\mathcal O\subseteq E(\tfrac12)$ and self-adjointness, so it is evidence for nothing |

**No counterexample to V3 found.** An independent hunt at $n=6$ converged $58$ critical points from $60$ random starts; every one has $\Delta>0$, and $\lambda_{\max}\in[1.670152,\,96.291798]$, the ceiling reproducing Observation L25's $96.3$ from code that never read it. None has $\lambda_{\max}\le\tfrac12$.

---

## G1, REFUTED: the closure was drawn from the wrong subspace

**The arithmetic is right.** With $H_A=D_AW+WD_A$ projected into $\mathrm{Weyl}_n$ and then into $e^\perp$, $\operatorname{tr}(L_e|_V)/\dim V$ is

| point | $n$ | $\dim V$ | $\operatorname{tr}/\dim$ | exact | $\lambda_{\max}$ full |
|---|---|---|---|---|---|
| $S^3\times S^5$ | $8$ | $34$ | $0.411765$ | $7/17$ | $0.500000$ |
| $\mathbb{CP}^4$ | $8$ | $15$ | $0.600000$ | $3/5$ | $0.600000$ |
| $C_5$ blow-up | $10$ | $54$ | $0.446362$ |, | $1.206011$ |

reproducing the record's $0.412$, $0.600$, $0.446$ to every digit quoted.

**But two of the three numbers carry no information, and one of them says the opposite of what it is used for.**

- $S^3\times S^5$ **is a local maximum**, so *every* subspace average there is $\le\tfrac12$ by Lemma L24 itself. A method returning more than $\tfrac12$ at that point would be wrong. $0.412$ is a consistency check, not evidence about the method.
- $\mathbb{CP}^4$ returns $0.600$, which is **above** $\tfrac12$, so the averaging argument **succeeds** there. The brief's "below the $\tfrac12$ an averaging argument needs" and [bounds.md](../findings/bounds.md)'s "against the $\tfrac12$ needed" are false at that entry. The reason is structural: at $\mathbb{CP}^4$, $V$ is *exactly* the top eigenspace, all $15$ principal cosines between $V$ and $E(0.6)$ equal $1.000000$, and $\dim V=15=m^2-1$, the $\mathfrak{su}(4)$ summand of Observation L25's table.

So the entire weight of G1 rests on one number at one point: $0.446362$ at the $C_5$ blow-up.

**And that number is an averaging artefact of the chosen index set.** Split $\mathrm{Sym}_0(\mathbb R^{10})$ by the block structure the blow-up already carries, and the same construction gives, at the $C_5$ blow-up:

| $A$ ranges over | $\dim$ | $\operatorname{tr}(L_e\vert)/\dim$ | spectrum on the subspace |
|---|---|---|---|
| all of $\mathrm{Sym}_0$, the record's $V$ | $54$ | $0.446362$ | $[\,\cdot\,,0.820541]$ |
| supported **inside** blocks | $14$ | $0.180328$ | $[\,\cdot\,,0.820541]$ |
| supported **across** blocks | $40$ | $\mathbf{0.539474}=41/76$ | $\{47/114,\ 2/3\}$ |
| across an **edge of $C_5$** | $20$ | $\mathbf{0.666667}=2/3$ | $\{2/3\}$ exactly |
| across a **non-edge** of $C_5$ | $20$ | $0.412281=47/114$ | $\{47/114\}$ exactly |

The $C_5$-edge family is a **$20$-dimensional exact eigenspace of $L_e$ at $\tfrac23$**, inside $\mathrm{Weyl}_{10}$ to $2.1\times10^{-15}$, orthogonal to $W$ to $3.8\times10^{-17}$, and orthogonal to the orbit tangent (largest principal cosine $0.000$). Basis-independence checked by re-running through a random $\mathrm{GL}$ change of basis inside the $A$-space: same $2/3$, same spectrum. So

$$\lambda_{\max}(L_e|_{e^\perp})\ \ge\ \frac{\operatorname{tr}(L_e|_{V_{\text{edge}}})}{\dim V_{\text{edge}}}=\frac23\ >\ \frac12,$$

**a complete averaging proof that the $C_5$ blow-up is not a local maximum**, no eigenvector, no eigenvalue computation, no violating direction. The record's sentence "the violation at a $\Delta>0$ point is carried by particular directions and not by the average" is false at the only $\Delta>0$ point it tests.

**The edge directions in closed form**, so nothing here rests on my $D_A$ implementation. For $A=E_{kl}+E_{lk}$ with $k,l$ in different blocks and $W$ diagonal in the coordinate $2$-planes with entries $w_{ij}$,

$$H_A\ =\ D_AW+WD_A\ =\ \sum_{j\ne k,l}(w_{kj}+w_{lj})\big(\varphi_{lj}\otimes\varphi_{kj}+\varphi_{kj}\otimes\varphi_{lj}\big),$$

matching $D_AW+WD_A$ to $0.0$ exactly at the $C_5$ blow-up. $D_A$ swaps $\varphi_{kj}\leftrightarrow\varphi_{lj}$ and annihilates every other basis $2$-plane, and $W$ is diagonal, which is the whole derivation.

**The sub-collection is canonical, not reverse-engineered from the answer.** It is indexed by the edges of the negative-block graph, the same object $S_{\mathfrak{mmm}}=3\times(\text{triangles})$ is built from in [b_c5_blowup.py](../scripts/lib/b_c5_blowup.py). Run on other block points it behaves like an instrument rather than a coincidence:

| point | negative graph | $\dim V_{\text{edge}}$ | $L_e$ on $V_{\text{edge}}$ | relation to the orbit |
|---|---|---|---|---|
| $S^3\times S^5$, $S^2\times S^6$, $S^3\times S^7$, $S^2\times S^4$ | $K_2$ | $15,12,21,8$ | $\tfrac12$ exactly | **is** the orbit tangent (all principal cosines $1$) |
| $K_3,K_4,K_5$ blow-ups ($n=6,8,9,10$) | complete | $12,24,27,40$ | $\tfrac12$ exactly | orthogonal to the orbit |
| $C_5$ blow-up | $C_5$ | $20$ | $\mathbf{\tfrac23}$ exactly | orthogonal to the orbit |

So the edge average sits *at* the bound on every complete negative graph (where it is the inert orbit direction or a tautological copy of it) and *strictly above* the bound at the one triangle-free point. That is exactly the discrimination V3 needs, and it lives inside the family the record has just told itself not to retry.

**Verdict.** The literal sentence *"no trace argument over $V$ proves V3"*, with $V$ the full $\mathrm{Sym}_0$ span, is CONFIRMED. The claim as titled (the averaging attempt over symmetric deformations fails), is **REFUTED**, and the record's "recorded so it is not retried" would cost the programme the strongest V3 lead on the file.

---

## G2, CONFIRMED, and the projection order is provably irrelevant

Without the $\mathrm{Weyl}_n$ projection, taking the span of the raw $H_A$ inside $\mathrm{Sym}^2(\Lambda^2)$ and forming $\langle v_i,L_ev_j\rangle$:

| point | no-projection $\lambda_{\max}$ | full-space $\lambda_{\max}$ | $\lVert H_A-P_{\mathrm{Weyl}}H_A\rVert/\lVert H_A\rVert$ |
|---|---|---|---|
| $S^3\times S^5$ | $0.571429=4/7$ | $0.500000$ | $0.3536$ |
| $\mathbb{CP}^3$ | $0.553947$ | $0.625000$ | $0.5145$ |
| $\mathbb{CP}^4$ | $0.567655$ | $0.600000$ | $0.3536$ |
| $C_5$ blow-up | $0.814324$ | $1.206011$ | $0.2712$ |

$0.571429>0.500000$ at $S^3\times S^5$ reproduces the record's $0.571$, and the diagnosis is right: a quarter to a half of $H_A$'s norm lies outside $\mathrm{Weyl}_n$, so the object computed is not a restriction of the self-adjoint $L_e$ on $\mathrm{Weyl}_n$ and is not bounded by its top eigenvalue. The deeper reason to project is variational rather than arithmetical, the Hessian is $6\theta(L_e-\tfrac12\mathrm{Id})$ on the tangent space of the unit sphere **of $\mathrm{Weyl}_n$**, so a direction leaving $\mathrm{Weyl}_n$ is not an admissible test direction at all.

**The order does not matter, and this is a one-line theorem rather than a measurement.** $P_{e^\perp}=\mathrm{Id}-\hat e\hat e^{\!\top}$ with $\hat e=W$ of unit norm, and $W\in\mathrm{Weyl}_n$, so $P_{\mathrm{Weyl}}\hat e=\hat e$; hence $P_{\mathrm{Weyl}}P_{\hat e}=\hat e\hat e^{\!\top}=P_{\hat e}P_{\mathrm{Weyl}}$ by symmetry of $P_{\mathrm{Weyl}}$, and the two projectors commute. Verified: the subspaces produced by the two orders have smallest principal cosine $1.000000000000$ at all four points, identical dimensions, and identical $\operatorname{tr}/\dim$ to twelve digits.

---

## G3, PLAUSIBLE: numbers exact, wording and inference both loose

Reproduced: $\lambda_{\max}(L_e|_V)=0.600000$ against the full-space $0.600000$ at $\mathbb{CP}^4$, and $0.820541$ against $1.206011$ at the $C_5$ blow-up, ratio $0.680376$.

**"The violating direction" is not well defined at either point.** The top eigenvalue of $L_e|_{e^\perp}$ has multiplicity $15$ at $\mathbb{CP}^4$ (the $\mathfrak{su}(4)$ summand, matching Observation L25's table) and multiplicity $2$ at the $C_5$ blow-up. What is well defined is the pair of scalars quoted, and those are right. At $\mathbb{CP}^4$ the stronger true statement is available: $V$ **is** the top eigenspace, not merely a subspace containing a top eigenvector. At the $C_5$ blow-up the principal cosines between $V$ and the $2$-dimensional top eigenspace are $0.649457$ twice.

**The inference drawn does not follow.** "$\mathrm{Sym}_0$ captures the whole violation at the Kähler points and only part of it at the blow-up, and a proof of V3 needs directions outside it too", the second half is wrong. A proof of V3 needs *a* violation, not *the largest* one, and $\mathrm{Sym}_0$ already delivers $0.820541>\tfrac12$ at the blow-up; with G1's edge sub-collection it delivers $\tfrac23$ without an eigenvector at all. What the $0.680376$ measures is that $\mathrm{Sym}_0$ does not diagonalise $L_e$ at the blow-up, which no proof requires.

---

## G4, CONFIRMED, derived, and stronger than stated

**Measured first.** $\operatorname{tr}(L_X)$ on $\mathrm{Weyl}_n$ over random, deliberately **non-critical** $X$ (criticality residual $0.33$–$0.61$):

| $n$ | $5$ | $6$ | $7$ | $8$ | $9$ | $10$ |
|---|---|---|---|---|---|---|
| $\dim\mathrm{Weyl}_n$ | $35$ | $84$ | $168$ | $300$ | $495$ | $770$ |
| $\operatorname{tr}(L_X)$ | $-8.3\text{e}{-16}$ | $6.6\text{e}{-16}$ | $-8.9\text{e}{-16}$ | $-5.6\text{e}{-17}$ | $1.1\text{e}{-16}$ | $-5.0\text{e}{-16}$ |
| $\operatorname{tr}(L_e|_{X^\perp})$ | $-1.000000000000$ | $-1$ | $-1$ | $-1$ | $-1$ | $-1$ |

and $0$ likewise at all four catalogued points. So the identity is confirmed, and the $-1$ needs **only $P(W)\ne0$**: for $\hat W$ of unit norm and $e=\hat W/P(\hat W)$, $\langle\hat W,L_e\hat W\rangle=T(e,\hat W,\hat W)=P(\hat W)/P(\hat W)=1$, so $\operatorname{tr}(L_e|_{\hat W^\perp})=\operatorname{tr}(L_e)-1=-1$ by self-adjointness. Criticality is used nowhere.

**Derivation, as asked.** $Y\mapsto\operatorname{tr}_{\mathrm{Weyl}_n}(L_Y)=\sum_k\langle B_k,Y\circ B_k\rangle$ is a **linear** functional of $Y$, and $\circ$ is $O(n)$-equivariant with $\mathrm{Weyl}_n$ an $O(n)$-invariant subspace, so the functional is $O(n)$-invariant: it is $\langle Z,\cdot\rangle$ for some invariant $Z\in\mathrm{Sym}^2(\Lambda^2)$. $\Lambda^2\mathbb R^n$ is $O(n)$-irreducible, so the invariant symmetric operators are $\mathbb R\cdot\mathrm{Id}$ and $Z=c_n\mathrm{Id}$, giving $\operatorname{tr}(L_Y)=c_n\operatorname{tr}(Y)$. Two consequences, both checked:

- $\operatorname{tr}(Y)=0$ for $Y\in\mathrm{Weyl}_n$ (it is half the scalar curvature), so **Ricci-flatness alone gives $\operatorname{tr}(L_Y)=0$**, no criticality, no unit norm, no $\theta>0$;
- fitted at $Y=\mathrm{Id}$, $c_n=0.000000000$ at $n=5,6,7,8$, and $\lvert\operatorname{tr}(L_Y)\rvert\le1.7\times10^{-14}$ over random symmetric $Y$ on $\Lambda^2$ with $\operatorname{tr}(Y)\ne0$. So the identity is **stronger than the record states**: the trace over $\mathrm{Weyl}_n$ of $L_Y$ vanishes for *every* symmetric $Y$, Ricci-flat or not.

**Which hypothesis is actually load-bearing: the trace space, not the argument.** Repeating the trace over the larger Bianchi-only space of algebraic curvature tensors (dimension $50$ at $n=5$, $105$ at $n=6$) and taking $Y=\mathrm{Id}/\lVert\mathrm{Id}\rVert$ (the constant-curvature tensor, $\mathrm{Ric}\ne0$), gives $\operatorname{tr}(L_Y)=+7.905694$ and $+11.618950$. Drop Ricci-flatness from the space being traced and the identity dies; drop it from $Y$ and nothing happens.

**Two scope remarks.**

1. It is **not new**: this is Fox's Theorem 1.3, $\operatorname{tr}(L_x)=0$, recorded in [second-order.md](../findings/second-order.md) with the note that it has been re-derived unwittingly three times. This is the fourth. What G4 adds is only the negative gloss, and that gloss is correct: a quantity independent of $W$ cannot separate maximisers from non-maximisers.
2. It is **narrower than the pair G1+G4 is being used for**. G4 closes the *global* first moment; G1 was meant to close the *subspace* first moment. G1 is refuted above, so the subspace first moment is not closed, and at the $C_5$ blow-up it is, on its own, decisive. The record's "the first two moments of $L_e$ are both closed for V3" therefore holds only for the global moments.

---

## G5, CONFIRMED, with one number demoted to a tautology

**The misread premise is in the record verbatim.** Commit `7ee03c0`, [findings/bounds.md](../findings/bounds.md): *"Since Lemma L24 reads $\lambda_{\max}(L_e|_{e^\perp})\le\tfrac12$, a large $\Delta$ piles directions up AT the bound and can never push one above it. So '$\Delta>0\Rightarrow$ the second-order condition fails $\Rightarrow$ not a local maximum' … cannot work."* Lemma L24's hypothesis is that $W$ is a maximizer; the sentence applies its conclusion to an arbitrary critical point. G5's characterisation is accurate.

**The contradiction with Observation L25 is real and not a scoping artefact.** Observation L25's population is *"155 converged critical points at $n=6$, all ungraded"*, i.e. exactly critical points, with $\lambda_{\max}\in[1.17,96.3]$ and none satisfying $\lambda_{\max}\le\tfrac12$. Under the misread premise there would be none above $\tfrac12$ at all. My own independent run converged $58$ critical points from $60$ random starts at $n=6$: all with $\Delta>0$, $\lambda_{\max}\in[1.670152,\,96.291798]$, ceiling matching the recorded $96.3$. A single point suffices anyway, $\mathbb{CP}^3$ is critical to $1.2\times10^{-15}$ with $\lambda_{\max}=0.625$.

**What survives is right but nearly free.** *"No argument evaluating the second-order form on the orbit tangent can produce a violation"* follows in one line from $P$ being constant along the orbit, which the same paragraph states. Reproduced: the orbit tangent at the $C_5$ blow-up is $40$-dimensional and $L_e$ is exactly $\tfrac12$ on all of it.

**The $1.1\times10^{-15}$ orbit component is not a measurement.** $\mathcal O\subseteq E_{L_e}(\tfrac12)$ and $L_e$ is self-adjoint, so *every* eigenvector with eigenvalue $\ne\tfrac12$ is exactly orthogonal to the orbit, the number is forced by the mechanism, and observing it confirms only floating-point arithmetic. I measure $9.4\times10^{-16}$ and $9.0\times10^{-16}$ for the two top eigenvectors; the difference from $1.1\times10^{-15}$ is which vector of the degenerate pair was picked, which is itself the G3 point. The genuinely informative half of the same sentence is $(P-\theta)/t^2\to1.420818$ against $3\theta(\lambda-\tfrac12)=1.420820$, reproduced here to $2\times10^{-6}$ at $t=10^{-3}$.

---

## The counterexample hunt

A critical point with $\Delta>0$ and $\lambda_{\max}\le\tfrac12$ would refute V3 outright. Solving $P_{\mathrm{Weyl}}Q(W)=\theta W$ on the unit sphere by Gauss–Newton with the analytic Jacobian $2L_W$ from random starts, [t9_hunt.py](../scripts/reviewers/r300/t9_hunt.py):

| $n$ | starts | converged ($\le10^{-10}$) | $\Delta>0$ | $\lambda_{\max}$ range | $\Delta>0$ with $\lambda_{\max}\le\tfrac12$ |
|---|---|---|---|---|---|
| $6$ | $60$ | $58$ | $58$ | $[1.670152,\ 96.291798]$ | **none** |
| $8$ | $25$ | $15$ | $15$ | $[6.701170,\ 35.285951]$ | **none** |

V3 survives $73$ independently converged critical points, every one of which has $\Delta>0$ and every one of which violates the bound. The gap between my floor $1.670$ and Observation L25's $1.17$ is a sampling difference, not a discrepancy, my run found no point in $[1.17,1.67)$, and the shared ceiling $96.291798$ is exact agreement from code that never read the record.
