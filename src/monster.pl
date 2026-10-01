:- discontiguous monsterMove/2.

/* types */
basicType(fire).
basicType(ghost).
basicType(grass).
basicType(normal).
basicType(water).

/* monsters */
monster(chewtle, water).
monster(pansage, grass).
monster(rapidash, fire).
monster(shuppet, ghost).
monster(wooloo, normal).

/* fire moves */
move(flameCharge, fire).
move(sunnyDay, fire).
move(overheat, fire).

/* ghost moves */
move(hex, ghost).
move(lick, ghost).
move(shadowBall, ghost).

/* grass moves */
move(grassySlide, grass).
move(seedBomb, grass).

/* normal moves */
move(headbutt, normal).
move(quickAttack, normal).
move(screech, normal).
move(stomp, normal).
move(tackle, normal).

/* water moves */
move(hydroPump, water).
move(waterGun, water).

/* chewtle moves */
monsterMove(chewtle, headbutt).
monsterMove(chewtle, hydroPump).
monsterMove(chewtle, tackle).
monsterMove(chewtle, waterGun).

/* pansage moves */
monsterMove(pansage, lick).
monsterMove(pansage, seedBomb).
monsterMove(pansage, sunnyDay).
monsterMove(pansage, tackle).

/* rapidash moves */
monsterMove(rapidash, flameCharge).
monsterMove(rapidash, overheat).
monsterMove(rapidash, quickAttack).
monsterMove(rapidash, sunnyDay).

/* shuppet moves */
monsterMove(shuppet, hex).
monsterMove(shuppet, screech).
monsterMove(shuppet, shadowBall).
monsterMove(shuppet, sunnyDay).

/* wooloo moves */
monsterMove(wooloo, grassySlide).
monsterMove(wooloo, headbutt).
monsterMove(wooloo, stomp).
monsterMove(wooloo, tackle).

/* fire type effectiveness */
typeEffectiveness(fire, fire, weak).
typeEffectiveness(fire, ghost, ordinary).
typeEffectiveness(fire, grass, strong).
typeEffectiveness(fire, normal, ordinary).
typeEffectiveness(fire, water, weak).

/* ghost type effectiveness */
typeEffectiveness(ghost, fire, ordinary).
typeEffectiveness(ghost, ghost, strong).
typeEffectiveness(ghost, grass, ordinary).
typeEffectiveness(ghost, normal, superweak).
typeEffectiveness(ghost, water, ordinary).

/* grass type effectiveness */
typeEffectiveness(grass, fire, weak).
typeEffectiveness(grass, ghost, ordinary).
typeEffectiveness(grass, grass, weak).
typeEffectiveness(grass, normal, ordinary).
typeEffectiveness(grass, water, strong).

/* normal type effectiveness */
typeEffectiveness(normal, fire, ordinary).
typeEffectiveness(normal, ghost, superweak).
typeEffectiveness(normal, grass, ordinary).
typeEffectiveness(normal, normal, ordinary).
typeEffectiveness(normal, water, ordinary).

/* water type effectiveness */
typeEffectiveness(water, fire, strong).
typeEffectiveness(water, ghost, ordinary).
typeEffectiveness(water, grass, weak).
typeEffectiveness(water, normal, ordinary).
typeEffectiveness(water, water, weak).    

/* basic effectiveness relationships */
moreEffective(strong, ordinary).
moreEffective(ordinary, weak).
moreEffective(weak, superweak).    

/* transitive effectiveness rules */
overallEffectiveness(X) :- X=strong; X=ordinary; X=weak; X=superweak.
moreEffectiveThan(E1,E2) :- overallEffectiveness(E1),overallEffectiveness(E2), E1=strong, not(E1=E2),!. 
moreEffectiveThan(E1,E2) :- overallEffectiveness(E1),overallEffectiveness(E2), E1=ordinary, not(E2=strong), not(E1=E2),!.
moreEffectiveThan(E1,E2) :- overallEffectiveness(E1),overallEffectiveness(E2), E1=weak, not(E2=strong), not(E2=ordinary), not(E1=E2).

/* prolog rule for monsterMove type match */
monsterMoveTypeMatch(MV,MO) :- monsterMove(MO,MV), monster(MO,X), move(MV,X).

/* prolog rule for moreEffective type move */
moreEffectiveTypeMove(T,MV1,MV2) :- move(MV1,X), move(MV2,Y), typeEffectiveness(X,T,Z1), typeEffectiveness(Y,T,Z2), moreEffectiveThan(Z1,Z2).
    
/* prolog rule for moreEffective monster move */
moreEffectiveMonsterMove(MO1,MO2,MV1,MV2) :- monsterMove(MO1,MV1), monsterMove(MO2,MV2), monster(MO1,MOT1), monster(MO2,MOT2), move(MV1,MVT1), move(MV2,MVT2), typeEffectiveness(MVT1,MOT2,EMO1), typeEffectiveness(MVT2, MOT1,EMO2), moreEffectiveThan(EMO1,EMO2).
