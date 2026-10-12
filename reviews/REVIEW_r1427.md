# REVIEW r1427: L161's kappa identity and L155's J5 corollary in Lean, `kappa_identity`, `kappa_split_free`, `kappa_13`, `J5_zero_of_graded`

Log [agent_logs/r1427.log](../agent_logs/r1427.log). One reviewer, statement fidelity only (the kernel has checked the proofs). Analysis-only: one scratch file elaborated for `#print axioms`, `#check` and three `#eval` screens on objects constructed for the purpose, finishing in seconds against current oleans. Record: [findings/curvature-invariants.md](../findings/curvature-invariants.md), Lemmas L13 and L161, [findings/bounds.md](../findings/bounds.md), Lemma L155, and [ATTEMPTS.md](../ATTEMPTS.md) Result 5(b) (line 900, cited verbatim at line 3858). Lean: commit 18a3a2c9, [L161.lean](../lean/HamiltonsCubic/Results/L161.lean) against [L27.lean](../lean/HamiltonsCubic/Results/L27.lean) and [L26Statement.lean](../lean/HamiltonsCubic/Results/L26Statement.lean), and `J5_zero_of_graded` in [EigenFrameExist.lean](../lean/HamiltonsCubic/Results/EigenFrameExist.lean), with the L161 and L155 rows of [lean/INDEX.md](../lean/INDEX.md). Predecessor [r1425](REVIEW_r1425.md) named the $J_5$ corollary as L155's only gap.

**Standfirst.** `trLe2` is the record's $\operatorname{tr}(L_e^2)$ term for term, `thetaSq` is the record's $\theta^2$ at $S^p\times S^q$, and `kappa_identity` is the record's rational-function identity, proved over $\mathbb Q$ with only the denominators assumed nonzero, which is a generalisation of the record's $p,q\ge3$. `J5_zero_of_graded` reads $J_5=\langle X_{\mathrm{inv}},H\rangle$ faithfully as the frame sum, since the frame is orthonormal and complete and $H$ is quantified over every matrix, and L155 can fairly be marked proved. Standard three axioms throughout. The gaps are in prose: the L161 row's Owed list omits $\theta^2(W_{p,q})$ as an input and says `kappa_split_free` licenses what Fox licenses, the `kappa_13` docstring calls $n=13$ open when the record had it audited, and L155's clause "proper in $\mathfrak{so}(n)$ whenever $\mathfrak k\ne0$" is neither typed nor named.

| Item | Verdict | Reason |
| --- | --- | --- |
| 1a. `trLe2` against the record's display | CONFIRMED | `1 + p*q/4 + dimS p * lam p^2 + dimS q * lam q^2 + (dimS p * dimS q + dimL p * dimL q) * mu^2` is $1+\tfrac{pq}4+d_p\lambda_p^2+d_q\lambda_q^2+(d_pd_q+e_pe_q)\mu^2$ with `dimS` $=d_m=\tfrac{m(m+1)}2-1$, `dimL` $=e_m=\tfrac{m(m-1)}2$ and `lam` $=\lambda_m=\tfrac{m-2}{2(m-1)}$. |
| 1b. $\mu$ and the $\pm\mu$ summands | CONFIRMED | `L26Statement.mu` is $\tfrac{p+q-2}{2(p-1)(q-1)}=\tfrac{n-2}{2(p-1)(q-1)}$. The coefficient $d_pd_q$ is $\dim S^2_0\otimes S^2_0$ carrying $-\mu$ and $e_pe_q$ is $\dim\Lambda^2\otimes\Lambda^2$ carrying $+\mu$, both squaring to $\mu^2$. |
| 1c. The $pq/4$ term | CONFIRMED | $(\tfrac12)^2$ times $\dim\mathbb R^p\otimes\mathbb R^q=pq$. |
| 1d. The four zero summands | CONFIRMED | L27's `tenSum` lists $\mathcal W_p$, $\mathcal W_q$, $X_p\otimes\mathbb R^q$, $X_q\otimes\mathbb R^p$ beside the six above, and `dim_sum` makes the ten exhaust $\mathcal W_{p+q}$, so nothing nonzero is dropped. |
| 2. `thetaSq` | CONFIRMED | $\tfrac{2(p+q-1)(p-1)(q-1)}{(p+q-2)pq}$ is the record's $\tfrac{2(n-1)(p-1)(q-1)}{(n-2)pq}$, and the same formula as [SphereProducts.lean](../lean/HamiltonsCubic/Results/SphereProducts.lean)'s `thetaSq`, [L43.lean](../lean/HamiltonsCubic/Results/L43.lean) and [L5Statement.lean](../lean/HamiltonsCubic/Results/L5Statement.lean). |
| 3. `kappa_identity` | CONFIRMED (GENERALISATION) | $\theta^2\operatorname{tr}(L_e^2)=\tfrac{(p+q-1)(2(p+q)-1)}4$ identically over $\mathbb Q$, the record's identity, under $p,q,p-1,q-1,p+q-2\ne0$ only, where the record takes $p,q\ge3$. |
| 4. `kappa_split_free` | CONFIRMED | Two splits with $p+q=p'+q'$ give one value, immediate from item 3. |
| 4b. The row's reading of `kappa_split_free` | CONFIRMED WITH GAP | The row says it "is what licenses the unbalanced split at odd $n$". The record's licence is Fox's $W$-independence. Split-freeness is the consistency that licence predicts, as the file's docstring says more carefully. |
| 5. `kappa_13` | CONFIRMED WITH GAP | $\kappa_{13}=\tfrac{12\cdot25}4=75$ is right. The docstring calls $n=13$ "the first odd $n$ the record had open above $11$", while L161's record has an audited extension to $n=4\ldots13$ and odd $n\ge15$ open. |
| 6. Consistency with L13 | CONFIRMED | L13's $\kappa_n$ is the same formula. Screen, not evidence: `thetaSq 6 6 = 55/36` ($\theta=1.23603$, L13's $\theta_0(12)$) and `trLe2 6 6 = 207/5` give $\tfrac{253}4=\kappa_{12}$, and $(3,3)$ gives $\tfrac{55}4=\kappa_6$. |
| 7. The L161 row's Owed list | CONFIRMED WITH GAP | Fox's Theorem 1.3 and L27's spectrum are the right two. The value $\theta(W_{p,q})^2$ is a third record input, a formula in every Lean file that carries it, and is not named. The phrase "representation theory and out" is garbled. |
| 8. `J5_zero_of_graded` as $\sum_{\gamma\delta}X_{\gamma\delta}H_{\gamma\delta}$ | CONFIRMED | Result 5(b) pairs operators on $\Lambda^2$. On an orthonormal complete frame, which `eigenFrame_exists` supplies, $\langle X,H\rangle=\sum_{\gamma,\delta}\langle Xv_\gamma,v_\delta\rangle\langle Hv_\gamma,v_\delta\rangle$. `XinvRec` is the first factor (r1424 item 3b), and $H$ ranges over every function on `Pairs n`, so it covers $\mathrm{Ric}^*(\mathrm{Ric}\lvert W\rvert)$ at every $h$. `inner2`'s factor $\tfrac12$ scales the pairing and leaves "$=0$" unchanged. |
| 9. L155 marked proved | CONFIRMED WITH GAP | The biconditional (r1425) and now the $J_5$ corollary are typed, $W\ne0$ unneeded. The clause "proper in $\mathfrak{so}(n)$ whenever $\mathfrak k\ne0$" is untyped and unnamed, although it is dimension bookkeeping from $\mathfrak{so}(n)=\mathfrak p\oplus\mathfrak m\oplus\mathfrak k$. |
| 10. Axioms | CONFIRMED | `kappa_identity`, `kappa_split_free`, `kappa_13` and `J5_zero_of_graded` each depend on `propext`, `Classical.choice`, `Quot.sound` only. |

**One-line summary: CONFIRMED WITH GAP.** The four theorems are the record's statements on the standard three axioms, and the gaps are the L161 row's Owed list and licence wording, the `kappa_13` docstring, and L155's untyped properness clause.

## 1. L161's trace formula

The record's spectrum of $L_e$ at $W_{p,q}$ is $1$ on $\langle W\rangle$, $\tfrac12$ on $\mathbb R^p\otimes\mathbb R^q$, $\lambda_m$ on $S^2_0(\mathbb R^m)$, $-\mu$ on $S^2_0\otimes S^2_0$, $+\mu$ on $\Lambda^2\otimes\Lambda^2$, and $0$ on the remaining four. Squaring and weighting by multiplicity gives the display, and `trLe2` is that display with L27's `dimS`, `dimL`, `lam` and L26's `mu`. `lam` resolves to L27's through `open HamiltonsCubic.L27`, and L26Statement's `lam` is the same expression, so the choice changes nothing. L27's `mu_eq_L26` ties L27's own $\mu$ to L26's, so the file uses one $\mu$.

## 2. The identity

`kappa_identity` unfolds every definition and closes by `field_simp` then `ring`, so it is a polynomial identity after clearing $2(p-1)(q-1)$, $2(m-1)$, $(p+q-2)pq$. Its hypotheses are exactly those denominators, so it holds on every rational split where the formula is defined. The record needs $p,q\ge3$ for L27's decomposition, and that restriction belongs to the owed spectrum rather than to the algebra.

## 3. What the row owes

The chain is Fox (the constant is $W$-independent), then $\kappa_n=\theta^2\operatorname{tr}(L_e^2)$ at $e=W/\theta$, then L27's spectrum, then this identity. The row names Fox and L27. It omits $\theta^2=P(W_{p,q})^2$, which enters as the eigenvalue $1$ on $\langle W\rangle$ after rescaling and as the prefactor. Lean carries it as a definition in four files and derives it from the tensor in none that this review found. `kappa_split_free` checks the prediction Fox makes and is the second thing to cite, after Fox.

## 4. The kappa_13 docstring

L161's record has "an audited extension to $n=4\ldots13$" and states that "odd $n\ge15$ was open". So $13$ was audited and $15$ is the first odd dimension the lemma newly reaches. The value $75$ is correct.

## 5. J5 on the graded class

Result 5(b) defines $J_5$ as $\langle X_{\mathrm{inv}},H\rangle$ with $H=\mathrm{Ric}^*(\mathrm{Ric}(\lvert W\rvert))$, a Frobenius pairing on operators on $\Lambda^2$, and $J_5^{\mathrm{diag}}=\sum_b\langle P_bX_{\mathrm{inv}}P_b,P_bHP_b\rangle$ in the same line confirms the pairing. Expanding in the orthonormal complete `frameVec` gives the double sum. The theorem takes `L155_exists.mpr` and rewrites every `XinvRec` entry to $0$, so it states $X_{\mathrm{inv}}=0$ paired with an arbitrary matrix. $J_5$ and $\mathrm{Ric}$ are untyped. The identification $J_5=\langle X_{\mathrm{inv}},H\rangle$ is the record's own definition, and since the conclusion holds for every $H$ nothing about $h$ is used, which is the record's "with no hypothesis on $h$".

## 6. L155's status

With the characterisation and the corollary typed, the one clause left is "proper in $\mathfrak{so}(n)$ whenever $\mathfrak k\ne0$", which follows from the orthogonal decomposition $\mathfrak{so}(n)=\mathfrak p\oplus\mathfrak m\oplus\mathfrak k$. By the standard r1425 applied to the $J_5$ line, the row should name it as owed or type it. Marking L155 **proved** is fair on the mathematics once that clause is named.
