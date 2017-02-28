#!/usr/bin/env python
import os.path

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

    module.exit_json(changed=False, ansible_facts={
        'powerline_site_packages_path':
            os.path.dirname(powerline.__file__)
    })


if __name__ == '__main__':
    main()
