# Meta Cookie Identifier | Tracking with Shadin

Expertly extract, generate, and persist Meta (Facebook) `_fbp` and `_fbc` cookies directly within Google Tag Manager. This variable template ensures 100% consistency for Meta Pixel and Conversions API (CAPI) tracking, especially in environments where browser-side cookies might be restricted or inconsistent.

## Key Features

- **Automated Extraction**: Effortlessly retrieves existing `_fbp` and `_fbc` values from the user's browser.
- **Dynamic Generation**: If cookies are missing, the template generates them following Meta's official naming conventions and timestamps.
- **Persistence Logic**: Automatically sets (or refreshes) cookies on your root domain to maximize their lifespan and accuracy.
- **CAPI Ready**: Provides perfectly formatted values ready to be mapped as `external_id` or `click_id` in your server-side or browser-side events.

## Configuration

1. **Select Cookie Type**: Choose whether you want to identify the Facebook Browser ID (`_fbp`) or the Facebook Click ID (`_fbc`).
2. **Permissions**: Ensure your GTM container has permissions to:
   - Read Cookies (`get_cookies`)
   - Write Cookies (`set_cookies`)
   - Read URL components (`get_url`)

## How It Works

- **For _fbp**: If not found, it generates a unique ID string (e.g., `fb.1.167...`) based on the current timestamp and a random value.
- **For _fbc**: It looks for the `fbclid` parameter in the URL. If found, it formats and stores it as an `_fbc` cookie.

## Developed By

**Md Sadikul Islam Shadin**  
[LinkedIn Profile](https://www.linkedin.com/in/sadikulshadin/)
