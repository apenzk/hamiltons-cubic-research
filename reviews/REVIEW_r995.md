# Review r995: the $\Lambda^4$ obstructions, and whether I75 is a finite list

Gate 2 reviewer r995, brief [BRIEF_I75_lambda4.md](BRIEF_I75_lambda4.md). Worked from the brief's definitions, from [AltPart.lean](../lean/HamiltonsCubic/Base/AltPart.lean) and [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean) for the conventions, and from the mathematics. No findings file was read.

## Verdicts

| # | claim | verdict |
|---|---|---|
| 1 | $\mathrm{Alt}(W^k)=\tfrac16\sum_\mu\mu^k\mathfrak b(P_\mu)$ at every $k$ | CONFIRMED, the $\tfrac16$ is bookkeeping |
| 2 | $\sum_\mu\mathfrak b(P_\mu)=\mathfrak b(\mathrm{Id})=0$, a free relation | CONFIRMED, and now derived rather than screened |
| 3 | $\sum_\mu\mu\,\mathfrak b(P_\mu)=6\,\mathrm{Alt}(W)=0$, and it IS first Bianchi | CONFIRMED |
| 4 | the $\mathfrak b(P_\mu)$ lie in the kernel of a $2\times s$ Vandermonde | CONFIRMED, with a correction to the statement of the kernel |
| 5 | at $s=2$ every $\mathfrak b(P_\mu)=0$, with no further hypothesis | CONFIRMED, non-vacuous over $\mathcal W_4$, open over critical points |
| 6 | at $s=3$ the family reduces to the single condition $\mathrm{Alt}(W^2)=0$ | CONFIRMED, "single" means one $k$, not one scalar |
| 7 | at $s=3$, $\mathrm{Alt}(W^3)=(\sum_\mu\mu)\,\mathrm{Alt}(W^2)$, over DISTINCT values | CONFIRMED, distinct is the correct reading and multiplicity is refuted |
| 8 | I75 is exactly $s-2$ conditions, $k=2,\dots,s-1$ | CONFIRMED with two corrections, $\max(s-2,0)$ and consecutive exponents |
| 9 | sharp at the obstruction, $W_{\mathbb{CP}^2}$ has spectrum $\{2c,-c,0\}$ | PLAUSIBLE, the spectrum and the sharpness of row 5 are facts, "exactly where the link fails" overreaches |
| 10 | it gives no bound on $s$ at a maximiser | CONFIRMED |

## The conventions this review works in

The record's $\mathrm{Alt}$ is [alt4](../lean/HamiltonsCubic/Base/AltPart.lean), $\mathrm{alt4}(T)_{ijkl}=\tfrac13(T_{ijkl}+T_{iklj}+T_{iljk})$, and [altCoeff](../lean/HamiltonsCubic/Base/AltPart.lean) is $\mathrm{alt4}\circ\mathrm{comp}$, with $\mathrm{comp}(R)_{ijkl}=\langle R\varphi_{ij},\varphi_{kl}\rangle$ and $\langle X,Y\rangle=\tfrac12\mathrm{tr}(X^{\mathsf T}Y)$ from [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean).

**The brief's $\tfrac1{4!}$ definition and the record's $\tfrac13$ cyclic sum are the same map on the objects in play**, so nothing below turns on the choice. For a tensor $T$ with the pair symmetries of $\mathrm{comp}$ of a symmetric operator, the Bianchi sum $b_{ijkl}=T_{ijkl}+T_{iklj}+T_{iljk}$ is totally antisymmetric, so $\mathrm{Alt}_{4!}(b)=b$. The two rotations $(i,j,k,l)\mapsto(i,k,l,j)$ and $(i,j,k,l)\mapsto(i,l,j,k)$ are even, so $\mathrm{Alt}_{4!}(b)=3\,\mathrm{Alt}_{4!}(T)$, giving $\mathrm{Alt}_{4!}(T)=\tfrac13 b$. Screened to machine zero at $\mathrm{Id}$, $W$, $W^2$ and $W^3$ on a generic $n=4$ Weyl tensor.

**In $n=4$ everything below has a closed form**, which is how several of the rows were checked twice. $\Lambda^4\mathbb R^4$ is spanned by $\star$ with $\|\star\|^2=6$, so $\mathrm{Alt}(R)=\tfrac16\langle R,\star\rangle\,\star$ and, for $W$ block-diagonal in $\Lambda^+\oplus\Lambda^-$,

$$\mathrm{Alt}(W^k)=\tfrac16\big(\mathrm{tr}(W^+)^k-\mathrm{tr}(W^-)^k\big)\,\star .$$

## Row 2, the row the brief most doubts: DERIVED, true at every $n$

**The four-index form of the identity is the Kulkarni-Nomizu square of the metric**, and the symmetry that kills it is the symmetry of $\delta$. With $\varphi_{ij}$ carrying $-1$ at $(i,j)$ and $+1$ at $(j,i)$,

$$\mathrm{comp}(\mathrm{Id})_{ijkl}=\langle\varphi_{ij},\varphi_{kl}\rangle=\tfrac12\big[(\delta_{ik}\delta_{jl}-\delta_{il}\delta_{jk})+(\delta_{ik}\delta_{jl}-\delta_{il}\delta_{jk})\big]=\delta_{ik}\delta_{jl}-\delta_{il}\delta_{jk}.$$

Under the record's $\mathrm{Alt}$ the three cyclic terms cancel in pairs, with no hypothesis and no dimension restriction:

$$(\delta_{ik}\delta_{jl}-\delta_{il}\delta_{jk})+(\delta_{il}\delta_{kj}-\delta_{ij}\delta_{kl})+(\delta_{ij}\delta_{lk}-\delta_{ik}\delta_{lj})=0 .$$

Under the brief's $\tfrac1{4!}$ definition the same fact reads once: $\delta_{ik}\delta_{jl}$ is symmetric in slots $1$ and $3$, $\delta_{il}\delta_{jk}$ is symmetric in slots $1$ and $4$, and total antisymmetrisation annihilates anything symmetric in two slots. **The one-line reason underneath both: $\mathrm{Id}$ is the curvature operator of the constant-curvature metric, so $\mathrm{Alt}(\mathrm{Id})=0$ is first Bianchi for the round sphere.**

**Status correction.** This is a theorem with a two-line proof at every $n$, so carrying it as a machine-zero screen understates it. It is also within reach of the Lean layer as it stands: `theorem bianchi_id (i j k l : ι) : bianchi (id) i j k l = 0`, whose proof is the displayed cancellation after rewriting $\mathrm{comp}$ through [inner2_eq_sum](../lean/HamiltonsCubic/Base/WeylReal.lean) and [phi](../lean/HamiltonsCubic/Base/WeylReal.lean). Rows 4 to 8 do not fall, at any $n$.

*Vacuity.* $\Lambda^4\mathbb R^n=0$ for $n\le 3$, where row 2 is true and empty. For $n\ge4$ it is a genuine relation, since $\mathrm{comp}(\mathrm{Id})\ne0$ there.

## Row 1: CONFIRMED, and the $\tfrac16$ is definitional

Three steps, each of which holds.

- **$\mathrm{comp}$ is linear in the operator**, immediately from $\mathrm{comp}(R)_{ijkl}=\langle R\varphi_{ij},\varphi_{kl}\rangle$ and bilinearity of $\langle\cdot,\cdot\rangle$, and $\mathrm{alt4}$ is a fixed linear combination of three entries. So $\mathrm{Alt}$ is linear.
- **The spectral decomposition pushes through term by term.** $W$ preserves the skew matrices and is self-adjoint there by clauses 1 and 2 of [IsWeyl](../lean/HamiltonsCubic/Base/WeylReal.lean), so the real spectral theorem applies on $(\Lambda^2,\langle\cdot,\cdot\rangle)$, giving $\sum_\mu P_\mu=\mathrm{Id}$ and $W^k=\sum_\mu\mu^kP_\mu$ for every $k\ge0$, including $k=0$ when $0$ is an eigenvalue. Each $P_\mu$ is a real polynomial in $W$, hence linear, self-adjoint and skew-preserving, so $\mathrm{comp}(P_\mu)$ is defined and $\mathrm{Alt}(P_\mu)$ is totally antisymmetric by [altCoeff_antisym_first](../lean/HamiltonsCubic/Base/AltPart.lean) and [altCoeff_antisym_mid](../lean/HamiltonsCubic/Base/AltPart.lean).
- **The constant.** With $\mathfrak b(P_\mu):=6\,\mathrm{Alt}(P_\mu)$ the row is an identity between a definition and itself: $\mathrm{Alt}(W^k)=\sum_\mu\mu^k\mathrm{Alt}(P_\mu)=\tfrac16\sum_\mu\mu^k\mathfrak b(P_\mu)$. **The $\tfrac16$ is correct and carries no content**, and any other constant $c$ in $\mathfrak b:=c\,\mathrm{Alt}$ would appear as $1/c$ here. The content of the row is the linearity plus the spectral theorem, not the number.

Screened at $k=0,\dots,6$ on a generic $n=4$ Weyl tensor with $s=6$, machine zero at every $k$.

*One reading trap worth recording.* $\mathrm{comp}(W^k)$ is the four-index form of the $k$-fold **composite operator**, and is not the $k$-th power of the array $\mathrm{comp}(W)$ in any index sense. The row is true under the composite reading and would be false under the other.

## Row 3: CONFIRMED

$\sum_\mu\mu\,\mathfrak b(P_\mu)=6\,\mathrm{Alt}(\sum_\mu\mu P_\mu)=6\,\mathrm{Alt}(W)$, by row 1 at $k=1$. And $\mathrm{Alt}(W)=0$ is first Bianchi exactly, by [altCoeff_eq_third_bianchi](../lean/HamiltonsCubic/Base/AltPart.lean) together with clause 3 of [IsWeyl](../lean/HamiltonsCubic/Base/WeylReal.lean): $\mathrm{altCoeff}=\tfrac13\,\mathrm{bianchi}$, so the two vanish together. The claim's "it IS first Bianchi" is literally right.

## Rows 4 and 8, the rank count: CONFIRMED with corrections

Rows 2 and 3 say the $s$-tuple $(\mathfrak b(P_{\mu_1}),\dots,\mathfrak b(P_{\mu_s}))$ is killed by the two rows $k=0,1$ of the Vandermonde $V_{k\mu}=\mu^k$.

- **The nodes are distinct by construction**, the $\mu_i$ being the distinct eigenvalues of a symmetric operator. Nothing further is needed, and no positivity or ordering is used.
- **Rank.** $\begin{pmatrix}1&\cdots&1\\ \mu_1&\cdots&\mu_s\end{pmatrix}$ has rank $\min(2,s)$ on distinct nodes, so for $s\ge2$ the kernel has dimension $s-2$ and for $s=1$ it is $0$.
- **Correction to row 4's wording.** The $\mathfrak b(P_\mu)$ are $\Lambda^4$-valued, so the precise statement is that the tuple lies in $\ker V\otimes\Lambda^4$, of dimension $(s-2)\dim\Lambda^4$. The rank count is per $\Lambda^4$ component, which is what the argument needs.
- **Adding $k=2,\dots,s-1$ completes a square Vandermonde** $V_{k\mu}=\mu^k$, $k=0,\dots,s-1$, whose determinant is $\prod_{i<j}(\mu_j-\mu_i)\ne0$. So those conditions force every $\mathfrak b(P_\mu)=0$, hence $\mathrm{Alt}(W^k)=0$ for **every** $k\ge0$ by row 1. The infinite family is genuinely finite.
- **Minimality, so "exactly" is earned.** The map from $\ker V\otimes\Lambda^4$ to $\big(\mathrm{Alt}(W^2),\dots,\mathrm{Alt}(W^{s-1})\big)$ is a linear isomorphism between spaces of equal dimension $(s-2)\dim\Lambda^4$, so no proper subset of the $s-2$ conditions suffices.
- **Correction 1 to row 8.** The count is $\max(s-2,0)$. At $s=1$ the free relations already force $\mathfrak b=0$, and the stated range $k=2,\dots,s-1$ is empty at $s\le2$, which is consistent, but "exactly $s-2$" reads as $-1$ at $s=1$.
- **Correction 2 to row 8, and it is the one a reader could get wrong.** The exponents must be the consecutive block $2,\dots,s-1$. An arbitrary set of $s-2$ exponents above $1$ can leave a singular generalised Vandermonde, because the nodes are real and may be negative or zero: at $s=3$ with spectrum $\{-1,0,1\}$, the rows $k=0,1,3$ give $\begin{pmatrix}1&1&1\\-1&0&1\\-1&0&1\end{pmatrix}$, which is singular, so $\mathrm{Alt}(W^3)=0$ does **not** imply $\mathrm{Alt}(W^2)=0$ there. Row 8's own choice is the consecutive one and is safe.

*Vacuity.* Row 8 would be empty if every algebraic Weyl tensor had $s\le2$. It does not: $W_{\mathbb{CP}^2}$ has $s=3$, and a generic block-diagonal traceless pair at $n=4$ has $s=6$.

## Row 5: CONFIRMED, with the vacuity question answered for the algebra and open for the geometry

At $s=2$ the $2\times2$ Vandermonde $\begin{pmatrix}1&1\\ \mu_1&\mu_2\end{pmatrix}$ has determinant $\mu_2-\mu_1\ne0$, so $\mathfrak b(P_{\mu_1})=\mathfrak b(P_{\mu_2})=0$ and $\mathrm{Alt}(W^k)=0$ for all $k$, with no hypothesis beyond first Bianchi and the trace conditions already in $W$. Correct.

**Non-vacuous over $\mathcal W_4$.** An explicit witness: $W^+=\mathrm{diag}(2,-1,-1)$ and $W^-=\mathrm{diag}(-1,-1,2)$ in orthonormal bases of $\Lambda^\pm$. Both blocks are trace-free and the operator is block-diagonal, which at $n=4$ is exactly an algebraic Weyl tensor, and its spectrum is $\{2,-1\}$ with $0$ absent, so $s=2$. Its Ricci trace and Bianchi array were asserted zero, and $\mathrm{Alt}(W^k)$ came out machine zero for $k=0,\dots,6$, as row 5 requires. The closed form agrees: $\mathrm{tr}(W^+)^k-\mathrm{tr}(W^-)^k=0$ for every $k$, since the two blocks are permutations of one another.

**What stays open, and it is the real vacuity risk.** Nothing in rows 1 to 9, and nothing I can reach from the brief, says whether a critical point above $\sqrt{3/2}$ ever has $s=2$. If none does, row 5 excludes nothing at the place I75 is used. This is a scope caveat on row 5 rather than a defect in it, and it is the same gap row 10 declares.

## Row 6: CONFIRMED, with a wording correction

At $s=3$ the kernel is one-dimensional per $\Lambda^4$ component, and $\{k=0,1,2\}$ is a square Vandermonde on distinct nodes, so $\mathrm{Alt}(W^2)=0$ forces every $\mathfrak b(P_\mu)=0$ and hence $\mathrm{Alt}(W^k)=0$ at all $k$. **"Single condition" means a single value of $k$**, not a single scalar equation: it is $\dim\Lambda^4=\binom n4$ scalar equations, which is one only at $n=4$.

## Row 7: CONFIRMED, and the coefficient is the sum over DISTINCT eigenvalues

Derived rather than quoted. At $s=3$ the kernel of the $2\times3$ Vandermonde is spanned by $w=(\mu_2-\mu_3,\ \mu_3-\mu_1,\ \mu_1-\mu_2)$, so $\mathfrak b(P_{\mu_i})=\beta\,w_i$ for a single $\beta\in\Lambda^4$. Then

$$6\,\mathrm{Alt}(W^2)=\beta\sum_i\mu_i^2w_i=-\beta\,(\mu_1-\mu_2)(\mu_2-\mu_3)(\mu_3-\mu_1),$$
$$6\,\mathrm{Alt}(W^3)=\beta\sum_i\mu_i^3w_i=-\beta\,(\mu_1-\mu_2)(\mu_2-\mu_3)(\mu_3-\mu_1)(\mu_1+\mu_2+\mu_3),$$

the second being the standard factorisation of the $3\times3$ alternant with the extra row. Dividing, $\mathrm{Alt}(W^3)=(\mu_1+\mu_2+\mu_3)\,\mathrm{Alt}(W^2)$, **the sum over the distinct values, with no multiplicities anywhere**, since multiplicities never enter the spectral sum once it is written over projectors.

**The multiplicity reading is refuted, not merely disfavoured.** The spectrum-with-multiplicity sum is $\mathrm{tr}_{\Lambda^2}W$, which vanishes for every algebraic Weyl tensor, so that reading would assert $\mathrm{Alt}(W^3)=0$ at every $s=3$ tensor. At $W_{\mathbb{CP}^2}$ with $c=1$: the distinct sum is $2-1+0=1$, while $\mathrm{tr}\,W=0$, and $\mathrm{Alt}(W^3)=\tfrac16(8-1-1)\star=\star\ne0$. Both the derivation and the $n=4$ closed form give $\mathrm{Alt}(W^3)=1\cdot\mathrm{Alt}(W^2)=\star$. Screened at machine zero.

*A further caution the row does not need but a reader might.* The identity is an equality of two $\Lambda^4$ elements and does not say either is non-zero. It degenerates harmlessly when $\mathrm{Alt}(W^2)=0$, where it just repeats $\mathrm{Alt}(W^3)=0$.

## Row 9: PLAUSIBLE, the spectrum is right and the sharpness wording overreaches

**The spectrum is confirmed.** $\mathbb{CP}^2$ with the Fubini-Study metric is Kähler-Einstein and self-dual, so $W^-=0$, and for a Kähler surface $W^+$ has eigenvalues $(s/6,-s/12,-s/12)$. Writing $c=s/12$, the operator on $\Lambda^2\mathbb R^4$ has eigenvalues $2c$ once, $-c$ twice and $0$ three times, so **exactly three distinct values $\{2c,-c,0\}$ whenever $c\ne0$**, and $\mathrm{tr}\,W=0$ as it must be. The eigenvalue $0$ is a genuine eigenvalue of the operator, carried by the three-dimensional $\Lambda^-$, so reading only $W^+$ would give $s=2$ and the wrong conclusion.

**The sharpness of row 5 is confirmed.** Row 5 cannot be pushed from $s=2$ to $s=3$, because this tensor has $s=3$ and $\mathrm{Alt}(W^2)=\tfrac16\big(\mathrm{tr}(W^+)^2-0\big)\star=c^2\star\ne0$. So at $s=3$ the obstructions are not automatically zero, and the single condition of row 6 has real content.

**What overreaches.** "The first case row 5 does not cover is exactly where the link is known to fail" joins two facts that are both about the same tensor and derives no principle from them. Rows 1 to 8 say only that the obstruction can be non-zero at $s=3$. They do not say that $s=3$ is where a link fails, that every $s=3$ tensor with $\mathrm{Alt}(W^2)=0$ is benign, or that failure cannot also occur at $s\ge4$. **Recommended wording**: "$s=3$ is the first case row 5 does not cover, and $W_{\mathbb{CP}^2}$ realises it with $\mathfrak b\ne0$, so row 5 is sharp in $s$." The coincidence with the known failure point is then an observation about one tensor rather than a claimed correspondence.

*Vacuity.* The row is empty only at $c=0$, the flat case, which $\mathbb{CP}^2$ is not.

## Row 10: CONFIRMED, nothing in rows 1 to 9 bounds $s$

I looked for a hidden bound in each row and found none. Rows 2 and 3 are two relations whatever $s$ is. Rows 4, 6 and 8 take $s$ as input and return a count that **grows** with it, which is the opposite of a bound. Row 5 is a conditional on $s=2$, and row 7 a conditional on $s=3$. Row 9 exhibits one tensor with $s=3$, which bounds nothing about a maximiser.

The only bounds visible anywhere are trivial and come from outside the argument: $s\le\dim\Lambda^2=\binom n2$, and $s\ge2$ for any non-zero $W$, since $\mathrm{tr}_{\Lambda^2}W=0$ forces eigenvalues of both signs. **Neither is a bound at a maximiser, and the record is right to say the reduction gives none.** The honest reading of rows 1 to 9 together is: I75's requirement is $\max(s-2,0)$ conditions, and without an independent bound on $s$ at the maximiser that number is only bounded by $\binom n2-2$.

## Vacuity check, all ten rows

| # | what vacuity would look like | is it vacuous |
|---|---|---|
| 1 | no operator admits a spectral decomposition | no, the spectral theorem always applies |
| 2 | $\Lambda^4=0$, so the relation says $0=0$ | empty at $n\le3$, a real relation at $n\ge4$ |
| 3 | $\mathrm{Alt}(W)=0$ holding for a reason other than Bianchi | no, the two are the same equation up to $\tfrac13$ |
| 4 | $s\le1$ always, so the kernel statement is empty | no, $s\ge2$ for every non-zero $W$ |
| 5 | no critical point above $\sqrt{3/2}$ has $s=2$ | non-vacuous over $\mathcal W_4$ by explicit witness, UNRESOLVED over critical points |
| 6 | no $W$ has $s=3$ | no, $W_{\mathbb{CP}^2}$ does |
| 7 | $\mathrm{Alt}(W^2)=0$ at every $s=3$ tensor, making it $0=0$ | no, $\mathrm{Alt}(W^2)=c^2\star\ne0$ at $W_{\mathbb{CP}^2}$ |
| 8 | $s\le2$ always, so the list is always empty | no, $s=6$ occurs generically at $n=4$ |
| 9 | $c=0$ | no |
| 10 | a scope disclaimer is vacuous only if false | it is true, so the disclaimer stands |

## Corrections to fold in

1. **Row 2 is a theorem, not a screen.** Record the derivation above, and add `bianchi_id` to [AltPart.lean](../lean/HamiltonsCubic/Base/AltPart.lean). The symmetry that kills it is the symmetry of the metric in $\mathrm{comp}(\mathrm{Id})_{ijkl}=\delta_{ik}\delta_{jl}-\delta_{il}\delta_{jk}$, at every $n$.
2. **Row 4** should say the tuple lies in $\ker V\otimes\Lambda^4$, dimension $(s-2)\dim\Lambda^4$.
3. **Row 8** should say $\max(s-2,0)$ conditions, and should say that the exponents are the consecutive block $k=2,\dots,s-1$, since a non-consecutive choice can be singular on real nodes. The witness is $\{-1,0,1\}$ with $k=0,1,3$.
4. **Row 6's "single condition"** means one value of $k$, which is $\binom n4$ scalar equations.
5. **Row 9** should claim sharpness of row 5 in $s$ and stop there.
6. **Row 1's $\tfrac16$** is bookkeeping from $\mathfrak b:=6\,\mathrm{Alt}$, and the row's content is linearity plus the spectral theorem. Worth saying so, so no reader hunts for a geometric meaning in the $6$.
7. **Row 5's open flank** is whether $s=2$ occurs at a critical point above $\sqrt{3/2}$. That question is unanswered here and is the one place the reduction could turn out to exclude nothing.

## Screens behind this report

All controls are assertions, in two scripts left in this session's scratchpad (`r995_screen.py` and `r995_screen2.py`, under `/private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/8003e6c1-e5ca-4867-b816-0a2997ebc8d6/scratchpad/`), built on objects constructed for the purpose at $n=4$ in the record's own $\varphi$ basis and $\langle\cdot,\cdot\rangle$, half a second of compute. They assert: the $\varphi$ basis is orthonormal on ordered pairs; the Hodge frame is orthonormal; each constructed operator has zero Ricci trace and zero Bianchi array; $\mathrm{Alt}(\mathrm{Id})=0$ exactly; row 1 at $k=0,\dots,6$ on an $s=6$ tensor; rows 2 and 3 on its projectors; row 5 at $k=0,\dots,6$ on the $s=2$ witness; row 7 at $W_{\mathbb{CP}^2}$ against the distinct-value sum; the two $\mathrm{Alt}$ conventions agreeing; and $\mathrm{comp}(\mathrm{Id})$ against the Kulkarni-Nomizu form. **Every verdict above rests on the derivation, and the screens are corroboration.**
