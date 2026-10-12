# Verifier v235, Lemma L43: the collapse of the a=0 invariance criterion on the Einstein slice, the boundary constant c(n-1)=θ₀(n), the imported facts from Böhm–Wilking and Beitz, and the Lean statement file

The brief ([BRIEF_L43.md](BRIEF_L43.md)) was read cold. No numerical work was done, every value is exact, no scripts were written, and no Lean build was run. Log: [agent_logs/verify-L43-v235.log](../agent_logs/verify-L43-v235.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | The collapse: Φ(cI+W)=c²(n-1)I+Φ(W), every cross term vanishes, ‖ric I‖² cancels, and G(cI+W)≤0 ⟺ ⟨W,Q(W)⟩≤c(n-1)‖W‖² | CONFIRMED |
| 2 | Passage A: "an identity on the whole slice", and the display ⟨W,Q(W)⟩≤θ₀(n)‖W‖³ as the criterion at a=0 | CONFIRMED |
| 3 | Passages B and C: "the whole condition collapses to ⟨W,Q(W)⟩≤c(n-1)‖W‖², where c(n-1)=θ₀(n)" | REFUTED AS STATED |
| 4 | ∂Ω₀ meets the slice at one ratio c/‖W‖, the root is selected by tr R>0, and c(n-1)=θ₀(n)‖W‖ there | CONFIRMED |
| 5 | Imports from BW08: Lemma 2.1 (W#I=-W, Φ(I,W)=0), eq. (6), Φ preserves Weyl, Hamilton's scal identity | CONFIRMED |
| 6 | Beitz p. 96: Ω₀={((n-2)/n)‖R_W‖²≤‖R_I‖² and tr R>0} | CONFIRMED |
| 7a | Passage D: Beitz Lemma 2.3.4 "supplies only the converse" of invariance ⟹ G≤0 | REFUTED |
| 7b | Passage E: invariance of Ω₀ ⟹ G≤0 on ∂Ω₀ is "the first clause of Lemma 2.3.4, whose hypotheses check" | GAP |
| 8 | Title: "demands θ₀(n) and nothing weaker" | CONFIRMED |
| 9 | The scal(R)>0 clause: F is even, the c<0 nappe reads ⟨W,Q(W)⟩≤-θ₀(n)‖W‖³ | CONFIRMED |
| 10 | Lean: the five theorems of L43Statement.lean type what their docstrings say | CONFIRMED AS ALGEBRA |
| 11 | Lean: the module doc's account of what is NOT typed ("RealLayer has ... no Φ") | REFUTED AS STATED |
| 12 | Edges: n=3, n=4, odd n, the crossover 6+2√7, c≤0, W=0, ker W≠0 | CONFIRMED |
| 13 | The sentence "Three verifiers, [ROUND_L43-arg](...ROUND_L00r2.md), so the bound demanded is" and its link | REFUTED AS STATED |

**What the round should do:** keep L43 as proven, add "on ∂Ω₀ at ‖W‖=1" (or write c(n-1)=θ₀(n)‖W‖) to Passages B and C, replace Passage D's "supplies only the converse" with the level-by-level reading of Lemma 2.3.4's first clause and cite its proof for that reading, correct the Lean module doc's "no Φ", and repair the "Three verifiers" sentence and its link.

## 0. Conventions, fixed once

- Beitz's conventions throughout, since the cone and F are hers: ⟨R,S⟩=tr(R∘S) on Λ² (Remark 1.1.7), so ‖I‖²=N=n(n-1)/2. Her ric carries a factor 1/2 against BW08 (Definition 1.1.10), and scal(R)=tr R (Remark 1.1.11).
- With that ric: ric(I)=((n-1)/2)·id, ‖ric I‖²=n(n-1)²/4, F(I)=2/(n-1), in agreement with Beitz p. 98.
- F(R)=‖R‖²/‖ric R‖² on scal⁺={scal>0} (Beitz (6.24)). Ω_a=F⁻¹((-∞,4/(n-2+4a)]) inside scal⁺ (Beitz p. 97).
- Φ(R)=R²+R#, Φ(A,B)=½(AB+BA)+A#B its polarisation, so Φ(A+B)=Φ(A)+2Φ(A,B)+Φ(B). Q(W)=W²+W#, so ⟨W,Q(W)⟩=⟨W,Φ(W)⟩.
- G(R)=dF_R(Φ(R)). By Beitz (6.25), G(R)=(2/‖ric R‖²)(⟨R,Φ(R)⟩-F(R)⟨ric R, ric Φ(R)⟩). The prefactor is positive on scal⁺, so "the invariance criterion" at R is the inequality ⟨R,Φ(R)⟩≤F(R)⟨ric R, ric Φ(R)⟩.
- On the slice R=cI+W with W Weyl and w=‖W‖. R∈scal⁺ ⟺ cN>0 ⟺ c>0.
- Every "false" below is exhibited in closed form. Every value is exact.

## Hypothesis inventory

| Source | Hypotheses at source | Checked against the object | Used by L43 |
|---|---|---|---|
| BW08 Lemma 2.1 (arXiv text, §2) | R∈S²_B(so(n)). Conclusion R+R#I=(n-1)R_I+((n-2)/2)R_Ric₀, and ⟨W⟩ lies in the kernel (proved at n=4 and carried to n≥5 by the natural embedding of Weyl operators) | W is Weyl, hence in S²_B. I is in S²_B. Beitz herself imports this lemma in her convention (proof of Lemma 6.3.16: "I²+I#=(n-1)I (see [BW08, Lemma 2.1])"), which pins her # to BW's | Yes: Φ(I)=(n-1)I and Φ(I,W)=W+W#I=0 |
| BW08 eq. (6) | e_i an orthonormal eigenbasis of Ric, R∈S²_B. Ric(R²+R#)_ij=Σ_k Ric_kk R_kijk | At R=W, Ric=0, so every basis is an eigenbasis and the right side is 0 whatever the sign convention (the filed notes flag a sign flip against the record, irrelevant at 0) | Yes: ric(Φ(W))=0, hence tr Φ(W)=0 |
| Hamilton's scalar identity (Beitz Example 2.3.5, citing [Ham86]) | R∈A_n. scal(R²+R#)=2‖ric R‖² (her normalisation) | At R=W: scal(Φ(W))=0 | Named in Passage A as an input. Either this or eq. (6) gives ⟨I,Φ(W)⟩=0 |
| Φ preserves the first Bianchi identity | Presupposed by both sources: BW08 state the maximum principle for the ODE on S²_B, Beitz states Lemma 1.4.2 ([Ham86]) and runs ODE (2.4) on A_n in Example 2.3.5 and Lemma 6.3.16 | Needed so that Φ:A_n→A_n and V=A_n in Lemma 2.3.4. The collapse algebra itself needs only ric(Φ(W))=0 and tr Φ(W)=0 | Yes, through Lemma 2.3.4. Named in Passage D as "standard Hamilton fact" |
| Beitz p. 96 (Remark 6.3.10) | n≥3, a∈[0,n/4]. The equivalence with (4a-n)/4‖R_I‖²+a‖R_ric₀‖²+((n-2)/4+a)‖R_W‖²≤0, and Ω₀={((n-2)/n)‖R_W‖²≤‖R_I‖² and tr(R)>0} | Quoted faithfully, the tr(R)>0 clause included | Yes: the boundary equation |
| Beitz Lemma 2.3.4 | V a vector space, Φ:V→V locally Lipschitz, C⊆V open, F:C→ℝ smooth. First clause: if the sublevel sets of F are invariant under (2.2), then dF_v(Φ(v))≤0 for all v∈C. Second clause: the converse, with C additionally invariant | V=A_n, Φ polynomial, C=scal⁺ open, F smooth on scal⁺: all check. The first clause's antecedent quantifies over all sublevel sets. The application has one (§7b) | Yes, for "demands" (necessity). Not used by the collapse algebra |
| ‖I‖²=N | Beitz Remark 1.1.7 | Checked at §0 | Yes |
| BW08 eq. (5), symmetry of tri | Stated with Huisken's argument | Used nowhere in the collapse, as Passage C says | No |

**Used but unstated:** the level-by-level form of Lemma 2.3.4's first clause (§7b). No other.

## 1. The collapse (attack item 1)

Derivation, each line from the one above and §0.

- Φ(I)=I²+I#I=I+(n-2)I=(n-1)I by Lemma 2.1 at R=I.
- Φ(I,W)=½(IW+WI)+I#W=W+W#I=0 by the kernel statement of Lemma 2.1.
- Φ(cI+W)=c²Φ(I)+2cΦ(I,W)+Φ(W)=c²(n-1)I+Φ(W). **Matches Passages C and D.**
- ⟨R,Φ(R)⟩=c³(n-1)⟨I,I⟩+c²(n-1)⟨W,I⟩+c⟨I,Φ(W)⟩+⟨W,Φ(W)⟩. Here ⟨W,I⟩=tr W=scal W=0, and ⟨I,Φ(W)⟩=tr Φ(W)=scal Φ(W)=0 by eq. (6). So ⟨R,Φ(R)⟩=c³(n-1)N+⟨W,Q(W)⟩. **Matches Passage D.**
- ric R=c·ric I, and ric Φ(R)=c²(n-1)ric I+ric Φ(W)=c²(n-1)ric I. So ⟨ric R, ric Φ(R)⟩=c³(n-1)‖ric I‖².
- F(R)=(c²N+w²)/(c²‖ric I‖²), using ⟨I,W⟩=0 and ric W=0.
- F(R)⟨ric R, ric Φ(R)⟩=(c²N+w²)·c(n-1)=c³(n-1)N+c(n-1)w². **‖ric I‖² cancels between F and the pairing, as Passage A says.**
- Therefore, for every c>0 and every Weyl W,
  G(cI+W)=(2/(c²‖ric I‖²))·(⟨W,Q(W)⟩-c(n-1)‖W‖²).

**The invariance criterion, as explicit inequalities.** Before: ⟨R,Φ(R)⟩≤F(R)⟨ric R, ric Φ(R)⟩ at R∈∂Ω₀ (equivalently G(R)≤0). After, on the slice: ⟨W,Q(W)⟩≤c(n-1)‖W‖², with the c³(n-1)N term common to both sides. **CONFIRMED.**

Observation for §2: this equivalence uses no value of a. The parameter enters only through which c the boundary ∂Ω_a fixes.

## 2. "An identity on the whole slice" and the θ₀ display (attack item 2, first half)

- The identity of §1 holds at every c>0, so "the collapse is an identity on the whole slice, not merely a vanishing at the boundary" is right, with the whole slice meaning slice∩scal⁺.
- The display ⟨W,Q(W)⟩≤θ₀(n)‖W‖³ is the collapsed inequality at c=c₀(W):=θ₀(n)‖W‖/(n-1), which is exactly the slice point of ∂Ω₀ (§4). Passage A names ∂Ω₀ in its third paragraph ("each unit W is tested against θ₀(n) and no other constant").
- Quantifier order: for fixed W, the right side c(n-1)‖W‖² increases in c. Ω₀∩slice is {c≥c₀(W)}. So "G≤0 at every point of Ω₀∩slice" and "G≤0 at every point of ∂Ω₀∩slice" are the same condition, and both are ⟨W,Q(W)⟩≤θ₀(n)‖W‖³ for every W. Passage A's display holds under either reading of "the criterion at a=0". **CONFIRMED.**
- Normalisation: the display is homogeneous of degree 3 in W, so it needs no normalisation. The form with c(n-1)‖W‖² needs c tied to W by the boundary.

## 3. Passages B and C: "c(n-1)=θ₀(n)" (attack item 2, second half)

**Candidate.**

1. Location. Passage C: "at a=0 the whole condition collapses to ⟨W,Q(W)⟩≤c(n-1)‖W‖², where c(n-1)=θ₀(n)=√(2(n-1)(n-2))/n". Passage B: "collapses Böhm–Wilking's criterion on Ω₀ to ⟨W,Q(W)⟩≤c(n-1)‖W‖² with c(n-1)=θ₀(n) exactly". Neither passage states ‖W‖=1 or R∈∂Ω₀.
2. Closed-form failure. Fix n=12 and a unit Weyl W. The cone is scale-invariant, so R=2(c₀I+W)=2c₀I+2W lies on ∂Ω₀ with c=2c₀ and ‖W‖=2. Then c(n-1)=2θ₀(12)=2√220/12=√220/6, which differs from θ₀(12)=√220/12. Off the boundary, R=I+W (W unit, c=1) lies in Ω₀ at n=12 since (10/12)·1≤66, and c(n-1)=11≠√220/12. So c(n-1)=θ₀(n) holds only at ‖W‖=1 on ∂Ω₀, and "the whole condition ... where c(n-1)=θ₀(n)" is false on the rest of the slice.
3. Charitable reading. The proof file (Passage D) says "Normalising ‖W‖=1, the ∂Ω₀ constraint ... gives c=...", and "at a=0" can be read as "on ∂Ω₀". Under that reading B and C are correct. The reading is not in either canonical statement, and Passage C's "the whole condition" points the other way. Since B and C are the canonical forms a consumer quotes, the omission survives.

**Verdict: REFUTED AS STATED.** Correct form: c(n-1)=θ₀(n)‖W‖ on ∂Ω₀∩slice, so c(n-1)=θ₀(n) at ‖W‖=1. The mathematics in Passages A and D is unaffected.

## 4. The boundary ratio and root selection (attack item 3)

- F(cI+W)≤4/(n-2) ⟺ (n-2)(c²N+w²)≤4c²‖ric I‖²=c²n(n-1)². With N=n(n-1)/2, moving (n-2)c²N to the right leaves c²n(n-1)[(n-1)-(n-2)/2]=c²n²(n-1)/2=c²nN. So the condition is ((n-2)/n)w²≤c²N=‖R_I‖², which is Beitz p. 96 on the slice.
- Boundary: c²=2(n-2)w²/(n²(n-1)), roots c=±(w/n)√(2(n-2)/(n-1)). scal(R)=cN>0 selects the positive root. For w>0 this is one ratio c/w=(1/n)√(2(n-2)/(n-1)).
- c(n-1)=(w/n)√((n-1)²·2(n-2)/(n-1))=(w/n)√(2(n-1)(n-2))=θ₀(n)·w, using n-1>0.
- **CONFIRMED.** "Ricci-flatness is c=0, where the boundary forces ‖W‖=0": at c=0 the boundary equation reads ((n-2)/n)w²=0, so w=0 for n≥3, and R=0 lies outside scal⁺. Confirmed.

## 5. Imports from BW08 (attack item 4, first part)

- Lemma 2.1 is quoted correctly (text at source: "R+R#I=(n-1)R_I+((n-2)/2)R_Ric₀=Ric∧id", "⟨W⟩ is in the kernel"). W#I=-W follows.
- eq. (6) is quoted correctly ("Ric(R²+R#)_ij=Σ_k Ric_kk R_kijk"). At Ric(W)=0 it gives Ric(Φ(W))=0.
- "Φ preserves Weyl" needs Φ(W)∈S²_B as well as Ric(Φ(W))=0. Passage D line 70 says so and calls Bianchi preservation a standard Hamilton fact. The filed sources presuppose it (§ inventory). The collapse algebra uses only ric(Φ(W))=0 and tr Φ(W)=0, which need no Bianchi preservation of the output.
- Convention check: BW's Ric omits Beitz's factor 1/2. The only place Ric values enter is F⟨ric R, ric Φ(R)⟩, which is invariant under rescaling ric (F scales by λ⁻², the pairing by λ²), and eq. (6) is used only at the value 0.
- **CONFIRMED.**

## 6. Beitz p. 96 (attack item 4, second part)

Source text, Remark 6.3.10: "Ω₀ = {R∈A_n | ((n-2)/n)‖R_W‖²≤‖R_I‖² and tr(R)>0}". The definition of Ω_a on p. 97 carries "and scal(R)>0", and F is defined only on scal⁺ (6.24). Passage D's table row quotes this faithfully, and the normalisation line ‖ric R‖²=((n-1)/2)‖R_I‖²+((n-2)/4)‖R_ric₀‖² follows from Beitz (1.3), (1.4). **CONFIRMED.**

## 7. The direction and scope of Beitz Lemma 2.3.4 (attack item 4, third part)

### 7a. Passage D: "Lemma 2.3.4 supplies only the converse"

1. Location. Passage D (problem.md line 70): "the bridge needs invariance ⟹ G≤0, where Beitz Lemma 2.3.4 supplies only the converse; it holds via d/dt scal=2‖ric‖²>0."
2. Failure at source. Lemma 2.3.4, first sentence of the conclusion: "If the sublevel sets of F are invariant under (2.2), then for all v∈C we have that dF_v(Φ(v))≤0." That is invariance ⟹ G≤0. The converse is the lemma's second clause ("Conversely, if F satisfies (2.3) ...").
3. Charitable reading. The sentence might mean that the lemma does not supply the single-set form (§7b). Its words say "only the converse", and its fallback "it holds via d/dt scal=2‖ric‖²>0" is no argument for invariance ⟹ G≤0: invariance of scal⁺ (Example 2.3.5) keeps solutions in C, which the second clause needs, and says nothing about the sign of G. The reading does not survive.

**Verdict: REFUTED.** Passage E has the direction right.

### 7b. Passage E: "the first clause of Lemma 2.3.4, whose hypotheses check"

1. Location. Passage E: "the direction invariance ⟹ dF_R(Φ(R))≤0 being the first clause of Beitz's Lemma 2.3.4, whose hypotheses check."
2. Failure. The standing hypotheses check (V=A_n, Φ polynomial hence locally Lipschitz, C=scal⁺ open, F smooth). The clause's antecedent is "the sublevel sets of F are invariant", every sublevel set F⁻¹((-∞,b]) of F on C. The application has invariance of one of them, Ω₀=F⁻¹((-∞,4/(n-2)]). The cone conjecture itself covers only b∈[2/(n-1),4/(n-2)], so even the whole conjecture does not deliver the antecedent at levels b>4/(n-2). As stated, the clause returns G≤0 on all of scal⁺ from a hypothesis the application does not have, and its contrapositive at the padded witness returns "some sublevel set is not invariant", which is weaker than "Ω₀ is not invariant".
3. Charitable reading. The source's own proof of the first clause is level by level: it fixes v∈C, sets a:=F(v), and uses only the invariance of F⁻¹((-∞,a]) to get 0≥d/dt F(f(t))|₀=dF_v(Φ(v)). Applied at v∈∂Ω₀∩scal⁺ (so F(v)=4/(n-2)) it gives exactly the needed implication "Ω₀ invariant ⟹ G≤0 on ∂Ω₀". So the needed statement is in the source, in the proof rather than the statement, and the record cites the statement and says the hypotheses check.

**Verdict: GAP** (a citation-scope gap, closed by citing the proof of the first clause, which is on file). It does not touch the collapse algebra of §1–§4.

## 8. "Demands θ₀(n) and nothing weaker" (attack item 5)

- What "nothing weaker" quantifies over: for every Weyl W∈𝒲_n, the criterion G≤0 on ∂Ω₀∩slice at the ray through W is equivalent (§1, §2) to ⟨W,Q(W)⟩≤θ₀(n)‖W‖³. Over all W this is sup_{‖W‖=1}⟨W,Q(W)⟩≤θ₀(n), with no slack in the constant, because each W is tested at a single boundary point.
- "Demands" is the necessity direction: invariance of Ω₀ ⟹ that bound. It rests on §7b's level-by-level reading.
- The title claims nothing about sufficiency and nothing off the slice. Off-slice points of ∂Ω₀ impose further conditions (Passage C defers them to L45), so the full criterion demands at least θ₀(n), which is what "nothing weaker" says.
- **CONFIRMED**, with necessity inheriting §7b.

## 9. The scal(R)>0 clause and the lower nappe

- F(-R)=F(R), so {F≤4/(n-2)} without scal>0 is symmetric under R↦-R. §1's identity used c>0 only through F being defined, and on c<0 it gives the same bracket ⟨W,Q(W)⟩-c(n-1)‖W‖² with the same positive prefactor. At c=-c₀(W) the criterion reads ⟨W,Q(W)⟩≤-θ₀(n)‖W‖³. Confirmed.
- "False at every sphere product": this needs ⟨W,Q(W)⟩>0 at the sphere-product Weyl tensors, a record value imported here and outside this brief. Granting it, the claim holds. At n=12, R=-c₀I+W_{S⁶×S⁶} has c=-c₀ and lies on the boundary of the double set. Confirmed.
- The clause is in the source's definition (§6). **CONFIRMED.**

## 10. The Lean theorems (standing item 5, attack item 6)

Read against [L43Statement.lean](../lean/HamiltonsCubic/Results/L43Statement.lean) and [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean). The brief's Passage F matches the file line for line. Proof validity was not checked by building (no computation run). A build artefact L43Statement.olean dated 2026-09-13 exists.

- theta0, boundaryC: n:ℝ. θ₀ matches √(2(n-1)(n-2))/n. boundaryC matches (1/n)√(2(n-2)/(n-1)). Faithful.
- boundary_equation (3≤n): (n-2)/n = boundaryC² · n(n-1)/2 ∧ 0<boundaryC. This is §4's equation at w=1 with N=n(n-1)/2, and positivity. It types "a positive root", and the uniqueness behind "one ratio" is untyped (it is immediate, and the docstring does not claim it).
- collapse_constant (3≤n): boundaryC·(n-1)=theta0. Equality, correct direction. Faithful.
- criterion_forms_agree: binders n:ℝ, ι an arbitrary Fintype, W an arbitrary function Matrix ι ι ℝ→Matrix ι ι ℝ, hypotheses normSq W=1 and norm W=1. Both inequalities are "≤" with Pcubic on the left, the same direction as the record. Three observations, none a refutation: (i) n is not tied to Fintype.card ι, and W carries no IsWeyl or linearity hypothesis, so the theorem is a statement about real numbers that any W at unit norm satisfies. (ii) hnorm follows from hsq by the definition norm=√normSq, so it is redundant. (iii) The docstring claims only that the two forms "are one inequality" at unit norm, which is what is typed. innerOp gives ‖id‖²=½·Σ_{i≠j}1=n(n-1)/2 in this layer, consistent with the record's ‖I‖², though the file never uses I.
- lower_nappe_is_different: types -θ₀(n)<0 ∧ 0<θ₀(n). The module doc's bullet says this shows "the scal(R)>0 clause is load-bearing". What is typed is the sign of θ₀. The docstring on the theorem itself ("the two constants are distinct, and of opposite sign") matches.
- theta0_four: θ₀(4)=√12/4=√3/2. Correct.

**CONFIRMED AS ALGEBRA.** The statements are true, the inequalities point the right way, and they type the constant half of the derivation only. The module-doc bullet on lower_nappe_is_different describes more than the theorem types.

## 11. The Lean file's account of what it does NOT type (attack item 6)

1. Location. Module doc: "RealLayer has Pcubic and normSq but no Φ, no I, and no decomposition R = cI + R_ric₀ + R_W. Writing those objects here would be stating the lemma about definitions invented in this file rather than about the record's."
2. Failure. The imported WeylReal.lean defines `def Qop (R) := fun X => compOp R X + sharpOp R X` with docstring "Hamilton's map Q(R) = R² + R#", which is Φ. It also defines Ric and IsWeyl. The identity on Λ² is `fun X => X`, which needs no invented definition.
3. Charitable reading. What the layer lacks is the polarisation Φ(I,W), the facts Φ(I,W)=0 and Φ-preserves-Weyl, Beitz's F and cone, and the orthogonal decomposition. Those absences are real, and the conclusion that the collapse is untyped stands. The literal claim "no Φ" is false, and the stated reason (the objects would have to be invented) is partly false for Φ, Ric and the identity.

**Verdict: REFUTED AS STATED** (documentation accuracy, no effect on any theorem).

## 12. Edges (standing item 3, attack item 7)

- **n=3.** 𝒲₃=0, so the slice is {cI}. F(cI)=2/(n-1)=1<4=4/(n-2), so no slice point lies on ∂Ω₀∩scal⁺. The statement holds vacuously (0≤0). The Lean hypothesis 3≤n admits this case, harmlessly.
- **n=4.** The first nonvacuous dimension. Every step of §1–§4 holds (n-2>0, n-1>0).
- **Odd n.** Nothing in §1–§4 uses parity. Passage D's odd-n remark is about attainment: 2(n-1)(n-3)/((n-2)(n+1))<2(n-1)(n-2)/n² ⟺ n²(n-3)<(n-2)²(n+1)=n³-3n²+4, true. The quoted values check: n=11 gives 160/108=40/27, n=13 gives 240/154=120/77, n=15 gives 336/208=21/13.
- **Crossover.** θ₀(n)²<3/2 ⟺ 4(n-1)(n-2)<3n² ⟺ n²-12n+8<0 ⟺ 6-2√7<n<6+2√7. Since 25<28<36, 6+2√7∈(11,12). Integers 4..11 fail and 12 holds (144-144+8=8>0). Passage D's "n≤11" is right on n≥4.
- **c≤0.** c<0 is the discarded nappe (§9). c=0 gives R=W∉scal⁺, and the boundary forces W=0 (§4).
- **W=0.** R=cI with c>0 is interior (F=2/(n-1)<4/(n-2) since 2(n-2)<4(n-1)). The collapsed criterion is 0≤0. The ratio c/‖W‖ is undefined there, and §4's "one ratio" is for W≠0.
- **ker W≠0.** Lemma 2.1's kernel statement is proved for all Weyl operators in S²_B(so(n)) through the embedding of so(4) Weyl operators, which is exactly the padded case. A padded Weyl tensor is Weyl in n dimensions (its Ricci contraction is the padded 4-dimensional one, 0). For W with image in so(4), W(b_α)=0 off so(4) and brackets of so(4) stay in so(4), so W# and W² are the padded 4-dimensional ones and ⟨W,Q(W)⟩ is unchanged. The collapse is kernel-blind, as Passage E says. The value θ(W_CP²)=√(3/2) is L44's import and was not checked here.
- **CONFIRMED.**

## 13. The "Three verifiers" sentence (attack item 8)

1. Location. problem.md line 60: "... sits on its boundary.* **Three verifiers, [ROUND_L43-arg](../verification/ROUND_L00r2.md)**, so the bound demanded is $$c(n-1)=...$$".
2. Failure. "Three verifiers, [link], so the bound demanded is c(n-1)=θ₀(n)" has no verb for "Three verifiers" and splices a provenance note into the derivation's conclusion. The link text names ROUND_L43-arg. The target is ROUND_L00r2.md. A file of that name exists in verification/, and no file named ROUND_L43-arg exists there (names listed, contents not opened, per the brief).
3. Charitable reading. "Three verifiers [checked this], [round], so ..." with a dropped verb. That rescues the sense, not the grammar, and the text–target mismatch stands.

**Verdict: REFUTED AS STATED.**

## 14. The gap between what is proven and what is stated or used (standing item 4)

- Proven: §1's identity on slice∩scal⁺, §4's boundary constant, hence Passage A's display as the slice criterion at a=0.
- Stated beyond it: B and C drop the normalisation (§3). Lean's module doc says "no Φ" (§11).
- Used beyond it: "demands" uses Lemma 2.3.4 in a single-level form the statement does not carry (§7b).
- Wording only, no verdict: Passage C's "The cone has three endpoints" (a∈[0,n/4] has two). Passage D's "The criterion gives P(W)≤θ₀(n) at every n" should read "demands": the criterion is necessary for invariance, and it proves no bound on its own. Passage E's last sentence states this correctly.

## 15. Withdrawn candidates

- **Lean positivity steps may not close with n-2 in the goal.** Withdrawn at step 2: no failure can be exhibited without running a build, which this loop forbids, and a build artefact for the file exists.
- **"Identity on the whole slice" fails off ∂Ω₀.** Withdrawn at step 2: §1 shows the identity holds at every c>0 once F is evaluated at R, which is the object in Beitz (6.25). Only the constant form c(n-1)=θ₀(n) is boundary-bound, filed as §3.
- **Beitz's # may differ from BW08's by a scalar, breaking W#I=-W.** Withdrawn at step 3: Beitz imports BW08 Lemma 2.1 in her own convention (I²+I#=(n-1)I), which fixes any scalar to 1.
- **The Ricci factor 1/2 between Beitz and BW08 changes the collapse.** Withdrawn at step 2: F⟨ric R, ric Φ(R)⟩ is invariant under rescaling ric, and eq. (6) is used only at the value 0.

## 16. The falsifier (standing item 7)

The statement would be falsified by a Weyl W and c>0 at which G(cI+W) and ⟨W,Q(W)⟩-c(n-1)‖W‖² have different signs, or by a slice point of ∂Ω₀∩scal⁺ with c(n-1)≠θ₀(n)‖W‖. I looked for it analytically: §1 exhibits G(cI+W) as a positive multiple of the bracket for every c>0 and every Weyl W (padded included), and §4 solves the boundary equation in closed form. Neither object exists. The boundary edges (n=3, c≤0, W=0) were checked in §12. The only failures found are of wording and citation (§3, §7a, §7b, §11, §13).

## Overall verdict

**PROVEN (hypotheses corrected).** The collapse and the constant are correct. The canonical forms B and C need "on ∂Ω₀, at ‖W‖=1" (equivalently c(n-1)=θ₀(n)‖W‖), and the necessity reading needs Lemma 2.3.4's first clause cited in its level-by-level form, which its proof on file supplies. At commit time three files from another session were staged and were left alone, uncommitted by this report: lean/HamiltonsCubic/Results/L49Statement.lean, lean/INDEX.md, plan-lean.md. Only this report was committed.
