#!/usr/bin/env python
from pathlib import Path

from ansible.module_utils.basic import AnsibleModule


def main():
    module = AnsibleModule(
        argument_spec=dict(),
        supports_check_mode=True,
    )

    try:
        import powerline
    except ImportError:
        module.fail_json(msg="Powerline isn't installed or importable?")

    powerline_lib_path = Path(powerline.__file__)

    module.exit_json(changed=False, ansible_facts={
        'powerline_lib_dir': str(powerline_lib_path.parent),
        'powerline_site_packages_dir': str(powerline_lib_path.parent.parent),
    })


if __name__ == '__main__':
    main()
