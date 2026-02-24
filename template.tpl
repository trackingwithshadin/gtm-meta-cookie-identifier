___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Meta Cookie Identifier | Tracking with Shadin",
  "description": "Expertly extract, generate, and persist Meta (Facebook) _fbp and _fbc cookies for 100% CAPI and Pixel data consistency.",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "SELECT",
    "name": "cookieToExtract",
    "displayName": "",
    "macrosInSelect": false,
    "selectItems": [
      {
        "value": "_fbp",
        "displayValue": "Facebook Browser ID (_fbp)"
      },
      {
        "value": "_fbc",
        "displayValue": "Facebook Click ID (_fbc)"
      }
    ],
    "simpleValueType": true
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const Math = require('Math');
const getCookieValues = require('getCookieValues');
const setCookie = require('setCookie');
const getUrl = require('getUrl');
const getTimestamp = require('getTimestamp');
const makeString = require('makeString');
const generateRandom = require('generateRandom');

const cookieToExtract = data.cookieToExtract;
if (!cookieToExtract) return undefined;

const getSubdomainIndex = () => {
    const hostname = getUrl('host');
    if (!hostname) return 1;
    const parts = hostname.split('.');
    return parts.length > 2 ? parts.length - 2 : 1;
};

const getRootDomain = () => {
    const hostname = getUrl('host');
    if (!hostname) return '';
    const parts = hostname.split('.');
    if (parts.length <= 2) return hostname;
    return parts.slice(-1 * (parts.length > 2 ? 2 : parts.length)).join('.');
};

const existingCookies = getCookieValues(cookieToExtract);
if (existingCookies && existingCookies.length > 0) {
    return makeString(existingCookies[0]);
}

const timestampMs = getTimestamp();
const timestampSec = Math.floor(timestampMs / 1000);
let finalValue = undefined;

if (cookieToExtract === '_fbp') {
    const subIndex = getSubdomainIndex();
    const random = generateRandom(1000000000, 2147483647);
    finalValue = 'fb.' + subIndex + '.' + timestampMs + '.' + random;
}

else if (cookieToExtract === '_fbc') {
    const fbclid = getUrl('query').fbclid;
    if (fbclid) {
        finalValue = 'fb.1.' + timestampSec + '.' + makeString(fbclid);
    }
}

if (finalValue) {
    const cookieOptions = {
        domain: getRootDomain(),
        path: '/',
        'max-age': 7776000,
        secure: true,
        sameSite: 'Lax'
    };

    setCookie(cookieToExtract, finalValue, cookieOptions);
    return finalValue;
}

return undefined;


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "get_cookies",
        "versionId": "1"
      },
      "param": [
        {
          "key": "cookieAccess",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "cookieNames",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "_fbp"
              },
              {
                "type": 1,
                "string": "_fbc"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "get_url",
        "versionId": "1"
      },
      "param": [
        {
          "key": "queriesAllowed",
          "value": {
            "type": 1,
            "string": "any"
          }
        },
        {
          "key": "urlParts",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "path",
          "value": {
            "type": 8,
            "boolean": true
          }
        },
        {
          "key": "query",
          "value": {
            "type": 8,
            "boolean": true
          }
        },
        {
          "key": "host",
          "value": {
            "type": 8,
            "boolean": true
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "set_cookies",
        "versionId": "1"
      },
      "param": [
        {
          "key": "allowedCookies",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "name"
                  },
                  {
                    "type": 1,
                    "string": "domain"
                  },
                  {
                    "type": 1,
                    "string": "path"
                  },
                  {
                    "type": 1,
                    "string": "secure"
                  },
                  {
                    "type": 1,
                    "string": "session"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "_fbp"
                  },
                  {
                    "type": 1,
                    "string": "*"
                  },
                  {
                    "type": 1,
                    "string": "*"
                  },
                  {
                    "type": 1,
                    "string": "any"
                  },
                  {
                    "type": 1,
                    "string": "any"
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "name"
                  },
                  {
                    "type": 1,
                    "string": "domain"
                  },
                  {
                    "type": 1,
                    "string": "path"
                  },
                  {
                    "type": 1,
                    "string": "secure"
                  },
                  {
                    "type": 1,
                    "string": "session"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "_fbc"
                  },
                  {
                    "type": 1,
                    "string": "*"
                  },
                  {
                    "type": 1,
                    "string": "*"
                  },
                  {
                    "type": 1,
                    "string": "any"
                  },
                  {
                    "type": 1,
                    "string": "any"
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios: []


___NOTES___

Created on 2/25/2026, 1:25:32 AM



___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.
