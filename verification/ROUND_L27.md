# ROUND L27, Morse–Bott nondegeneracy at the sphere products, and a multiplicity-free claim

**Id:** L27. **Source:** [findings/nondegeneracy.md](../findings/nondegeneracy.md):457–502, with the canonical form at [results.md](../results.md):423 and the landscape line at :140. **Date:** 2026-09-07. **Verifiers allocated:** v134, v135, v136. **Phase:** 6, closed. **Verdict:** `PROVEN, hypotheses corrected`, repaired, impact `CONTAINED`.

**Why this id.** Tier 1, cited eight or more times. It is what makes the conjectured maximiser a *nondegenerate* critical point, and the exclusions $(p,q)\ne(3,3)$ and $p,q\ge3$ are the record's only stated exceptions to it.

**Pre-registered questions.** *(Questions, not verdicts. No adjudication has run on any.)*

1. **Is the decomposition multiplicity-free, and does the Schur step follow?** *The argument turns on ten summands with pairwise distinct Young labels, and on a symmetric equivariant operator being scalar.* **Check the distinctness for every admissible $p,q$, check the dimension sum, and check the division-algebra step, including whether symmetry is what makes it work.**
2. **Are the excluded cases excluded for the stated reason?** *$p,q\ge3$ and $(p,q)\ne(3,3)$.* **Say what fails at $(3,3)$ and at $q\le2$, and whether each exclusion is forced by the argument or by the object.**
3. **Is $\tfrac12$ the maximum, or only attained?** *The statement says $\lambda_{\max}=\tfrac12$ attained exactly on the orbit tangent.* **Evaluate every summand's eigenvalue and say whether any other reaches or exceeds $\tfrac12$, and what that would mean for $\dim E(\tfrac12)$.**

**A source is read, never cited from memory.** *Nienhaus is in [references/](../references/); if a cited proposition is not there, say the claim rests on an unread source.*

## The brief as dispatched

*Provenance stripped, mathematics verbatim, quoted from the current source.*

Needed because Lemma L26 closes only the half that runs the wrong way. An exhibited eigenvector bounds
$\lambda_{\max}$ from below; nondegeneracy needs an upper bound on the whole spectrum, and nothing in this
programme supplied one until the representation theory was brought in.
**Statement.** Let $p,q\ge3$ with $(p,q)\ne(3,3)$ and $n=p+q$. Then $\lambda_{\max}(L_e|_{W^\perp})=\tfrac12$ at
$W_{p,q}$, attained exactly on the orbit tangent, so $\dim E(\tfrac12)=pq=\dim(\text{orbit})$ and $S^p\times S^q$
is Morse–Bott nondegenerate.
**Argument.** Nienhaus Proposition 4.6 and the summary display following it give
$$\mathrm{Weyl}_n=\langle W\rangle\oplus\mathrm{Weyl}_p\oplus\mathrm{Weyl}_q\oplus(\mathbb R^p\!\otimes\!\mathbb R^q)
\oplus S^2_0(\mathbb R^p)\oplus S^2_0(\mathbb R^q)\oplus(S^2_0\!\otimes\!S^2_0)\oplus(\Lambda^2\!\otimes\!\Lambda^2)
\oplus(X_p\!\otimes\!\mathbb R^q)\oplus(X_q\!\otimes\!\mathbb R^p),$$
with $X_m$ the $O(m)$-irreducible of Young label $[2,1]$ and $\dim X_m=m(m^2-4)/3$; the ten dimensions sum to
$\dim\mathrm{Weyl}_n$ identically in $p,q$. The Young labels are pairwise distinct for every $p,q\ge3$, so the
decomposition is multiplicity-free. Since $e$ is $O(p)\times O(q)$-invariant, $L_e$ is equivariant, and **a symmetric
element of a real division algebra of operators has a real eigenvalue and is therefore a real scalar**, which
covers $\mathbb R$, $\mathbb C$ and $\mathbb H$ alike, so $L_e$ acts as a **scalar** on each summand and each
summand's value is its eigenvalue. *Symmetry is what does this work; it cannot, as the first version had it,
change a representation's type.* The ten values: $1$ on $\langle W\rangle$; $\tfrac12$ on
$\mathbb R^p\otimes\mathbb R^q$, since differentiating $Q(W_t)=\theta W_t$ along the orbit gives
$e\circ\dot W=\tfrac12\dot W$; $\lambda_m=(m-2)/(2(m-1))<\tfrac12$ on $S^2_0(\mathbb R^m)$, derived at [second-order.md](second-order.md);
$+\mu$ on $\Lambda^2\otimes\Lambda^2$ by [Lemma L26](../findings/nondegeneracy.md#lemma-l26-the-dangerous-eigenvalue-of-the-two-block-spectrum-in-closed-form-canonical-statement-and-proof),
**and $-\mu$ on $S^2_0\otimes S^2_0$ by the trace identity below**, L26 supplying only the first of the two;
and $0$ on the remaining four. Then
$$\tfrac12-\mu=\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}>0\quad\text{for }p,q\ge3,\ (p,q)\ne(3,3),$$
so $\tfrac12$ is attained on the orbit summand alone. $\square$
**The list checks itself, and the check is not in the argument that produced it.** $\mathcal W_n$ is $O(n)$-irreducible and non-trivial, so $\sum_iQ(V_i)$ is an invariant vector in it and vanishes; hence $\mathop{\mathrm{tr}}_{\mathcal W_n}L_e=0$ unconditionally. **The ten values satisfy that identically in $p,q$**, and given the other nine it **forces $-\mu$ on $S^2_0\otimes S^2_0$ uniquely.** It also discriminates the assignment: reversing the two tensor summands leaves a trace of $30$ at $(3,5)$ and $(4,4)$, $48$ at $(5,5)$, $70$ at $(5,7)$, never zero. *Derived independently and concurrently by [r529](../reviews/REVIEW_r529.md) and [r530](../reviews/REVIEW_r530.md), whose briefs were identical and neither of which read the other.*
**Both former grants are now discharged.** $L_e$ vanishes on $\mathrm{Weyl}_p$ and $\mathrm{Weyl}_q$ by two independent proofs. On $X_p\otimes\mathbb R^q$ it vanishes by an index computation uniform in $p,q,n$: writing $\mathrm{sharp\_bilin}(X,Y)=\mathrm{Sym}_{\text{pair}}\mathrm{Alt}_{ij}H$ and specialising $X=I_p$, Ricci-flatness enters exactly once to force the partial trace $\rho$ to vanish, and a six-case exhaustion leaves one live case in which Bianchi is used twice to give $-V/2$; the companion $X_q\otimes\mathbb R^p$ follows. The multiplicity-freeness at $p,q\le4$, asserted rather than proved in the source, is supplied by exact $O(m)$-commutant computation at $m=3,4$: every $\mathrm{End}=1$ and every cross-$\mathrm{Hom}=0$, including $\mathbb R^3$ against $\Lambda^2(\mathbb R^3)$ and $S^2_0$ against $X_3$, which share dimensions; $\mathrm{Weyl}_4$ is $O(4)$-irreducible although it splits under $SO(4)$. The $p,q\ge5$ case is proved in the source.
**The excluded case is a theorem, not an observation.** At $(3,3)$, $\mu=\tfrac12$ exactly and
$\dim E(\tfrac12)=18$ against orbit dimension $9$. This is an **eigenvalue coincidence, not representation
mixing**: under $O(3)$, $\Lambda^2(\mathbb R^3)\cong\mathbb R^3\otimes\det\not\cong\mathbb R^3$, measured as
$\dim\mathrm{Comm}_{O(3)^2}=2$ against $\dim\mathrm{Comm}_{SO(3)^2}=4$, so Schur permits no mixing and the two
summands carry $\tfrac12$ separately. A symbolic solve over all $45$ summand pairs finds it the only such
coincidence with $p,q\ge3$, over all $p,q$ rather than a tested range.
**Sources.** [Nienhaus, arXiv:2311.02404](https://arxiv.org/abs/2311.02404), Proposition 4.6 and Remark 4.7(ii).
Audited by Reviewers 34 and 35 on identical briefs, agreeing on every verdict; both proved the $\mathrm{Weyl}_p$
vanishing independently, and both refuted the mechanism first proposed for the $(3,3)$ exception.

### The canonical form, quoted alongside without comment

**Lemma L27 (landscape). Sphere products are Morse–Bott nondegenerate.** The isotypic decomposition is multiplicity-free, so Schur makes $L_e$ scalar on each of ten summands and each value is an eigenvalue, not a lower bound.

## Phase 2, the clustering

**Reports:** [VERIFY_v134](VERIFY_v134.md) `PROVEN, hypotheses corrected`, [VERIFY_v135](VERIFY_v135.md) `PROVEN, hypotheses corrected`, [VERIFY_v136](VERIFY_v136.md) `GAP`.

| # | clause attacked | mechanism | support |
|---|---|---|---|
| **C1** | the dimension identity | *no defect*, **derived as a polynomial identity in $\mathbb Q[p,q]$ by two verifiers independently**, not spot-checked | v134, v135, v136 |
| **C2** | "the labels are distinct, so multiplicity-free" | **a non-sequitur as written**: distinctness gives non-isomorphism, never irreducibility. Irreducibility is the source's, and the block names it nowhere | v136 |
| **C3** | the division-algebra step | correct, and **over-general**: every $O(m)$-irreducible is of real type, so the commutant is $\mathbb R$ throughout and only "has a real eigenvalue" is consumed | v134, v135, v136 |
| **C4** | the four zero eigenvalues | *split.* One verifier found no derivation on file for the six-case exhaustion; another located the $X_p\otimes\mathbb R^q$ computation written out elsewhere in the file, **credited to the wrong reviewers**, the block's Sources line names two who recorded it as still owed | v135 (located), v136 (owed) |
| **C5** | $\dim(\text{orbit})=pq$ at $\min(p,q)\in\{3,4\}$ | the only source statement carries $k,l\ge5$. **This reaches the word "nondegenerate"**, not a parenthetical | v134 |
| **C6** | the two exclusions | they fail **differently**, and the statement runs them together: at $(3,3)$ the decomposition holds and two scalars collide; at $q\le2$ **the decomposition itself is false**, over-counting by $2$ at $q=2$ and $1+p$ at $q=1$ | v134, v135, v136 |
| **C7** | $\tfrac12$ as maximum | true, **and only because of the $W^\perp$ restriction**, $\langle W\rangle$ carries $1$. $\tfrac12-\mu=\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}$, zero over integers $\ge3$ at exactly $(3,3)$ | v135, v136 |
| **C8** | "the only such coincidence" | false over the 45 summand pairs, $\mu=\lambda_5=\tfrac38$ at $(3,5)$ and $\mu=\lambda_4=\tfrac13$ at $(4,4)$. True under the reading *"at $\tfrac12$"*, proved by hand for all $p,q$ | v134, v135 |
| **C9** | [nondegeneracy.md](../findings/nondegeneracy.md):104–107 | **inside another lemma's canonical block**, it says in the present tense that what L27 proves is *"rigorous only at $n\le12$"*, and gives the bottom-end criterion as $n\ge5$, false at $(3,2)$, where the sum reads $37$ against $35$ | v135, v136 |
| **C10** | the retracted phrasing | *"symmetry rules out the $\mathbb C$ and $\mathbb H$ cases"* still stands 235 lines below the block that retracts it | v135, v136 |
| **C11** | [second-order.md](../findings/second-order.md):603 | calls $\lambda_m$ *"a fit and not a proof"* eight lines below its own derivation, **and that is the line L27 cites for the value** | v134, v135, v136 |
| **C12** | [results.md](../results.md):140 | drops $n=p+q$, which is load-bearing since padding destroys nondegeneracy | v135 |

## Phase 3, adjudication

**The mathematics survives every attack.** Two verifiers derived the degree-four dimension identity symbolically; all five tabulated spectra reproduce multiplicity by multiplicity, and one verifier reconstructed a **sixth at $(3,4)$**, odd $n$, for which the record has no exact spectrum.

**C2 is the split, and it is settled by reading rather than by count.** One verifier called the inference a non-sequitur; two passed it. **The non-sequitur is real** (distinct labels give non-isomorphism and nothing more), *and* the missing input exists: a third verifier read the source and found irreducibility stated there for every $p,q\ge3$. So the step is sound and the block does not name what makes it sound, which is a hypothesis correction rather than a gap.

**C4 is the round's genuine split and both halves stand.** The $X_p\otimes\mathbb R^q$ computation *is* written out in the file, located by the verifier who looked for it, per the rule that a report is read before an argument is called absent, and the six-case exhaustion is *not*. **The block cites neither, and credits the discharge to two reviewers who recorded it as owed.**

**C9 is the trap at its most damaging.** A canonical block, in the present tense, tells a reader that this theorem is not one.

**No finding required computation.**

## Phase 4, the fix

**Verdict: `PROVEN, hypotheses corrected`. Impact: `CONTAINED`**, the theorem holds on its stated range; what was owed is the irreducibility input, the orbit dimension at small $\min(p,q)$, and one exhaustion.

- **The multiplicity-free sentence now names irreducibility** as the source's input, with the note that distinctness alone gives only non-isomorphism.
- **The two exclusions are separated** and the bottom-end criterion given as $p,q\ge3$ with the over-counts.
- **The $W^\perp$ restriction is stated as load-bearing**, with $\tfrac12-\mu$ in closed form and $(3,3)$ falling out of it.
- **The division-algebra generality is marked unnecessary.**
- **[results.md](../results.md):140 carries $n=p+q$**, the irreducibility, and the $W^\perp$ restriction.
- **The canonical block that called this "rigorous only at $n\le12$" now says it is a theorem**, and its $n\ge5$ criterion is corrected with the $(3,2)$ witness.
- **The retracted $\mathbb C$/$\mathbb H$ phrasing and the "fit and not a proof" clause are withdrawn where they stood.**

**Owed and recorded**: $\dim(\text{orbit})=pq$ at $\min(p,q)\in\{3,4\}$, and the six-case exhaustion behind two of the four zeros.
