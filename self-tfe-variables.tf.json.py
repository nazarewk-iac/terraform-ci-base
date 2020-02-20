import json
from pathlib import Path

script = Path(__file__)
cwd = Path(__file__).parent
variables_path = cwd / 'variables.tf'
data = {}
variables = data.setdefault('resource', {}).setdefault('tfe_variable', {})

with variables_path.open() as file:
    for line in file:
        line = line.strip()
        if not line.startswith('variable '):
            continue
        key = line.split()[1].strip('"')

        variables[f'self-{key}'] = dict(
            category="terraform",
            sensitive="token" in key,
            key=key,
            value="${var.%s}" % key,
            workspace_id="${tfe_workspace.self.id}",
        )

with script.with_suffix('').open('w') as file:
    json.dump(data, file, indent=2)
