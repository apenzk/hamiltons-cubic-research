# REVIEW r1832: L220 step 4 in FourStep4.lean

*Gate 2 on [FourStep4.lean](../lean/HamiltonsCubic/Results/FourStep4.lean) at commit 8e4343d1 and that commit's two L220 rows in [lean/INDEX.md](../lean/INDEX.md). The Lean is a faithful, slightly stronger formalisation of the record's step 4, and it compiles on the standard three axioms. The statement row of the INDEX still lists $L_r\nu=0$ as owed after the commit proved it.*

| # | Claim | Verdict |
|---|---|---|
| 1 | `inner_fox_move` is correctly derived from `foxTri2_comm` and `foxTri2_symm_right`, with the right hypotheses (question c) | CONFIRMED |
| 2 | `mixed_sq`: $\nu\circ\nu'\in\Pi_Q$ for $\nu,\nu'\in V_Q$ by polarisation | CONFIRMED |
| 3 | `Lr_zero`'s hypothesis is the record's $r\in\mathcal D_n\ominus\Pi_Q$ (question a) | CONFIRMED WITH OBSERVATIONS |
| 4 | Pairing against the single $\nu'=L_r\nu$ with definiteness is equivalent to the record's pairing against all of $V_Q$ (question b) | CONFIRMED |
| 5 | `Lq_eigen`'s hypothesis is what step 3 gives, `L220_split`'s second conjunct (question d) | CONFIRMED WITH OBSERVATIONS |
| 6 | `PiQ_lin`, `PiQ_closed`, `Dnu_mem` state what their docstrings say | CONFIRMED WITH OBSERVATIONS |
| 7 | INDEX statement row: the step-2 pointer (r1831 O3) and the owed list (question e) | REFUTED AS STATED |
| 8 | INDEX result row: the step-4 sentence, the r1829, r1830, r1831 citations and the owed list (question e) | CONFIRMED WITH OBSERVATIONS |
| 9 | Axiom audit of FourStep4.lean | CONFIRMED |

**Summary: the mathematics is sound and faithful, and the one defect is bookkeeping, an owed item in the statement row that this very commit discharged.**

## 1. Runs

- `lake env lean HamiltonsCubic/Results/FourStep4.lean` from lean/: exit 0, no errors, one linter warning, "Variable name `hs'` is not explicitly referenced" at line 37 (`PiQ_closed`, see O4).
- `python3 scripts/misc/axiom_audit.py --only FourStep4.lean`: "auditing 7 declarations across 1 files", "7/7 clean -- resting on the standard three alone".

## 2. The record, quoted

Setting: "Write $D=q+r$ with $q\in\Pi_Q$, $r\in\mathcal D_n\ominus\Pi_Q$", and "$\Pi_Q\subset\mathcal D_n$ is the plane of sectional matrices supported on $Q$, $K_{ij}=K_{kl}=x$, $K_{ik}=K_{jl}=y$, $K_{il}=K_{jk}=z$ with $x+y+z=0$".

Step 4: "**$L_r\nu=0$.** $L_r\nu\in V_Q$, and $\langle L_r\nu,\nu'\rangle=\langle r,\nu\circ\nu'\rangle=0$ for $\nu'\in V_Q$, as $\nu\circ\nu'\in\Pi_Q\perp r$. So $L_q\nu=\tfrac\theta2\nu$."

## 3. `inner_fox_move` (claim 1, question c)

`foxTri2 X Y Z` is by definition `innerOp2 (foxProd2 X Y) Z`, so the goal is `foxTri2 a b c = innerOp2 a (foxProd2 b c)`. The proof's chain is:

- `foxTri2 a b c = foxTri2 a c b` by `foxTri2_symm_right a b c hb hc` (needs $b$, $c$ self-adjoint).
- `= foxTri2 c a b` by `foxTri2_comm` (no hypothesis).
- `= foxTri2 c b a` by `foxTri2_symm_right c a b ha hb` (needs $a$, $b$ self-adjoint).
- `= foxTri2 b c a` by `foxTri2_comm`.

Unfolding gives $\langle a\circ b,c\rangle=\langle b\circ c,a\rangle$, and `innerOp2_comm` closes it. Each of the three self-adjointness hypotheses is consumed by one of the two `foxTri2_symm_right` calls, so none is idle along this route. In `Lr_zero` the three are supplied by `IsWeyl2.isSelfAdjoint2` at $r$, $\nu$ and $r\circ\nu$, the last Weyl by `isWeyl2_foxProd2`. CONFIRMED.

## 4. `mixed_sq` (claim 2)

`L219Prod.Qop2_add` is $Q(\nu+\nu')=Q(\nu)+Q(\nu')+2\,\nu\circ\nu'$, so $\nu\circ\nu'=\tfrac12\big(Q(\nu+\nu')-Q(\nu)-Q(\nu')\big)$. `nu_sq` applies to $\nu+\nu'$ (Weyl by `isWeyl2_add`, character $\chi_Q$ by `signChar_add`), $\nu$ and $\nu'$, each giving a `coordOp (PiQ …)` whose three values $2a^2-b^2-c^2$ and cyclic sum to zero identically. The witness is half the difference of the three value triples, and its sum is zero by `ring`. The operator identity is closed by `coordOp_sub`, `coordOp_smul'` and an entrywise `ring` on `PiQ`. The hypotheses $a+b+c=0$ from `nu_sq` are discarded (the `-` patterns), correctly, since the sum-zero of the witness is an identity. CONFIRMED.

## 5. `Lr_zero`'s hypothesis (claim 3, question a)

The Lean hypotheses on $r$ are `IsWeyl2 r`, `SignChar (fun _ => 1) r`, and `hperp`: `innerOp2 r (coordOp (PiQ i j k l x y z)) = 0` for every $x+y+z=0$.

- **Orthogonality matches exactly.** The record's $\Pi_Q$ is the set of `PiQ` with $x+y+z=0$ ("with $x+y+z=0$" is in the Setting's definition), and `hperp` quantifies over exactly that set.
- **Weyl of character 1 contains $\mathcal D_n$.** A weight operator is Weyl, and it acts on $\varphi_{ab}$ by the scalar $K_{ab}$, so it commutes with every sign conjugation and has character $1$. The record's $r\in\mathcal D_n$ therefore satisfies the Lean's two hypotheses. That the two sets coincide is step 1's identification ($D=$ `comp ∅`, `weyl_fixed_iff`), and the proof needs only the inclusion.
- **What the proof consumes.** Self-adjointness of $r$, the Weyl property of $r\circ\nu$, and its character $\chi_Q$ via `Dnu_char` (character $1$ times $\chi_Q$). All three follow from Weyl plus character $1$.

So `Lr_zero` covers the record's $r$ and possibly more, a harmless generalisation (O1). CONFIRMED WITH OBSERVATIONS.

## 6. The single-element pairing (claim 4, question b)

The record argues $L_r\nu\in V_Q$ and $\langle L_r\nu,\nu'\rangle=0$ for all $\nu'\in V_Q$, from which $L_r\nu=0$ follows by taking $\nu'=L_r\nu$. The Lean takes that instance directly: $w=r\circ\nu$ lies in $V_Q$ (`hwW`, `hwc`), `mixed_sq` at $(\nu,w)$ puts $\nu\circ w$ in $\Pi_Q$, and

$$\lVert w\rVert^2=\langle r\circ\nu,w\rangle=\langle r,\nu\circ w\rangle=0$$

by `inner_fox_move` and `hperp`. `normSq2_eq_zero` then gives $w=0$. The two forms are equivalent: the Lean's is the record's at one $\nu'$, and conversely $w=0$ makes every pairing vanish. The definiteness used is on `CurvOp2` with `innerOp2`, the domain where [Bivectors2.lean](../lean/HamiltonsCubic/Base/Bivectors2.lean) proves it (its docstring notes the older domain lacks it), so the step is sound. CONFIRMED.

## 7. `Lq_eigen` against `L220_split` (claim 5, question d)

`L220_split` in [BlockSub.lean](../lean/HamiltonsCubic/Results/BlockSub.lean) concludes `foxProd2 D D + foxProd2 ν ν = θ • D ∧ (2 : ℝ) • foxProd2 D ν = θ • ν`. `Lq_eigen`'s `hD` is `(2 : ℝ) • foxProd2 (q + r) ν = θ • ν`, the second conjunct verbatim at $D=q+r$. The record's $L_D\nu=\tfrac\theta2\nu$ reads $L_D=D\circ\cdot$ from step 3's "$Q(W)=D\circ D+2D\circ\nu+\nu\circ\nu$", which matches `foxProd2`. The proof expands by `foxProd2_add_left`, kills $r\circ\nu$ by `Lr_zero`, and strips `+ 0`.

`Lq_eigen` carries no hypothesis on $q$ at all, while its docstring, the module header and both INDEX sentences say "$q\in\Pi_Q$" (O2). The theorem is therefore stronger than stated. CONFIRMED WITH OBSERVATIONS.

## 8. The helpers (claim 6)

- `PiQ_lin`: entrywise linearity of `PiQ`, closed by `ring`. Correct.
- `Dnu_mem`: the pair `isWeyl2_foxProd2`, `Dnu_char`. Correct, and it is the record's "$D\circ\nu\in V_Q$ by L120" as an operator statement.
- `PiQ_closed`: a scalar identity, that the three values of FourPi's `PiQ_mul` product sum to $(x+y+z)(x'+y'+z')=0$. The operator closure is `PiQ_mul` plus this identity, and the name overstates a lemma that mentions no operator (O3). The hypothesis `hs'` is unused, since one vanishing factor suffices, and this is the build's one linter warning (O4).

CONFIRMED WITH OBSERVATIONS.

## 9. The INDEX rows (claims 7 and 8, question e)

**Statement row (line 151 at 8e4343d1).** The owed list reads, verbatim: "step 2's products (now proved on the operators in the [L220] result row below, r1831 O3); $L_r\nu=0$; the norm split `hunit`; …".

- The step-2 pointer is accurate: FourIdent, FourProd and FourPi prove step 2's three products, as the result row records.
- **The item "$L_r\nu=0$" is stale.** The commit proves it (`Lr_zero`) and removed it from the result row's owed list, but left it in the statement row, where it survives at HEAD (bab7acfa). A reader of the statement row is told step 4 is owed (O5). REFUTED AS STATED.

**Result row (line 152).**

- The step-4 sentence matches the file declaration for declaration, and "standard three axioms" matches the audit.
- The citations are right in scope: r1829, r1830 and r1831 are cited as "Gate 2 on FourIdent, FourProd and FourPi", which they are. None of them reviewed FourStep4, and the row does not claim they did. It records no Gate 2 for FourStep4 either, pending or otherwise (O6).
- The owed list has no step 2 or step 4 item and is otherwise the statement row's list. Accurate.
- The row closes with "The full account, with its Gate 2 history, is in the L220 (statement) row above", while the statement row's step-2 item points back down to this row. For steps 2 and 4 the full account lives here, so the pointer is circular for them (O7).

CONFIRMED WITH OBSERVATIONS.

## 10. Hand evaluation (exact, by hand, a screen)

**Hand evaluation.** $n=5$, $Q=\{0,1,2,3\}$, $(i,j,k,l)=(0,1,2,3)$, and $r=$ `coordOp` $w$ with $w_{04}=w_{14}=1$, $w_{24}=w_{34}=-1$, zero elsewhere.

- **$r\perp\Pi_Q$.** A `coordOp` acts diagonally on the $\varphi_{ab}$, so `innerOp2` of two of them is a positive multiple of $\sum_{a<b}w_{ab}K_{ab}$. Every pair carrying $w$ contains the index $4$, and every pair carrying `PiQ` lies inside $Q$. The supports are disjoint, so the pairing is $0$ for every $(x,y,z)$, sum-zero or not.
- **$r\circ\sigma_A$ on $\varphi_{02}$.** $\sigma_A=S_{02}XS_{13}+S_{13}XS_{02}$. Then $\varphi_{02}S_{13}=(e_0e_2^{\mathsf T}-e_2e_0^{\mathsf T})(e_1e_3^{\mathsf T}+e_3e_1^{\mathsf T})=0$ and $S_{13}\varphi_{02}=0$, so $\sigma_A\varphi_{02}=0$, and $r\varphi_{02}=w_{02}\varphi_{02}=0$. The Jordan half $\tfrac12(r\sigma_A+\sigma_Ar)\varphi_{02}$ is therefore $0$. The $\#$ half at $\varphi_{02}$ pairs an entry $r_{\gamma\gamma}$ with a row of $\sigma_A$ at $\delta$, where $[\gamma,\delta]\propto\varphi_{02}$, so $\{\gamma,\delta\}=\{\varphi_{0m},\varphi_{m2}\}$ with $m\in\{1,3,4\}$. $r_{\gamma\gamma}\neq0$ forces $m=4$, and then $\delta\in\{\varphi_{42},\varphi_{04}\}$ is a pair leaving $Q$, on which $\sigma_A$ vanishes. So $(r\circ\sigma_A)\varphi_{02}=0$.

**What this shows.** Both checks come out as the lemma predicts, but the specimen lies outside `Lr_zero`'s hypothesis. Its row sums at $0,1,2,3$ are $\pm1$, so $w$ is not a weight (`IsWeight` asks for zero row sums), $r$ is not Weyl, and $r\notin\mathcal D_n$. The vanishing here comes from disjoint support alone and exercises none of the proof. An element of $\mathcal D_5\ominus\Pi_Q$ must couple the $Q$-internal entries to column $4$. One such element, checked by hand: $w_{01}=w_{03}=1$, $w_{12}=w_{23}=-1$, $w_{24}=2$, $w_{04}=-2$, others $0$. Every row sums to $0$, and $p+p'=w_{01}+w_{23}=0$, $a'+b'=w_{02}+w_{13}=0$, $c'+d'=w_{03}+w_{12}=0$, which is step 8's orthogonality "$p+p'=a'+b'=c'+d'$" (O8). This review evaluated $r\circ\sigma_A$ only at the brief's specimen, since the $\#$ half at the proper specimen depends on the structure-constant normalisation and a hand value there would be a screen of a convention rather than of the lemma.

## 11. Observations

- **O1.** `Lr_zero` asks for $r$ Weyl of character $1$, which contains $\mathcal D_n$ (equal to it by step 1's identification). A generalisation of the record's hypothesis, which suffices for every use.
- **O2.** `Lq_eigen` has no hypothesis $q\in\Pi_Q$, though its docstring, the module header and both INDEX sentences mention one. The theorem is stronger than described. Either drop "$q\in\Pi_Q$" from the prose or say that the conclusion holds for any $q$.
- **O3.** `PiQ_closed` is a scalar identity on the value triples. Operator closure of $\Pi_Q$ is `PiQ_mul` together with it, and the docstring could say so.
- **O4.** `PiQ_closed`'s `hs'` is unused and produces the build's one linter warning. The commit message's "Module build clean" is true of errors only. Drop `hs'` or rename it `_hs'`.
- **O5.** The INDEX statement row still owes "$L_r\nu=0$" at 8e4343d1 and at HEAD. The record's L220 status paragraph in [second-order.md](../findings/second-order.md) likewise still reads "The Lean owes $L_r\nu=0$" and calls r1831 "pending". Both need the downstream repair.
- **O6.** The result row records no Gate 2 for FourStep4.lean. This review is it, and the row should cite r1832.
- **O7.** The result row's pointer "The full account … is in the L220 (statement) row above" is circular for steps 2 and 4, whose account lives in the result row. Scope the pointer to steps 1 and 3.
- **O8.** The brief's hand-evaluation specimen is outside $\mathcal D_n$. §10 gives a proper element of $\mathcal D_5\ominus\Pi_Q$ for any later check.

## 12. What would falsify each headline

- **Claims 1, 2, 4, 5 and 9 (the Lean proves step 4).** A compile error or a non-standard axiom in the audit, or a definition of `foxTri2`, `innerOp2` or `normSq2` different from the one read here (`innerOp2 (foxProd2 X Y) Z`, $\tfrac12\sum\sum$ inner2 of the $\varphi$ images, `innerOp2 R R`).
- **Claim 3 (fidelity of the hypothesis).** A record element of $\mathcal D_n\ominus\Pi_Q$ that fails to be Weyl or fails character $1$, or a record $\Pi_Q$ element outside `PiQ` with $x+y+z=0$. The Setting's definition rules out the second, and weight operators being Weyl and sign-invariant rules out the first.
- **Claim 5.** `L220_split`'s second conjunct differing from `hD` at $D=q+r$. It is verbatim.
- **Claim 7 (REFUTED AS STATED).** A statement row at 8e4343d1 without the item "$L_r\nu=0$". Line 151 contains it.
- **Claim 8.** A citation in the result row attributing FourStep4 to r1829, r1830 or r1831. There is none.
