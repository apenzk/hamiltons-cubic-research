# Reviewer 113, PARTIAL (salvaged from its log)

**This reviewer did not file a report.** Salvaged 2026-08-26 from `agent_logs/reviewer113.log` at the moment it was stopped, so the findings it had already reached are not lost. **Nothing here has been reconciled against the record, and none of it should be cited as a verdict**, a partial reviewer's numbers are exactly the kind that get propagated wrongly (see Reviewer 78, whose unverified quadric values reached FINDINGS.md for a commit).

Its phase plan and every line it logged, verbatim, 7 lines:

```
PID 24294 | Reviewer 113 | phases: 1) read record (graded-half.md, nondegeneracy.md, plan/findings) 2) build own Weyl basis W_6 (dim 84) + criticality + grading test 3) Claim 3: sigma-invariant subspace dim, solver spread 4) Claim 4 MAIN: is the theta~0.418198 / gap 2.2e-3 point graded (full test) 5) sigma-invariance vs grading question 6) Claims 1,2 spot-check 7) write reviews/REVIEW_r113.md
phase 1 done: record read. grading test of record = eigenvalue-sign split h=(lam>=0), m=(lam<0); graded iff S_mmm=0 AND S_hhm=0 (the two 'leaks' are one quantity by antisymmetry, findings/nondegeneracy.md:98). phase 2: own implementation.
phase 2 done: own Weyl basis via explicit Bianchi+Ricci nullspace. Gates PASS: dim Weyl_{4,5,6,7}=10/35/84/168; Q preserves Weyl (1.4e-15); Q(Id)=(n-1)Id exact; S3xS3 theta=1.054092553=theta0(6), gap=0.210818511 (matches record), graded; padded CP2 S_mmm=0 but leak 8/16/24 at n=6/8/10 -- reproduces record's 16/24 exactly, so my grading test IS the record's. phase 3: sigma-invariant hunt.
phase 3: dim sigma-invariant subspace = 45 CONFIRMED (svd gap 1.0 -> 8.9e-16). 376/400 converged (record 355/400). ORIENTATION BUG found in my first pass AND in the record's run_graded_gap_hunt.py: the grading test / slack S is sign-sensitive (W and -W swap h and m) and both scripts evaluate it at the solver's random sign while reporting |theta|. Re-running oriented to theta>0.
phase 4 in progress. Oriented hunt (seed 113113, 400 starts, 376 converged): exactly ONE solution with S_mmm=0 on the theta>0 side (theta=0.104886, dim m=7, leak 17.0 => UNGRADED). 12 with S_mmm=0 on the theta<0 side, all with leak 24-26.7 => UNGRADED. ZERO graded solutions overall. Reproduced record row theta=0.421067 S=10.2700 gap=1.27e-3 EXACTLY. Cartan filter: at n=6 involutions of so(6) give h in {so(5),so(2)+so(4),so(3)+so(3),u(3)} so dim m must be 5,6,8,9. Running record's own script to dump its exact points.
phase 4 DONE: CLAIM 4 REFUTED. Record's own theta=0.418198 point (dumped from an unmodified rerun of run_graded_gap_hunt.py that reproduces its table exactly, resid 4.8e-16): solver returns theta=-0.418198; on that orientation S_mmm=2.9e-30 (source of the 'S=0') but S_hhm=25.652461 => UNGRADED. On the maximiser orientation theta=+0.418198: S_mmm=21.52, dim m=10 (not in the Cartan-allowed {5,6,8,9}) => UNGRADED. phase 5: sweep all 355 + cone hunt.
phase 6: Claim1 REFUTED (padded S^kxS^k has S_hhm=36/72/108 => ungraded by the record's own full test, contradicting Claim 1's premise and agreeing with findings/nondegeneracy.md:100). Claim2 fixed-n floor CORRECTED: p=2 admissible, S^2xS^{n-2} graded with gap 2/((n-2)sqrt((n-1)(n-3))), exact to 9 digits at n=8,10,12,14: 0.056344/0.031497/0.020101/0.013937, all below the recorded p=3 floor; the record's run_graded_gap_at_fixed_n.py loops 'for p in range(3,...)'.
```

## What to do with this

Either re-launch a reviewer on the same brief and let it finish, or rebuild any number above from the object's own definition before recording it. Do not fold it into the record as-is.
