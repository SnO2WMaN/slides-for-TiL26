#import "template.typ": *
#import "notation.typ": *

#let Gentzen(L) = $bold(sans("G"))_#L$
#let G3(L) = $bold(sans("G3"))_#L$

#show: slides-theme.with(
  config-info(
    title: [Embeddings of propositional logics into the provability logics $LogicS$ and $LogicD$],
    date: [2026/11/26 @ Trends in Logic XXVI],
    url: "https://sno2wman.github.io/slides-for-TiL26/main.pdf",
    author: [Mashū Noguchi],
    institution: [Kobe University],
  ),
)

#title-slide()

= Introduction

== Abstract

What we talk:
+ Sequent calculus for defining two propositional logics embeddable into Solovay's $LogicS$ and Japaridze's $LogicD$ via a modified Gödel translation.
+ Semantical analytics for this caliculus and logic.

== Map

#figure(gap: 1em, caption: none)[
  #let nodes = (
    "VF": (label: $Logic("VF")$, pos: (0, 0)),
    "WF": (label: $Logic("WF")$, pos: (1, 0)),
    "F": (label: $Logic("F")$, pos: (2, 0)),
    "BPL": (label: $LogicBPL$, pos: (3, 0)),
    "FPL": (label: $LogicFPL$, pos: (3.5, -0.5)),
    "DPL": (label: text(fill: theme-colors.accent, LogicDPL), pos: (4.5, -0.5)),
    "SPL": (label: text(fill: theme-colors.accent, LogicSPL), pos: (5.5, -0.5)),
    "Int": (label: $Logic("Int")$, pos: (4, 0)),
    "KC": (label: $Logic("KC")$, pos: (5, 0)),
    "LC": (label: $Logic("LC")$, pos: (6, 0)),
    "Cl": (label: $Logic("Cl")$, pos: (7, 0)),
    "N": (label: $Logic("N")$, pos: (0, 2)),
    "EN": (label: $Logic("EN")$, pos: (1, 2)),
    "K": (label: $Logic("K")$, pos: (2, 2)),
    "K4": (label: $Logic("K4")$, pos: (3, 2)),
    "GL": (label: $LogicGL$, pos: (3.5, 2.5)),
    "D": (label: $LogicD$, pos: (4.5, 2.5)),
    "S": (label: $LogicS$, pos: (5.5, 2.5)),
    "S4": (label: $Logic("S4")$, pos: (4, 2)),
    "S4.2": (label: $Logic("S4.2")$, pos: (5, 2)),
    "S4.3": (label: $Logic("S4.3")$, pos: (6, 2)),
    "S5": (label: $Logic("S5")$, pos: (7, 2)),
  )
  #let edges = (
    ("VF", "WF"),
    ("WF", "F"),
    ("F", "BPL"),
    ("BPL", "Int"),
    ("Int", "KC"),
    ("KC", "LC"),
    ("LC", "Cl"),
    ("N", "EN"),
    ("EN", "K"),
    ("K", "K4"),
    ("K4", "S4"),
    ("S4", "S4.2"),
    ("S4.2", "S4.3"),
    ("S4.3", "S5"),
    ("K4", "GL"),
    ("BPL", "FPL"),
    ("FPL", "DPL"),
    ("DPL", "SPL"),
    ("GL", "D"),
    ("D", "S"),
  )
  #let MC = (
    ("VF", "N"),
    ("WF", "EN"),
    ("F", "K"),
    ("BPL", "K4"),
    ("Int", "S4"),
    ("KC", "S4.2"),
    ("LC", "S4.3"),
    ("Cl", "S5"),
    ("FPL", "GL"),
    ("DPL", "D"),
    ("SPL", "S"),
  )
  #diagram(
    spacing: 3.5em,
    edges.map(e => edge(
      nodes.at(e.at(0)).pos,
      nodes.at(e.at(1)).pos,
      stroke: theme-colors.secondary,
      "<-",
    )),
    MC.map(e => edge(
      nodes.at(e.at(0)).pos,
      nodes.at(e.at(1)).pos,
      stroke: theme-colors.foreground,
      bend: -20deg,
      "<-->",
    )),
    nodes.values().map(n => node(n.pos, text(n.label))),
  )
]

- Upper: propositional logics
- Lower: modal logics

#let Fml = $serif("Fml")$

== Gödel-McKinsey-Tarski Theorem

$Logic("Int")$ embeds into $Logic("S4")$.

#fact[@Göd33,@MT48][
  $
    Logic("Int") proves A <==> Logic("S4") proves A^goedelTr
  $
]


#definition[
  The _Gödel translation_ $(dot.c)^goedelTr : Fml_upright("P") -> Fml_upright("M")$ is defined by:

  - $p^goedelTr mapsto box p$ where $p$ is a propositional variable.
  - $bot^goedelTr mapsto box bot$
  - $(A -> B)^goedelTr mapsto box (A^goedelTr -> B^goedelTr)$
  - $(A and B)^goedelTr mapsto A^goedelTr and B^goedelTr$
  - $(A or B)^goedelTr mapsto A^goedelTr or B^goedelTr$
]

== Modal Companion

#definition[
  Let $L$ be a propositional logic and $M$ be a modal logic.
  We say that _$M$ is a modal companion of $L$ (via $goedelTr$)_ if $L proves A <==> M proves A^goedelTr$.
]

Modal companions of superintuitionistic logics (extensions of $Logic("S4")$) are well known.

#fact[cf. @CZ97][
  - $Logic("S4.2") & : Logic("S4") + dia box p -> box dia p$ is a modal companion of Jankov's logic (weak excluded middle) $Logic("KC") : Logic("Int") + not p or not not p$.
  - $Logic("S4.3") & : Logic("S4") + box (box p -> q) or box (box q -> p)$ is a modal companion of Gödel--Dummett logic (linearity) $Logic("LC") : Logic("Int") + (p -> q) or (q -> p)$.
  - $Logic("S5") & : Logic("S4") + p -> box dia p$ is a modal companion of classical logic $Logic("Cl") : Logic("Int") + p or not p$.
]

_Question_: What about logics below $Logic("S4")$ (e.g. $Logic("K"), LogicK4, LogicGL$)?

== Visser's $LogicBPL$ and $LogicFPL$

Motivated by provability logic, @Vis81 introduced two propositional logics _by natural deduction_, $LogicBPL$ (_Basic Propositional Logic_) and $LogicFPL$ (_Formal Propositional Logic_).

#definition[
  _Visser--Gödel translation_ $(dot.c)^visserTr : Fml_upright("P") -> Fml_upright("M")$ is $goedelTr$ with the variable clause changed: $ p^visserTr mapsto p and box p $
]

#proposition[@Vis81][

  $
    LogicBPL proves A & <==> LogicK4 proves A^visserTr & <==> LogicK4 proves A^goedelTr \
    LogicFPL proves A & <==> LogicGL proves A^visserTr & <==> LogicGL proves A^goedelTr
  $
]

That is, $LogicK4$ (resp. $LogicGL$) is a modal companion of $LogicBPL$ (resp. $LogicFPL$) via $goedelTr$ or $visserTr$.

/*
#pagebreak()

In @Vis81:
- $LogicBPL$ and $LogicFPL$: defined.
- The embeddings are proven by Kripke semantic arguments.

#proposition[
  - $LogicBPL$ is complete w.r.t. transitive, valuation-persistent Kripke models (intuitionistic models without reflexivity).
  - $LogicFPL$ is complete w.r.t. finite, transitive, irreflexive, valuation-persistent Kripke models.
]
*/

== Sequent calculi for $LogicBPL$ and $LogicFPL$

Sequent calculi: @IKK01 @YS17.
- @IKK01: Kripke completeness and semantic cut-elimination.
- @YS17: constructive embedding of $LogicBPL$ into $LogicK4$.

#definition[$->$-left rule][
  Let $k >= 0$ and let $A, B, C_0 -> D_0, ..., C_n -> D_n$ be propositional formulas.

  $
    #prooftree(rule(
      name: $(->)_k$,
      $Delta_I, Sigma, \{ C_j -> D_j \}_(j < k), A => B, Gamma_I colon I subset.eq {0,...,k - 1}$,
      $Sigma, \{ C_j -> D_j \}_(j < k) => A -> B, Pi$,
    ))
  $
  Here $Delta_I := { D_j colon j in I }$ and $Gamma_I := {C_j colon j in.not I}$.
]

#pagebreak()

#example[$->$-left rule][

  $k = 0$:
  $
    #prooftree(rule(name: $(->)_0$, $Sigma, A -> B, A => B$, $Sigma => A -> B, Pi$))
  $

  $k = 1$:
  $
    #prooftree(rule(
      name: $(->)_1$,
      $Sigma,C_0 -> D_0, A -> B, A => B, C_0$,
      $D_0, C_0 -> D_0, Sigma, A -> B, A => B$,
      $Sigma, C_0 -> D_0 => A -> B, Pi$,
    ))
  $

  $k = 2$:
  $
    #prooftree(rule(
      name: $(->)_2$,
      $Sigma, \{C_j -> D_j\}_(j < 2), A -> B, A => B, C_0, C_1$,
      $D_0, D_1, \{C_j -> D_j\}_(j < 2), Sigma, A -> B, A => B$,
      $D_0, Sigma, \{C_j -> D_j\}_(j < 2), A -> B, A => B, C_1$,
      $D_1, Sigma, \{C_j -> D_j\}_(j < 2), A -> B, A => B, C_0$,
      $Sigma, \{C_j -> D_j\}_(j < 2) => A -> B, Pi$,
    ))
  $
]

== Provability logics $LogicS$ and $LogicD$

Provability logics $LogicS$ and $LogicD$ are important _non-normal_ extensions of $LogicGL$.

1. Solovay's provability logic: $LogicS := LogicGL + box A -> A$.
  - Corresponds to true arithmetic $TA$.
2. Japaridze's (Dzhaparidze's) provability logic: $LogicD := LogicGL + not box bot + box (box A or box B) -> box A or box B$.
  - Corresponds to $PA + #text[$Sigma_1$-reflection ($box_PA sigma -> sigma colon sigma in Sigma_1$)]$.

Strict inclusions hold: $LogicGL subset.neq LogicD subset.neq LogicS$.

== Sequent calculi for $LogicS$ and $LogicD$

#let seq(l) = $attach(tr: #l, =>)$
#let seq1 = seq("1")
#let seq2 = seq("2")
#let seq3 = seq("3")
#let level = $scr(l)$
#let LvRuleAx(l) = Rule($"Ax"_#l$)
#let LvRuleBotL(l) = Rule($bot L_(#l)$)
#let Inverse(R) = $#R^(-1)$
#let LvRuleWL(l1, l2) = Rule($W L^(#l1)_(#l2)$)
#let LvRuleWR(l1, l2) = Rule($W R^(#l1)_(#l2)$)
#let LvRuleCL(l1, l2) = Rule($C L^(#l1)_(#l2)$)
#let LvRuleCR(l1, l2) = Rule($C R^(#l1)_(#l2)$)
#let LvRuleAndL(l1, l2) = Rule($and L^(#l1)_(#l2)$)
#let LvRuleAndLI(l1, l2) = Inverse(LvRuleAndL(l1, l2))
#let LvRuleAndR(l1, l2) = Rule($and R^(#l1)_(#l2)$)
#let LvRuleAndRI(l1, l2) = Inverse(LvRuleAndR(l1, l2))
#let LvRuleOrL(l1, l2) = Rule($or L^(#l1)_(#l2)$)
#let LvRuleOrLI(l1, l2) = Inverse(LvRuleOrL(l1, l2))
#let LvRuleOrR(l1, l2) = Rule($or R^(#l1)_(#l2)$)
#let LvRuleOrRI(l1, l2) = Inverse(LvRuleOrR(l1, l2))
#let LvRuleCut(l1, l2) = Rule($"Cut"^(#l1)_(#l2)$)
#let LvRuleImpL(l1, l2) = Rule($->L^(#l1)_(#l2)$)
#let LvRuleImpLI(l1, l2) = Inverse(LvRuleImpL(l1, l2))
#let LvRuleImpR(l1, l2) = Rule($->R^(#l1)_(#l2)$)
#let LvRuleImpRI(l1, l2) = Inverse(LvRuleImpR(l1, l2))
#let LvRuleBoxL(l1, l2) = Rule($box L^(#l1)_(#l2)$)
#let LvRuleBoxLI(l1, l2) = Inverse(LvRuleBoxL(l1, l2))
#let LvRuleBoxGL(l1, l2) = Rule($box #LogicGL^(#l1)_(#l2)$)
#let LvRuleBoxGLI(l1, l2) = Inverse(LvRuleBoxGL(l1, l2))
#let LvRuleLift(l1, l2) = Rule($"LU"^(#l1)_(#l2)$)

#let GentzenS = Gentzen(LogicS)
#let GentzenD = Gentzen(LogicD)

Sequent calculi: @Kus20 @KKIM25.

Main idea: sequents *with levels*.

#definition[
  For sets of formulas $Gamma, Delta$ and $level = 1,2,3$, a sequent with level $level$ is $Gamma seq(level) Delta$.
]

Intuition:
- $seq1$: reasoning in $LogicGL$.
- $seq2$: reasoning in $Logic("KT")$.
- Levels can go up: $seq1 ~> seq2 ~> seq3$.
- *Levels cannot go down.*

#pagebreak()

#definition[
  $GentzenD$ for $LogicS$ and $LogicD$ ($level = 1, 2, 3$).

  #grid(
    columns: 2,
    row-gutter: 16pt,
    align: top,
    [
      $ #prooftree(rule(name: LvRuleAx(level), $p seq(level) p$)) $
    ],
    [$ #prooftree(rule(name: LvRuleBotL(level), $bot seq(level)$)) $],

    [$ #prooftree(rule(name: LvRuleWL(level, level), $Gamma seq(level) Delta$, $A, Gamma seq(level) Delta$)) $],
    [$ #prooftree(rule(name: LvRuleWR(level, level), $Gamma seq(level) Delta$, $Gamma seq(level) Delta, A$)) $],

    [
      $
        #prooftree(rule(
          name: LvRuleImpL(level, level),
          $A -> B, Gamma seq(level) Delta$,
          $Gamma seq(level) Delta, A$,
          $B, Gamma seq(level) Delta$,
        ))
      $
    ],
    [
      $
        #prooftree(rule(name: LvRuleImpR(level, level), $A, Gamma seq(level) Delta, B$, $Gamma seq(level) Delta, A -> B$))
      $
    ],

    [
      $
        #prooftree(rule(name: LvRuleBoxGL(1, 1), $box Gamma, Gamma, box A seq1 A$, $box Gamma seq1 box A$))
      $
    ],
    [
      $
        #prooftree(rule(name: LvRuleBoxL(2, 2), $A, Gamma seq2 Delta$, $box A, Gamma seq2 Delta$))
      $
    ],

    [
      $
        #prooftree(rule(name: LvRuleLift(1, 2), $Gamma seq1 Delta$, $Gamma seq2 Delta$))
      $
    ],
    [
      $
        #prooftree(rule(name: LvRuleLift(2, 3), $box Gamma seq2 box Delta$, $box Gamma seq3 box Delta$))
      $
    ],
  )
]

#pagebreak()

#fact[@KKIM25][
  1. $GentzenD proves Gamma seq1 Delta$ iff $LogicGL proves and.big Gamma -> or.big Delta$.
  2. $GentzenD proves Gamma seq2 Delta$ iff $LogicS proves and.big Gamma -> or.big Delta$.
  3. $GentzenD proves Gamma seq3 Delta$ iff $LogicD proves and.big Gamma -> or.big Delta$.
]

#fact[Cut-elimination for $GentzenD$, @KKIM25][
  $#GentzenD + LvRuleCut(level, level) proves Gamma seq(level) Delta$ implies $#GentzenD proves Gamma seq(level) Delta$.
  $
    #prooftree(rule(name: LvRuleCut(level, level), $Gamma_1, Gamma_2 seq(level) Delta_1, Delta_2$, $Gamma_1 seq(level) Delta_1, A$, $A, Gamma_2 seq(level) Delta_2$))
  $
]

== Motivation

#text(size: 1.25em)[
  Question: Can we define propositional logics corresponding to $LogicS$ and $LogicD$?
]

@Pet23 defined _Solovay's propositional logic_ $LogicSPL$ via @Kus20's sequent calculus for $LogicS$,
but his proof of the embedding has errors.

= Results


#let GentzenSPL = $Gentzen(LogicSPL)$
#let GentzenDPL = $Gentzen(LogicDPL)$
#let PropVar = $upright("Prop")$
#let FmlPL = $upright("Fml")_upright("P")$
#let FmlML = $upright("Fml")_upright("M")$

== Sequent calculus $GentzenDPL$

#definition[$GentzenDPL$][
  $level = 1, 2, 3$. Omitted: $LvRuleAndL(level, level), LvRuleAndR(level, level), LvRuleOrL(level, level), LvRuleOrR(level, level)$.
  #grid(
    columns: 2,
    row-gutter: 24pt,
    align: top,
    [
      $
        #prooftree(rule(name: $LvRuleAx(level)$, $p seq(level) p$))
      $
      where $p in PropVar$.
    ],
    [
      $
        #prooftree(rule(name: $LvRuleBotL(level)$, $bot seq(level)$))
      $
    ],

    grid.cell(colspan: 2)[
      Let $k >= 0$ and let $A, B, C_0 -> D_0, ..., C_n -> D_n$ be propositional formulas.
      $
        #prooftree(rule(
          name: $LvRuleImpR(1, 1)$,
          $Delta_I, Sigma, \{ C_j -> D_j \}_(j < k), A seq1 B, Gamma_I colon I subset.eq {0,...,k - 1}$,
          $Sigma, \{ C_j -> D_j \}_(j < k) seq1 A -> B, Pi$,
        ))
      $
      Here $Delta_I := { D_j colon j in I }$ and $Gamma_I := {C_j colon j in.not I}$.
    ],
    grid.cell(colspan: 2)[
      $
        #prooftree(rule(
          name: $LvRuleImpL(2, 2)$,
          $Gamma seq2 Delta, A$,
          $B, Gamma seq2 Delta$,
          $A -> B, Gamma seq2 Delta$,
        ))
      $
    ],

    [
      $
        #prooftree(rule(name: LvRuleLift(1, 2), $Gamma seq1 Delta$, $Gamma seq2 Delta$))
      $
    ],

    [
      $
        #prooftree(rule(
          name: $LvRuleLift(2, 3)$,
          $\{A_j -> B_j\}_(j < n), Gamma seq2 \{C_j -> D_j\}_(j < m)$,
          $\{A_j -> B_j\}_(j < n), Gamma seq3 \{C_j -> D_j\}_(j < m)$,
        ))
      $
    ],
  )
]

== Proof-theoretic results

By proof-theoretic embedding, following @YS17 @Pet23:

#theorem[@Nog26][
  For finite sets $Gamma, Delta subset.eq FmlPL$ and $level = 1, 2, 3$:
  $ GentzenDPL proves Gamma seq(level) Delta <==> GentzenD proves Gamma^visserTr seq(level) Delta^visserTr $
]

#corollary[Cut-admissibility of $GentzenDPL$][
  The rule $LvRuleCut(level, level)$ is admissible in $GentzenDPL$.
]

However, the syntactic proof is long and complicated.
_What about semantics?_

== Kripke semantics

#let omegaprec = $attach(prec, tr: omega)$
#let omegasucc = $attach(succ, tr: omega)$
#let omegaforces = $attach(forces, tr: omega)$

#definition[
  A propositional Kripke model $M := chevron.l W, prec, forces chevron.r$ is an _$LogicFPL$-model_ if
  $prec$ is _transitive_ and _converse well-founded_, and $forces$ is _valuation-persistent_.
]

#definition[
  Let $M := chevron.l W, prec, forces chevron.r$ be an $LogicFPL$-model.
  We call $M^omega := chevron.l W^omega, omegaprec, omegaforces chevron.r$ an _$omega$-extension_ of $M$ at $r in W$ if:
  + $W^omega := W union.plus {t_i colon i <= omega }$.
  + $omegaprec$ is as sketched below.
  + $omegaforces$ is valuation-persistent in $M^omega$ and coincides with $forces$ on $W$.
]

// embedding.pdf の Fig. (omega-extension) を横向きにしたもの．t_ω（左）から W（右）へ向かう．
#align(center, canvas(length: 2em, {
  import draw: *
  let pt(p) = circle(p, radius: 0.07, fill: black)
  let arr(a, b) = line(a, b, mark: (end: "stealth", fill: black))
  circle((3.3, 0), radius: (1.25, 1.7), stroke: luma(140))
  content((4.75, 1.5), $W$)
  pt((2.5, 0))
  content((2.4, -0.45), $r$)
  pt((3.6, 1.0))
  pt((3.7, -1.0))
  pt((4.2, -0.2))
  arr((2.57, 0.07), (3.53, 0.93))
  arr((2.57, -0.07), (3.63, -0.93))
  arr((2.6, -0.02), (4.1, -0.18))
  // tail の点 t_0, ..., t_(n-1) を間隔 d で左へ並べる．
  let t0 = 1.3
  let d = 1.1
  let n = 4
  let tx(i) = t0 - i * d
  arr((t0 + 0.1, 0), (2.4, 0))
  for i in range(n) {
    pt((tx(i), 0))
    content((tx(i), -0.45), $t_#i$)
    if i > 0 { arr((tx(i) + 0.1, 0), (tx(i - 1) - 0.1, 0)) }
  }
  let last = tx(n - 1)
  content((last - 0.95, 0), $dots.c$)
  arr((last - 0.65, 0), (last - 0.1, 0))
  pt((last - 2.0, 0))
  content((last - 2.0, -0.45), $t_omega$)
  arr((last - 1.9, 0), (last - 1.3, 0))
  content(((t0 + last - 1.2) / 2, 1.0), [tail])
  content((last - 2.0, 1.0), [bottom])
  line((t0 + 0.25, 0.6), (last - 1.2, 0.6), stroke: (paint: luma(140), thickness: 0.5pt))
}))

#pagebreak()

#theorem[Completeness of $GentzenDPL$][
  + $GentzenDPL proves Gamma seq1 Delta$ if and only if $Gamma seq1 Delta$ is valid in every $LogicFPL$-model.
  + $GentzenDPL proves Gamma seq2 Delta$ if and only if $Gamma seq2 Delta$ is eventually always satisfied on the tail $(t_n)_(n in omega)$ of every $omega$-extension of an $LogicFPL$-model.
    - i.e. satisfied at all $t_n$ with $n >= N$, for some $N$.
  + $GentzenDPL proves Gamma seq3 Delta$ if and only if $Gamma seq3 Delta$ is satisfied at the bottom $t_omega$ of every $omega$-extension of an $LogicFPL$-model.
]

#proposition[
  Using the semantic results of @KKIM25 for modal logics, $GentzenDPL proves Gamma seq(level) Delta <==> GentzenD proves Gamma^visserTr seq(level) Delta^visserTr$ can be proven semantically.
]

== Logic and Calculus

Define the logics (i.e. sets of formulas) naturally:

#definition[
  + $LogicFPL := { A colon GentzenDPL proves seq1 A}$
  + $LogicSPL := { A colon GentzenDPL proves seq2 A}$
  + $LogicDPL := { A colon GentzenDPL proves seq3 A}$
]

Question: Since $LogicGL subset.neq LogicD subset.neq LogicS$, does $LogicFPL subset.neq LogicDPL subset.neq LogicSPL$ hold?
*No!*

#pagebreak()

Surprisingly, semantics shows that the _logics_ $LogicFPL, LogicDPL, LogicSPL$ coincide.


#theorem[
  $LogicFPL = LogicDPL = LogicSPL$.
]

#corollary[
  For any $A in FmlPL$:
  $
    A^visserTr in LogicGL <==> A^visserTr in LogicD <==> A^visserTr in LogicS
  $
]

The Visser--Gödel translation acts quite strongly on propositional logics.

However, they differ at the sequent level; counterexamples are easy to find.

#theorem[
  1. $GentzenDPL proves Gamma seq(1) Delta$ implies $GentzenDPL proves Gamma seq(3) Delta$. But the converse fails.
  2. $GentzenDPL proves Gamma seq(3) Delta$ implies $GentzenDPL proves Gamma seq(2) Delta$. But the converse fails.
]

= Conclusion

== Conclusion

+ Sequent calculi for two propositional logics embeddable into Solovay's $LogicS$ and Japaridze's $LogicD$ via a modified Gödel translation.
  - Sequents _with levels_.
+ Semantic analysis of these calculi and logics.
  - $omega$-extensions of Kripke models.

== Ongoing research

Some problems remains! Examples:

+ What is meaning of $LogicFPL, LogicSPL, LogicDPL$ in perspective of provability logic?
+ Correspondence with the classification theorem of @Bek90.
  #proposition[Classification Theorem][
    Provability logics can be classified into four families, each consisting of suitable extensions of $LogicGL$, $LogicD$ or $LogicS$.
  ]
  Can we define propositional logics corresponding to them?
  - Sequent calculi with four levels seem to work (in progress).
+ Relation between the Gödel translation and Visser--Gödel translations.
  - They differ subtly at the logic level and at the sequent level.

== References

#show bibliography: set text(size: 0.75em)
#bibliography(title: none, "references.yml", style: "elsevier-harvard")
