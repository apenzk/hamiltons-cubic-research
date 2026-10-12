# Reviewer 114, PARTIAL (salvaged from its log)

**This reviewer did not file a report.** Salvaged 2026-08-26 from `agent_logs/reviewer114.log` at the moment it was stopped, so the findings it had already reached are not lost. **Nothing here has been reconciled against the record, and none of it should be cited as a verdict**, a partial reviewer's numbers are exactly the kind that get propagated wrongly (see Reviewer 78, whose unverified quadric values reached FINDINGS.md for a commit).

Its phase plan and every line it logged, verbatim, 40 lines:

```
PID 24298 | Reviewer 114 | phase plan:
  1. toolchain check (python/numpy/scipy), read findings/graded-half.md + findings/nondegeneracy.md for the RECORD's grading test
  2. build own W_6 basis (84-dim), sigma-invariant subspace dim (Claim 3)
  3. own criticality solver in W_6^sigma; reproduce spread of small eigenvalues
  4. CLAIM 4 (main): locate theta~0.418198 / S=0 / min|lambda|~2.2e-3 point; apply FULL grading test
  5. Claims 1,2 checks: padding invariance, balanced-sphere gap formula, S^p x S^q floor
  6. sigma-invariance of subspace vs sigma as a grading -- is it automatic?
  7. write reviews/REVIEW_r114.md
phase 1 DONE: numpy 2.0.2 scipy 1.13.1 sympy 1.14.0 present. Record read: grading test of record =
  h:=span(positive eigenvectors), m:=span(negative); Z2-grading iff T_mmm=0 AND T_hhm=0 (T totally
  symmetric), valid only when ker W = 0 (findings/target.md:220, findings/second-order.md:83).
  theta_0(n)=sqrt(2(n-1)(n-2))/n -> 1.054093 at n=6 = normalisation anchor for #.
phase 2 start: own Weyl_6 basis + # operator.
phase 2 DONE: own Weyl_6 basis dim 84 (constraint rank 36 of 120). # normalisation fixed by anchor:
  theta(S^3xS^3)=1.0540925534=theta_0(6) exactly, criticality residual 1.3e-16, min|lambda|=0.210818511.
  Grading test validated: S^3xS^3 -> T_hhm=T_mmm=0, ker=0 => GRADED. padded CP^2 -> S=T_mmm=0 but
  ker=12 with T_hzz=4, T_mzz=8 => ungraded, reproducing the record's witness.
  CLAIM 3 dimension: dim Weyl_6^sigma = 45 CONFIRMED (84 = 45 + 39 under M -> DMD).
phase 3 start: 400-start solver in Weyl^sigma (bg pid 24556), log scripts/reviewers/r114/hunt.out
heartbeat: claims 1&2 computed. CLAIM 1 confirmed (13/51 zeros at n=8/12, nonzero spectrum
  0.210818511 invariant, padded points exactly critical res 1.3e-16, and ungraded by the full test
  since ker!=0). CLAIM 2 formula confirmed analytically+numerically (dev <=2.8e-17 at n=6,8,10,12,16)
  BUT the fixed-n floor is wrong: the most unbalanced two-block product is S^2xS^(n-2), not S^3xS^(n-3)
  -> gap 0.031497 (n=10) and 0.020101 (n=12), about half the quoted 0.062994/0.038925. Both are
  exactly critical, kernel-free and GRADED by the full test.
phase 3 DONE: 383/400 converged (res<=1e-12 in the FULL 84-dim space), 121 distinct critical values.
  Record's row theta=0.413728259 gap=8.3091e-05 REPRODUCED exactly. NO graded point among the 121.
  Reproduced an independent kernel-free S=0-but-ungraded witness at n=6: theta=0.104886129,
  S=T_mmm=-2.5e-16, T_hhm=17.0, dims 8/7/0.
  KEY REDUCTION (own): W graded <=> sign(W)=Lambda^2(g) for g in O(6) with g^2=+-I, so the graded
  critical set at n=6 is exactly the union over the FOUR involution classes of the sigma-invariant
  critical points that are sign-DEFINITE on the two blocks. => sigma-invariance is NOT gradedness.
phase 4 start: (a) targeted hunt for theta=0.418198/S=0; (b) hunts in all four invariant subspaces.
heartbeat: exact identity verified at 1e-16 on 9 catalogued points: lam_a(theta-lam_a) =
  (1/2) sum_{gd} T_{agd} lam_g lam_d, with sum_{gd} T_{agd} = 2(n-2) EXACTLY for every a (Killing).
  Graded => every term on the RHS is >=0 => gap <= theta/(n-3). Holds at all 9.
  Sign-pattern distance of the 121 sigma-invariant critical points to sigma-gradedness: minimum 5
  mismatched signs out of 15; histogram {5:1,6:14,7:52,8:25,9:24,10:5}. None is graded.
  Launched: p1/p2/J hunts (500 starts each), p3 theta-targeted hunt at 0.418198 with S penalty,
  and a penalised GRADED search in W^sigma.
```

## What to do with this

Either re-launch a reviewer on the same brief and let it finish, or rebuild any number above from the object's own definition before recording it. Do not fold it into the record as-is.
