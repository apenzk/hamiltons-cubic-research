# Gate 2 brief: the bracket-trace bridge, and the Gram reading of Ricci-flatness

You are an adversarial reviewer. **TWO reviewers on identical briefs**, because this is an argument being made rather than text compared against something fixed. *Your independence comes from your implementation, not from your instructions.*

**Work from the definitions below and from the mathematics alone.** Do not read [findings/diagonal-half.md](../findings/diagonal-half.md) or the other findings files. You may read the Lean files named in the table.

## The definitions, quoted so you can work from them alone

$\{\omega_\alpha\}_{\alpha=1}^{N}$, $N=\binom n2$, is an **orthonormal basis of $\Lambda^2\mathbb R^n$ by DECOMPOSABLE unit forms**, $\omega_\alpha=a_\alpha\wedge b_\alpha$ with $a_\alpha\perp b_\alpha$ unit. Write $P_\alpha=\mathrm{span}\{a_\alpha,b_\alpha\}$ for its plane and $\Pi_\alpha$ for the orthogonal projection of $\mathbb R^n$ onto $P_\alpha$. Set

$$S_{\alpha\beta}:=\operatorname{tr}(\Pi_\alpha\Pi_\beta),\qquad W:=\sum_\alpha\lambda_\alpha\,\omega_\alpha\otimes\omega_\alpha,\qquad M:=\sum_\alpha\lambda_\alpha\Pi_\alpha .$$

The inner product on $\Lambda^2$ is the one making $\{\varphi_{ab}=e_b\otimes e_a-e_a\otimes e_b\}_{a<b}$ orthonormal, and $\langle A,B\rangle=\operatorname{tr}(AB)$ on $\mathrm{Sym}^2\mathbb R^n$. Throughout $n\ge3$, and **the hypothesis is that the WHOLE basis is decomposable**.

**GIVEN, Gate 2 passed, not audited here.** [Lemma L201](../lean/HamiltonsCubic/Results/L201Statement.lean): if $\operatorname{tr}(\Pi_\alpha\Pi_\beta)\in\{0,1\}$ at every pair, then some orthonormal frame of $\mathbb R^n$ has the $P_\alpha$ as exactly its coordinate planes. **Also given and OUT OF SCOPE**: that $\operatorname{rank}S\ge n$ at every configuration, with equality exactly at the coordinate ones. *Do not re-audit either.*

## The claims to attack, one row per claim, with the Lean declaration

| # | claim | Lean |
|---|---|---|
| 1 | **THE BRIDGE**: $\lVert[\omega_\alpha,\omega_\beta]\rVert^2=\operatorname{tr}(\Pi_\alpha\Pi_\beta)$ at every pair of $\Lambda^2$-orthogonal decomposable unit forms | [trace_instA_instB](../lean/HamiltonsCubic/Results/L201Statement.lean) and [frobSq_commutator_inst](../lean/HamiltonsCubic/Results/L201Statement.lean) type it **at one concrete instance only**, $9/25$; **no declaration states the general identity** |
| 2 | the bracket $[\omega_\alpha,\omega_\beta]$ is itself DECOMPOSABLE, so integrality says every bracket is zero or a UNIT bivector | none: a claim about the rank of a bracket, which the layer does not express |
| 3 | hence [Lemma L31](../findings/stratum-two-negative.md)'s pair cap SHARPENS from $2$ to $1$ on the decomposable locus, with equality exactly when the two planes share a line | none: the cap is recorded as a bound on $\lVert[v_\alpha,v_\beta]\rVert^2$, and its restriction is the claim |
| 4 | $\sum_{\beta\ne\alpha}\operatorname{tr}(\Pi_\alpha\Pi_\beta)=2(n-2)$ at every $\alpha$ | [sum_trace_row](../lean/HamiltonsCubic/Results/L201Statement.lean) |
| 5 | $\sum_{\alpha\ne\beta}\operatorname{tr}(\Pi_\alpha\Pi_\beta)=n(n-1)(n-2)$, fixed across every configuration | [sum_trace_off](../lean/HamiltonsCubic/Results/L201Statement.lean) |
| 6 | **Ricci-flatness of $W$ is EXACTLY $S\lambda=0$** | none: no declaration relates Ricci-flatness to this Gram matrix |
| 7 | $S$ is positive semidefinite, of trace $n(n-1)$, with $\operatorname{rank}S=\dim\mathrm{span}\{\Pi_\alpha\}$, and the all-ones vector is an eigenvector at $2(n-1)$ | none, same reason |
| 8 | at a coordinate configuration $S=A(J(n,2))+2\,\mathrm{Id}$, with spectrum $2n-2,\ n-2,\ 0$ at multiplicities $1,\ n-1,\ \binom n2-n$, so $\lVert S\rVert_F^2=n^2(n-1)$ | none, same reason |
| 9 | relation (B) reads $(\hat S\lambda)_k=-2\lambda_k$ with $\hat S=S-2\,\mathrm{Id}$, which IS $(S\lambda)_k=0$ | none, same reason |
| 10 | **relation (C) summed gives $\lambda^{\mathsf T}S\lambda=0$, and $S\succeq0$ then forces $S\lambda=0$, so on this locus Ricci-flatness is a CONSEQUENCE of criticality's diagonal rather than a hypothesis beside it** | none, and **this is the row with the most to lose** |
| 11 | two of the three off-diagonal criticality families cannot force integrality, and only the third, the off-diagonal of $W^\#=\theta W-W^2$, can bite | none: a claim about which relations carry information |

## What to do

1. **Row 1 is the bridge everything else crosses, and it is typed only at a single instance.** Derive it in general. *The record's proof puts the two planes in principal position and claims three of the four terms of $[a\wedge b,c\wedge d]$ vanish.* **Check the principal-position normalisation is available at EVERY $\Lambda^2$-orthogonal pair**, including when the planes are equal, when they meet in a line, and when they are orthogonal, and say whether $\Lambda^2$-orthogonality really forces $\cos\vartheta_1\cos\vartheta_2=0$.
2. **Row 10 is the one this brief most doubts.** It upgrades Ricci-flatness from hypothesis to consequence, which is a strong claim. **Check what "relation (C) summed" actually needs**, whether $\operatorname{tr}W=0$ is enough, and whether $S\succeq0$ plus $\lambda^{\mathsf T}S\lambda=0$ really gives $S\lambda=0$ *for a possibly singular $S$*. Say precisely which hypotheses the upgrade consumes.
3. **Rows 6 and 7 carry a positivity argument in one line**: $M$ lies in $\mathrm{span}\{\Pi_\beta\}$ and a vector of that span orthogonal to all of it is zero. **Check that $M$ really lies in the span** and that the pairing is positive definite there.
4. **Row 8 is arithmetic and is checkable exactly.** Verify the Johnson-graph identification and recompute the three eigenvalues and the Frobenius norm. *A slip here would be invisible to every other row.*
5. **Row 3 claims a sharpening of a recorded cap.** Confirm the equality case, and say whether it needs both arguments to have rank $4$, which a decomposable form does not.
6. **Row 11 asks which families carry information.** Two are claimed inert, one basis-free by the Killing form and one holding at every Weyl tensor. **Check both**, and say whether "cannot force integrality" follows from "is satisfied by a non-integral example".
7. **State what each claim would look like if it were VACUOUS**, and check that it is not. *Row 6 in particular: if no orthonormal decomposable basis admits a nonzero Ricci-flat weighting, the row describes an empty set.*
8. Return **CONFIRMED**, **PLAUSIBLE** or **REFUTED** per claim, with corrections.

## Standing rules

**Analysis only.** A LONG or OPEN-ENDED run needs the user's approval for the specific task. **Permitted without asking**: screening a claim you are about to record, seconds of compute on objects you construct for that purpose, and any run finishing in a few minutes on objects already in hand. **The deliverable is a derivation, and a number is a screen.**

**A control is an assertion, never a printed expectation.**

**Report.** Write your own `reviews/REVIEW_rN.md` at the number you are given, skeleton committed in your FIRST phase with every verdict `NOT REACHED`. **Commit with an explicit PATHSPEC**, `git commit -m "<msg>" -- reviews/REVIEW_rN.md`. Never `git add -A`, never `git commit -a`, never amend. **Do not write to reviews/INDEX.md**, and do not read the other reviewer's report.

**Two traps in the commit gate.** [cycle_deliverable.py](../.claude/hooks/cycle_deliverable.py) reads the first physical line of the bash command for `refut\w+`, so a subject line containing "refutes" trips its opens-an-item tripwire while the parent has `plan.md` staged. Its `SEARCHED` regex anchors on `$` under `re.M`, so a trailer works only when the closing shell quote sits on the next line.

**Log** to the path you are given: PID and phase plan on the first line, a line per phase, a heartbeat carrying live state at least every 3 minutes, and a closing line OPENING with `DONE ` or `FAILED `.
