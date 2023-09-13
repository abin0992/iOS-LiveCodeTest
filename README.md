# TF-iOS-LiveCodeTest

## Specifications
We want to display a list of addresses from different countries. The contract and URL of the response is shown below:

**URL**: `https://thirdfort.github.io/mobileStaticServer/addresses.json`

**Method**: GET

| Property Name | Data Type | Required |
|-----|-----|-----|
| flatNumber | Int |  |
| buildingName | String |  |
| street | String | ✅ |
| town | String | ✅ |
| state | String |  |
| postcode | String |  |
| countryCode | String | ✅ |

### Requirements
1. Filter out invalid addresses. There are two ways to know if an address is invalid:
* Invalid Postcode. Client has provided us with the regex of postcode for UK, US and Canada addresses:
  * UK: `^[A-Za-z][A-Ha-hJ-Yj-y]?[0-9][A-Za-z0-9]? ?[0-9][A-Za-z]{2}$` (e.g. EC1N 2TD is valid, 1DF 444 is invalid)
  * US: `^[0-9]{5}(?:-[0-9]{4})?$` (e.g. 12345 and 98445-1111 is valid, ABCDE and 43153-091 is invalid)
  * Canada: `^(?!.*[DFIOQU])[A-VXY][0-9][A-Z] ?[0-9][A-Z][0-9]$` (e.g. V2P 2S6 is valid, o1d 2D1 is invalid)
* Address contains invalid properties.
#### UK Address
| Property Name | Required |
|-----|-----|
| flatNumber |  |
| buildingName |  |
| street | ✅ |
| town | ✅ |
| postcode | ✅ |
| countryCode | ✅ |

#### US Address
| Property Name | Required |
|-----|-----|
| street | ✅ |
| town | ✅ |
| state | ✅ |
| postcode | ✅ |
| countryCode | ✅ |

#### Canada Address
| Property Name | Required |
|-----|-----|
| street | ✅ |
| town | ✅ |
| state | ✅ |
| postcode | ✅ |
| countryCode | ✅ |

#### International (Other) Address
| Property Name | Required |
|-----|-----|
| street | ✅ |
| town | ✅ |
| state |  |
| postcode |  |
| countryCode | ✅ |
  
2. Our client wants us to list and group these addresses into 4 sections: `UK`, `US`, `Canada` and `International` (the rest).
3. In our UI, address list view should look like this:

   <img src=https://github.com/thirdfort/iOS-LiveCodeTest/assets/2783446/cec8a091-10e9-4d86-ad4d-960d628a7bdf width=320>

 * (Optional) Show country emoji flag
4. (Additional Challenge, Optional) Add filter functionality to list addresses for a country.
