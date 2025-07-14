<div align="center">

[![Build Status][build status badge]][build status]
[![Platforms][platforms badge]][platforms]
[![Documentation][documentation badge]][documentation]
[![Matrix][matrix badge]][matrix]

</div>

# WebFinger
A WebFinger library for Swift.

This is an implementation of the [WebFinger](https://webfinger.net) protocol.

## Integration

```swift
dependencies: [
    .package(url: "https://github.com/mattmassicotte/WebFinger", branch: "main")
]
```

## Usage

```swift
import WebFinger

// decode
let resource = try JSONDecoder().decode(WebFingerResource.Descriptor.self, from: webfingerData)

print(resource.subject)

// work with queries

let query = WebFingerResource.Query(
    user: "me",
    server: "example.com"
    rel: ["http://webfinger.net/rel/profile-page"]
)

print(query.resource) // "acct:me@example.com"
```

## Contributing and Collaboration

I would love to hear from you! Issues or pull requests work great. Both a [Matrix space][matrix] and [Discord][discord] are available for live help, but I have a strong bias towards answering in the form of documentation. You can also find me on [the web](https://www.massicotte.org).

I prefer collaboration, and would love to find ways to work together if you have a similar project.

I prefer indentation with tabs for improved accessibility. But, I'd rather you use the system you want and make a PR than hesitate because of whitespace.

By participating in this project you agree to abide by the [Contributor Code of Conduct](CODE_OF_CONDUCT.md).

[build status]: https://github.com/mattmassicotte/WebFinger/actions
[build status badge]: https://github.com/mattmassicotte/WebFinger/workflows/CI/badge.svg
[platforms]: https://swiftpackageindex.com/mattmassicotte/WebFinger
[platforms badge]: https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fmattmassicotte%2FWebFinger%2Fbadge%3Ftype%3Dplatforms
[documentation]: https://swiftpackageindex.com/mattmassicotte/WebFinger/main/documentation
[documentation badge]: https://img.shields.io/badge/Documentation-DocC-blue
[matrix]: https://matrix.to/#/%23chimehq%3Amatrix.org
[matrix badge]: https://img.shields.io/matrix/chimehq%3Amatrix.org?label=Matrix
[discord]: https://discord.gg/esFpX6sErJ

