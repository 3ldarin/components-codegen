// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import {TypesLibrary} from "../../core/TypesLibrary.sol";
import {BaseComponent, IComponent} from "../../core/components/BaseComponent.sol";

uint256 constant ID = uint256(keccak256("game.piratenation.bountycomponent"));

/**
 * @title BountyComponent
 * This component defines rules for a Bounty
 */
contract BountyComponent is BaseComponent {
    /** ERRORS */

    /// @notice Error component value not found
    error ValueNotFound(uint256 entity);

    /** SETUP **/

    /** Sets the GameRegistry contract address for this contract  */
    constructor(
        address gameRegistryAddress
    ) BaseComponent(gameRegistryAddress, ID) {
        // Do nothing
    }

    /**
     * @inheritdoc IComponent
     */
    function getSchema()
        public
        pure
        override
        returns (string[] memory keys, TypesLibrary.SchemaValue[] memory values)
    {
        keys = new string[](7);
        values = new TypesLibrary.SchemaValue[](7);

        
        // Amount of XP earned on successful completion of this Bounty
        keys[0] = "success_xp";
        values[0] = TypesLibrary.SchemaValue.UINT32;
        
        // Lower bound of staked amount required for reward
        keys[1] = "lower_bound";
        values[1] = TypesLibrary.SchemaValue.UINT32;
        
        // Upper bound of staked amount required for reward
        keys[2] = "upper_bound";
        values[2] = TypesLibrary.SchemaValue.UINT32;
        
        // Amount of time (in seconds) to complete this Bounty + NFTs are locked for
        keys[3] = "bounty_time_lock";
        values[3] = TypesLibrary.SchemaValue.UINT32;
        
        // Bounty Group ID defined in the SoT,  ex: "WOOD_BOUNTY"
        keys[4] = "group_id";
        values[4] = TypesLibrary.SchemaValue.UINT256;
        
        // Bounty Input Loot component namespace GUID defined in the SoT
        keys[5] = "input_loot_set_entity";
        values[5] = TypesLibrary.SchemaValue.UINT256;
        
        // Output Loot component GUID, unique namespace GUID defined in the SoT
        keys[6] = "output_loot_set_entity";
        values[6] = TypesLibrary.SchemaValue.UINT256;
        
    }

    /**
     * Sets the typed value for this component
     *
    @param success_xp
    @param lower_bound
    @param upper_bound
    @param bounty_time_lock
    @param group_id
    @param input_loot_set_entity
    @param output_loot_set_entity
    
     */
    function setValue(
        uint32 success_xp,
        uint32 lower_bound,
        uint32 upper_bound,
        uint32 bounty_time_lock,
        uint256 group_id,
        uint256 input_loot_set_entity,
        uint256 output_loot_set_entity
        
    ) external virtual {
        setBytes(
            entity,
            abi.encode(
                success_xp, 
                lower_bound, 
                upper_bound, 
                bounty_time_lock, 
                group_id, 
                input_loot_set_entity, 
                output_loot_set_entity
                
            )
        );
    }

    /**
     * Returns the typed value for this component
     *
     * @param entity Entity to get value for
     */
    function getValue(
        uint256 entity
    )
        external
        view
        virtual
        returns (
            uint32 success_xp,
            uint32 lower_bound,
            uint32 upper_bound,
            uint32 bounty_time_lock,
            uint256 group_id,
            uint256 input_loot_set_entity,
            uint256 output_loot_set_entity
            
        )
    {
        if (has(entity)) {
            (
                success_xp,
                lower_bound,
                upper_bound,
                bounty_time_lock,
                group_id,
                input_loot_set_entity,
                output_loot_set_entity,
                
            ) = abi.decode(
                getBytes(entity),
                (
                    uint32, uint32, uint32, uint32, uint256, uint256, uint256
                )
            );
        } else {
            revert ValueNotFound(entity);
        }
    }
}