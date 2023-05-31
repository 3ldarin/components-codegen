import { BigNumberish } from "ethers";
import { GDPLootSet, OCLootSet } from "./lootSets";

export interface GDPBountyDefinition {
    /** Test block comment */
    // Test inline comment.
  id: BigNumberish;
  bountyGroupId: BigNumberish;
  name: string;
  enabled: boolean;
  lowerBound: BigNumberish;
  upperBound: BigNumberish;
  bountyTimeLock: BigNumberish;
  inputLoot?: GDPLootSet;
  outputLoot?: GDPLootSet;
  successXp: BigNumberish;
}

export interface OCBountyDefinition {
  bountyId: BigNumberish;
  bountyGroupId: BigNumberish;
  lowerBound: BigNumberish;
  upperBound: BigNumberish;
  bountyTimeLock: BigNumberish;
  inputLoot: OCLootSet;
  outputLoot: OCLootSet;
  successXp: BigNumberish;
}
