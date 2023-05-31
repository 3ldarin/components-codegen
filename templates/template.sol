// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import {TypesLibrary} from "../../core/TypesLibrary.sol";
import {BaseComponent, IComponent} from "../../core/components/BaseComponent.sol";

uint256 constant ID = uint256(keccak256("game.piratenation.{{component_name|lower}}component"));

/**
 * @title {{component_name}}Component
 * {{ description }}
 */
contract {{component_name}}Component is BaseComponent {
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
        keys = new string[]({{ variables|length }});
        values = new TypesLibrary.SchemaValue[]({{ variables|length }});

        {% for variable in variables %}
        // {{ variable["comment"] }}
        keys[{{ loop.index0 }}] = "{{variable["name"]}}";
        values[{{ loop.index0 }}] = {{variable["component_lib_type"]}};
        {% endfor %}
    }

    /**
     * Sets the typed value for this component
     *
    {% for variable in variables -%}
    @param {{variable["name"]}}
    {% endfor %}
     */
    function setValue(
        {% for variable in variables -%}
        {{variable["solidity_type"]}} {{variable["name"]}}{{ "," if not loop.last else "" }}
        {% endfor %}
    ) external virtual {
        setBytes(
            entity,
            abi.encode(
                {% for variable in variables -%}
                {{variable["name"]}}{{ ", " if not loop.last else "" }}
                {% endfor %}
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
            {% for variable in variables -%}
            {{variable["solidity_type"]}} {{variable["name"]}}{{ "," if not loop.last else "" }}
            {% endfor %}
        )
    {
        if (has(entity)) {
            (
                {% for variable in variables -%}
                {{variable["name"]}},
                {% endfor %}
            ) = abi.decode(
                getBytes(entity),
                (
                    {% for variable in variables -%}
                    {{variable["solidity_type"]}}{{ ", " if not loop.last else "" }}
                    {%- endfor %}
                )
            );
        } else {
            revert ValueNotFound(entity);
        }
    }
}
