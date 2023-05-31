// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import {TypesLibrary} from "../../core/TypesLibrary.sol";
import {BaseComponent, IComponent} from "../../core/components/BaseComponent.sol";

uint256 constant ID = uint256(keccak256("game.piratenation.componentherecomponent"));

/**
 * @title ComponentHereComponent
 * 
 */
contract ComponentHereComponent is BaseComponent {
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
        keys = new string[](3);
        values = new TypesLibrary.SchemaValue[](3);

        
        // This is a comment for the variable
        keys[0] = "variableName";
        values[0] = TypesLibrary.SchemaValue.STRING;
        
        // 
        keys[1] = "commentLessVariable";
        values[1] = TypesLibrary.SchemaValue.STRING;
        
        // 
        keys[2] = "commentWithTypescriptOverride";
        values[2] = TypesLibrary.SchemaValue.UINT32;
        
    }

    /**
     * Sets the typed value for this component
     *
    @param variableName
    @param commentLessVariable
    @param commentWithTypescriptOverride
    
     */
    function setValue(
        string variableName,
        string commentLessVariable,
        uint32 commentWithTypescriptOverride
        
    ) external virtual {
        setBytes(
            entity,
            abi.encode(
                variableName, 
                commentLessVariable, 
                commentWithTypescriptOverride
                
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
            string variableName,
            string commentLessVariable,
            uint32 commentWithTypescriptOverride
            
        )
    {
        if (has(entity)) {
            (
                variableName,
                commentLessVariable,
                commentWithTypescriptOverride,
                
            ) = abi.decode(
                getBytes(entity),
                (
                    string, string, uint32
                )
            );
        } else {
            revert ValueNotFound(entity);
        }
    }
}