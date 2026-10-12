# ROUND L20, the tube around the rival maximizer, its radius, and the word "unconditional"

**Id:** L20. **Source:** [findings/route-a.md](../findings/route-a.md):89–120, with the canonical form at [results.md](../results.md):671 and the landscape lines at :48 and :232. **Date:** 2026-09-07. **Verifiers allocated:** v119, v120, v121. **Phase:** 6, closed. **Verdict:** `HYPOTHESIS-DEBT`, repaired, impact `NARROWS`.

**Why this id.** Tier 1, cited eight or more times. It is the only result on the record that excludes a maximizer from a *region* rather than from a family, and the localization route rests on it.

**Phase 0's own finding.** [results.md](../results.md):232 calls the lemma **"Proven unconditionally by bootstrap"** and :48 says it **"closes the tube itself unconditionally"**. The verifiers are told neither that, nor that anything on the record disputes it.

**Pre-registered questions.** *(Questions, not verdicts. No adjudication has run on any.)*

1. **Inventory what the proof consumes, and say which of it is proved.** **For each input: proved here, proved elsewhere on the record, or imported from a source, and for imports, whether the source is in [references/](../references/) and whether its hypotheses hold at the object.**
2. **What is $d$?** *The radius $0.5748$ is a distance, and the statement gives no metric.* **Say what metric the proof's own expansion $W^*=\cos\varphi\,u+\sin\varphi\,V$ commits it to, whether that is stated anywhere, and how the radius changes under a different reasonable reading.**
3. **Does the final step hold at odd $n$?** **Follow the last inequality to its conclusion and name the object it needs; then check that object exists at odd $n$.**

**A source is read, never cited from memory.** *If a source is not in [references/](../references/), say the claim rests on an unread source.*

## The brief as dispatched

*Provenance stripped, mathematics verbatim, quoted from the current source.*

Write $\theta^*=\sqrt{3/2}=P(W_{\mathbb{CP}^2})$ and $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$ as fixed in [conventions.md](conventions.md), so that $\theta_0(n)>\theta^*$ exactly when $n>6+2\sqrt7$.

*Proof.* The unit sphere of $\mathrm{Weyl}_n$ is compact, so $m:=\sqrt{2/3}\max P$ is attained, at some $W^*$. Suppose $\varphi:=d(W^*,SO(n).W_{\mathbb{CP}^2})\le0.5748$. Since $P$ is invariant under the conjugation action of $SO(n)$ on $\Lambda^2(\mathbb{R}^n)$, rotate so that the nearest orbit point is $u=W_{\mathbb{CP}^2}$ itself, and write $W^*=\cos\varphi\,u+\sin\varphi\,V$. The vector $V$ is a unit vector orthogonal to $u$, and orthogonal also to $T_u(SO(n).u)$ by the first-variation condition for a nearest point on the orbit. Since $P$ is a cubic form with polarization $T$, and $Q(u)=\theta^*u$ makes $T(u,u,V)=\theta^*\langle u,V\rangle=0$, the expansion is exact and has no linear term:

$$m=\cos^3\varphi+3\cos\varphi\sin^2\varphi\,\alpha+\sin^3\varphi\,\gamma_V,\qquad \alpha=\sqrt{\tfrac23}\langle F_uV,V\rangle,\quad \gamma_V=\sqrt{\tfrac23}P(V),$$

where $F_u(h)=\tfrac12(uh+hu)+u\# h$. The largest eigenvalue of $F_u$ on $u^\perp\cap T_u(SO(n).u)^\perp$ is $\tfrac13\theta^*$, so $\alpha\le1/3$; this is Nienhaus Theorem 4.14(c), valid for $n\ge9$ and reverified here from scratch. And $\gamma_V\le m$ because $V$ is itself a unit Weyl operator and $m$ is the maximum over all of them. Substituting both and using $\cos^3\varphi+\cos\varphi\sin^2\varphi=\cos\varphi$,

$$m\le\cos\varphi+m\sin^3\varphi,\qquad\text{i.e.}\qquad m\le\psi(\varphi):=\frac{\cos\varphi}{1-\sin^3\varphi}.$$

On $[0,0.5748]$ one has $\psi\le\psi(0)=1$: $\psi$ falls to $0.9787$ near $\varphi=0.3927$ and rises again, first exceeding $1$ at $\varphi=0.5748$. Hence $m\le1$, i.e. $\max P\le\sqrt{3/2}$. But the balanced sphere product is a unit Weyl operator with $P=\theta_0(n)$, which exceeds $\sqrt{3/2}$ for $n\ge12$, a contradiction. Therefore $\varphi>0.5748$. $\square$

### The canonical form, quoted alongside without comment

**Lemma L20 (localization). No maximizer lies within $0.5748$ of the rival maximizer's orbit, for every $n\ge12$.** Proven unconditionally by bootstrap on the attained maximum.

## Phase 2, the clustering

**Reports:** [VERIFY_v119](VERIFY_v119.md), [VERIFY_v120](VERIFY_v120.md), [VERIFY_v121](VERIFY_v121.md), **all three `HYPOTHESIS-DEBT`, unanimous, naming the same three debts.**

| # | clause attacked | mechanism | support |
|---|---|---|---|
| **C1** | $\alpha\le\tfrac13$ | **the one unproved input, and the citation given does not carry it.** Nienhaus 4.14(c) states one eigenvalue on one subspace; being the *largest* on $u^\perp\cap T_u\mathcal O^\perp$ needs (a) and (d)–(g) exhaustive **plus** Remark 4.16, neither cited. *4.14's own proof runs through a Schur step whose multiplicity-free hypothesis this record's own L21 says fails here* | v119, v120, v121 |
| **C2** | the metric of $d$ | undefined in the block and in [conventions.md](../findings/conventions.md); the expansion commits the proof to geodesic angular distance. **Under the chord reading $0.5748$ is the angle $0.5830224$, where $\psi=1.0020125>1$ and the argument reaches no contradiction** | v119, v120, v121 |
| **C3** | the final step at odd $n$ | its witness is *"the balanced sphere product with $P=\theta_0(n)$"*, which **does not exist at odd $n$**. The conclusion survives via $\Theta_n$ and $n^2-13n+18>0$ (a different polynomial from the block's) which is on the record elsewhere and not here | v119, v120, v121 |
| **C4** | "unconditional" | stands at [results.md](../results.md):19, :41, :48 and :232 while the qualification sits 443 lines away; :41 attaches it to a bundle containing the conditional Observation L22 | v119, v120, v121 |
| **C5** | three unstated hypotheses | $SO(n)$-invariance of $d$, the orbit being compact and embedded, and $\varphi>0$ for the first-variation condition to be non-vacuous | v119, v120, v121 |
| **C6** | "$\psi$ first exceeds $1$ at $\varphi=0.5748$" | false as written, $\psi(0.5748)=0.9999937<1$, the crossing being $0.5748263$. **The sentence contradicts its own first clause**, and errs in the safe direction | v120, v121 |
| **C7** | "$\psi$ falls to $0.9787$ near $\varphi=0.3927$" | the minimiser is $\arcsin\tfrac{\sqrt3-1}2=0.3747372$ and the minimum $0.9785933$; $0.3927$ is $\pi/8$, where $\psi$ is already rising | v120, v121 |
| **C8** | [route-a.md](../findings/route-a.md):35's "Applied throughout" | a status claim about a repair, **false eighty lines below itself**, line 119 still read $\theta_0(n)$ | v120, v121 |
| **C9** | [LEDGER.md](../findings/LEDGER.md)'s "the block now says so" about the metric | a margin note said so; the proof did not | v121 |
| **C10** | Nienhaus 4.14 as printed | it does not exhaust $\mathrm{Weyl}_n$: $\langle W_{S^4\times S^{n-4}}\rangle$ is assigned to no clause, and sits inside the subspace the bound is taken over | v119 |

## Phase 3, adjudication

**The analytic chain is sound and all three verifiers re-derived it independently.** The expansion is exact, its linear term vanishes from criticality rather than maximality, the bootstrap is legitimate and non-circular, and $\psi\le1$ on $[0,0.5748]$ reduces *exactly* to $s^3+s^2+s\le1$ with the root hand-bracketed in $(0.5436,0.5437)$ against $\sin(0.5748)=0.5436669$.

**C1 is the round.** The lemma is conditional, and what makes that worth recording is not that an input is imported, it is that **the citation offered does not state the imported fact**. A reader following it finds an eigenvalue on a subspace and no maximality claim at all.

**C2 shows the radius is not a number until the metric is fixed.** *A theorem whose constant changes meaning under two natural readings of an undefined symbol is not yet a theorem*, and under one of them this one fails at its own stated radius.

**C5's first-variation hypotheses are load-bearing, not pedantic.** Without that step $\alpha\le\tfrac12$, at which the admissible interval is empty and the theorem is vacuous, so the unstated hypotheses carry the whole result.

**C6 and C7 are errors in the safe direction and are corrected rather than weighed.**

**No adjudication split, and no finding required computation.**

## Phase 4, the fix

**Verdict: `HYPOTHESIS-DEBT`. Impact: `NARROWS`**, the theorem stands, conditional on one named input, at a radius now measured in a stated metric.

- **The metric is defined in the proof's opening line and tabled in [conventions.md](../findings/conventions.md)**, with the chord reading's failure recorded beside it.
- **The odd-$n$ witness is replaced**: $\Theta_n$ with $n^2-13n+18>0$, and the two parities' different polynomials stated together.
- **$\alpha\le\tfrac13$ is marked as the lemma's one unproved input**, with what the citation actually says, what would be needed to discharge it, and the note that without the first-variation step the theorem is vacuous.
- **The three unstated hypotheses are stated.**
- **The two numerical sentences are corrected** to $0.9785933$ at $\varphi=0.3747372$ and a crossing at $0.5748263$, with the radius identified as the true crossing truncated safely.
- **"Unconditional" is gone from all four [results.md](../results.md) sites**, replaced by the condition; [route-a.md](../findings/route-a.md):35's false "Applied throughout" and [LEDGER.md](../findings/LEDGER.md)'s "the block now says so" are corrected to what is true.
