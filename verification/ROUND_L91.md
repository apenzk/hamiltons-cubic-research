# Round L91, the identity Gram gives the lower bound 1

**Id:** L91 · **Date:** 2026-09-14 · **Verifiers:** v308, v309, v310 · **Brief:** [BRIEF_L91.md](BRIEF_L91.md) · **Logs:** `agent_logs/verify-L91-v308.log`, `agent_logs/verify-L91-v309.log`, `agent_logs/verify-L91-v310.log`

## Sources, verbatim

| passage | source |
| --- | --- |
| the heading and argument | [findings/sym3-blocks.md](../findings/sym3-blocks.md) lines 175, 189-195 |
| L90, given | [findings/sym3-blocks.md](../findings/sym3-blocks.md) line 153 |

**Withheld**: the Gate 2 stack under the heading, and every index row.

## The findings from phase 0

**No [results.md](../results.md) entry and no Lean file.** The block's bullets predate L90's statement. Brief items 1 and 5.

## Adjudication

**Verdicts: [v308](VERIFY_v308.md), [v309](VERIFY_v309.md), [v310](VERIFY_v310.md) all `HYPOTHESIS-DEBT`. Round verdict: `HYPOTHESIS-DEBT`, narrowed, impact `CONTAINED`.** *Unanimous on every cluster.*

### Clustering

| id | step attacked | mechanism | support | outcome |
| --- | --- | --- | --- | --- |
| C1 | which rank the heading bounds | unnamed; bullet 3 fixes it as $\mathrm{rank}\,\mu_K$ | v308, v309, v310 | **named** in heading and statement |
| C2 | $\Delta\ne0$ | only a sampled value; the sum-of-squares proof needs $K\ne0$ and an invariant apolar product | v308, v309, v310 (`HYPOTHESIS-DEBT`) | **settled inline**: $K\ne0$ from codimension $\le3570<7770$ (L86 on Observation L83), then $\Delta\ge q_a^2>0$ |
| C3 | "$36-\mathrm{rank}$ ... only when consistent" | affine solution set, the PSD set possibly smaller | v308, v309, v310 (`CONFIRMED`) | **kept** |
| C4 | $\mathrm{rank}=14-\dim\{F:\mathrm{Cat}_F(K,K)=0\}$ | holds over invariant sextics only, with the invariant average of $\mathcal A(W_0^6)$; no derivation | v308 (`CONFIRMED AS ALGEBRA`), v309, v310 (`HYPOTHESIS-DEBT`) | **scoped**, derivation marked owed |
| C5 | "$14+29-65<0$" | undefined numbers, and an expected-dimension count bounds no intersection | v308, v309, v310 (`HYPOTHESIS-DEBT`) | **removed** |
| C6 | $\Delta$ vanishing exactly on the cone, $F_5/\Delta\in[2.50,3.15]$ | twelve sample points | v308, v309, v310 (`HYPOTHESIS-DEBT`) | **labelled** measured |
| C7 | which blocks die, only $c=30$ surviving | no rule stated; L86's parity rule supplies it, and among first labels $\le6$ the repeats are $30,40,60$ | v308, v309, v310 | **grounded** in L86 |
| C8 | scope against L90 | no contradiction, no new bound given L90 | v308, v309, v310 (`CONFIRMED`) | **stated**, with consistency reduced to $F_5(W_0)=0$ |

**No adjudication pair was spent.**

### Withdrawn

- **v310: a collision at $70$ between $(5,5)$ and $(7,0)$.** Outside the cubic range, first label $\le6$ (v309).
- **v309: an extra zero of $\Delta$ at $-W_0$.** On the two-sided cone.

**Impact `CONTAINED`.**
