import operator
from datetime import date

import collections

COUNTRIES = {
                'AD': 'Andorra',
                'AE': 'United Arab Emirates',
                'AG': 'Antigua and Barbuda',
                'AL': 'Albania',
                'AM': 'Armenia',
                'AO': 'Angola',
                'AR': 'Argentina',
                'AT': 'Austria',
                'AU': 'Australia',
                'AW': 'Aruba',
                'AZ': 'Azerbaijan',
                'BA': 'Bosnia and Herzegovina',
                'BB': 'Barbados',
                'BD': 'Bangladesh',
                'BE': 'Belgium',
                'BF': 'Burkina Faso',
                'BG': 'Bulgaria',
                'BH': 'Bahrain',
                'BI': 'Burundi',
                'BJ': 'Benin',
                'BN': 'Brunei',
                'BO': 'Bolivia',
                'BR': 'Brazil',
                'BS': 'Bahamas',
                'BT': 'Bhutan',
                'BW': 'Botswana',
                'BY': 'Belarus',
                'BZ': 'Belize',
                'CA': 'Canada',
                'CD': 'Congo, The Democratic Republic of the',
                'CF': 'Central African Republic',
                'CG': 'Congo',
                'CH': 'Switzerland',
                'CI': "Cote d'Ivoire",
                'CL': 'Chile',
                'CM': 'Cameroon',
                'CN': 'China',
                'CO': 'Colombia',
                'CR': 'Costa Rica',
                'CU': 'Cuba',
                'CUW': 'Curacao',
                'CV': 'Cape Verde',
                'CY': 'Cyprus',
                'DE': 'Germany',
                'DJ': 'Djibouti',
                'DK': 'Denmark',
                'DM': 'Dominica',
                'DO': 'Dominican Republic',
                'DZ': 'Algeria',
                'EC': 'Ecuador',
                'EE': 'Estonia',
                'EG': 'Egypt',
                'ER': 'Eritrea',
                'ES': 'Spain',
                'ET': 'Ethiopia',
                'FI': 'Finland',
                'FJ': 'Fiji',
                'FM': 'Micronesia',
                'FR': 'France',
                'GA': 'Gabon',
                'GB': 'United Kingdom',
                'GD': 'Grenada',
                'GE': 'Georgia',
                'GH': 'Ghana',
                'GM': 'Gambia',
                'GN': 'Guinea',
                'GQ': 'Equatorial Guinea',
                'GR': 'Greece',
                'GT': 'Guatemala',
                'GW': 'Guinea-Bissau',
                'GY': 'Guyana',
                'HK': 'Hong Kong',
                'HN': 'Honduras',
                'HR': 'Croatia',
                'HT': 'Haiti',
                'HU': 'Hungary',
                'ID': 'Indonesia',
                'IE': 'Ireland',
                'IL': 'Israel',
                'IN': 'India',
                'IQ': 'Iraq',
                'IR': 'Iran, Islamic Republic of',
                'IS': 'Iceland',
                'IT': 'Italy',
                'JM': 'Jamaica',
                'JO': 'Jordan',
                'JP': 'Japan',
                'KE': 'Kenya',
                'KG': 'Kyrgyzstan',
                'KH': 'Cambodia',
                'KI': 'Kiribati',
                'KM': 'Comoros',
                'KN': 'Saint Kitts and Nevis',
                'KP': "North Korea",
                'KR': 'South Korea',
                'KW': 'Kuwait',
                'KZ': 'Kazakhstan',
                'LA': "Lao People's Democratic Republic",
                'LB': 'Lebanon',
                'LBY': 'Libya',
                'LC': 'Saint Lucia',
                'LI': 'Liechtenstein',
                'LK': 'Sri Lanka',
                'LR': 'Liberia',
                'LS': 'Lesotho',
                'LT': 'Lithuania',
                'LU': 'Luxembourg',
                'LV': 'Latvia',
                'MA': 'Morocco',
                'MC': 'Monaco',
                'MD': 'Moldova',
                'ME': 'Montenegro',
                'MG': 'Madagascar',
                'MH': 'Marshall Islands',
                'MK': 'Macedonia',
                'ML': 'Mali',
                'MM': 'Myanmar',
                'MN': 'Mongolia',
                'MO': 'Macao',
                'MR': 'Mauritania',
                'MT': 'Malta',
                'MU': 'Mauritius',
                'MV': 'Maldives',
                'MW': 'Malawi',
                'MX': 'Mexico',
                'MY': 'Malaysia',
                'MZ': 'Mozambique',
                'NA': 'Namibia',
                'NE': 'Niger',
                'NG': 'Nigeria',
                'NI': 'Nicaragua',
                'NL': 'Netherlands',
                'NO': 'Norway',
                'NP': 'Nepal',
                'NR': 'Nauru',
                'NZ': 'New Zealand',
                'OM': 'Oman',
                'PA': 'Panama',
                'PE': 'Peru',
                'PG': 'Papua New Guinea',
                'PH': 'Philippines',
                'PK': 'Pakistan',
                'PL': 'Poland',
                'PS': 'Palestinian Territories',
                'PT': 'Portugal',
                'PW': 'Palau',
                'PY': 'Paraguay',
                'QA': 'Qatar',
                'RO': 'Romania',
                'RS': 'Serbia',
                'RU': 'Russia',
                'RW': 'Rwanda',
                'SA': 'Saudi Arabia',
                'SB': 'Solomon Islands',
                'SC': 'Seychelles',
                'SD': 'Sudan',
                'SE': 'Sweden',
                'SG': 'Singapore',
                'SI': 'Slovenia',
                'SK': 'Slovakia',
                'SL': 'Sierra Leone',
                'SXM': 'Sint Maarten',
                'SM': 'San Marino',
                'SN': 'Senegal',
                'SO': 'Somalia',
                'SR': 'Suriname',
                'ST': 'Sao Tome and Principe',
                'SV': 'El Salvador',
                'SY': 'Syria',
                'SZ': 'Swaziland',
                'TD': 'Chad',
                'TG': 'Togo',
                'TH': 'Thailand',
                'TJ': 'Tajikistan',
                'TL': 'Timor-Leste',
                'TM': 'Turkmenistan',
                'TN': 'Tunisia',
                'TO': 'Tonga',
                'TR': 'Turkey',
                'TT': 'Trinidad and Tobago',
                'TV': 'Tuvalu',
                'TW': 'Taiwan',
                'TZ': 'Tanzania',
                'UA': 'Ukraine',
                'UG': 'Uganda',
                'US': 'United States',
                'UY': 'Uruguay',
                'UZ': 'Uzbekistan',
                'VA': 'Holy See (Vatican City State)',
                'VC': 'Saint Vincent and the Grenadines',
                'VE': 'Venezuela',
                'VN': 'Vietnam',
                'VU': 'Vanuatu',
                'WS': 'Samoa',
                'YE': 'Yemen',
                'ZA': 'South Africa',
                'ZM': 'Zambia',
            }


def calculate_age_years(born):
    today = date.today()
    return today.year - born


def get_country_iso(c_name):
    _iso = ""
    for iso, name in COUNTRIES.items():
        if name == c_name:
            _iso = iso

    return _iso


def reorder_registration_form_fields(fields):
    for idx, field in enumerate(fields):
        if field['name'] == 'first_name':
            field['order'] = 0
        elif field['name'] == 'last_name':
            field['order'] = 1
        elif field['name'] == 'username':
            field['order'] = 2
        elif field['name'] == 'email':
            field['order'] = 3
        elif field['name'] == 'password':
            field['order'] = 4
        elif field['name'] == 'confirm_password':
            field['order'] = 5
        elif field['name'] == 'is_currently_employed':
            field['order'] = 6
        elif field['name'] == 'organization_name':
            field['order'] = 7
        elif field['name'] == 'is_poc':
            field['order'] = 8
        elif field['name'] == 'org_admin_email':
            field['order'] = 9
        else:
            field['order'] = idx

    required_order = sorted(fields, key=lambda k: k['order'])
    return required_order
