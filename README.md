# Prolog Monster Battle Knowledge Base

A Prolog knowledge-base project developed during my university studies to explore declarative programming, logical inference, facts, rules and relationships.

The application models a simplified monster-battle system in which monsters have elemental types, can perform different moves, and interact according to defined type-effectiveness relationships.

## Project Overview

Rather than describing a sequence of operations as in an imperative language, the project defines knowledge about the problem domain using Prolog facts and rules.

The knowledge base represents:

- Monster types
- Individual monsters
- Monster types
- Available moves
- Move types
- Moves available to individual monsters
- Type-effectiveness relationships
- Relative effectiveness
- Rules for reasoning about moves and battles

Queries can then be submitted to the Prolog inference engine to derive information from those relationships.

## Technologies

- Prolog
- Declarative Programming
- Logic Programming
- Rule-Based Reasoning

## Repository Structure

```text id="3a11b6"
prolog-monster-battle-knowledge-base/
│
├── README.md
├── LICENSE
│
├── src/
│   └── monster.pl
│
└── tests/
    └── query_results.txt
```

## Knowledge Representation

The system begins by defining five basic elemental types:

```prolog id="efifpz"
basicType(fire).
basicType(ghost).
basicType(grass).
basicType(normal).
basicType(water).
```

Individual monsters are then associated with a type.

Conceptually:

```text id="97ekxc"
Monster
   |
   +--> chewtle  --> water
   +--> pansage  --> grass
   +--> rapidash --> fire
   +--> shuppet  --> ghost
   └--> wooloo   --> normal
```

Moves are similarly associated with their own elemental type.

## Monster Moves

The `monsterMove/2` relationship describes which moves can be performed by each monster.

For example:

```prolog id="q0p0kk"
monsterMove(rapidash, flameCharge).
monsterMove(rapidash, overheat).
monsterMove(rapidash, quickAttack).
monsterMove(rapidash, sunnyDay).
```

Because these relationships are represented as Prolog facts, they can be queried in either direction.

For example:

```prolog id="0c85hh"
monsterMove(shuppet, X).
```

returns the moves associated with `shuppet`.

## Type Effectiveness

The knowledge base represents how one elemental type performs against another.

Effectiveness is categorised as:

```text id="17wjjp"
strong
ordinary
weak
superweak
```

For example, the model defines water attacks as strong against fire, while grass attacks are strong against water.

The relationships between effectiveness levels allow Prolog rules to reason about whether one attack is preferable to another.

## Logical Inference

The project implements several rules that derive new information from the stored facts.

### Monster Move Type Match

```prolog id="ad6mmx"
monsterMoveTypeMatch(MV, MO)
```

determines whether a move available to a monster has the same elemental type as that monster.

Conceptually:

```text id="ctg6yn"
Monster
   |
   +--> Monster Type
   |
   +--> Available Move
             |
             +--> Move Type
                     |
                     v
             Do the types match?
```

### Move Effectiveness Comparison

```prolog id="5qaxc6"
moreEffectiveTypeMove(T, MV1, MV2)
```

determines whether one move is more effective than another against a specified target type.

The rule combines:

```text id="xrs9uo"
Move 1 Type ──┐
              ├──> Type Effectiveness ──┐
Target Type ──┘                         │
                                        ├──> Compare
Move 2 Type ──┐                         │
              ├──> Type Effectiveness ──┘
Target Type ──┘
```

### Monster Battle Comparison

```prolog id="plvb33"
moreEffectiveMonsterMove(MO1, MO2, MV1, MV2)
```

compares attacks performed by two monsters.

The rule determines:

1. Whether each monster can perform the specified move
2. The type of each monster
3. The type of each move
4. The effectiveness of each move against the opposing monster
5. Whether the first attack has greater effectiveness than the second

This demonstrates how relatively simple facts can be combined into more complex inferred relationships.

## Example Queries

The original project included a collection of test queries and their resulting outputs.

For example:

```prolog id="kjepms"
basicType(X).
```

returns each supported type.

A query such as:

```prolog id="g5w6hm"
monsterMove(shuppet, X).
```

returns:

```text id="jq1s5c"
X = hex
X = screech
X = shadowBall
X = sunnyDay
```

The project also tests inferred relationships.

For example:

```prolog id="zxkldg"
moreEffectiveMonsterMove(
    chewtle,
    rapidash,
    waterGun,
    flameCharge
).
```

returns:

```text id="7k0pbj"
true
```

while reversing the matchup:

```prolog id="acx6r9"
moreEffectiveMonsterMove(
    rapidash,
    chewtle,
    flameCharge,
    waterGun
).
```

returns:

```text id="6ub3rx"
false
```

The complete original query set is preserved in:

`tests/query_results.txt`

## Concepts Demonstrated

This project introduced and reinforced:

- Declarative programming
- Logic programming
- Knowledge representation
- Facts and predicates
- Rules
- Variables
- Unification
- Logical inference
- Relationships
- Backtracking
- Query-based programming
- Transitive relationships
- Domain modelling

## Original Implementation

The implementation has been preserved largely as originally developed during university.

Rather than being a production application, the project demonstrates a fundamentally different programming paradigm from the imperative and object-oriented languages used elsewhere in my portfolio.

## Retrospective

This project provided an introduction to reasoning about software in terms of relationships and logical constraints rather than explicitly defining every step of program execution.

Instead of writing an algorithm that manually searches through every monster and move, Prolog allows the underlying relationships to be defined and then uses inference and backtracking to satisfy queries.

### Effectiveness Ordering

The original implementation represents effectiveness using named atoms:

```text id="9d4alh"
strong
ordinary
weak
superweak
```

and then manually defines the rules used to determine whether one effectiveness level is greater than another.

A cleaner implementation could model this ordering more directly, reducing the amount of special-case logic required by `moreEffectiveThan/2`.

### Naming

The original predicates use camelCase names such as:

```prolog id="u6okai"
monsterMove
typeEffectiveness
moreEffectiveMonsterMove
```

Conventional Prolog style would generally favour lowercase snake_case names such as:

```prolog id="3xj4re"
monster_move
type_effectiveness
more_effective_monster_move
```

### Testing

The original test evidence consists of manually executed queries with their recorded results.

A modern implementation could convert these into automated Prolog unit tests so that expected logical relationships can be checked automatically.

## Portfolio Context

This project is useful within my portfolio because it demonstrates experience with a programming paradigm substantially different from my Java, C/C++ and embedded-development work.

It required modelling a domain as interconnected facts and relationships and then constructing rules capable of deriving additional information from that knowledge.

```text id="mzqr82"
Facts
  |
  v
Relationships
  |
  v
Rules
  |
  v
Inference
  |
  v
Query Results
```

It therefore provides an early example of declarative and rule-based problem solving alongside the imperative and object-oriented approaches demonstrated elsewhere in my portfolio.
