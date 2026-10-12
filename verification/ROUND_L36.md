# ROUND L36, the isotropy cap, its sharpness at both parities, and a converse that fails

**Id:** L36. **Source:** [findings/isotropy-cap.md](../findings/isotropy-cap.md):17–, with the canonical form at [results.md](../results.md):489 and the landscape line at :158. **Date:** 2026-09-07. **Verifiers allocated:** v131, v132, v133. **Phase:** 6, closed. **Verdict:** `PROVEN, hypotheses corrected`, repaired, impact `CONTAINED`.

**Why this id.** Tier 1, cited eight or more times. It is the only structural constraint the record has on the locus $\{S=0\}$, which governs the residual's non-diagonal half.

**Pre-registered questions.** *(Questions, not verdicts. No adjudication has run on any.)*

1. **Is the cap right, and is it attained at both parities?** **Derive $\dim\mathfrak m\le\lfloor n^2/4\rfloor$, then check the claimed maximiser: verify it is isotropic, compute its dimension at even and odd $n$, and say whether equality really holds at both.**
2. **Does the lower bound hold for every subspace?** *The proof asserts $\mu\ge4d^2/n-2d$ for **every** $d$-dimensional subspace, from a Casimir spectrum.* **Check that spectrum and the resulting bound, and say what happens at the smallest and largest admissible $d$.**
3. **Which direction is used?** *The block says every $S=0$ negative eigenspace is isotropic, and that the converse fails.* **Say which implication the lemma's consumers need, and whether anything on the record uses the failing direction.**

**A source is read, never cited from memory.** *If a source is not in [references/](../references/), say the claim rests on an unread source.*

## The brief as dispatched

*Provenance stripped, mathematics verbatim, quoted from the current source.*

Needed because the residual's non-diagonal half is governed by $\{S=0\}$, and nothing on
record constrained that locus structurally, only value measurements at named points.
**Statement.** Let $\mathfrak m\subseteq\mathfrak{so}(n)$ satisfy $\langle[u,v],w\rangle=0$ for all
$u,v,w\in\mathfrak m$, *isotropic*, which the negative eigenspace of a Weyl operator with $S=0$ is.
Then $\dim\mathfrak m\le\lfloor n^2/4\rfloor$, **with equality attained by the mixed planes
$\mathfrak m\cong\mathbb R^p\otimes\mathbb R^q$ at $p=\lceil n/2\rceil$**, of dimension $pq$, which is
$n^2/4$ at even $n$ and $\frac{n^2-1}4$ at the odd split, so **sharpness holds at both parities**.
Sharp, every $n\ge3$, no genericity hypothesis.
**Proof.** Write $\mu(\mathfrak m)=\sum_{a,b}\|[e_a,e_b]\|^2$ over an orthonormal basis, $d=\dim\mathfrak m$,
and $\gamma$ for the $\mathfrak h\mathfrak h\mathfrak m$ mass, the failure of $\mathfrak m^\perp$ to be a
subalgebra, a sum of squares and so $\ge0$ by inspection. *Naming $\gamma$ here is what makes the next step
an argument: read instead as the residual $2(n-2)d-2\mu$, the identity is a tautology and $\gamma\ge0$
restates the conclusion.* Isotropy
gives $\mu\le(n-2)d$ from the Killing block identity $2\mu+\gamma=2(n-2)d$, which is **[Lemma L153](bounds.md)** summed over the $d$ rows of $\mathfrak m$. And
**every** $d$-dimensional subspace satisfies $\mu\ge4d^2/n-2d$, because $\mu=\langle T(P),P\rangle$
with $P$ the orthogonal projection onto $\mathfrak m$ and
$T(A)=-\sum_k\mathrm{ad}(f_k)\,A\,\mathrm{ad}(f_k)=2(n-2)\mathrm{Id}-\tfrac12\mathrm{Cas}$, whose
spectrum on $\mathbb R\oplus\mathrm{Sym}^2_0\oplus\mathrm{Weyl}_n\oplus\Lambda^4$ is
$2n-4,\ n-4,\ -2,\ 4$. Chaining the two gives $4d^2/n-2d\le(n-2)d$, i.e. $d\le n^2/4$. $\square$
**The whole content is one eigenvalue**, and it is the Weyl space's: $-2$ is $T$'s only negative
eigenvalue, and its eigenspace is exactly $\mathrm{Weyl}_n$, multiplicities $10,35,84,168$ at
$n=4,\dots,7$.
**It is Mantel's theorem in continuous form.** In the $\varphi_{ij}$ basis the Cartan 3-form is
supported exactly on the triangles of $K_n$, so a coordinate subspace is isotropic precisely when its
graph is triangle-free; $\lfloor n^2/4\rfloor$ with the complete bipartite extremiser is then Mantel,
and the content of the lemma is that no non-coordinate subspace beats it.
**What it does not reach.** Equality forces $\gamma=0$, hence $\mathfrak m^\perp$ a subalgebra, hence a
symmetric pair, and Cartan then leaves only the balanced split, but that argument is complete only
for **even** $n$; odd $n$ needs $\gamma=0$ forced at $d=(n^2-1)/4$ and is open. Gate 2 passed by two
reviewers on identical briefs who proved the bound independently, one representation-theoretically and
one by centraliser induction.

### The canonical form, quoted alongside without comment

**Lemma L36 (landscape). $S=0$ caps the negative eigenspace at $\lfloor n^2/4\rfloor$.** Slack zero says the negative eigenspace is isotropic for the Cartan 3-form $\langle[x,y],z\rangle$, and such a subspace of $\mathfrak{so}(n)$ has dimension at most $\lfloor n^2/4\rfloor$.

## Phase 2, the clustering

**Reports:** [VERIFY_v131](VERIFY_v131.md), [VERIFY_v132](VERIFY_v132.md), [VERIFY_v133](VERIFY_v133.md) (**all three `PROVEN), hypotheses corrected`, unanimous.**

| # | clause attacked | mechanism | support |
|---|---|---|---|
| **C1** | the cap and its sharpness | *no defect.* Rebuilt cold three times, including all four Casimir eigenvalues from $\langle\lambda,\lambda+2\rho\rangle$ and the $\Lambda^4$ degenerations at $n=4,5,6,7$ where the generic highest weight does not exist. **The mixed planes are isotropic because the Cartan 3-form is supported on triangles and $K_{p,q}$ is bipartite**, and $\lceil n/2\rceil\lfloor n/2\rfloor=\lfloor n^2/4\rfloor$ at both parities | v131, v132, v133 |
| **C2** | the bridging clause | *"which the negative eigenspace of a Weyl operator with $S=0$ is"* is unhypothesised in **all three forms**. It needs $W$ **critical**, its only support is a decomposition stated at critical points, and the record elsewhere records $S\ge0$ failing off that set | v131, v132, v133 |
| **C3** | the symbol $S$ | unsubscripted $S$ resolves via [conventions.md](../findings/conventions.md) to the *analytic slack*, under which the bridge needs two further facts and $\ker W=0$; under the intended $S_{\mathfrak{mmm}}$ it is a one-line tautology. **The default reading is the wrong one** | v132 |
| **C4** | "$-2$ is $T$'s only negative eigenvalue" | **false at $n=3$**, where the $\mathrm{Weyl}$ summand is absent and the least eigenvalue is $-1$, inside a statement scoped to $n\ge3$. The qualified copy sits 25 lines below, outside the citable block. *The cap survives more strongly*, $T\ge-1$ giving $d\le2=\lfloor9/4\rfloor$ | v131, v132, v133 |
| **C5** | [results.md](../results.md):158 | *"attained by the balanced symmetric pair"*, **the object this block's own box refutes twice over**, and it names no admissible object at odd $n$. The canonical form at :489 carries every correction inline; the landscape line carries none | v131, v132, v133 |
| **C6** | [INDEX-results.md](../findings/INDEX-results.md):94 | claims another lemma *"repairs L36's $n\ge4$"*, it does not: that is an eigenvalue table, and what $n=3$ needs is a *missing* summand | v132, v133 |
| **C7** | where isotropy enters | the block attributes it to the inequality; it is consumed by the **identity**, in the step $\lVert P^\perp[e_a,e_b]\rVert^2=\lVert[e_a,e_b]\rVert^2$ | v131, v133 |
| **C8** | the converse | fails at $n=3$, and **nothing on the record uses it**, three independent sweeps of every consumer agree | v131, v132, v133 |

**Withdrawn with reasons:** the small-$d$ failure, the floor step, the $\Lambda^4$ weight, and the $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ scope.

## Phase 3, adjudication

**The cap is the soundest result this loop has examined.** Three cold rebuilds agreeing to the digit, sharpness *exact* at both parities ($\mu=(n-2)d$ at the maximiser makes the first step an equality) and the floor's constant $4/n$ tight at $d=N$. **No verifier could construct a falsifier, and one showed why: the mixed planes give $\mu=(n-2)pq$ at every split, so the first step does not single out the maximiser; the second does.**

**C2 and C3 are one debt seen twice.** The clause that carries $\{S=0\}$ into the cap is the only unhypothesised step, and the symbol it turns on has a documented default reading that makes it hard rather than trivial. **Under the intended reading the bridge is a tautology, which is the charitable case, and the statement never says which is meant.**

**C5 is the trap, and it is the fourth time tonight a landscape line has kept a refuted object** while the canonical form beside it was repaired.

**C4 is a false clause that makes the theorem stronger.** *Recorded as a defect anyway*: a reader checking $n=3$ finds the stated reason wrong, and the correct reason gives a better bound.

**No adjudication split, and no finding required computation.**

## Phase 4, the fix

**Verdict: `PROVEN, hypotheses corrected`. Impact: `CONTAINED`**, the cap, its sharpness and the floor stand exactly as claimed; what was owed is the hypothesis on the clause that reaches them.

- **The bridging clause now names both missing conditions** ($S_{\mathfrak{mmm}}$ rather than the analytic slack, and $W$ critical), with the note that the tautological reading is the intended one.
- **The eigenvalue claim is scoped to $n\ge4$** and the $n=3$ case given, with the stronger cap it yields.
- **[results.md](../results.md):158 names the mixed planes** and says explicitly that the symmetric pair is their complement and is not isotropic.
- **[INDEX-results.md](../findings/INDEX-results.md):94's repair claim is withdrawn**, with what $n=3$ actually needs.
- **Isotropy is attributed to the identity**, where it is consumed.
