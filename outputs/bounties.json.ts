import { BigNumberish } from "ethers";

export interface BountyComponent {
  
    // Amount of XP earned on successful completion of this Bounty
    success_xp: number;
    // Lower bound of staked amount required for reward
    lower_bound: number;
    // Upper bound of staked amount required for reward
    upper_bound: number;
    // Amount of time (in seconds) to complete this Bounty + NFTs are locked for
    bounty_time_lock: number;
    // Bounty Group ID defined in the SoT,  ex: "WOOD_BOUNTY"
    group_id: BigNumberish;
    // Bounty Input Loot component namespace GUID defined in the SoT
    input_loot_set_entity: BigNumberish;
    // Output Loot component GUID, unique namespace GUID defined in the SoT
    output_loot_set_entity: BigNumberish;
  }
  