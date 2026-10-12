# REVIEW r1422: L47's dimension lemma and certificates in Lean, `dimension_lemma`, `cert_*`, `exc_*`, `CPm_ge`, `HPm_gt`, `minima`

Log [agent_logs/r1422.log](../agent_logs/r1422.log). One reviewer, statement fidelity only (the kernel has checked the proofs). Analysis-only: one scratch file elaborated for `#print axioms` and one screening `example` on the file's own `P`, finishing in seconds, reported as a screen. The script was read and not run. Record: [findings/problem.md](../findings/problem.md), Lemma L47 ("the dimension lemma for symmetric spaces"), with the family and exceptional tables read from [b_symmetric_dimension_lemma.py](../scripts/route-b/b_symmetric_dimension_lemma.py). Lean: commit c5946767, [L47Cert.lean](../lean/HamiltonsCubic/Results/L47Cert.lean) and the L47 row of [lean/INDEX.md](../lean/INDEX.md), read against [L47Statement.lean](../lean/HamiltonsCubic/Results/L47Statement.lean).

**Standfirst.** Every theorem in the file is the record's arithmetic, transcribed exactly. `dimension_lemma` is the displayed implication with the Cauchy–Schwarz output and the Einstein-normalised Weyl identity as hypotheses, and its identity $(n/4)^2/D-\frac n{8(n-1)}-\frac16=P(n,D)/(48D(n-1))$ checks by hand. The eight `cert_*` match the script's family rows in $n$, $\dim\mathfrak h$ and shift, and their $P$ at $a=b=0$ gives the record's constants $616, 48, 7200, 114, 3696, 2192, 236, 84$ in the record's order. The twelve `exc_*` match the script with $n=\dim G-\dim\mathfrak h$, and strict is the record's "all pass strictly". `CPm_ge` and `HPm_gt` carry the record's closed forms. Standard three axioms. **The gaps are one missing implication and three index slips**: the equality clause "only at $\mathbb{CP}^2$" needs the strict form $P>0\Rightarrow\lVert W\rVert^2>\frac16$, which no file states, so the eight certificates' strictness is consumed by nothing typed. `minima` only evaluates at $m=2$, and the HP minimum is proved in L47Statement's `hp_floor`, which neither the file nor the row cites. `dimension_lemma` and `P` duplicate L47Statement's `weyl_floor` and `P`, and the L47 (statement) row still says the certificates had nothing faithful to transcribe.

| Item | Verdict | Reason |
| --- | --- | --- |
| 1a. `dimension_lemma` hypotheses | CONFIRMED | `hCS` is the Cauchy–Schwarz output $\lVert R\rVert^2\ge(n/4)^2/D$, `hW` is $\lVert W\rVert^2=\lVert R\rVert^2-\frac n{8(n-1)}$, `hdim` is the display's premise. `2 ≤ n` and `0 < D` are domain conditions every symmetric space satisfies. Nothing the record uses is missing and nothing extra constrains the statement. |
| 1b. The identity | CONFIRMED | Over $48D(n-1)$: $3n^2(n-1)-6nD-8D(n-1)=3n^2(n-1)-(14n-8)D=P(n,D)$. |
| 1c. The strict implication | CONFIRMED WITH GAP | The record's "equality only at $\mathbb{CP}^2$" needs $P>0\Rightarrow\lVert W\rVert^2>\frac16$ on the rank $\ge2$ families, which is why the script demands a strictly positive constant term. `dimension_lemma` gives only $\ge$, as does L47Statement's `weyl_floor`. The strict form follows from the same identity (screened here as a Lean `example`, seconds) and is untyped. |
| 1d. Bridge from `cert_*` to `dimension_lemma` | CONFIRMED WITH GAP | The certificates conclude in the cleared form $P>0$ and `dimension_lemma` takes the divided form. L47Statement's `P_nonneg_iff` is that bridge, for its own `P`, which is a separate definition with the same body as `L47Cert.P`. |
| 2a. `cert_*` against the script's rows | CONFIRMED | AIII $(2pq,\ p^2+q^2-1)$, BDI $(pq,\ \binom p2+\binom q2)$, CII $(4pq,\ p(2p+1)+q(2q+1))$ at $p=2+a$, $q=2+a+b$. AI $((m-1)(m+2)/2,\ m(m-1)/2)$ and AII $((m-1)(2m+1),\ m(2m+1))$ at $m=3+a$. DIII $(m(m-1),\ m^2)$ at $m=4+a$, CI $(m(m+1),\ m^2)$ at $m=2+a$, II $(m,m)$ at $m=6+a$. Each row verbatim. |
| 2b. Constant terms | CONFIRMED | $P$ at $a=b=0$: AIII $(8,7)$ gives $1344-728=616$. BDI $(4,2)$ gives $144-96=48$. CII $(16,20)$ gives $11520-4320=7200$. AI $(5,3)$ gives $300-186=114$. AII $(14,21)$ gives $7644-3948=3696$. DIII $(12,16)$ gives $4752-2560=2192$. CI $(6,4)$ gives $540-304=236$. II $(6,6)$ gives $540-456=84$. The record's list, in its order. |
| 2c. Real $a,b\ge0$ | CONFIRMED (GENERALISATION) | Every integer parameter at or above the shift is a real $a,b\ge0$, so the real reading contains the record's and is stronger. The two conservative corners the record flags (BDI at $p=q=2$, type II at $n=6$) are inside the range, as the record says they are. |
| 3a. `exc_*` against the script | CONFIRMED | $n=\dim G-\dim\mathfrak h$: $42, 40, 32, 26$ for $E_6$, $70, 64, 54$ for $E_7$, $128, 112$ for $E_8$, $28, 16$ for $F_4$, $8$ for $G_2$, each with the script's $\dim\mathfrak h$. |
| 3b. Strict | CONFIRMED | The record says "all pass strictly" and the script tests $\le$, so `<` is the record's claim and the stronger one. The tightest, $\mathbb{OP}^2$ at $36<160/3$ and $G_2/SO(4)$ at $6<168/13$, are the record's factors $\frac{40}{27}$ and $\frac{28}{13}$. |
| 4a. `CPm_ge` | CONFIRMED | $\frac{3m(m-1)}{4(m+1)(2m-1)}-\frac16=\frac{(5m-1)(m-2)}{12(m+1)(2m-1)}$ by hand, and the factored numerator makes "zero exactly at $m=2$" immediate on $m\ge2$, though that iff is left to the reader. |
| 4b. `HPm_gt` | CONFIRMED | The record's HP closed form. Cleared, it is $92m^3-114m^2-102m+16>0$, which holds on $m\ge2$ (value $92$ at $m=2$, increasing after). |
| 4c. `minima` | CONFIRMED WITH GAP | Two evaluations at $m=2$, $\frac16$ and $\frac{45}{224}$, correct. The docstring calls them "the record's two minima", but that $\frac{45}{224}$ is the HP minimum over $m\ge2$ is proved only in L47Statement's `hp_floor`, uncited here. For CP, `CPm_ge` does make $\frac16$ the minimum. |
| 5. The L47 row | CONFIRMED WITH GAP | Accurate on what L47Cert proves and its Owed list is right (classification and hard-coded dimensions, the rank bound, the closed forms). It says "equality exactly at $\mathbb{CP}^2$" is proved, which needs 1c. It omits L47Statement, which already proves `weyl_floor`, `P_nonneg_iff`, `cp_floor` and `hp_floor`, and the L47 (statement) row and L47Statement's header still say the certificates had "nothing faithful to transcribe". A semicolon joins two clauses before "and the rest of the arithmetic is PROVED". |
| 6. `#print axioms` | CONFIRMED | `dimension_lemma`, `cert_CII`, `exc_EVIII`, `CPm_ge`, and also `HPm_gt` and `minima`, depend on `[propext, Classical.choice, Quot.sound]`. |

**One-line summary: CONFIRMED WITH GAP.** L47Cert types the record's implication, its eight certificates and its twelve exceptional checks exactly as the record and the script state them, on the standard three axioms. The strict implication behind "equality only at $\mathbb{CP}^2$" is untyped, `minima` leans on an uncited `hp_floor`, and the index rows do not connect L47Cert to L47Statement.

## 1. The implication

The record's argument is: $\operatorname{tr}R=n/4$ and $\operatorname{rank}R\le\dim\mathfrak h$ give $\lVert R\rVert^2\ge(n/4)^2/\dim\mathfrak h$ by Cauchy–Schwarz, the Einstein normalisation gives $\lVert W\rVert^2=\lVert R\rVert^2-\frac n{8(n-1)}$, and the dimension bound then gives $\lVert W\rVert^2\ge\frac16$. `dimension_lemma` takes the first two outputs as hypotheses on reals and proves the third. That is the record's display with its inputs named, and the geometric inputs are listed as owed in the row. The proof's identity is exact:

$$\frac{n^2}{16D}-\frac n{8(n-1)}-\frac16=\frac{3n^2(n-1)-6nD-8D(n-1)}{48D(n-1)}=\frac{3n^2(n-1)-2(7n-4)D}{48D(n-1)}.$$

**What the record also spends and the file does not state.** The equality clause needs every rank $\ge2$ space strictly above $\frac16$. With $P>0$ the same identity makes the right-hand side strictly positive, so $\lVert W\rVert^2>\frac16$. A screen compiled that form in seconds against `L47Cert.P`. It belongs in the file, since it is what the certificates' strict constant terms exist to feed.

## 2. The eight certificates

Each theorem is `0 < P n D` with $n$ and $D$ the script's row after the script's substitution, character for character. The constants were recomputed by hand in the table and agree with the record's list and order. The record's own caution that "first admissible rank" misdescribes BDI (the corner $p=q=2$ is the reducible $S^2\times S^2$) and type II (the corner $n=6$ is no simple Lie algebra's dimension) applies unchanged. Both corners are below the true families' starts, so the certificates cover the families with room. The file's docstrings repeat "rank p ≥ 2" and "dim ≥ 6" from the script, which is the same description the record corrects.

The classical list AI, AII, AIII, BDI, CI, CII, DIII, with type II, is the complete list of classical compact irreducible families. That these are the spaces and these their $(n,\dim\mathfrak h)$ is correctly owed.

## 3. The exceptional table

All twelve pairs are the script's, and $n$ is computed as the script computes it. Strict inequality is what the record states, and `norm_num` decides each over $\mathbb Q$.

## 4. The rank-one closed forms

Both closed forms are the record's, and they agree with the script's $\theta^2$ through $\lVert W\rVert^2=1/(4\theta^2)$. `CPm_ge` and `HPm_gt` hold at every real $m\ge2$, which settles the record's owed monotonicity for the use the equality clause makes of it: CP is at least $\frac16$ with equality only at $m=2$, HP is strictly above. That the HP minimum is exactly $\frac{45}{224}$ is `L47Statement.hp_floor`, and `minima` should cite it rather than stand as "the minima".

## 5. The index rows

The L47 row describes L47Cert accurately and its Owed list is complete for L47Cert. It should add the strict implication of 1c to what is owed, or type it, and cite L47Statement for `P_nonneg_iff` and `hp_floor`. The L47 (statement) row and L47Statement's header both say the certificate polynomials had nothing faithful to transcribe, which L47Cert now does, so both are stale. `dimension_lemma` restates `weyl_floor` with `hW` folded in, and `L47Cert.P` duplicates `L47Statement.P`, which is harmless but leaves two names for one object.

## 6. Axioms

`#print axioms` on `dimension_lemma`, `cert_CII`, `exc_EVIII`, `CPm_ge`, `HPm_gt` and `minima` gives `[propext, Classical.choice, Quot.sound]` for each.
