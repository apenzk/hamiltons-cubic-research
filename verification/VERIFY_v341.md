# Verifier v341, whether only the off-diagonal entries of M can bring the Jacobi identity into a bound on D (L111, step D7)

*Cold brief [ADJ_L111_D7.md](ADJ_L111_D7.md). No numerical work was done and no scripts were written. Every value below is exact. Log: [agent_logs/verify-L111-v341.log](../agent_logs/verify-L111-v341.log).*

| # | Claim | Verdict |
|---|---|---|
| 1 | At an eigenvector, $D$ is fixed exactly by the diagonal entry $M_{kk}$ and relation (A), so L70 is that diagonal entry rewritten | CONFIRMED AS ALGEBRA |
| 2 | The diagonal entries cannot carry the Jacobi identity, because they are functions of $T=c^2$ alone | REFUTED |
| 3 | The off-diagonal entries are a place the Jacobi identity enters, in the sense in which the diagonal ones are not | REFUTED AS STATED |
| 4 | Step D7: among the entries of $M_{kl}$, only the off-diagonal ones can bring the Jacobi identity into a bound on $D$ | REFUTED |

**Summary: the step FAILS, because the Jacobi identity has closed-form consequences in $T$ alone, which is the currency of both $D$ and the diagonal entries, and in the one sense where the diagonal entries are Jacobi-free (degree-2 linear relations) the off-diagonal entries are Jacobi-free too.**

## 0. Conventions, fixed once

- $\{v_k\}$ is an orthonormal eigenbasis of $W$ on $\mathfrak{so}(n)\cong\Lambda^2\mathbb R^n$, $Wv_k=\lambda_kv_k$, and $c_{abc}=\langle[v_a,v_b],v_c\rangle$ is totally antisymmetric (Passage B). $T_{abc}=c_{abc}^2$.
- $(\mathrm{ad}\,v_a)_{ij}=\langle v_i,[v_a,v_j]\rangle=c_{aji}$.
- $M_{kl}=\operatorname{tr}(\mathrm{ad}(v_k)W\,\mathrm{ad}(v_l)W)$. With $W$ diagonal, $M_{kl}=\sum_{ij}c_{kji}\lambda_j c_{lij}\lambda_i=-\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta c_{k\alpha\beta}c_{l\alpha\beta}$. The sign is immaterial to everything below, which reads only which monomials an entry contains.
- Criticality is $Q(W)=\theta W$. Relations (A), (B), (C) are as quoted in Passage B. The Killing form is proportional to the inner product, so $\sum_{\alpha\beta}c_{k\alpha\beta}c_{l\alpha\beta}=2(n-2)\delta_{kl}$, whose diagonal is (A).
- The Jacobi identity paired with $v_d$ reads, for all $a,b,c,d$,
$$J_{abcd}:=\sum_e\big(c_{abe}c_{cde}+c_{bce}c_{ade}+c_{cae}c_{bde}\big)=0,$$
obtained from $\langle[[v_a,v_b],v_c],v_d\rangle=\sum_e c_{abe}c_{ecd}$ and its two cyclic partners, using $c_{ecd}=c_{cde}$.
- "A bound on $D$" is read as an inequality on $D(v)$ that is derived from relations the record holds, and "the Jacobi identity enters" as the derivation using a consequence of $J_{abcd}=0$.

## 1. Hypothesis inventory

- **H1.** $v$ in L70 is a unit eigenvector for $\lambda_{\min}<0$, or more generally a unit vector $v=\sum_kx_kv_k$. The boxed formula is checked for the eigenvector in section 2 and extended to general $v$ there.
- **H2.** The structure constants are those of $\mathfrak{so}(n)$ in an orthonormal basis, so the Jacobi identity holds for them. This is automatic for an eigenbasis of $W$.
- **H3 (reading L).** "Enter" means a linear combination of degree-2 relations, with coefficients allowed to depend on $(\lambda,\theta)$.
- **H4 (reading N).** "Enter" means any consequence of $J=0$ used in a derivation, including polynomial and inequality consequences.

The step as written names neither H3 nor H4. Section 5 shows it fails under each.

## 2. D is fixed exactly by the diagonal entries and (A)

**At an eigenvector.** By definition, $D(v_k)=\tfrac12\big[\sum_{ab}\lambda_a\lambda_bT_{kab}-\lambda_{\min}\lambda_{\max}\sum_{ab}T_{kab}\big]$. Relation (C), which is the diagonal entry $M_{kk}$ at criticality, and relation (A) give
$$D(v_k)=\lambda_k(\theta-\lambda_k)-(n-2)\lambda_{\min}\lambda_{\max}.$$

**L70 is this identity at $k=\min$.** With $\lambda_{\min}=-\lvert\lambda_{\min}\rvert$, $D(v_{\min})=\lvert\lambda_{\min}\rvert\big(\lambda_{\min}+(n-2)\lambda_{\max}-\theta\big)$, which rearranges to the boxed formula of L70 with no further input.

**At a general unit vector.** For $v=\sum_kx_kv_k$, $c_{vab}=\sum_kx_kc_{kab}$, so
$$D(v)=\tfrac12\sum_{kl}x_kx_l\Big[\sum_{ab}\lambda_a\lambda_bc_{kab}c_{lab}-\lambda_{\min}\lambda_{\max}\sum_{ab}c_{kab}c_{lab}\Big]=\sum_kx_k^2\big[\lambda_k(\theta-\lambda_k)-(n-2)\lambda_{\min}\lambda_{\max}\big],$$
using the off-diagonal entries $M_{kl}=0$ ($k\ne l$) and the off-diagonal Killing relation. The off-diagonal entries do appear in $D(v)$ here, but as exact identities.

**Consequence.** At a critical point $D$ is an exact function of $(\lambda,\theta,x)$ once all entries of $M$ and the Killing relation are used. A bound on $D$ is therefore equivalent to a bound on $\theta$, and it needs a constraint on the $c$ that criticality and the Killing form do not supply. The step asks which entries of $M$ can carry the Jacobi identity into such a derivation. This part is CONFIRMED AS ALGEBRA (claim 1).

## 3. Reading L: at degree 2, the Jacobi identity meets no entry of M

**Every nontrivial $J_{abcd}$ has $a,b,c,d$ distinct.** With a repeated index each $J$ vanishes identically by antisymmetry alone:

- $d=a$: $J_{abca}=\sum_e(c_{abe}c_{cae}+c_{cae}c_{bae})=\sum_e c_{cae}(c_{abe}+c_{bae})=0$.
- $d=b$: $J_{abcb}=\sum_e c_{abe}(c_{cbe}+c_{bce})=0$.
- $d=c$: $J_{abcc}=\sum_e c_{bce}(c_{ace}+c_{cae})=0$.
- A coincidence among $a,b,c$ kills every term, since each term then contains a $c$ with a repeated index, or reduces to one of the cases above after relabelling.

**For distinct $a,b,c,d$ the summed index satisfies $e\notin\{a,b,c,d\}$ in every surviving monomial.** For $e\in\{a,b,c,d\}$ each of the three products contains a factor with a repeated index (for instance $e=a$ gives $c_{aba}$, $c_{ada}$, $c_{caa}$), so it is zero. Hence every monomial of a nontrivial $J$ is $c_Sc_{S'}$ with index triples meeting in exactly one index, $\lvert S\cap S'\rvert=1$.

**The entries of M and D sit in other monomial classes.**

| Object | Monomials | $\lvert S\cap S'\rvert$ |
|---|---|---|
| Degree-2 Jacobi $J_{abcd}$ | $c_{abe}c_{cde}$ | 1 |
| Off-diagonal $M_{kl}$, off-diagonal Killing | $c_{k\alpha\beta}c_{l\alpha\beta}$ | 2 |
| Diagonal $M_{kk}$, (A), (B), (C), $D(v_k)$ | $c_{k\alpha\beta}^2$ | 3 |

These classes are disjoint sets of monomials in the degree-2 polynomials in the variables $c_S$ (one variable per oriented triple). A linear combination of Jacobi relations, with any coefficients depending on $(\lambda,\theta)$, contributes only class-1 monomials, so it can neither produce nor cancel a monomial of any entry of $M$. **Under reading L the diagonal entries carry no Jacobi, and the off-diagonal entries carry none either.** The step's "only the off-diagonal ones can" draws a line that reading L does not see (claim 3).

## 4. Reading N: the Jacobi identity has consequences in T alone

**The inequality.** Fix distinct $a,b,c,d$ and an index $e_0$. Isolating one term of $J_{abcd}=0$ and applying the triangle inequality, with $\lvert c_{abe}c_{cde}\rvert=\sqrt{T_{abe}T_{cde}}$,
$$\sqrt{T_{abe_0}T_{cde_0}}\;\le\;\sum_{e\ne e_0}\sqrt{T_{abe}T_{cde}}+\sum_e\sqrt{T_{bce}T_{ade}}+\sum_e\sqrt{T_{cae}T_{bde}}.$$
Every quantity in it is a function of $T$. It holds for the structure constants of $\mathfrak{so}(n)$ in any orthonormal basis, in particular an eigenbasis of $W$ (H2).

**It is a genuine constraint on T, supplied by Jacobi and by nothing in antisymmetry.** Take the totally antisymmetric 3-form whose only nonzero components are $c_{125}=c_{345}=s>0$ and their signed permutations. Then $T_{125}=T_{345}=s^2$, every other product in $J_{1234}$ vanishes ($c_{12e}c_{34e}\ne0$ only for $e=5$, and $c_{23e}$, $c_{14e}$, $c_{31e}$, $c_{24e}$ are all zero), and
$$J_{1234}=c_{125}c_{345}=s^2\ne0.$$
The inequality at $(a,b,c,d,e_0)=(1,2,3,4,5)$ reads $s^2\le0$, false. So the support pattern "two triples meeting in one index with no companion product" is excluded from the $T$ of any Lie bracket, and the exclusion is written purely in $T$.

**Why this refutes the step.** $D(v_k)$ and the diagonal entries $M_{kk}$ are functions of $T$ alone (section 2). A derivation of a bound on $D$ may impose (A), (B), (C) for every $k$, total symmetry, and the inequality above, and use no off-diagonal entry. That derivation brings the Jacobi identity into a bound on $D$ through the diagonal entries. The step says this route cannot exist, and it does (claim 2).

**Degree 4 shows the same thing polynomially.** Contract $J_{abcd}$ with $X_{ab,cd}=\sum_fc_{abf}c_{cdf}$ and sum. The terms $e=f$ of $\sum_{abcd}X_{ab,cd}\sum_ec_{abe}c_{cde}$ are $\sum_{abcde}T_{abe}T_{cde}$, a monomial in $T$ alone. Once the Jacobi identity is used beyond degree 2 it reaches square monomials as readily as mixed ones, so no degree separates the diagonal entries from the off-diagonal entries.

## 5. Arguing the opposite

- **"The diagonal entries are sign-blind and Jacobi is sign-sensitive."** Jacobi is sign-sensitive as an identity, but its image on $T$ is not empty, as section 4 exhibits. Sign-blindness of the diagonal entries does not make them Jacobi-blind.
- **"The author meant degree-2 linear relations."** Then the diagonal half is true (section 3), and the off-diagonal half is false by the same argument, since the off-diagonal entries are class-2 monomials and Jacobi is class 1. The sentence then asserts an asymmetry that reading L refutes.
- **"The inequality might already follow from (A), (B), (C) at a critical point, so Jacobi adds nothing through the diagonal."** That would make the diagonal channel redundant, not absent, and the identical question applies to the off-diagonal channel. Nothing in the passages settles it either way. It is not needed for the verdict, which concerns whether the route exists.

**The computation that would decide usefulness (not run, not required here).** Compare the supremum of $\theta$ over totally symmetric $T\ge0$ vanishing on coincident indices and satisfying (A), (B), (C) for every $k$ at a fixed spectrum, with and without the section 4 inequalities. A strict drop means the Jacobi identity sharpens a bound on $D$ through the diagonal entries alone. No drop means it is redundant there. Neither outcome restores the step, which excludes the diagonal route as impossible.

## 6. Verdict

**Step D7 FAILS.** The quoted line is "the off-diagonal entries are the only place the Jacobi identity can enter a bound on $D$" (Passage A of the brief, [findings/bounds.md](../findings/bounds.md)).

- Under reading N (H4), the Jacobi identity yields the closed-form inequality of section 4 in $T$ alone, which is the currency of $D$ and of every diagonal entry, so the diagonal entries are a place it can enter.
- Under reading L (H3), degree-2 Jacobi relations have monomials meeting in one index, disjoint from the diagonal entries (three) and from the off-diagonal entries (two), so neither kind of entry carries it and the claimed asymmetry is absent.
- No hypothesis in the inventory yields the asymmetry the step asserts.

**What stands.** $D$ at an eigenvector is the diagonal entry plus (A), and L70 is that identity rearranged (section 2). The correct replacement sentence is that $D$ and the diagonal entries are functions of $T$, that degree-2 Jacobi relations touch neither them nor the off-diagonal entries, and that the Jacobi identity reaches a bound on $D$ only through nonlinear consequences, which constrain the diagonal and off-diagonal data alike.
