# REVIEW r1453: L35 proved in full in Lean: `L35`, `L35_weyl`, `L35_general`, `frame_trace`, `P_frame`, `bracketT_cst`, `dual_set`, `negatives`, L35Pack and L35Mono, the one-negative correction, and the citing lines of commits 38eec718 and a54fd5c5

Log [agent_logs/r1453.log](../agent_logs/r1453.log). One reviewer, working cold, statement fidelity and hypothesis use against the record. Analysis-only: one scratch file in the session scratchpad (outside the repository) importing [L35Statement.lean](../lean/HamiltonsCubic/Results/L35Statement.lean) and carrying `#print axioms` for five names and `#check`/`#print` of the layer objects the chain consumes (14 s, compiled through the import), reading, and the hand derivations below. No numerical run. Record: [findings/stratum-two-negative.md](../findings/stratum-two-negative.md) at a54fd5c5 (lines 127, 498, 516, 532 to 558), [reviews/REVIEW_r63.md](REVIEW_r63.md) §(ii), [reviews/REVIEW_r1452.md](REVIEW_r1452.md), [lean/INDEX.md](../lean/INDEX.md) rows 619 and 620, [findings/INDEX-results.md](../findings/INDEX-results.md) row 35 (line 50), [findings/LEDGER.md](../findings/LEDGER.md) line 1535, [results.md](../results.md) line 175, [report/sections/07-gradedness-split.tex](../report/sections/07-gradedness-split.tex), [report/sections/09-status.tex](../report/sections/09-status.tex) line 56, [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean) lines 39 to 180.

**Standfirst.** `L35` is the record's L35: a unit-norm `IsWeyl` operator with a spanning orthonormal eigenframe of skew matrices, at most two negative entries of the frame's spectrum counted with multiplicity, and `theta W ≤ √(3/2)`, with `theta = Pcubic / norm³` and `Pcubic = ⟨R, R² + R#⟩` in the repaired operator form. The span-to-expansion conversion is correct. `P_frame`'s ½ over ordered triples is the record's 3 over strictly increasing ones, `frame_trace` is the trace of $W$ on $\Lambda^2$ killed by Ricci-flatness, and `bracketT_cst`'s five properties are each true and derived from the layer. The eight-block split, the pigeonhole, the three equal $(+--)$ blocks, weak duality, the two harmonic-mean bounds, the cube bound and `R3_le_R2`'s factorisation all rederive by hand with every inequality in the enlarging direction. **The one-negative correction is right**: `R3_le_R2` needs only $\sqrt{1-u}\le s\le\sqrt{2-2u}$ and $bc\ge0$, and one negative sits at the lower end $s^2=1-u$. Standard three axioms on all five names. The gaps are stale citing lines, none claiming more than is proved: four lines in the record and its indexes still describe L35 as partial, owed or unable to reach a case that the Lean proof now covers, and L35Statement.lean's own header quotes a record line that no longer reads that way and describes a base defect that WeylReal.lean records as repaired.

| Item | Verdict | Reason |
| --- | --- | --- |
| A. The statement | CONFIRMED | `IsWeyl` is the four-clause $\mathrm{Weyl}_m$ (bivector-valued, self-adjoint on bivectors, Bianchi, Ricci-flat), `norm W = 1` is unit norm, `Eigenframe` is an orthonormal spanning family of eigen-bivectors so `lam` is the spectrum on $\Lambda^2$ with multiplicity, `AtMostTwoNegative` is the count of `lam a < 0` at most 2, and `theta` is $P/\lVert W\rVert^3$. The conversion writes $X=\sum c_iv_i$ from the span and reads $c_\delta=\langle X,v_\delta\rangle$ by orthonormality, giving L41Statement's `EigenFrame.complete` exactly. Screen: padded $W_{\mathbb{CP}^2}$ meets every hypothesis and reaches $\sqrt{3/2}$. |
| B. `frame_trace`, `P_frame`, `bracketT_cst` | CONFIRMED | `frame_trace`: $\operatorname{tr}_{\Lambda^2}W=\tfrac12\sum_{ij}\langle W\varphi_{ij},\varphi_{ij}\rangle=\tfrac12\sum_i\mathrm{Ric}_{ii}=0$ and in the frame it is $\sum\lambda$. `P_frame` is `trCube_frame` plus `sharpPair_T`. $T=c^2$ with $c=\langle[v_a,v_b],v_c\rangle$ is nonnegative, totally symmetric because $c$ is totally antisymmetric, zero at $a=b$ since $[v_a,v_a]=0$ (the other repeats follow by symmetry), and the pair cap is `brnorm_le_two`. Zero on repeats and total symmetry give $\sum_{\text{ordered}}=6\sum_{\alpha<\beta<\gamma}$, so ½ is the record's 3. At $(2,-1,-1)/\sqrt6$ with $T=2$ both read $2/\sqrt6$. |
| C. `L35_general` | CONFIRMED | Eight blocks exhaust $P\sqcup N$ (zero eigenvalues contribute nothing). Each $(++-)$ block is $\le0$, $(---)$ is $0$ because three distinct indices cannot fit in $\lvert N\rvert\le2$, and $NNP=NPN=PNN$ by the symmetries. `negatives` gives $PNN=2b_0c_0\sum_P\lambda\tau$ with $\tau_a=T_{a,n_1,n_2}\ge0$, $\sum_P\tau\le2$, so $\tfrac32PNN\le6Ab_0c_0$. `dual_set` gives $\tfrac12PPP\le\mu(s^2-u)$, `cube_sum_leP` gives $\sum_P\lambda^3\le A^3+\min(A,\sqrt d)d$, and the sum is `R3` via $-b^3-c^3+6Abc=-s^3+3bc(s+2A)$. `R3_le`'s two side conditions are $bc\ge0$ and $(b-c)^2\ge0$. Every step enlarges. |
| D. L35Pack.lean and L35Mono.lean | CONFIRMED | `hm_le_of_le` and `hm_le_K0` ($8y^2z^2\le(y^2+z^2)(y+z)^2$) rederive. `R3_le_R2`'s factorisation $R(S)-R(s)=(S-s)[m_2(S+s)+\tfrac12(S^2+Ss+s^2)+3A(S+s)+\tfrac32(u-1)]$ expands by hand, and the bracket is at least $\tfrac32(s^2-1+u)=3bc\ge0$ at $s\le S$. `R3` is the transcription's $R(A,s,u)$ and REVIEW_r63's. Observation: `dual_general`, `cube_sum_le`, `packing_le_R3` and `packing_le` are off L35's proof path, which uses L35Weyl's Finset versions and takes only the harmonic-mean lemmas from L35Pack. |
| E. The one-negative case | CONFIRMED | `R3_le_R2` assumes $A\ge0$, $s\ge0$, $1-u\le s^2\le2-2u$ and nothing else. At one negative $c=0$, $s=b$, $u=1-b^2$, so $s^2=1-u$ and $s^2\le2-2u$ is $u\le1$. $R_2$ is $R$ evaluated at $S=\sqrt{2-2u}$, an upper bound needing no spectrum with $b=c$. The old objection read "attained only at $b=c$" as "applies only at $b=c$". |
| F. Citing lines | CONFIRMED WITH GAP | The a54fd5c5 edits to stratum-two-negative.md line 516, LEDGER line 1535's body, results.md line 175, report §7 and §9 and lean/INDEX row 620 claim exactly what is proved. Stale, each claiming less than is proved: INDEX-results row 35 ends "**Lean: partial**" beside its own "PROVED IN LEAN IN FULL". LEDGER line 1535 keeps the header "'Unconditionally' reaches a case the argument does not." above a body saying the chain covers it. lean/INDEX row 619 is **proved** and ends "**statement: not typed**". stratum-two-negative.md line 127 says L35 "cannot discharge" the $k=2$ maximisation. L35Statement.lean line 19 quotes "the one-negative case is OWED" as verbatim record, and line 60 describes a `tr(R#)` defect that WeylReal.lean records as repaired. |
| G. Axioms | CONFIRMED | `L35`, `L35_weyl`, `L35_general`, `R3_le_R2`, `packing_le`: each `[propext, Classical.choice, Quot.sound]`. No `sorryAx`. |
| H. Hypotheses | CONFIRMED | Every hypothesis of `L35`, `L35_weyl`, `L35_general`, `R3_le_R2`, `R3_le` is consumed (by reading, since L35Statement.lean disables the unused-variable lint). Used but unstated: none. The eigenframe is a hypothesis, and [EigenFrameExist.lean](../lean/HamiltonsCubic/Results/EigenFrameExist.lean)'s `eigenFrame_exists` supplies one, though no `L35_exists` form is stated. |

**One-line summary.** `L35` is the record's L35 at unit norm, proved through a chain whose every step rederives by hand and runs in the enlarging direction, with the one-negative case covered by the same monotonicity step. What remains is four stale citing lines and two stale docstring clauses, none overclaiming. **CONFIRMED WITH GAP**

## A. The statement against the record

**The record** (stratum-two-negative.md, statement block): $W\in\mathrm{Weyl}_m$, unit norm, at most two negative eigenvalues, any number of positive ones, any $m$, then $\theta\le\sqrt{3/2}$.

**The Lean objects.**
- `IsWeyl` ([WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean) line 126): maps bivectors to bivectors, self-adjoint for `inner2` on bivectors, first Bianchi, Ricci-flat. This is $\mathrm{Weyl}_m$ as a map on $\Lambda^2$.
- `norm W = √(innerOp W W)` with `innerOp` the $\Lambda^2$ pairing (½ paying for the ordered-pair double count), and `theta = Pcubic / norm ^ 3`, `Pcubic = trCube + sharpPair`, `sharpPair = innerOp R (sharpOp R)`. This is $\langle W,W^2+W^\#\rangle/\lVert W\rVert^3$.
- `Eigenframe`: `skew`, `orthonormal` for `inner2` $=\tfrac12\operatorname{tr}(X^\top Y)$, `eigen`, and `complete` in span form. Orthonormality makes `v` injective and linearly independent, and with `complete` it is a basis of $\Lambda^2$, so `lam` is the spectrum of $W$ on $\Lambda^2$ counted with multiplicity.
- `AtMostTwoNegative lam`: the number of indices with `lam a < 0` is at most 2, the record's count with multiplicity.

**The conversion** (L35Statement.lean, inside `L35`). `Submodule.mem_span_range_iff_exists_fun` gives $X=\sum_ic_iv_i$. `hlin` is linearity of `inner2` in the first slot through the trace, and orthonormality turns $\sum_ic_i\langle v_i,v_\delta\rangle$ into $c_\delta$. Substituting back gives $X=\sum_\delta\langle X,v_\delta\rangle v_\delta$, which is `EigenFrame.complete` as `#print` shows it. `hn` reads `normSq W = 1` from $\sqrt{\mathrm{normSq}}=1$ through `Real.sqrt_eq_one`, and `theta W` becomes `Pcubic W / 1`. **Correct.**

**Screen** (by hand, not evidence for the theorem). Padded $W_{\mathbb{CP}^2}$ has spectrum $(2,-1,-1)/\sqrt6$ on $\Lambda^2_+$ and zeros elsewhere: two negatives. With $\omega_i=J_i/\sqrt2$ for the quaternion units ($J_iJ_j=J_k$, $[J_1,J_2]=2J_3$), `inner2` gives $\lVert\omega_i\rVert=1$ and $[\omega_1,\omega_2]=\sqrt2\,\omega_3$, so $T=2$ and the pair cap is saturated. $P=1/\sqrt6+3\cdot2\cdot\tfrac{2}{6\sqrt6}=\sqrt{3/2}$. The hypotheses admit the record's maximiser and the bound is attained there, so the statement is neither vacuous nor loose at that point.

## B. `frame_trace`, `P_frame`, `bracketT_cst`

**`frame_trace`.** `innerOp_frame` evaluates `innerOp W id` in the frame as $\sum_\gamma\langle Wv_\gamma,v_\gamma\rangle=\sum_\gamma\lambda_\gamma$. In the $\varphi$ basis it is $\tfrac12\sum_{i,j}\langle W\varphi_{ij},\varphi_{ij}\rangle=\tfrac12\sum_i\mathrm{Ric}_{ii}$, zero by the fourth clause of `IsWeyl`. So $\sum\lambda=0$ is trace-freeness from Ricci-flatness. **Correct.**

**`P_frame`.** `trCube_frame` gives $\sum\lambda^3$ and `sharpPair_T` gives $\tfrac12\sum_{\gamma,\alpha,\beta}\lambda_\gamma\lambda_\alpha\lambda_\beta c_{\gamma\alpha\beta}^2$ (both `#check`ed). **The factor.** $T_{abc}=0$ whenever two indices coincide and $T$ is totally symmetric, so the ordered sum is $3!=6$ times the sum over $\alpha<\beta<\gamma$, and $\tfrac12\cdot6=3$ is the record's coefficient. At the maximiser: $\tfrac12\cdot6\cdot2\cdot\tfrac{2}{6\sqrt6}=2/\sqrt6$, the record's second half.

**`bracketT_cst`**, $T=c^2$, $c_{abc}=\langle[v_a,v_b],v_c\rangle$ (`cst`, `#print`ed):
- `nonneg`: a square.
- `s12`, `s23` (`T12`, `T23`): $c$ is antisymmetric in its first two slots by $[X,Y]=-[Y,X]$ and in its last two by ad-invariance of the trace form on $\mathfrak{so}(n)$, $\langle[X,Y],Z\rangle=-\langle Y,[X,Z]\rangle$, so $c^2$ is totally symmetric.
- `rep`: $[v_a,v_a]=0$. `rep13`, `rep23` follow from `rep` and the symmetries.
- `cap`: $\sum_cT_{abc}=\sum_c\langle[v_a,v_b],v_c\rangle^2=\lVert[v_a,v_b]\rVert^2$ by completeness, at most 2 by `brnorm_le_two` for orthonormal skew $v_a,v_b$ (under `inner2`, equivalent to $\lVert[X,Y]\rVert_F\le\lVert X\rVert_F\lVert Y\rVert_F$ on $\mathfrak{so}(n)$). At $a=b$ it is $0$.

Every property is true and derived from the layer.

## C. `L35_general`, by hand

**The split** (`hsplit`, `htot`). $P=\{\lambda>0\}$, $N=\{\lambda<0\}$ are disjoint, and every summand with a zero eigenvalue in any slot is zero, so each of the three sums restricts to $P\sqcup N$ and the triple sum is the eight blocks.

**Signs.**
- $(++-)$ in each of its three positions: $\lambda_+\lambda_+\lambda_-\le0$ against $T\ge0$, so `hPPN`, `hPNP`, `hNPP` are $\le0$. They enter the upper bound with coefficient $+\tfrac12$ and are dropped: safe.
- $(---)$: a nonzero term needs three distinct indices (`rep`, `rep13`, `rep23`), and $\{a,b,c\}\subseteq N$ with $\lvert N\rvert\le2$ is impossible. `hneg`'s set is literally $N$. So `hNNN` $=0$.
- $(+--)$: `hNNP` and `hNPN` equal `PNN` by reindexing and total symmetry. So the three contribute $\tfrac32PNN$.

**`negatives`.** Card 0: $b_0=c_0=0$, $\tau=0$. Card 1: $b_0=-\lambda_n$, $c_0=0$, $\tau=0$, and the $NN$ sum is $\lambda_n^2T_{ann}=0$ by `rep23`. Card 2: $b_0=-\lambda_{n_1}$, $c_0=-\lambda_{n_2}$, $\tau_a=T_{a,n_1,n_2}$, the $NN$ sum is $2\lambda_{n_1}\lambda_{n_2}T_{a,n_1,n_2}=2b_0c_0\tau_a$, and $\sum_P\tau\le\sum_{\text{all}}T_{a,n_1,n_2}=\sum_cT_{n_1n_2c}\le2$. Moments: $\sum_N\lambda=-(b_0+c_0)$, $\sum_N\lambda^2=b_0^2+c_0^2$, $\sum_N\lambda^3=-b_0^3-c_0^3$ in every case. **Correct.**

**The $(+--)$ term.** $\tfrac32PNN=3b_0c_0\sum_P\lambda\tau\le3b_0c_0\cdot A\sum_P\tau\le6Ab_0c_0$, using $\lambda\le A$ on $P$, $\tau\ge0$ and $b_0c_0\ge0$. Safe.

**`dual_set`.** Per distinct triple, $3\lambda_\alpha\lambda_\beta\lambda_\gamma=\mathrm{HM}\cdot(\lambda_\alpha\lambda_\beta+\lambda_\beta\lambda_\gamma+\lambda_\alpha\lambda_\gamma)\le\mu(\cdots)$, times $T\ge0$. Repeated triples are $0=0$. The three pair sums agree by symmetry, and $\sum_{\alpha,\beta,\gamma\in P}\lambda_\alpha\lambda_\beta T_{\alpha\beta\gamma}\le2\sum_{\alpha\ne\beta\in P}\lambda_\alpha\lambda_\beta=2(s^2-u)$, using $\lambda_\alpha\lambda_\beta\ge0$ on $P$ and the cap restricted to $\gamma\in P$ (nonnegativity). So $3\cdot PPP\le3\mu\cdot2(s^2-u)$, $\tfrac12PPP\le\mu(s^2-u)$, the record's $3M\le\mu(s^2-u)$. `hμ0` is needed to multiply the cap bound by $\mu$ and is supplied by $\min(A,K_0\sqrt d)\ge0$.

**The dual weight.** For a distinct triple containing $i_0$, drop $i_0$: the other two are distinct and outside $i_0$, so $y^2+z^2\le d$ (`pair_sq_leP`) and `hm_le_K0` gives $\mathrm{HM}\le K_0\sqrt d$. `hm_perm12`, `hm_perm13` move $i_0$ to the first slot. Without $i_0$, any two entries serve. $\mathrm{HM}\le A$ is `hm_le_of_le`.

**`cube_sum_leP`.** For $i\in P\setminus\{i_0\}$: $\lambda_i\le A$ and $\lambda_i^2\le d$, so $\lambda_i^3\le\min(A,\sqrt d)\lambda_i^2$, and summing gives $A^3+\min(A,\sqrt d)d$. **Correct.**

**Assembly.** $\sum\lambda^3+\tfrac12\sum T\lambda\lambda\lambda\le A^3+\min(A,\sqrt d)d-b^3-c^3+\mu(s^2-u)+6Abc=R(A,s,u)$ with $s=b_0+c_0=\sum_P\lambda$, $u=A^2+d=\sum_P\lambda^2$, $bc=(s^2-1+u)/2$ from unit norm, and $-b^3-c^3+6Abc=-s^3+3bc(s+2A)$. `R3_le`'s hypotheses: $s\ge0$, $1-u\le s^2$ is $bc\ge0$, and $s^2\le2-2u$ is $(b-c)^2\ge0$ ($s^2-4bc=2-2u-s^2$). `hPne`: $P=\emptyset$ forces $b_0+c_0=0$, so $b_0=c_0=0$, against $b_0^2+c_0^2=1$. **Every inequality runs in the enlarging direction.**

## D. L35Pack.lean and L35Mono.lean

- **`hm_le_of_le`**: each $1/x\ge1/A$, so $3/(\sum1/x)\le A$. Correct.
- **`hm_le_K0`**: $\mathrm{HM}\le3yz/(y+z)$ by dropping $1/x>0$. Then $9y^2z^2\le\tfrac98(y^2+z^2)(y+z)^2$ is $8y^2z^2\le(y^2+z^2)(y+z)^2$, from $y^2+z^2\ge2yz$ and $(y+z)^2\ge4yz$. Correct.
- **`R3`**: $A^3+\min(A,\sqrt d)d+\min(A,K_0\sqrt d)(s^2-u)-s^3+3\cdot\tfrac{s^2-1+u}2(s+2A)$, the transcription's $R(A,s,u)$ (stratum-two-negative.md "The middle of the proof") and REVIEW_r63 §(ii), checked against both by r1452 and unchanged.
- **`R3_le_R2`**, by hand: $(S^2-1+u)(S+2A)-(s^2-1+u)(s+2A)=(S^3-s^3)+2A(S^2-s^2)+(u-1)(S-s)$, so $R(S)-R(s)=m_2(S^2-s^2)-(S^3-s^3)+\tfrac32(S^3-s^3)+3A(S^2-s^2)+\tfrac32(u-1)(S-s)$, which is the stated $(S-s)[\cdots]$. At $0\le s\le S$: $\tfrac12(S^2+Ss+s^2)\ge\tfrac32s^2$, so the bracket is at least $m_2(S+s)+3A(S+s)+\tfrac32(s^2-1+u)\ge0$. `hR2` rewrites `R2` as $R$ at $S$ using $S^2=2-2u$. **Correct, and "bracket nonnegative because $bc\ge0$" is exact.**
- **`R3_le`**: `R3_le_R2` then r1452's `R2_le`, whose $A^2+d\le1$ follows from $1-u\le s^2\le2-2u$.
- **`dual_general`, `cube_sum_le`, `packing_le_R3`, `packing_le`**: correct statements over `Fin k` with a `Feasible` packing, parallel to the Finset lemmas. *Observation*: they are not consumed by `L35_general`, which re-proves `dual_set`, `cube_sum_leP`, `pair_sq_leP` over a Finset of positives. The lean/INDEX L35 row lists them beside the proof path without saying they sit off it.

## E. The one-negative case

**The old record** (before a54fd5c5, stratum-two-negative.md line 516): the line offered "does not work", since $c\to0$ sits strictly inside $\{s^2<2-2u\}$ and the step "forces $b=c$". **The new record**: $R\le R_2$ holds at every feasible $s$, $bc=0$ included, because $R_2$ is an upper bound evaluated at $s=\sqrt{2-2u}$.

**The check.** `R3_le_R2`'s hypotheses are $A\ge0$, $s\ge0$, $1-u\le s^2$, $s^2\le2-2u$, and nothing else. At one negative: $c=0$, $s=\sum_P\lambda=b$, $u=1-b^2$, so $s^2=1-u$ (the lower face, $bc=0$) and $s^2\le2-2u$ is $u\le1$. The factorisation's bracket at $bc=0$ is still $\ge0$. $R_2$ is the value of $R$ at the other endpoint, and nothing in the inequality asks that a spectrum with $b=c$ realise it. **The correction is right.** *Strongest defence of the old reading*: $R_2$ is *attained* only on $b=c$, so the two-negative maximiser lives there. That is a statement about equality, and the old text took it for a condition of validity. In Lean the case is `negatives` at card 1 feeding the same `R3_le` call, so it is covered by construction. I48's $\theta\le0$ remains the sharper statement.

## F. Citing lines changed in a54fd5c5, and stale lines near L35

**Faithful** (each claims what is proved):
- stratum-two-negative.md line 516: "The chain covers it as it stands", with `L35_general` and `negatives` named.
- LEDGER line 1535's body: "the same chain covers it … machine-checked in `L35_general`".
- results.md line 175, report §7 ("The lemma as a whole … is machine-checked in Lean"), report §9 line 56 ("Machine-checked in Lean in full").
- lean/INDEX row 620: **proved**, no `sorry`, the chain named, "statement: typed".
- L35Statement.lean lines 36 to 57 and the `L35` docstring.

**Stale** (each claims less than is proved, located exactly):
1. [INDEX-results.md](../findings/INDEX-results.md) row 35 (line 50) opens "**PROVED IN LEAN IN FULL**" and closes "**Lean: partial**, [statement]". The sweep edited the head and left the tail.
2. [LEDGER.md](../findings/LEDGER.md) line 1535 keeps the bold lead "'Unconditionally' reaches a case the argument does not." above a body that now says the chain reaches it. The lead is false against its own paragraph.
3. [lean/INDEX.md](../lean/INDEX.md) row 619 is **proved** and still ends "**statement: not typed**" (r1452 noted the tag, and row 620 says "typed").
4. [stratum-two-negative.md](../findings/stratum-two-negative.md) line 127 says the $k=2$ two-parameter maximisation is owed and "[Lemma L35] cannot discharge it, its own proof consuming this lemma at $k\le2$". The Lean chain runs uniformly in $k$ (at $k=1$, $d=0$ and $s^2-u=0$, at $k=2$ nothing changes) and consumes no $k\le2$ lemma, so L35 in Lean now discharges it. *Defence*: the sentence speaks of the hand proof, whose $k\le2$ closure line 558 places in REVIEW_r63. The sentence still reads as a claim about L35 as such, and line 558's "what the canonical record owes here is the transcription of the $k\le2$ closed forms" is the accurate one.
5. [L35Statement.lean](../lean/HamiltonsCubic/Results/L35Statement.lean) line 19 quotes "the one-negative case is OWED" as verbatim record. The record's line 498 has read "THE ONE-NEGATIVE CASE IS CLOSED, 2026-09-17 … $\theta\le0$" since commit 7fcad1c7, and the file's own lines 53 to 57 now say the case is proved.
6. L35Statement.lean lines 59 to 61 say WeylReal.lean's docstring "records that its `sharpPair` term is even in `R` and so is `tr(R#)`". WeylReal.lean line 167 defines `sharpPair = innerOp R (sharpOp R)` and its docstring says the `tr(R#)` shape was carried and "both are repaired". The theorem is against the repaired `theta`, so the clause misdescribes the object while the proof is unaffected. The heading "What is NOT typed here" (line 53) now introduces what is typed.

**Searched**: "sorry", "owed", "OWED", "partial", "not typed", "one-negative", "does not work" across stratum-two-negative.md, LEDGER.md, INDEX-results.md, results.md, report/sections, lean/INDEX.md and the L35 Lean files. No `sorry` remains in L35Statement.lean, L35Weyl.lean, L35Pack.lean or L35Mono.lean. No line claims more than is proved.

## G. Axioms

`#print axioms` for `HamiltonsCubic.L35Statement.L35`, `HamiltonsCubic.L35Residual.L35_weyl`, `HamiltonsCubic.L35Residual.L35_general`, `HamiltonsCubic.L35Residual.R3_le_R2`, `HamiltonsCubic.L35Residual.packing_le`: each depends on `[propext, Classical.choice, Quot.sound]`. No `sorryAx`. The scratch file compiled through the import of L35Statement.lean, which builds L35Weyl, L35Pack, L35Mono, L35Reduce and L35Residual.

## H. Hypotheses stated but unused, and used but unstated

- `L35`: `hW` feeds `L35_weyl` (trace, `P_frame`, `normSq_frame`), `hnorm` gives `hn` and the division, `hframe` gives the expansion frame, `hneg` passes through. L35Statement.lean sets `linter.unusedVariables false`, so this is by reading.
- `L35_weyl`: `hW`, `hf`, `hn`, `hneg`, all consumed.
- `L35_general`: `hT` in every symmetry and cap step, `hneg` in `negatives` and the pigeonhole, `hsum` in `hs1`, `hn` in `hs2`.
- `dual_set`: `hP` for the triple constraint and $\lambda_\alpha\lambda_\beta\ge0$, `hμ0` for scaling the cap, `hμ` per triple.
- `R3_le_R2`: `hA` in `hm2` and the bracket, `hs`, `hbc`, `hbmc` in the bracket and in $s\le S$.
- `negatives`: `hPN` is not consumed in the body (the column bound goes through `univ`). Harmless: an extra hypothesis the caller always supplies.
- Used but unstated: none. The eigenframe is a hypothesis, and [EigenFrameExist.lean](../lean/HamiltonsCubic/Results/EigenFrameExist.lean) line 146's `eigenFrame_exists` supplies one for any Weyl $W$, though no `L35` form with the frame supplied is stated.
- Scope: the record's remark that the chain never uses first Bianchi is recorded rather than formalised (lean/INDEX row 619 says so). `L35` carries full `IsWeyl`, which is the record's statement.
