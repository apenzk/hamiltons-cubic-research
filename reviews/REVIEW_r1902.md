# REVIEW r1902: I123 coupling, three extensions of P

Reviewed: [reviews/2026-09-28o-I123-coupling.md](2026-09-28o-I123-coupling.md). Log: [agent_logs/r1902-i123-extensions.log](../agent_logs/r1902-i123-extensions.log). Analysis-only footing: every derivation below is by hand. The numerical lines are screens of seconds (Sage's Python, an explicit halved # on so(6) and the closed-form G on the invariant circle), reported as screens.

**Verdict: extensions 1 to 3 hold as written, with one normalisation note on the Ricci figure. The conclusion's proposed mechanism is vacuous: Q(W) is itself Weyl (BW08 eq. (6), on the record at [problem.md](../findings/problem.md) line 53), so Ric(Q(W)) is identically zero on the Weyl subspace.**

| # | claim | verdict |
|---|---|---|
| 1 | object paragraph | CONFIRMED |
| 2 | extension 1 | CONFIRMED (already on the record) |
| 3 | extension 2 | CONFIRMED, and it undersells: the first-order term vanishes in every direction orthogonal to Weyl |
| 4 | extension 3 | CONFIRMED, with a correction to the Ricci normalisation |
| 5 | conclusion | REFUTED in its second half (the Ric Q(W) candidate is identically zero), CONFIRMED in its first half |
| 6 | prior record | see below: extension 1, the symmetry of T, Q-invariance of Weyl and the value 1.248376 are all on the record |

## 1. The object

- tr(XYZ) is invariant under cyclic shifts and, for symmetric arguments, under reversal (transpose), so it is fully symmetric. The # half, ⟨X#Y,Z⟩, is fully symmetric by BW08 eq. (5), which the record already holds ([problem.md](../findings/problem.md) line 74, "the symmetry of T is a theorem"). Screen at n=6 on random symmetric X, Y, Z: the three orderings agree to 1e-14.
- G(X)=⟨Q(X),X⟩=tr X³+⟨X#X,X⟩ is P on the Weyl subspace by the definition in the givens. "X^#" in the note means X#X, consistent with [conventions.md](../findings/conventions.md).
- Q preserving curvature operators under the halved product: screened at n=6 (Bianchi residual of Q(W) 7e-17).

## 2. Extension 1

G(W+cI)=G(W)+3c T(W,W,I)+3c² T(W,I,I)+c³G(I).

- T(W,W,I)=⟨Q(W),I⟩=tr W²+⟨W#W,I⟩=‖W‖²+⟨W,I#W⟩=‖W‖²−‖W‖²=0 by L265. This is the stated cancellation.
- T(W,I,I)=⟨Q(I),W⟩=(n−1) tr W=0.
- G(I)=tr I+⟨(n−2)I,I⟩=(n−1)N.

So G(W+cI)=P(W)+c³(n−1)N. Already on the record: [problem.md](../findings/problem.md) derives θ₀ from exactly this collapse, "Φ(cI+W)=c²(n−1)I+Φ(W), and every cross term in the cubic vanishes".

## 3. Extension 2

- Sym²(Λ²)=ker b ⊕ Λ⁴ with the Bianchi map b (one third of the cyclic sum) an orthogonal projection onto Λ⁴ under the Frobenius pairing, so Λ⁴ is the orthogonal complement of the algebraic curvature operators. Correct.
- T(W,W,Y)=⟨Q(W),Y⟩=0 since Q(W) is a curvature operator. Correct.
- Expansion: G(W+Y)=G(W)+3T(W,W,Y)+3T(W,Y,Y)+G(Y)=P(W)+3⟨Q(Y),W⟩+G(Y). Correct.
- **Stronger fact the note misses.** Q(W) is Weyl, not merely a curvature operator (BW08 eq. (6), Ric(Q(R))_{ij}=Σ_k Ric_kk R_kijk, recorded at [problem.md](../findings/problem.md) line 53 and [conventions.md](../findings/conventions.md) line 51). Hence T(W,W,Z)=⟨Q(W),Z⟩=0 for every Z orthogonal to the Weyl subspace: Λ⁴, the identity and the traceless Ricci directions alike. Extensions 1 and 2 are the same fact, and the Ricci directions of extension 3 are first-order neutral too. Screen: Ric(Q(W)) of a random unit Weyl W at n=6 is 3e-16.

## 4. Extension 3

- **Curvature operators.** Under O(p)×O(q), Λ²ℝⁿ=Λ²ℝᵖ ⊕ Λ²ℝ^q ⊕ ℝᵖ⊗ℝ^q splits into three inequivalent irreducibles, so the invariant symmetric operators are spanned by the three projections. Λ⁴ has no O(p)×O(q) invariant (Λⁱℝᵖ has an O(p) invariant only at i=0), so all three are curvature operators. P_p is S^p×ℝ^q, P_q likewise, and P_p+P_q+P_mix=I. Correct. Screen at p=q=3: Bianchi residual 0 for each projection.
- **The formula.** With A=P_p, B=P_q, M=P_mix and X=aA+bB+cM: tr X³=a³d_p+b³d_q+c³pq, and X#X=a²(p−2)A+b²(q−2)B+c²(qA+pB)+c(a(p−1)+b(q−1))M, so ⟨X#X,X⟩=a³(p−2)d_p+b³(q−2)d_q+c²(qa d_p+pb d_q)+c²pq(a(p−1)+b(q−1)). Since q d_p=½pq(p−1), the c² terms total (3/2)pq c²(a(p−1)+b(q−1)). The formula is right. The products pass the identity test: I#I=(p+q−2)(A+B)+(p+q−2)M=(n−2)I. Screen at p=q=3: all four products exact, and the formula matches a direct evaluation at a random (a,b,c).
- **a=b=c=1.** 150+36+540=726=11·66 at p=q=6, and in general it is G(I)=(n−1)N. Correct.
- **Ricci-free line.** Ric on the p-factor is a(p−1)+cq and on the q-factor b(q−1)+cp (sums of sectional curvatures, screened at n=6). Their vanishing gives the stated line, a one-dimensional space of invariant Weyl tensors, hence the span of W(S^p×S^q). At p=q=6, a=b=−6c/5: ‖X‖²=79.2c², G=−871.2c³, unit value 871.2/79.2^{3/2}=1.236033. Correct.
- **The maximiser, exact.** With s=a+b, d=b−a: trace 15s+36c=0 gives s=−12c/5. The unit condition becomes 7.5d²+79.2c²=1. G=75s(s²+3d²)/4+36c³+270c²s reduces on the circle to G(c)=(2772/5)c³−18c, with c²≤1/79.2 and d entering only as d². G′=0 gives c²=5/462, inside the range, and c=−√2310/462 yields G=12√2310/462=2√2310/77=1.248376. Then (a+b)/2=√2310/385, d²=2/105 and d/2=√210/210, matching the stated a, b. The endpoints c²=1/79.2 (d=0) are the Weyl points at ±1.236033, so **this is the maximum on the traceless unit circle**, both signs of d giving the same value (a↔b).
- **Correction, Ricci normalisation.** Ric_p=5a+6c=(1/77−1/77)√2310−5√210/210=−√210/42. The figure ∓√210/42=∓0.345 is correct in the sum-of-sectional-curvatures normalisation (Ric(I)=(n−1)id). The record's tabled convention is ric(I)=(n−1)/2·id ([conventions.md](../findings/conventions.md) line 32), in which the value is ∓√210/84=∓0.173. The note should name its normalisation.
- **p=5,7.** Screen on the closed form: traceless maximum 1.244363, Weyl value 1.228239. Both figures confirmed.
- **Observation (screen).** 2√2310/77 squared is 9240/5929=120/77=Θ₁₃², so the witness's value is exactly Θ₁₃=P(S⁶×S⁷), already tabled in [INDEX-values.md](../findings/INDEX-values.md). The same coincidence holds at every balanced split screened: traceless maximum at (m,m) equals Θ_{2m+1} for m=3,4,5,6 (1.095445, 1.171080, 1.217161, 1.248376). Its cause is unexplained here and worth one line of analysis. The traceless maximum exceeds the Weyl value at every split screened, (3,3) to (8,8) and (4,8), so the obstruction holds beyond n=12 as a screen.

## 5. The conclusion

- **First half, CONFIRMED.** A unit traceless curvature operator with G=1.248376>θ₀(12) shows that the sharp inequality G≤θ₀(n)‖X‖³ fails on the traceless curvature operators at n=12, so any proof of P must use Ric=0 beyond tracelessness. This matches post F14 and sharpens it as stated.
- **Second half, REFUTED.** Q(W) is Weyl for every Weyl W (BW08 eq. (6), on the record). Therefore Ric(Q(W))≡0, ‖Q(W)_Ric‖=0, P(W)=⟨Q(W)_Weyl,W⟩ reads P(W)=⟨Q(W),W⟩, and the decomposition ‖Q(W)‖²=‖Q(W)_Weyl‖²+‖Q(W)_Ric‖² holds only as ‖Q(W)‖²=‖Q(W)‖²+0. The part "no scalar part, no Λ⁴ part" is right, and the Ricci part is absent as well. **A coupling reading Ric Q(W) reads zero.**
- **The object the note wants** is Ric(Q(X)) for X off the Weyl subspace, which by BW08 eq. (6) is Σ_k Ric(X)_kk X_kijk, linear in Ric(X). The record already holds an inequality of that shape: the Böhm–Wilking/Beitz cone criterion P(R)≤F(R)⟨ric(R),ric(Φ(R))⟩ ([problem.md](../findings/problem.md) line 102), whose a=0 slice produces θ₀(n). The "next candidate" is that criterion under another name, and it should be routed through it.

## 6. Prior record

| item in the note | on the record as |
|---|---|
| extension 1 | [problem.md](../findings/problem.md), the θ₀ derivation, "every cross term in the cubic vanishes" (and 28n batch 3, as cited) |
| full symmetry of T | BW08 eq. (5), [problem.md](../findings/problem.md) line 74 |
| Q(W) is Weyl | BW08 eq. (6), [problem.md](../findings/problem.md) line 53, [conventions.md](../findings/conventions.md) line 51 |
| 1.248376 | Θ₁₃, [INDEX-values.md](../findings/INDEX-values.md) line 17, [route-a.md](../findings/route-a.md), exactly equal to 2√2310/77 |
| a Ricci-reading inequality | the cone criterion, [problem.md](../findings/problem.md) line 102 |
| √2310, "scalar-flat", "traceless curvature" | no prior occurrence in findings/ as this object: the traceless witness is new |
| post F14 | [second-order.md](../findings/second-order.md) line 1202: the curvature subspace peaks at the round sphere, √(2(n−1)/n). Consistent with the note |
