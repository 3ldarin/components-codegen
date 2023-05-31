import { BigNumberish } from "ethers";

export interface {{ component_name}}Component {
  {% for variable in variables -%}
    {% if variable.comment %}
    // {{ variable.comment }}
    {%- endif %}
    {{ variable.name }}: {{ variable.typescript_type }};
  {%- endfor %}
  }
  