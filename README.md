# Quote of the day

An OpenHarmony app for phones and tablets that fetches and displays a Stoic quote from a public web API.

## What this example demonstrates

| Capability | API or platform service | Where to look |
| --- | --- | --- |
| Fetch and validate a quote over HTTPS | `@kit.NetworkKit` HTTP request | [Quotes.ets](entry/src/main/ets/entryability/Quotes.ets) |
| Show loading, retry, quote, and author states | ArkUI `@State` and components | [Index.ets](entry/src/main/ets/pages/Index.ets) |
| Allow network access | `ohos.permission.INTERNET` | [module.json5](entry/src/main/module.json5) |

## Preview

![Quote displayed in the app](images/screenshot-2026-10-08.jpg)

## Requirements

- OpenHarmony 6.1 (API 23) SDK, Java, and the `oniro-app` CLI. The app targets API 23 and declares API 20 as its minimum; the SDK versions are set in [build-profile.example.json5](build-profile.example.json5).
- An OpenHarmony phone, tablet, or emulator with network access to the [Stoicism Quote API](https://github.com/tlcheah2/stoic-quote-lambda-public-api). The app declares `ohos.permission.INTERNET`.
- Development signing material for installation. `oniro-app sign` creates it locally in the ignored `signatures/` directory.

## Build and run

From the repository root in PowerShell, copy the build profile once, then sign and build:

```powershell
Copy-Item build-profile.example.json5 build-profile.json5
oniro-app sign
oniro-app build
oniro-app devices
oniro-app app install --device <serial>
oniro-app app launch --device <serial>
```

Replace `<serial>` with the OpenHarmony device or emulator serial reported by `oniro-app devices`. `oniro-app sign` updates only the ignored local build profile and signing files. Run it once per checkout; subsequent changes only need `oniro-app build` before installation. CI copies the tracked example and signs its own build.

## Use

Launch the app to fetch a quote. Tap **New quote** to request another one. While a request is pending, the button is disabled. If a request fails, tap **Try again** to retry.

## Explore the implementation

[EntryAbility.ets](entry/src/main/ets/entryability/EntryAbility.ets) loads the page. [Index.ets](entry/src/main/ets/pages/Index.ets) starts the first fetch and updates the UI. [Quotes.ets](entry/src/main/ets/entryability/Quotes.ets) creates an HTTP request, checks the response, parses the quote and author, and destroys the request when finished.

## Verify

On a connected emulator or device, confirm that a quote and author appear after launch and that **New quote** fetches another quote. Try repeated taps, disconnect the network, and confirm that **Try again** appears after a failed request.

## Limitations

Quotes depend on the external API and network availability. The app does not cache quotes for offline use or select one quote per calendar day.

## Contributing

These apps are focused examples of specific platform capabilities. Contributions that keep an example correct, buildable, and clear are welcome, including bug fixes, documentation and setup corrections, and improvements to its existing behavior. Please keep pull requests within the app's stated purpose and describe how you verified the change.

**Found a problem but can't fix it?** Open an issue in this repository; a pull request is not required. For a bug or broken build, include the steps to reproduce it, what you expected, what happened, and your device, OS, and SDK/API version. Logs or screenshots are helpful when available. You can also open an issue for inaccurate or unclear documentation.

## License

This project is licensed under the Apache License, Version 2.0. See [LICENSE](LICENSE).
