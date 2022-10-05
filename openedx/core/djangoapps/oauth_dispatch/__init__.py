from edx_toggles.toggles import WaffleSwitch

OAUTH_DISPATCH_WAFFLE_SWITCH_NAMESPACE = 'oauth_dispatch'

DISABLE_JWT_FOR_MOBILE = WaffleSwitch(
    f'{OAUTH_DISPATCH_WAFFLE_SWITCH_NAMESPACE}.disable_jwt_for_mobile',
    __name__
)
