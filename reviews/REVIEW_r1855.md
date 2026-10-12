# REVIEW r1855: the r1853 fold and CPmE.lean as committed

Brief: [BRIEF_I121_fold1853.md](BRIEF_I121_fold1853.md). Log: [agent_logs/r1855-i121-fold2.log](../agent_logs/r1855-i121-fold2.log). Footing: analysis only. One `lake env lean` compile of a copy of the committed file in the session scratchpad (`scratchpad/r1855/CPmE_r1855.lean`), for `#print axioms`. The margin figures were rechecked by hand.

| item | subject | verdict |
|---|---|---|
| 1 | fold 9edacfe1 against REVIEW_r1853 | CONFIRMED as a fold: (a) to (f) and the docstring extension are applied as r1853 states them. One figure is REFUTED: the $\mathbb{CP}^4$ cap is $\tfrac3{10}$, where the fold has $\tfrac13$, an error inherited from r1853 itself. Two minor corrections go with it |
| 2 | CPmE.lean as committed against the r1853 draft and the note | CONFIRMED |

## Item 1: the fold

**Finding by finding.**

| r1853 | required | applied in 9edacfe1 |
|---|---|---|
| (a) | margin restated at unit $W$: fails at the matching threshold by $0.002$, holds from $t^2\approx0.08$ | yes, near verbatim, with "where both carry the factor $1-t^2$" and "$0.20$ at unit $B_f$" added. Both additions are accurate |
| (b) | "reproduced here at $n=8$" | yes |
| (c) | "at the $c=\tfrac12$ maximisers", with the $c=2$ split | yes. $0.083/0.750$ and $0.092/0.746$ match r1851's table ($0.0833/0.7500$, $0.0917/0.7461$) |
| (d) | "sups" to "values" | yes. No other "sup" remains in the note |
| (e) | realised $0.044$ at $n=10$ | yes |
| (f) | $k\ll\dim\mathcal W_n$; $\mathbb{CP}^4$, $\mathbb{CP}^5$ cap $\tau$ at $n\le10$; change of coordinates between pairings | all three added, each as one clause (the cap figure is corrected below) |
| docstring | $P=\theta$ untyped, the two forms of $\theta$ | yes. The two forms are typed as `cp_theta` rather than listed as untyped, which r1853 offered as an option |

**The margin, rechecked by hand.** With $\theta_0(8)=1.1456$, $\lVert D\rVert=0.1428$ and $\max_ME(M)=0.0634$, the matching threshold is $t^2=0.0634/1.0634=0.0596$, so $t=0.244$. The diagonal condition $1.1456\,t-2.2714\,t^2-0.1428\le0$ has roots $t=0.2252$ and $0.2791$ ($t^2=0.078$). At $t=0.244$ the left side is $0.1358$ against $0.1343$, a failure by $0.0015$, which rounds to $0.002$. The fold says what r1853 computed.

**Corrections.**

- **(i) The $\mathbb{CP}^4$ cap is REFUTED.** The fold's closing sentence of "What this shows" says $\mathbb{CP}^4$ and $\mathbb{CP}^5$ cap the threshold "at $\tfrac13$ and $\tfrac14$". The maximal-frame mass is $\tfrac3{n+2}$ (the note's own sentence, by L95), so $\mathbb{CP}^4$ at $n=8$ gives $\tfrac3{10}$, and $\mathbb{CP}^5$ at $n=10$ gives $\tfrac14$ (the table's $0.250$). The $\tfrac13$ is r1853's figure, and r1852 gave none, so the fold copied an error in the report it answers. Replace "$\tfrac13$ and $\tfrac14$" with "$\tfrac3{10}$ and $\tfrac14$". The substance holds: $\varepsilon_8=1.1456-1.5/1.1456=-0.164<0<E(\mathbb{CP}^4)=9/(2\sqrt{1260})=0.127$.
- **(ii) The margin applies to the first $n=8$ maximiser.** The note says "At the $n=8$ maximisers ($\lVert D(B_f)\rVert=0.14$, $0.20$ ...) ... that pair of conditions is marginal". r1853 computed the margin for the first maximiser only. For the second ($\lVert D\rVert=0.1984$, $\max_ME(M)=0.0656$) the threshold is $t=0.248$, and there $1.1456\,t-2.2158\,t^2-0.1984=-0.051$, so the conditions hold with room. The note's conclusion ("neither excludes them nor leaves room") is unchanged, but the sentence should read "at the first $n=8$ maximiser it is marginal ... (the second holds by $0.05$)". This imprecision is in r1853's replacement text too.
- **(iii) The INDEX row for r1853 overstates it.** The row says "the fold applies every finding". r1853 found three findings neither applied nor declined (its item (f)) and two applied only in part. Say "the fold applies the findings, three omitted ones and two partial ones being completed on r1853".

**Nothing new entered under cover of the fold.** Every changed clause of the note traces to r1853, r1851 or r1852. The note's diff and the commit message agree. One sentence in the working tree at the $\mathbb{CP}^m$ paragraph ("At $n=12$ Conjecture A is recorded on an outside certificate (L254 ...)") is absent from 9edacfe1: it is another session's uncommitted edit, outside this review.

## Item 2: CPmE.lean as committed

**CONFIRMED.**

- **The reviewed declarations.** The committed `cp_norm`, `cp_cube`, `cp_E_poly` and `cp_E` are character for character those of the r1853 scratch copy, which is 92f0acd8's file plus r1853's appended checks. A `diff` of the two files differs only in the docstring and in the appended block.
- **`cp_theta`.** Its statement and proof are r1853's compiled `example (m : ℝ) (hm : 2 ≤ m)` verbatim, now named: $(m+1)(2m-1)/\sqrt N=\sqrt{(m+1)(2m-1)/(3m(m-1))}$ at $m\ge2$, the $\theta$ of `cp_E` equal to the record's $\theta^2=\tfrac{(m+1)(2m-1)}{3m(m-1)}$. r1853's two `norm_num` witnesses for $N>0$ and its `#print axioms` line were left in the scratch copy, which is correct for committed source.
- **The docstring.** The typed list names the five declarations and what each states, accurately. The untyped list names the spectrum of $\mathbb{CP}^m$'s Weyl tensor, its value $\theta$, and $P(W)=\theta$ at a unit critical point. Those are the inputs the file assumes: the spectrum fixes $N$, $K$ and the unit normalisation, $\theta$ enters `cp_E` as a numeral expression, and $P=\theta$ is what makes `cp_E` a statement about $E$.
- **Build and axioms.** `lake env lean` on the copy, run from lean/, exit 0: `cp_theta` and `cp_E` each depend on `[propext, Classical.choice, Quot.sound]`, no `sorryAx`. The file is imported in HamiltonsCubic.lean at HEAD.
